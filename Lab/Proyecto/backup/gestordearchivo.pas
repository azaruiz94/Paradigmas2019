unit gestorDeArchivo;
{$mode objfpc}{$H+}

interface

const
  PadronFile = 'D:\Drive Fiuni\Universidad\Paradigmas\Clase_6\proyecto\padron.txt';

type
  TParts = array [1..4] of string;

//Definicion de los procedimientos/functiones publicas
function BuscarPadron(Ci: String; Sexo : Char) : String;

implementation

uses Classes, SysUtils, crt;

var
  PunteroDeArchivo : Text;
  Linea : String;

function splitString(cadena: String; separador : Char): TParts;
var
   listaDatos : Array[1..4]of String;
   i, j : integer;
   word : String;
begin
     word:= '';
     j :=1;

     for i := 1 to Length(cadena) do
     begin
          if cadena[i] <> separador then
          begin
               word := word + cadena[i];
          end

          else
          begin
               listaDatos[j] := word;
               word := '';
               inc(j);
          end
     end;
     {La ultima palabra leida}
     listaDatos[j] := word;
     splitString := listaDatos;
end;

function BuscarPadron(Ci: String; Sexo : Char) : String;
var
  NumCedula: String;
  DatosPersona : Array[1..4]of String;
  Nombre: String;

begin
  Assign(PunteroDeArchivo, PadronFile);
  Reset(PunteroDeArchivo); { va al inicio para lectura }
  Nombre:='No Encontrado';

  While NOT EOF(PunteroDeArchivo) do
  begin
      Readln(PunteroDeArchivo, Linea);
      DatosPersona := splitString(Linea, ',');

      if DatosPersona[1] = Ci then
      begin
        Nombre:= DatosPersona[2];
        break;
      end

  end;
  Close(PunteroDeArchivo);
  BuscarPadron:=Nombre;

end;



  begin
  end.
