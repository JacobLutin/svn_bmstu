program ReadFile;

uses
	SysUtils, tests;

type
	STArray = array of string;

function ReadFile(const fileName: string): STArray;
var
	i: integer;
	userFile: text;
	st: string;
	arr: STArray;
begin
	Assign(userFile, fileName);
	{$I-}
	Reset(userFile);
	{$I+}

	if IOResult = 1 then
	begin
		Writeln('Файл с указанным названием не существует');
		ReadFile := nil;
	end;

	i := 0;

	while not Eof(userFile) do 
	begin
		SetLength(arr, i+1);
		Readln(userFile, st);
		arr[i] := st;
		i := i + 1;
	end;

	if i = 0 then
	begin
		Writeln('Файл пустой');
		ReadFile := nil;
	end;

	ReadFile := arr;
end;

var
	filename: String;
	arr: STArray;
	i: integer;

begin
	filename := '/Users/Jacob/svn/se_16_ya-ljutin/rk_01/file.txt';
	arr := ReadFile(filename);
end.