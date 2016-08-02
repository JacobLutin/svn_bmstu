program ChangeWords;

uses
	SysUtils;

type
	STArray = array of string;


var
	i: integer;
	minWord: Integer;
	maxWord: Integer;
	arr: STArray;


function ChangeWords(const arr: STArray): STArray;
var
	res: STArray;
begin
	res := Copy(arr);

	res[minWord] := arr[maxWord];
	res[maxWord] := arr[minWord];

	ChangeWords := res;
end;

function Test1(): STArray;
begin
	minWord := 1;
	maxWord := 4;
	SetLength(arr, 5);
	arr[0] := 'Алексей';
	arr[1] := 'и';
	arr[2] := 'Семен';
	arr[3] := 'посещают';
	arr[4] := 'университет';
	Test1 := arr;
end;

function AssertTest1(): Boolean;
begin
	if ((arr[0] = 'Алексей') and (arr[1] = 'университет') and 
	(arr[2] = 'Семен') and (arr[3] = 'посещают') and
	(arr[4] = 'и')) then
		AssertTest1 := true
	else
		AssertTest1 := false;
end;

begin
	Test1();
	arr := ChangeWords(arr);
	Writeln('Результат работы первого теста: ', AssertTest1());
end.
