unit Tarea;

interface

uses
  crt, strtools, sysutils, DateUtils;

const
  nom_archivo='datos.txt';
  max= 50;                        {maximo de 50 tareas}

type
  actividad= record               {TDA actividad o tarea}
             titulo: string;
             fecha: string;
             detalle: string;     {descripcion de la tarea}
             cont: integer;       {numero de la tarea}
             end;
var
  arreglo_tarea: array [1..max] of  actividad;    {arreglo de 50 actividades}
  archivo: text;                                  {puntero al archivo}
  cont: integer;                                  {para cantidad de tareas}

procedure agregar_tarea(var titulo, fecha, detalle:string; var activ: actividad);
procedure guardar_archivo(var activ: actividad);
procedure listar_xfecha(fecha:string; var activ: actividad);
procedure cargar_archivo(var activ: actividad);
procedure agregado_interno(var titulo, fecha, detalle:string; var activ: actividad);
procedure eliminar_tarea(var activ: actividad);
procedure listar_tareas(var activ: actividad);
procedure tareas_del_dia(var activ: actividad);

implementation

var
   i: Integer;

{procedimiento auxiliar que utiliza el programa para la carga de tareas durante la lectura del archivo}
procedure agregado_interno(var titulo, fecha, detalle:string; var activ: actividad);
    begin
       activ.cont+=1;
       arreglo_tarea[activ.cont].cont:=activ.cont;
       arreglo_tarea[activ.cont].titulo:=titulo;
       arreglo_tarea[activ.cont].fecha:=fecha;
       arreglo_tarea[activ.cont].detalle:=detalle;
    end;

{Agrega una tarea con los valores ingresados por el usuario}
procedure agregar_tarea(var titulo, fecha, detalle:string; var activ: actividad);
   begin
      activ.cont+=1;
      arreglo_tarea[activ.cont].cont:=activ.cont;
      writeln('Ingrese actividad: ');
      readln(titulo);
      arreglo_tarea[activ.cont].titulo:=titulo;
      writeln('Ingrese fecha y hora[dd/mm/yyyy hh:mm]: ');
      readln(fecha);
      arreglo_tarea[activ.cont].fecha:=fecha;
      writeln('Ingrese descripcion: ');
      readln(detalle);
      arreglo_tarea[activ.cont].detalle:=detalle;
      guardar_archivo(activ);
   end;

{guarda todos los elementos del arreglo de actividades separados con el caracter '|'
en un archivo que se encuentra la carperta del proyeccto}
procedure guardar_archivo(var activ: actividad);
   begin
      assign(archivo, nom_archivo);
      rewrite(archivo);
      cont:= activ.cont;
      for i:=1 to cont do
        begin
             writeln(archivo, arreglo_tarea[i].titulo,'|',
                              arreglo_tarea[i].fecha,'|',
                              arreglo_tarea[i].detalle);
        end;
      close(archivo);
   end;

{Lista las tareas que tengan una fecha especificada por el usuario}
procedure listar_xfecha(fecha: string; var activ: actividad);
  var
     encontrados: integer;   {por si encuentra tarea(s)}
     d1, d2: TDateTime;       {d1= entrada del usuario, d2= fecha de la tarea}
     cmp: integer;
  begin
      encontrados:=0;
      writeln('Ingrese la fecha[dd/mm/yyyy hh:mm]:');
      readln(fecha);
      d1:= StrToDateTime(fecha);
      cont:= activ.cont;
      for i:=1 to cont do
        begin
           d2:= StrToDateTime(arreglo_tarea[i].fecha);
           cmp:= CompareDateTime(d1,d2);
           if cmp >= 0 then
              begin
                   encontrados+=1;
                   writeln(encontrados,
                   arreglo_tarea[i].titulo:20,
                   arreglo_tarea[i].fecha:20,
                   arreglo_tarea[i].detalle:25);
              end;
        end;
      if encontrados=0 then writeln('No posee tarea(s) para el ', fecha);
      readkey;
  end;

{carga los los elementos del archivo a la ectructura para procesar}
procedure cargar_archivo(var activ: actividad);
  const
    titulo=0;
    fecha=1;
    detalle=2;
  var
     partes: TParts;
     linea: string;
  begin
      assign(archivo, nom_archivo);          {asigna el directorio a la variable archivo}
      reset(archivo);                        {lee el archivo para lectura}
      while not EOF(archivo) do              {mientras no sea el final del archivo}
      begin
         Readln(archivo, linea);
         partes:= StringSplit(linea, '|');  {divide una linea del achivo por el caracter |}
         agregado_interno(partes[titulo], partes[fecha], partes[detalle], activ);
      end;
      close(archivo);
  end;

{Lista todas las tareas existentes}
procedure listar_tareas(var activ: actividad);
  begin
     cont:= activ.cont;
     Writeln(cont);
     writeln('Tarea':20, 'Fecha':20, 'OBS':20 );
     for i:=1 to cont do
        begin
          writeln(arreglo_tarea[i].cont,
                  arreglo_tarea[i].titulo:20,
                  arreglo_tarea[i].fecha:20,
                  arreglo_tarea[i].detalle:25);
        end;
  end;

{elimina una tarea que el usuario especifique, }
procedure eliminar_tarea(var activ: actividad);
var
   numero:integer;
   cond: boolean;
begin
    cont:= activ.cont;
    listar_tareas(activ);
    writeln();
    writeln('Ingrese numero de tarea a eliminar o ingrese 0 para cancelar: ');
    readln(numero);
    cond:= (numero<>0) and (numero<=cont);
    if cond then
      begin
          for i:=1 to cont do
             begin
               if(i >= numero) then
                 arreglo_tarea[i]:= arreglo_tarea[i+1];
                 arreglo_tarea[i].cont:= i;
             end;
          activ.cont-=1;
          guardar_archivo(activ);
          writeln();
          writeln('La tarea ',numero,' se elimino correctamente...');
          listar_tareas(activ);
          readkey;
      end
    else if (numero<>0) then
      begin
          writeln('Entrada incorrecta...');
          readkey;
      end;
end;

procedure tareas_del_dia(var activ: actividad);
var
     principio, fin, fecha_tarea: TDateTime;
     cond: boolean;
     cmp1, cmp2, encontrados: integer;
  begin
     encontrados:= 0;
     principio:= StrToDateTime(concat(DateToStr(Date), ' 00:00'));
     fin:= StrToDateTime(concat(DateToStr(Date), ' 23:59'));
     cont:= activ.cont;
     write('Tareas para hoy...');
     for i:=1 to cont do
        begin
          fecha_tarea:= StrToDateTime(arreglo_tarea[i].fecha);
          cmp1:= CompareDateTime(fecha_tarea, principio);     { >0 si la fecha de la tarea es mayor al inicio del dia }
          cmp2:= CompareDateTime(fecha_tarea, fin);           { <0 si la fecha de la tarea es menor al fin del dia }
          cond:= (cmp1 > 0) and (cmp2 < 0);
          if cond then
            begin
                 encontrados+=1;
                 writeln();
                 writeln(encontrados,
                 arreglo_tarea[i].titulo:20,
                 arreglo_tarea[i].fecha:20,
                 arreglo_tarea[i].detalle:25);
            end;
        end;
     if encontrados=0 then writeln(' Yuhu! No tiene tareas hoy...');
  end;

end.

