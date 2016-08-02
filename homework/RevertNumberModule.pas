/// Unit for reverting number

unit RevertNumberModule;

interface

uses
	SysUtils;

{ Reverts number in opposite side.
  @param(Input: num - integer number)
  @param(Output: res - string with reversed number) }

function RevertNumber(const num: integer): string;

implementation

function RevertNumber(const num: integer): string;
var
	a: integer;
	res: string;
	i: integer;
	st: string;
	l: integer;
begin
	a := num;

	if a <> 0 then
	begin
		while a mod 10 = 0 do
			a := a div 10;

		str(a, st);
		i := 0;
		res := '';

		l := Length(st);

		if num < 0 then 
		begin
			res := '-';
			l := l - 1;
		end;
		

		while i < l do
		begin
			res := res + st[Length(st) - i];
			i := i + 1;
		end;

		RevertNumber := res;
	end
	else 
		RevertNumber := '0';

end;

end.