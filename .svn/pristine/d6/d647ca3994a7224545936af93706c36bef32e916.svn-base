program FindMinWord;

uses SysUtils;

type
	STArray = array of string;

function FindMinWord(const arr: STArray): integer;
var
	i: integer;
	minWord: integer;
	minLength: integer;
begin
	minWord := 0;
	minLength := Length(arr[0]);
	i := 1;

	while i < Length(arr) do
	begin
		if Length(arr[i]) < minLength then
		begin
			minLength := Length(arr[i]);
			minWord := i;
		end;
		i := i + 1;
	end;

	FindMinWord := minWord;
end;

function Test1(): STArray;
var
	arr: STArray;
begin
	SetLength(arr, 4);
	arr[0] := 'Валера';
	arr[1] := 'Юра';
	arr[2] := 'Никита';
	arr[3] := 'Леша';

	Test1 := arr;
end;

function Test2(): STArray;
var
	arr: STArray;
begin
	SetLength(arr, 4);
	arr[0] := 'Коля';
	arr[1] := 'Тимур';
	arr[2] := 'Сережа';
	arr[3] := 'Саша';

	Test2 := arr;
end;

function AssertTest1(minWord: integer): Boolean;
begin
	if minWord = 1 then
		AssertTest1 := true
	else
		AssertTest1 := false;
end;

function AssertTest2(minWord: integer): Boolean;
begin
	if minWord = 0 then
		AssertTest2 := true
	else
		AssertTest2 := false;
end;

var
	arr: STArray;
	minWord: integer;
begin

	{$DEFINE DEBUG}

	{$IFDEF DEBUG}
	arr := Test1();
	minWord := FindMinWord(arr);
	Writeln('Результат работы первого теста: ', AssertTest1(minWord));

	arr := Test2();
	minWord := FindMinWord(arr);
	Writeln('Результат работы второго теста: ', AssertTest2(minWord));
	{$ENDIF}
end.