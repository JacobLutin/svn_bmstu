program integral;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  N_MAX = 100;

type
  TIArray = array [1..N_MAX] of integer;


procedure RevertArray(var arr: TIArray; var n: integer);
var
  x, y: integer;
  i: integer;
begin
  i := 1;
  while i <= n do 
  begin
    if i <= n div 2 then 
    begin 
      x:=arr[i]; 
      y:=arr[n-i+1];
      if (x * y < 0) then
      begin
        x := -1 * x;
        y := -1 * y;
      end;
      arr[n-i+1]:=x; 
      arr[i]:= y;
    end;
  i := i + 1;
  end;
end;

procedure PrintArray(var arr: TIArray; n: integer);
var
    i: integer;
begin

  for i := 1 to n do
    write(arr[i], ' ');
  writeln;
end;

procedure Test1(var arr: TIArray; var n: integer);
begin
  n := 4;

  arr[1] := 1;
  arr[2] := 2;
  arr[3] := 3;
  arr[4] := 4;
end;

procedure Test2(var arr: TIArray; var n: integer);
begin
  n := 3;

  arr[1] := 7;
  arr[2] := 5;
  arr[3] := 6;
end;

procedure Test3(var arr: TIArray; var n: integer);
begin
  n := 5;

  arr[1] := 1;
  arr[2] := 0;
  arr[3] := 0;
  arr[4] := 0;
  arr[5] := 0;
end;

procedure Test4(var arr: TIArray; var n: integer);
begin
  n := 0;
end;

procedure Test5(var arr: TIArray; var n: integer);
begin
  n := -1;
end;

procedure Test6(var arr: TIArray; var n: integer);
begin
  n := 4;

  arr[1] := -1;
  arr[2] := 2;
  arr[3] := 3;
  arr[4] := 4;
end;

var
  n : integer;
  arr : TIArray;

begin
  Test1(arr, n);

  PrintArray(arr, n);

  RevertArray(arr, n);

  PrintArray(arr, n);
end.
