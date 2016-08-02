/// \brief Unit for string processing.

unit file_utils;

{$define DEBUG}

interface

uses
	SysUtils;

type
	STArray = array of string;

/// \details Checks if file exists and is not empty process file.
/// \param[in] File contains list of strings.
/// \return Array of strings if file contains anything, otherwise - nil.

function ReadFile(const fileName: string): STArray;

implementation

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

	if IOResult <> 0 then
	begin
		{$ifdef DEBUG}
		{$else}
		Writeln('Файл с указанным названием не существует');
		{$endif}
		exit(nil);
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
		{$ifdef DEBUG}
		{$else}
		Writeln('Файл пустой');
		{$endif}
		exit(nil);
	end;

	ReadFile := arr;
end;

end.