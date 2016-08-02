/// Unit for string processing.

unit ReadFromFileModule;

// {$define DEBUG}

interface

uses
	SysUtils;

type
	/// Storages array of integer from file
	TIArray = array of integer;


{ Checks if file exists and if it's not empty process file and content
  any integer number - converts them into array.
  @param(Input: filename - name of file)
  @param(Output: arr - array of integers in file) }

function ReadFromFile(const fileName: string): TIArray;

implementation

function ReadFromFile(const fileName: string): TIArray;
var
	i, k: integer;
	userFile: text;
	st: string;
	arr: TIArray;
	num: integer;
begin

	Assign(userFile, fileName);
	{$I-}
	Reset(userFile);
	{$I+}

	if IOResult <> 0 then
	begin
		{$ifdef DEBUG}
		{$else}
		Writeln('Ошибка: Файл с указанным названием не существует');
		{$endif}
		exit(nil);
	end;

	i := 0;
	k := 0;

	while not Eof(userFile) do 
	begin
		Readln(userFile, st);
		// num := StrToInt(st);
		num := StrToIntDef(st, 0);
		if num <> 0 then
		begin
			SetLength(arr, i+1);
			arr[i] := num;
			i := i + 1;
		end;
		k := k + 1;
	end;

	if i = 0 then
	begin
		if k > 0 then begin
			{$ifdef DEBUG}
			{$else}
			Writeln('Ошибка: Файл не содержит целых чисел значений');
			{$endif}
			exit(nil);
		end else
		begin
			{$ifdef DEBUG}
			{$else}
			Writeln('Ошибка: Файл пустой');
			{$endif}
			exit(nil);
		end;
	end;

	ReadFromFile := arr;
end;

end.