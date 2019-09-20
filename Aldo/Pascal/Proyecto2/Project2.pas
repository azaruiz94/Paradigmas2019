program Project2;

uses crt, tarea;

const

type

var
  titulo, fecha, hora, detalle: string;
  tarea: actividad

begin
  agregar_tarea(titulo, fecha, hora, detalle, tarea);
  writeln(titulo);
  writeln(fecha);
  writeln(hora);
  writeln(detalle);
  readln();
end.



