program Pruebas;
{$mode objfpc}
{ Program to demonstrate the Concat function. }
uses crt;
Var
  fecha, hora : String;

begin
  writeln('Ingrese la fecha[dd/mm/yyyy]:');
  readln(fecha);
  fecha:= Concat(fecha,' ');
  writeln('Ingrese la hora[hh:mm]:');
  readln(hora);
  fecha:= Concat(fecha, hora);
  writeln(fecha);
  readkey;
end.

