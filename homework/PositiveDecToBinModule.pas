/// Unit for decimal to binary conversation

unit PositiveDecToBinModule;

interface

uses 
	SysUtils;

{ Translates positive decimal to binary
  @param(Input: num - positive integer number (decimal))
  @param(Output: bin - String with binary number) }

function PositiveDecToBin(const num: integer): string;

implementation

function PositiveDecToBin(const num: integer): string;
var
	t: integer;
	dec: integer;
	bin: string;
begin
	dec := num;

	if dec <= 0 then 
		bin := '0'
	else
	begin
		bin := '';
		while dec > 1 do
		begin
			t := dec mod 2;
			if t = 1
				then bin := '1' + bin
				else bin := '0' + bin;
			dec := dec div 2;
		end;
		bin := '1' + bin;
	end;

	PositiveDecToBin := bin;
end;

end.