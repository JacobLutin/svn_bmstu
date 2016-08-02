#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
DelphiDoc is a HTML program documentation generator for Turbo Delphi.
DelphiDoc requires "Generate XML documentation" project option to be turned on.
This tool supports Turbo Delphi only and does not work for other Delphi versions.
Only Russian output is currently supported.
"""

__author__ = 'Vsevolod Krishchenko'
__copyright__ = 'Copyright (c) 2012 Vsevolod Krishchenko'
__license__ = 'MIT'
__vcs_id__ = '$Id$'
__version__ = '0.2'

import os
import os.path
import re
import sys


def error(msg):
    print "ERROR:", msg
    sys.exit(2)


def warning(msg):
    print "WARNING:", msg


def msg(msg):
    print(msg)


try:
    import xml.etree.ElementTree as ET
except:
    error("xml.etree.ElementTree parser not found, please install it.")


try:
    from Cheetah.Template import Template
except:
    error("Cheetah.Template engine not found, please install it.")


doxy_pre = r"^(?:\\|@)"


def doxy_cmd(cmd):
    return doxy_pre + cmd + r"\s+(?P<text>.*?)$"


re_par = re.compile(doxy_cmd("par"), re.U)
re_brief = re.compile(doxy_cmd("brief"), re.U)
re_author = re.compile(doxy_cmd("author"), re.U)
re_details = re.compile(doxy_cmd("details"), re.U)
re_note = re.compile(doxy_cmd("note"), re.U)
re_remark = re.compile(doxy_cmd("remark"), re.U)
re_bug = re.compile(doxy_cmd("bug"), re.U)
re_warning = re.compile(doxy_cmd("warning"), re.U)
re_result = re.compile(doxy_cmd(r"(?:result|return|returns)"), re.U)
re_param = re.compile(doxy_pre + r"param(?:\[(?P<dir>out|in|in,out)\])?\s+(?P<name>.*?)\s+(?P<text>.*?)$", re.U)
re_some_tag = re.compile(doxy_pre + r"\w.*")
re_emptyline = re.compile(r"^$", re.U)

tire = ur" — "

html_escaping = (
    (r"&", r"&amp;"),
    (r" --- ", tire),
    (r" -- ", tire),
    (r" - ", tire),
    (r"< ", r"&lt; "),
    (r" >", r" &gt;"),
)


text_replaces = {
    re.compile(r"\\(?:p|c)\s+(\w+)"): r"<tt>\1</tt>",
    re.compile(r"\\b\s+(\w+)", re.U): r"<b>\1</b>",
    re.compile(r"\\(?:em|e)\s+(\w+)", re.U): r"<em>\1</em>",
}


def proceed_text(line):
    for sub, rep, in html_escaping:
        line = line.replace(sub, rep)
    for pattern, rep in text_replaces.items():
        line = re.sub(pattern, rep, line)
    return line


class Element:
    def __init__(self):
        self.name = ""
        self.brief = ""
        self.author = ""
        self.details = ""
        self.note = ""
        self.remark = ""
        self.bugs = []
        self.warnings = []
        self.typeof = None
        self.value = None
        self.prefix = ""
        self.fields_name = None

    def documented(self, tag):
        return True

    def check(self, tag):
        if not self.name:
            return u'Tag "%s" has no "name" attribute.' % (tag.tag, )
        return None

    def parse(self, e):
        self.__init__()
        self.name = e.attrib["name"]
        if "type" in e.attrib:
            self.typeof = e.attrib["type"].strip()
        for dev in e.findall("devnotes"):
            parse_devnotes(self, dev.text)


class Function(Element):
    def __init__(self):
        Element.__init__(self)
        self.result = None
        self.params = []

    def check(self, tag):
        err = Element.check(self, tag)
        if err:
            return err
        names = [p.name for p in self.params]
        ps = tag.find("parameters")
        present = []
        if ps is not None:
            present = [t.attrib["name"] for t in ps.findall("parameter")]
        for n in names:
            if not n in present:
                return 'Parameter "%s" not found in function "%s".' % (n, self.name)
        for p in present:
            if not p in names:
                return 'Parameter "%s" has no description in function "%s".' % (p, self.name)
        if tag.tag == 'function' and not self.result:
            return 'Function "%s" has no return value description.' % (self.name, )
        if tag.tag == 'procedure' and self.result:
            return 'Procedure "%s" cannot have return value.' % (self.name, )
        return None

    def parse(self, e):
        Element.parse(self, e)
        if e.tag == "procedure":
            self.prefix = "Процедура"
        else:
            self.prefix = "Функция"
        ps = e.find("parameters")
        if ps is not None:
            for p_tag in ps.findall("parameter"):
                tag_name = p_tag.attrib["name"]
                p = [p for p in self.params if p.name == tag_name]
                if len(p) == 1:
                    p[0].parse(p_tag)


class Type(Element):
    def __init__(self):
        Element.__init__(self)
        self.fields = []
        self.prefix = "Тип"


class Pointer(Type):
    def __init__(self):
        Type.__init__(self)
        self.prefix = "Указатель"

    def parse(self, e):
        Type.parse(self, e)
        self.typeof = "указатель на тип " + self.typeof


class Enum(Type):
    def __init__(self):
        Type.__init__(self)
        self.fields_name = "Элементы"

    def parse(self, e):
        Type.parse(self, e)
        if e.tag == 'enum':
            self.prefix = "Перечисление"
        else:
            self.prefix = "Множество"
        for fld_tag in e.findall("element"):
            f = Field()
            f.parse(fld_tag)
            self.fields.append(f)


class Array(Type):
    def __init__(self):
        Type.__init__(self)
        self.low = None
        self.high = None
        self.prefix = "Массив"

    def parse(self, e):
        Type.parse(self, e)
        es = e.findall("element")
        if len(es) == 1:
            typeof = es[0].attrib["type"]
            if typeof[0] not in (":", "."):
                self.typeof = "массив из типа " + typeof

class Struct(Type):
    def __init__(self):
        Type.__init__(self)
        self.fields = []
        self.prefix = "Запись"
        self.fields_name = "Поля"

    def parse(self, e):
        Type.parse(self, e)
        for fld_tag in e.findall("field"):
            f = Field()
            f.parse(fld_tag)
            self.fields.append(f)


class Variable(Element):
    def parse(self, e):
        Element.parse(self, e)
        if e.tag == 'variable':
            self.prefix = "Переменная"
        elif e.tag == 'const':
            self.prefix = "Константа"
        elif e.tag == 'element':
            self.prefix = "Элемент"
        elif e.tag == 'field':
            self.prefix = "Поле"
        v = e.find("value")
        if v is not None:
            self.value = v.text.strip()

    def documented(self, tag):
        # Skipping auto enum constants.
        return self.name != self.value


class Field(Variable):
    pass


class Param(Variable):
    def __init__(self):
        Variable.__init__(self)
        dir = None


class Unit(Element):
    def __init__(self):
        Element.__init__(self)
        self.members = []
        self.types = []
        self.enums = []
        self.variables = []
        self.functions = []

    def parse(self, e):
        tags  = {
            'struct': (Struct, "types"),
            'enum': (Enum, "types"),
            'set': (Enum, "types"),
            'array': (Array, "types"),
            'pointer': (Pointer, "types"),
            'type': (Type, "types"),
            #
            'variable': (Variable, "variables"),
            'const': (Variable, "variables"),
            #
            'procedure': (Function, "functions"),
            'function': (Function, "functions"),
            #
            'contains': (None, None),
            'devnotes': (None, None),
        }
        Element.parse(self, e)
        for tag in e:
            if not tag.tag in tags:
                error('Invalid tag: "%s"' % (tag.tag, ))
            t, lst = tags[tag.tag]
            if not t:
                continue
            obj = t()
            obj.parse(tag)
            if not obj.documented(tag):
                continue
            err = obj.check(tag)
            if not err:
                self.members.append(obj)
                getattr(self, lst).append(obj)
            else:
                error(err)

fields_re = {
    "author": re_author,
    "brief": re_brief,
    "details": re_details,
    "note": re_note,
    "remark": re_remark,
    "warning": re_warning,
    "bug": re_bug,
    "result": re_result,
}


def parse_devnotes(obj, text):
    cur_attr = "brief"
    cur_param = None
    #prev_attr = cur_attr

    text = text.strip()
    text = re.sub(r"\n\s*\n\s*\n", r"\n\n", text)
    text = re.sub(r"\n\s*\n\s*\\par", r"\n\par", text)

    def add_attr(l):
        mul = cur_attr + 's'
        if hasattr(obj, cur_attr):
            v = getattr(obj, cur_attr)
            if v:
                l = " ".join((v, l))
            setattr(obj, cur_attr, l)
        elif hasattr(obj, mul):
            obj.__dict__[mul].append(l)
        else:
            error('internal error: "%s"', (cur_attr, ))

    def append_attr(l):
        if cur_param:
            cur_param.text = " ".join((cur_param.text, l))
            return
        mul = cur_attr + 's'
        if hasattr(obj, cur_attr):
            v = getattr(obj, cur_attr)
            if v:
                l = " ".join((v, l))
            setattr(obj, cur_attr, l)
        elif hasattr(obj, mul):
            obj.__dict__[mul][-1] = " ".join((obj.__dict__[mul][-1], l))
        else:
            error('internal error: "%s"', (cur_attr, ))

    for l in text.split("\n"):
        l = proceed_text(l.strip())
        m = None
        for fld, reg in fields_re.items():
            m = reg.match(l)
            if m:
                cur_attr = fld
                cur_param = None
                add_attr(m.group("text"))
                break
        if m:
            continue
        m = re_par.match(l)
        if m:
            add_attr('<p>' + m.group("text"))
            continue
        if obj.__class__ == Function:
            m = re_param.match(l)
            if m:
                p = Param()
                p.__dict__.update(m.groupdict())
                obj.params.append(p)
                cur_param = p
                continue
        if re_some_tag.match(l):
            error('Unknown tag: "%s"' % (l, ))
        else:
            #print 'no tag: "%s", "%s"' % (l, cur_attr)
            if re_emptyline.match(l):
                if cur_attr != "details":
                    cur_attr = "details"
                    cur_param = None
                else:
                    cur_param = None
                    add_attr('<p>')
            else:
                append_attr(l)
    return obj


def proceed_xml(xml_file):
    tree = ET.parse(xml_file)
    unit = Unit()
    unit.parse(tree.getroot())
    return unit

html_template = ur"""
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>$title</title>
    <style type="text/css">
    body {
        color: black;
        background-color: white;
        margin: 10px;
    }
    a:link    {
        text-decoration:  none;
        color:            black;
    }
    a:visited {
        text-decoration:  none;
        color:            black;
    }
    a:hover   {
        text-decoration:  none;
        color:            #555;
    }
    a:active  {
        color: silver;
    }
    h1 {
    }
    h2.numbered:before {
        content: counter(cnt-h2) " ";
        counter-increment: cnt-h2;
    }
    h2.numbered {
        counter-reset: cnt-h3;
    }
    h3:before {
        content: counter(cnt-h2) "." counter(cnt-h3) " ";
        counter-increment: cnt-h3;
    }
    h3 {
        counter-reset: cnt-h4;
    }
    h4:before {
        content: counter(cnt-h2) "." counter(cnt-h3) "." counter(cnt-h4) " ";
        counter-increment: cnt-h4;
    }
    ul.c1 {
        list-style: none;
        padding-left: 0px;
    }
    ul.c2 {
        list-style: none;
        padding-left: 30px;
        margin-bottom: 10px;
    }
    ul.c3 {
        list-style: none;
        padding-left: 30px;
        margin-bottom: 5px;
    }
    li.c1:before {
        content: counter(cnt-c1)  " ";
    }
    li.c1 {
        counter-reset: cnt-c2;
        counter-increment: cnt-c1;
    }
    li.c2:before {
        content: counter(cnt-c1) "." counter(cnt-c2) " ";
    }
    li.c2 {
        counter-reset: cnt-c3;
        counter-increment: cnt-c2;
    }
    li.c3:before {
        content: counter(cnt-c1) "." counter(cnt-c2) "." counter(cnt-c3)  " ";
    }
    li.c3 {
        counter-increment: cnt-c3;
    }
    div.heading {
        border-style: solid;
        border-color: silver;
        border-width: 1px;
        margin: 10px;
        padding: 10px;
        counter-reset: cnt-c1;
        counter-reset: cnt-h2;
    }
    div.unit {
        border-style: solid;
        border-color: silver;
        border-width: 1px;
        background-color: #f8f8f8;
        margin: 10px;
        padding: 10px;
    }
    div.member {
        background-color: white;
        border-style: solid;
        border-color: silver;
        border-width: 1px;
        margin-left: 0px;
        margin-right: 0px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 10px;
    }
    </style>
</head>

    #def author($p)
        #if $p.author
            <b>Автор: $p.author</b><p>
        #end if
    #end def

<body>
    <div class="heading">
    <h1>$title</h1>

    $author($project)

    <h2>Оглавление</h2>

    <ul class="c1">
    #for $unit in $units
    <li class="c1"><a href="#$unit.name">$unit.prefix <b>$unit.name</b></a>
        #if $unit.enums or $unit.variables or $unit.functions or $unit.types
            <ul class="c2">
            #if $unit.types
            <li class="c2"><a href="#$unit.name-types">Типы данных</a>
                <ul class="c3">
                #for $p in $unit.types
                <li class="c3"><a href="#$unit.name-types-$p.name">$p.prefix <b>$p.name</b></a></li>
                #end for
                </ul>
            </li>
            #end if
            #if $unit.variables
            <li class="c2"><a href="#$unit.name-variables">Переменные и константы</a>
                <ul class="c3">
                #for $p in $unit.variables
                <li class="c3"><a href="#$unit.name-variables-$p.name">$p.prefix <b>$p.name</b></a></li>
                #end for
                </ul>
            </li>
            #end if
            #if $unit.functions
            <li class="c2"><a href="#$unit.name-functions">Процедуры и функции</a>
                <ul class="c3">
                #for $p in $unit.functions
                <li class="c3"><a href="#$unit.name-functions-$p.name">$p.prefix <b>$p.name</b></a></li>
                #end for
                </ul>
            </li>
            #end if
            </ul>
        #end if
        </li>
    #end for
    ## <li> <a href="#_index">Алвафитный указатель</a></li>
    </ul>
    </div>

    #def header($p)
        #if $p.typeof
            Тип: <b>$p.typeof</b>.
        #end if
        #if $p.value
            Значение: <b>$p.value</b>.
        #end if
        $p.brief<p>
        #if $p.details
            $p.details<p>
        #end if
    #end def

    #def footer($p)
        #if $p.remark
            <b>Примечания.</b> $p.remark<p>
        #end if
        #if $p.note
            <b>Замечания</b>. $p.note<p>
        #end if
        #if $p.bugs
            <b>Известные ошибки</b>
            <ul>
            #for $b in $p.bugs
                <li>$b</li>
            #end for
            </ul>
        #end if
        #if $p.warnings
            <b>Предупреждения</b>
            <ul>
            #for $w in $p.warnings
                <li>$w</li>
            #end for
            </ul>
        #end if
    #end def

    #def dir($par)
        #if $par.dir
, направление:
            #if $par.dir == "in"
            <b>вход</b>.
            #else if $par.dir == "out"
            <b>выход</b>.
            #else if $par.dir == "in,out"
            <b>вход</b> и <b>выход</b>.
            #else
            не ясно.
            #end if
        #else
.
        #end if
    #end def

    #def list($lst, $pref)
        #for $p in $lst[:-1]
        <a href="#$pref-$p.name">$p.name</a>,
        #end for
        <a href="#$pref-$lst[-1].name">$lst[-1].name</a>.<p>
    #end def


    #for $unit in $units
    <div class="unit">
    <a name="$unit.name"></a><h2 class="numbered">$unit.prefix $unit.name</h2>
        $header($unit)
        $footer($unit)
        #if $unit.types
        <h3><a name="$unit.name-types"></a>Типы данных</h3>
            Типы данных: $list($unit.types, $unit.name + "-types")
            #for $p in $unit.types
            <div class="member">
            <h4><a name="$unit.name-types-$p.name"></a>$p.prefix $p.name</h4>
            $header($p)
            #if $p.fields_name
                <b>$p.fields_name</b>
                <ul>
                #for $f in $p.fields:
                    <li>$f.prefix <b>$f.name</b>.
                    $header($f)
                    $footer($f)
                    </li>
                #end for
                </ul>
            #end if
            $footer($p)
            </div>
            #end for
        #end if
        #if $unit.variables
        <h3><a name="$unit.name-variables"></a>Переменные и константы</h3>
            Переменные: $list($unit.variables, $unit.name + "-variables")
            #for $p in $unit.variables
            <div class="member">
            <h4><a name="$unit.name-variables-$p.name"></a>$p.prefix $p.name</h4>
            $header($p)
            $footer($p)
            </div>
            #end for
        #end if
        #if $unit.functions
        <h3><a name="$unit.name-functions"></a>Процедуры и функции</h3>
            Процедуры и функции: $list($unit.functions, $unit.name + "-functions")
            #for $p in $unit.functions
            <div class="member">
            <h4><a name="$unit.name-functions-$p.name"></a>$p.prefix $p.name</h4>
            $header($p)
            <b>Аргументы</b>
            #if $p.params
                <ul>
                #for $par in $p.params:
                    <li>Аргумент <b>$par.name</b>, тип: <b>$par.typeof</b>$dir($par)
                    $par.text
                    </li>
                #end for
                </ul>
            #else
                <p>Отсутствуют.<p>
            #end if
            #if $p.result
                <b>Результат.</b> $p.result<p>
            #end if
            $footer($p)
            </div>
            #end for
        #end if
    </div>
    #end for

    ## <a name="_index"></a><h2 class="numbered">Алвафитный указатель</h2>

</body>
"""

def process_project(dpr, pas):
    units = []
    for f in [dpr] + pas:
        xml_file = os.path.splitext(f)[0] + '.xml'
        if not os.path.exists(xml_file):
            error('Cannot find xml documentation file: "%s"' % (xml_file, ))
        msg('Parsing documentation file: "%s"' % (xml_file, ))
        unit = proceed_xml(xml_file)
        unit.filename = os.path.basename(f)
        if f == dpr:
            unit.prefix = "Программа"
            dpr_unit = unit
        else:
            unit.prefix = "Модуль"
        units.append(unit)
    #
    names = {
        'title': "Документация проекта " + dpr_unit.name,
        'units': units,
        'project': dpr_unit,
    }
    t = Template(html_template, searchList=[names])
    return t


def usage():
    print "Usage: delphidoc <project_directory>"
    print "DelphiDoc version: " + __version__
    print "Author: " + __author__
    print __doc__
    sys.exit(1)


def main():
    if len(sys.argv) != 2:
        usage()
    dir = sys.argv[1]
    if not os.path.exists(dir):
        error('Cannot find path: "%s"' % (dir, ))
    if not os.path.isdir(dir):
        error('Path is not a directory: "%s"' % (dir, ))
    # FIXME: does not work with .DPR and .PAS
    files = os.listdir(dir)
    dprs = [os.path.join(dir, f) for f in files if f.endswith(".dpr")]
    pas  = [os.path.join(dir, f) for f in files if f.endswith(".pas")]
    pas.sort()
    if not dprs:
        error('Path does not contain any .dpr files: "%s"' % (dir, ))
    if len(dprs) > 1:
        error('Path contains more than one .dpr file: "%s"' % (dir, ))
    dpr = dprs[0]
    msg("Found a project: %s" % (dpr, ))
    for p in pas:
        msg("Found a unit: %s" % (p, ))
    html = process_project(dpr, pas)
    outname = os.path.splitext(dpr)[0] + ".html"
    msg('Writing an output file: "%s"' % (outname, ))
    out = open(outname, 'w+')
    out.write(str(html))
    out.close()
    print "Success."
    sys.exit(0)


if __name__ == "__main__":
    main()
