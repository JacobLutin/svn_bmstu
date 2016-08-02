/// Unit for sum of numbers in value

unit SumOfNumbersModule;

interface

uses SysUtils;

/// \brief Summing all numbers of value in one value
/// \param[in] Integer number.
/// \return Integer number.

{ Summing all numbers of value in one value.
  @param(Input: num - integer number)
  @param(Output: sum - integer number of sum) }

function SumOfNumbers(const num: integer): integer;

implementation

function SumOfNumbers(const num: integer): integer;
var
	sum, n: integer;
begin
	sum := 0;
	n := abs(num);

	while n > 0 do
	begin
		sum := sum + (n mod 10);
		// writeln(sum);
		n := n div 10;
		// writeln(n);
	end;

	SumOfNumbers := sum;
end;

end.