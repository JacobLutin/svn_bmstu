program tests;

uses 
	SysUtils, SumOfNumbersModule, CheckEvenModule, PositiveDecToBinModule,
	NegativeDecToBinModule, RevertNumberModule, ReadFromFileModule;

type
	STArray = array of integer;

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

procedure Tests();
var 
	n: integer;
	path: string;
	arr: TIArray;
begin

	PATH := '/Users/Jacob/svn/homework/testfiles/';

	n := 0;

	{ ReadFromFile tests }

	//  Test_1
	// file does not exist

	if ReadFromFile(PATH + 'file_1.txt') <> nil then
	begin
		inc(n);
		Writeln('Ошибка на первом тесте');

	end;

	//  Test_2
	// file is empty

	if ReadFromFile(PATH + 'file_1.txt') <> nil then
	begin
		inc(n);
		Writeln('Ошибка на втором тесте');
	end;

	//  Test_3
	// wrong value

	if ReadFromFile(PATH + 'file_2.txt') <> nil then
	begin
		inc(n);
		Writeln('Ошибка на третьем тесте');
	end;

	//  Test_4

	SetLength(arr, 3);
	arr[0] := 8;
	arr[1] := 5000;
	arr[2] := 2;
	arr[3] := 75;

	if not Assert((ReadFromFile(path + 'file_3.txt')), arr) then
	begin
		inc(n);
		Writeln('Ошибка на четвертом тесте');
	end;

	{ SumOfNumbers tests }

	//  Test_5

	if SumOfNumbers(123) <> 6 then
	begin
		inc(n);
		Writeln('Ошибка на пятом тесте');
	end;

	//  Test_6

	if SumOfNumbers(101) <> 2 then
	begin
		inc(n);
		Writeln('Ошибка на шестом тесте');
	end;

	//  Test_7

	if SumOfNumbers(666) <> 18 then
	begin
		inc(n);
		Writeln('Ошибка на седьмом тесте');
	end;

	{ RevertNumber tests }

	//  Test_8

	if RevertNumber(123) <> '321' then
	begin
		inc(n);
		Writeln('Ошибка на восьмом тесте');
	end;

	//  Test_9

	if RevertNumber(-1100) <> '-11' then
	begin
		inc(n);
		
		Writeln('Ошибка на девятом тесте');
	end;

	//  Test_10

	if RevertNumber(9060) <> '609' then
	begin
		inc(n);
		Writeln('Ошибка на десятом тесте');
	end;

	{ PositiveDecToBin tests }

	//  Test_11

	if PositiveDecToBin(1) <> '1' then
	begin
		inc(n);
		Writeln('Ошибка на одиннадцатом тесте');
	end;

	//  Test_12

	if PositiveDecToBin(75) <> '1001011' then
	begin
		inc(n);
		Writeln('Ошибка на двенадцатом тесте');
	end;

	//  Test_13

	if PositiveDecToBin(14) <> '1110' then
	begin
		inc(n);
		Writeln('Ошибка на тринадцатом тесте');
	end;

	{ NegativeDecToBin tests }

	//  Test_14

	if NegativeDecToBin(-26) <> '10101' then
	begin
		inc(n);
		Writeln('Ошибка на четырнадцатом тесте');
	end;

	//  Test_15

	if NegativeDecToBin(-54) <> '101101' then
	begin
		inc(n);
		Writeln('Ошибка на пятнадцатом тесте');
	end;

	{ CheckEven tests }

	// Test_16

	if CheckEven(2) <> true then
	begin
		inc(n);
		Writeln('Ошибка на шестнадцатом тесте');
	end;

	// Test_17

	if CheckEven(5) <> false then
	begin
		inc(n);
		Writeln('Ошибка на семнадцатом тесте');
	end;


	if n > 0 
		then Writeln(n, ' тестов не пройдены')
		else Writeln('Все тесты пройдены успешно');

end;


begin
	Tests();

	// Readln();
end.






