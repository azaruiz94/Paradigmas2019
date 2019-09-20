program Project2;
uses crt, Tarea, strtools, DateUtils, SysUtils;

var
  titulo, fecha, detalle: string;
  activ: actividad;
  entrada: integer;
  fmt: string;

begin
  cargar_archivo(activ); {carga el archivo en el arreglo de actividades}
  fmt:= 'dddd dd mmmm yyyy hh:nn';
  repeat
      clrscr;
      writeln('Administrador de tareas');
      writeln('Hoy es: ', FormatDateTime(fmt, Now));
      tareas_del_dia(activ);
      writeln('Menu de Opciones');
      writeln('1- Agregar Tarea');
      writeln('2- Listar por fecha');
      writeln('3- Eliminar tarea');
      writeln('4- Listar todas');
      writeln('5- Salir');
      readln(entrada);
      clrscr;
      case entrada of {opcion ingresada por el usuario}
          1:
            begin  {agrega una tarea ingresada por el ususario}
                 agregar_tarea(titulo, fecha, detalle, activ);
            end;
          2:
            begin {lista las tareas que hayan en una fecha especidicada por el usuario}
                 listar_xfecha(fecha, activ);
            end;
          3:
            begin {elimina un tarea}
                 eliminar_tarea(activ);
            end;
          4:
            begin  {lista todas las tareas existentes}
                 listar_tareas(activ);
                 readkey;
            end;
      end;
   until entrada=5;
end.

