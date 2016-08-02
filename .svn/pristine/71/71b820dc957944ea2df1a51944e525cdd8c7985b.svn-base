program integral;

{$APPTYPE CONSOLE}

uses
    SysUtils;

const
  N_MIN = 100;
  N_MAX = 5000;

type
    TFunction = function(x : real) : real;

function F_1(x : real) : real;
begin
    result := x + 1.0;
end;

function F_2(x : real) : real;
begin
    result := sin(x);
end;

function F_3(x : real) : real;
begin
    result := exp(x);
end;

function Trapezium(A, B : real; N : integer; Func : TFunction) : real;
var
    H : real;
    X, Y : real;
    Sum : real;
    I : integer;
begin
    H := (B - A) / N;

    Sum := 0;
    for I := 1 to N - 1 do
    begin
        X := A + I * H;
        Sum := Sum + Func(X);
        
     end;

     result := h * ((Func(A) + Func(B))/2 + Sum)
end;

var
    A, B : real;
    N : integer;
    Choise : integer;

begin
    WriteLn('Input a:');
    ReadLn(A);
    WriteLn('Input b:');
    ReadLn(B);

    repeat
        WriteLn('Input n (', N_MIN, ' <= n <= ', N_MAX, '):');
        ReadLn(N);
    until (N >= N_MIN) and (N <= N_MAX);

    repeat
        WriteLn('Input function:');
        WriteLn('0 - x + 1');
        WriteLn('1 - sin(x)');
        WriteLn('2 - exp(x)');
        ReadLn(Choise);
    until (Choise >= 0) and (Choise <= 2);

    case Choise of
        0 : WriteLn('Integral of "x + 1" from ', A:4:2, ' till ', B:4:2, ' = ', Trapezium(A, B, N, F_1):6:2);
        1 : WriteLn('Integral of "sin(x)" from ', A:4:2, ' till ', B:4:2, ' = ', Trapezium(A, B, N, F_2):6:2);
        2 : WriteLn('Integral of "exp(x)" from ', A:4:2, ' till ', B:4:2, ' = ', Trapezium(A, B, N, F_3):6:2);
    end;

    ReadLn;
end.
