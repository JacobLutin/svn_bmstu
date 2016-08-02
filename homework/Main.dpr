/// Main program
program Main;

uses 
	SysUtils, SumOfNumbersModule, CheckEvenModule, PositiveDecToBinModule,
	NegativeDecToBinModule, RevertNumberModule, ReadFromFileModule;

const
	PATH = '/Users/Jacob/svn/homework/';
	INPUT_FILE = 'input.txt';
	OUTPUT_FILE = 'output.txt';


type
	TIArray = array of integer;

var
	num: integer;
	res: string;
	sum: integer;
	arr: TIArray;
	i: integer;
	userfile: text;

begin

	arr := ReadFromFile(PATH + INPUT_FILE);

	Assign(userfile, PATH + OUTPUT_FILE);
	Rewrite(userfile);

	for i := 0 to High(arr) do
	begin
		num := arr[i];
	
		sum := SumOfNumbers(num);

		if CheckEven(sum) 
			then if num > 0
					then res := PositiveDecToBin(num)
					else res := NegativeDecToBin(num)
			else res := RevertNumber(num);

		Writeln(userfile, res);
	end;

	CloseFile(userfile);
end.

