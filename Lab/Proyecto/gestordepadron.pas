unit gestordepadron;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UPersona;

function verificarLugar(p: Persona): String;

implementation

function verificarLugar(p: Persona): String;
var
  lugar: String;
  edad: integer;
  sexo: string;
begin
  lugar:= '';
  edad:= p.edad;
  sexo:= p.sexo;
  if(p.ci = '') then
  begin
    lugar:= 'registro no existente en el padron';
  end
  else if(edad < 15) then
  begin
    lugar:= 'Es menor y no vota';
  end
  else if(edad > 71) then
  begin
       lugar:= 'Vota en Centro Regional de Encarnación';
  end
  else if((edad >= 51) and (edad <= 70)) then
  begin
       lugar:= 'Vota en Universidad Nacional de Itapua';
  end
  else if((edad >= 16) and (edad <= 50) and (sexo = ' M')) then
  begin
       lugar:= 'Vota en Centro Regional de Encarnación';
  end
  else if((edad >= 16) and (edad <= 50) and (sexo = ' F')) then
  begin
       lugar:= 'Vota en Colegio Tecnico';
  end;
  verificarLugar:= lugar;
end;

end.

