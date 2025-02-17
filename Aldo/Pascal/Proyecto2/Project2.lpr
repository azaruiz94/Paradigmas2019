program Project2;
uses
  {$ifdef unix}
  cthreads,
  {$endif}
  Classes,
  crt, Tarea, strtools, DateUtils, SysUtils;

type
    TMyThread = class(TThread)
       procedure Execute; override;
    end;

var
  titulo, fecha, detalle: string;
  activ: actividad;
  entrada: integer;
  fmt: string;
  t: TThread;

procedure TMyThread.Execute;
  var
    cmp, cont, i: integer;
    fmt: string;
    ahora: string;
  begin
     fmt:= 'dd/mm/yyyy hh:nn';
     cont:= activ.cont;
     while (not Terminated)  do
        begin
          for i:=1 to cont do
              begin
                 ahora:= FormatDateTime(fmt, Now);
                 cmp:= CompareDateTime(StrToDateTime(arreglo_tarea[i].fecha), StrToDateTime(ahora));
                 if((cmp = 0) and (arreglo_tarea[i].hecho = false)) then
                 begin
                   Writeln('Alarma!!! debe ', arreglo_tarea[i].titulo);
                   t.Sleep((14000));
                 end;
              end;
          t.Sleep(1000);
        end;
  end;

procedure alarma();
  begin
     t := TMyThread.Create(true);
     t.FreeOnTerminate:=true;
     t.Start;
  end;

begin
  cargar_archivo(activ); {carga el archivo en el arreglo de actividades}
  ordenarTareas(activ);
  alarma();
  fmt:= 'dddd dd mmmm yyyy hh:nn';
  repeat
      clrscr;
      writeln('Administrador de tareas':60);
      writeln('Hoy es ', FormatDateTime(fmt, Now));
      tareas_del_dia(activ);
      writeln('Menu de Opciones');
      writeln('1- Agregar Tarea');
      writeln('2- Listar por fecha y hora ');
      writeln('3- Eliminar tarea');
      writeln('4- Listar todas');
      writeln('5- Marcar como hecha');
      writeln('6- Salir');
      readln(entrada);
      clrscr;
      case entrada of {opcion ingresada por el usuario}
          1:
            begin  {agrega una tarea ingresada por el ususario}
                 t.Terminate;
                 agregar_tarea(titulo, fecha, detalle, activ);
                 alarma();
            end;
          2:
            begin {lista las tareas que hayan en una fecha especidicada por el usuario}
                 listar_xfecha(fecha, activ);
            end;
          3:
            begin {elimina un tarea}
                 t.Terminate;
                 eliminar_tarea(activ);
                 alarma();
            end;
          4:
            begin  {lista todas las tareas existentes}
                 listar_tareas(activ);
                 readkey;
            end;
          5:
            begin  {lista todas las tareas existentes}
                 t.Terminate;
                 cambiar_estado(activ);
                 alarma();
                 readkey;
            end;
      end;
   until entrada=6;
end.

