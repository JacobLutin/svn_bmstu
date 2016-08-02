program StringToArray;

uses SysUtils;

type
	STArray = array of string;

function StringToArray(const st: string): STArray;
var
	i, j, n, k: integer;
	word: string;
	arr: STArray;
begin
	SetLength(arr, 100);
	i := 1; j := 0; k := 0; n := 0;
	word := '';

	while i < Length(st)+1 do
	begin
	Writeln(st[i]);
		if st[i] <> ' ' then
		
		begin
	    	k := 0;
	    	while st[i] <> ' ' do
	    	begin
	    		word[k] := st[i];
	    		i := i + 1;
	    		k := k + 1;
	    	end;
	    	arr[n] := word;
	    	// writeln(word);
	    	word := '';
	    	n := n + 1;
	    	k := 0;
	    	i := i + 1;
	    end
	    else
	    	i := i + 1;
	end;

	StringToArray := arr;
end;

function Test1(): string;
var
	st: string;
begin
	st := 'a b c ';
	Test1 := st;
end;

var
	st: string;
	arr: STArray;
	i: integer;
begin
	st := Test1();
	arr := StringToArray(st);
	// for i := 0 to High(arr) do
		// Writeln(arr[i]);
end.