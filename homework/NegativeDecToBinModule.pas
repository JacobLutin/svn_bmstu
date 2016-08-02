unit NegativeDecToBinModule;

//< Unit for negative decimals

interface

uses
	SysUtils;

{ Translates positive decimal to binary by calculating
  additional code.
  @param(Input: num - negative integer number (decimal))
  @param(Output: bin - String with binary number) }

function NegativeDecToBin(const num: integer): string;

implementation


function NegativeDecToBin(const num: integer): string;
var
	// Iterations and reserved variables
	i, j, t: integer; 
	{ Variable for storage of decimal number }
	dec: integer;
	// Variable for storage of decimal number	  
	bin: string;
	// Variable for storage of additional code	  
	dopBin: string;    
begin
	
	dec := -num;
	bin := '';
	j := 1;
	
	while dec > 1 do
	begin
		t := dec mod 2;
		if t = 1
			then bin := '1' + bin
			else bin := '0' + bin;
		dec := dec div 2;
		
		j := j + 1;
	end;

	dopBin := '1';
	for i := j-1 downto 1 do
		dopBin := dopBin + bin[i];

	NegativeDecToBin := dopBin;

end;

end.

	// bin := '1' + bin;
	// i := 0;

	// while i < j do
	// begin
	// 	if bin[i] = '0' 
	// 		then bin[i] := '1'
	// 		else bin[i] := '0';
	// 	i := i + 1;
	// end;

	// i := j - 1;

	// while bin[i] = '1' do
	// 	i := i - 1;

	// if i = -1 then
	// begin
	// 	bin := '';
	// 	i := 1;
	// 	while i < j do
	// 	begin
	// 		bin[i] := '0';
	// 		i := i + 1;
	// 	end;
	// 	bin[0] := '1';
	// end else
	// begin
	// 	bin[i] := '1';
	// 	i := i + 1;
	// 	while i < j do
	// 	begin
	// 		bin[i] := '0';
	// 		i := i + 1;
	// 	end;
	// end;

	// NegativeDecToBin := bin;

// end;

// end.