program tests;

uses 
	SysUtils, file_utils;

type
	TIArray = array of integer;

function Assert(const arr1, arr2: STArray): Boolean;
var
	i, size: Integer;
begin
	if High(arr1) > High(arr2) then
		size := High(arr1)
	else
		size := High(arr2);

	for i := 0 to size do
		if arr1[i] <> arr2[i] then
		begin
			exit(false);
		end;
			

	Assert := true
end;

procedure TestReadFile();
var 
	n: integer;
	path: string;
	arr: STArray;
begin

	path := '/Users/Jacob/svn/se_16_ya-ljutin/rk_01/ReadFile/';

	n := 0;

	//  Test_1
	// file does not exist

	if ReadFile(path + 'file_0.txt') <> nil then
	begin
		inc(n);
		Writeln('Ошибка на первом тесте');
	end;

	//  Test_2
	// file is empty

	if ReadFile(path + 'file_1.txt') <> nil then
	begin
		inc(n);
		Writeln('Ошибка на втором тесте');
	end;

	//  Test_3

	SetLength(arr, 1);
	arr[0] := 'test';

	if not Assert(ReadFile(path + 'file_2.txt'), arr) then
	begin
		inc(n);
		Writeln('Ошибка на третьем тесте');
	end;

	//  Test_4

	SetLength(arr, 3);
	arr[0] := 'test1 test2';
	arr[1] := 'test3  test 4';
	arr[2] := 'test5';

	if not Assert((ReadFile(path + 'file_3.txt')), arr) then
	begin
		inc(n);
		Writeln('Ошибка на четвертом тесте');
	end;

	if n > 0 then
		Writeln(n, ' тестов не пройдены')
	else
		Writeln('Все тесты пройдены успешно');
end;


begin
	TestReadFile();

	// Readln();
end.






