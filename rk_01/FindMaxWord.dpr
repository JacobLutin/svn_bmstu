program FindMaxWord;

uses SysUtils;

type
	STArray = array of string;

function FindMaxWord(const arr: STArray): integer;
var
	i: integer;
	maxWord: integer;
	maxLength: integer;
begin
	maxWord := 0;
	maxLength := Length(arr[0]);
	i := 1;

	while i < Length(arr) do
	begin
		if Length(arr[i]) > maxLength then
		begin
			maxLength := Length(arr[i]);
			maxWord := i;
		end;
		i := i + 1;
	end;

	FindMaxWord := maxWord;
end;

function Test1(): STArray;
var
	arr: STArray;
begin
	SetLength(arr, 4);
	arr[0] := 'Семен';
	arr[1] := 'Максим';
	arr[2] := 'Святослав';
	arr[3] := 'Леша';

	Test1 := arr;
end;

function Test2(): STArray;
var
	arr: STArray;
begin
	SetLength(arr, 4);
	arr[0] := 'Николай';
	arr[1] := 'Ирина';
	arr[2] := 'Катя';
	arr[3] := 'Давид';

	Test2 := arr;
end;

function AssertTest1(maxWord: integer): Boolean;
begin
	if maxWord = 2 then
		AssertTest1 := true
	else
		AssertTest1 := false;
end;

function AssertTest2(maxWord: integer): Boolean;
begin
	if maxWord = 0 then
		AssertTest2 := true
	else
		AssertTest2 := false;
end;

var
	arr: STArray;
	maxWord: integer;
begin

	{$DEFINE DEBUG}

	{$IFDEF DEBUG}
	arr := Test1();
	maxWord := FindMaxWord(arr);
	Writeln('Результат работы первого теста: ', AssertTest1(maxWord));

	arr := Test2();
	maxWord := FindMaxWord(arr);
	Writeln('Результат работы второго теста: ', AssertTest2(maxWord));
	{$ENDIF}
	
end.