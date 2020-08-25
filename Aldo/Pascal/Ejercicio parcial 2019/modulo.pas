program modulo;

uses
    crt;
var
  entrada:integer;
function esPrimo(x:integer):boolean;
var
  resultado, i: integer;
  divisores:integer;
  begin
    resultado:=0;
    divisores:=0;
    for i:= x downto 1 do
    begin
      resultado:= x mod i;
      if(resultado = 0) then
      begin
        divisores:= divisores+1;
      end;
    end;
    writeln(divisores, ' ');
    if(divisores = 2) then esPrimo:= true
    else esPrimo:= false;
  end;

begin
  writeln('Ingrese un numero: ');
  readln(entrada);
  writeln('esPrimo?', esPrimo(entrada));
  readkey;
end.

