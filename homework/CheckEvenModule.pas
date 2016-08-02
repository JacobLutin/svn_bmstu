/// Unit for checking even values

unit CheckEvenModule;

interface

uses SysUtils;

{ Checks if value is even
  @param(Input: num - integer number)
  @param(Output: even - boolean variable) }

function CheckEven(const num: integer): boolean;

implementation

function CheckEven(const num: integer): boolean;
var
	even: boolean;
begin
	if num mod 2 = 0
		then even := true
		else even := false;

	CheckEven := even;
end;

end.
