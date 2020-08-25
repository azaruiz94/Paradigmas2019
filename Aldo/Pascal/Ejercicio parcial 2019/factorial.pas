program factorial;

uses
    crt;
var
  i, entrada: integer;

function factorial(var numero: integer):integer;
var
  resultado: integer;
begin
  resultado:=1;
  if(numero = 0) then resultado:= 1;
  for i:=numero downto 1 do
    begin
         resultado:= resultado * i;
    end;
  factorial:= resultado;
end;

begin
  writeln('Ingrese un numero: ');
  readln(entrada);
  writeln('El factorial de ', entrada, ' es: ', factorial(entrada));
  readkey;
end.

