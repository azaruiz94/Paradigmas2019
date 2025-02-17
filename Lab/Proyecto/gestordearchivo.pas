unit gestorDeArchivo;
{$mode objfpc}{$H+}

interface

uses UPersona;

const
  PadronFile = 'padron.txt';

type
  TParts = array [1..4] of string;

//Definicion de los procedimientos/functiones publicas
function BuscarPadron(Ci: String) : Persona;

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

function BuscarPadron(Ci: String):Persona;
var
  DatosPersona : TParts;
  p: Persona;

begin
  Assign(PunteroDeArchivo, PadronFile);
  Reset(PunteroDeArchivo); { va al inicio para lectura }
  While NOT EOF(PunteroDeArchivo) do
  begin
      Readln(PunteroDeArchivo, Linea);
      DatosPersona := splitString(Linea, ',');
      if DatosPersona[1] = Ci then
      begin
        p.ci:= DatosPersona[1];
        p.nombre:= DatosPersona[2];
        p.edad:= StrToInt(DatosPersona[3]);
        p.sexo:= DatosPersona[4];
        BuscarPadron:= p;
        break;
      end
  end;
  Close(PunteroDeArchivo);
  BuscarPadron:= p;
end;



  begin
  end.
