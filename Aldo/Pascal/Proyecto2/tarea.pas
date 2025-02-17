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
             hecho: boolean;      {false= pendiente, true= hecho}
             end;
var
  arreglo_tarea: array [1..max] of  actividad;    {arreglo de 50 actividades}
  archivo: text;                                  {puntero al archivo}
  cont: integer;                                  {para cantidad de tareas}

procedure agregar_tarea(var titulo, fecha, detalle:string; var activ: actividad);
procedure guardar_archivo(var activ: actividad);
procedure listar_xfecha(fecha:string; var activ: actividad);
procedure cargar_archivo(var activ: actividad);
procedure agregado_interno(var titulo, fecha, detalle:string; hecho:boolean; var activ: actividad);
procedure eliminar_tarea(var activ: actividad);
procedure listar_tareas(var activ: actividad);
procedure tareas_del_dia(var activ: actividad);
function parse_hecho(estado:boolean):string;
procedure cambiar_estado(var activ: actividad);
procedure ordenarTareas(var activ: actividad);

implementation

var
   i: Integer;

{procedimiento auxiliar que utiliza el programa para la carga de tareas durante la lectura del archivo}
procedure agregado_interno(var titulo, fecha, detalle:string; hecho:boolean; var activ: actividad);
    begin
       activ.cont+=1;
       arreglo_tarea[activ.cont].cont:=activ.cont;
       arreglo_tarea[activ.cont].titulo:=titulo;
       arreglo_tarea[activ.cont].fecha:=fecha;
       arreglo_tarea[activ.cont].detalle:=detalle;
       arreglo_tarea[activ.cont].hecho:=hecho;
    end;

{Agrega una tarea con los valores ingresados por el usuario}
procedure agregar_tarea(var titulo, fecha, detalle:string; var activ: actividad);
var
   hora: string;
   begin
      activ.cont+=1;
      arreglo_tarea[activ.cont].cont:=activ.cont;
      writeln('Ingrese actividad:');
      readln(titulo);
      arreglo_tarea[activ.cont].titulo:=titulo;
      writeln('Ingrese la fecha[dd/mm/yyyy]:');
      readln(fecha);
      fecha:= Concat(fecha,' ');
      writeln('Ingrese la hora[hh:mm] en formato 24hs:');
      readln(hora);
      fecha:= Concat(fecha, hora);
      arreglo_tarea[activ.cont].fecha:=fecha;
      writeln('Ingrese descripcion:');
      readln(detalle);
      arreglo_tarea[activ.cont].detalle:=detalle;
      arreglo_tarea[activ.cont].hecho:= false;
      ordenarTareas(activ);
      guardar_archivo(activ);
   end;

{guarda todos los elementos del arreglo de actividades separados con el caracter '|'
en un archivo que se encuentra la carperta del proyecto}
procedure guardar_archivo(var activ: actividad);
   begin
      assign(archivo, nom_archivo);
      rewrite(archivo);
      cont:= activ.cont;
      for i:=1 to cont do
        begin
             writeln(archivo, arreglo_tarea[i].titulo,'|',
                              arreglo_tarea[i].fecha,'|',
                              arreglo_tarea[i].detalle, '|',
                              arreglo_tarea[i].hecho );
        end;
      close(archivo);
   end;

{Lista las tareas que tengan una fecha especificada por el usuario}
procedure listar_xfecha(fecha: string; var activ: actividad);
  var
     encontrados: integer;   {por si encuentra tarea(s)}
     d1, d2: TDateTime;       {d1= entrada del usuario, d2= fecha de la tarea}
     cmp: integer;
     hora: string;
  begin
      encontrados:=0;
      writeln('Ingrese la fecha[dd/mm/yyyy]:');
      readln(fecha);
      fecha:= Concat(fecha,' ');
      writeln('Ingrese la hora[hh:mm] en formato 24hs:');
      readln(hora);
      fecha:= Concat(fecha, hora);
      d1:= StrToDateTime(fecha);
      cont:= activ.cont;
      for i:=1 to cont do
        begin
           d2:= StrToDateTime(arreglo_tarea[i].fecha);
           cmp:= CompareDateTime(d2,d1);         {>0 si la fecha de la tarea es mayor a la fecha ingresada por el usuario}
           if cmp >= 0 then
              begin
                   encontrados+=1;
                   writeln(encontrados,
                   arreglo_tarea[i].titulo:20,
                   arreglo_tarea[i].fecha:20,
                   arreglo_tarea[i].detalle:25,
                   parse_hecho(arreglo_tarea[i].hecho):20);
              end;
        end;
      if encontrados=0 then writeln('No posee tarea(s) despues del ', fecha);
      readkey;
  end;

{carga los los elementos del archivo a la ectructura para procesar}
procedure cargar_archivo(var activ: actividad);
  const
    titulo=0;
    fecha=1;
    detalle=2;
    hecho=3;
  var
     partes: TParts;
     linea: string;
     estado: boolean;
  begin
      assign(archivo, nom_archivo);          {asigna el directorio a la variable archivo}
      reset(archivo);                        {lee el archivo para lectura}
      while not EOF(archivo) do              {mientras no sea el final del archivo}
      begin
         Readln(archivo, linea);
         partes:= StringSplit(linea, '|');  {divide una linea del achivo por el caracter |}
         TryStrToBool(partes[hecho], estado);
         agregado_interno(partes[titulo], partes[fecha], partes[detalle], estado, activ);
      end;
      close(archivo);
      ordenarTareas(activ);
  end;

{Lista todas las tareas existentes}
procedure listar_tareas(var activ: actividad);
  begin
     cont:= activ.cont;
     writeln('#', 'Tarea':30, 'Fecha y hora ':18, 'Estado':11, 'OBS':40 );
     for i:=1 to cont do
        begin
          writeln(arreglo_tarea[i].cont,
                  arreglo_tarea[i].titulo:30,
                  arreglo_tarea[i].fecha:18,
                  parse_hecho(arreglo_tarea[i].hecho):11,
                  arreglo_tarea[i].detalle:40);

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
    cond:= (numero>0) and (numero<=cont);
    if cond then
      begin
          for i:=numero to cont do
             begin
                 arreglo_tarea[i]:= arreglo_tarea[i+1];
                 arreglo_tarea[i].cont:= i;
             end;
          activ.cont-=1;
          ordenarTareas(activ);
          guardar_archivo(activ);
          writeln();
          writeln('La tarea ',numero,' se elimino correctamente...');
          listar_tareas(activ);
          readkey;
      end
    else if (numero<0) or (numero>cont)then
      begin
          writeln('Entrada incorrecta...');
          readkey;
      end;
end;

{lista las tareas que empiezen las 00:00 hasta las 23:29 del corriente}
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
          cond:= (cmp1 > 0) and (cmp2 < 0) and (arreglo_tarea[i].hecho = false);
          if cond then
            begin
                 encontrados+=1;
                 writeln();
                 write(encontrados,
                 arreglo_tarea[i].titulo:40,
                 arreglo_tarea[i].fecha:18,
                 arreglo_tarea[i].detalle:40);
            end;
        end;
     if encontrados=0 then writeln(' Yuhu! No tiene tareas hoy...');
     writeln();
     writeln();
  end;

{conviente el boolean del estado de la tarea a pendiente o hecho}
function parse_hecho(estado: boolean):string;
var
     equivalente: string;
  begin
     if(estado) then equivalente:= 'Hecho'
     else equivalente:= 'Pendiente';
  parse_hecho:= equivalente;
  end;

{cambia el estado de una tarea a hecho/pendiente}
procedure cambiar_estado(var activ: actividad);
var
   numero:integer;
   cond: boolean;
begin
    cont:= activ.cont;
    listar_tareas(activ);
    writeln();
    writeln('Ingrese numero de tarea: ');
    readln(numero);
    cond:= (numero>0) and (numero<=cont);
    if cond then
      begin
          if(arreglo_tarea[numero].hecho) then arreglo_tarea[numero].hecho:= false
          else arreglo_tarea[numero].hecho:= true;
          writeln('La tarea ',numero,' se modifico correctamente...');
          guardar_archivo(activ);
          listar_tareas(activ)
      end
    else if (numero<0) or (numero> cont) then
      begin
          writeln('Entrada incorrecta...');
      end;
end;

{ordena las tareas del arreglo dependiendo de la fecha y hora utilizando
el algoritmo selection sort}
procedure ordenarTareas(var activ: actividad);
var
   tam, j, cmp, min: integer;
   fecha1, fecha2: TDateTime;
   aux: actividad;
begin
   tam:= activ.cont;
   for i:=1 to (tam-1) do
     begin
       min:= i;
      for j:=(i+1) to tam do
         begin
           fecha1:= StrToDateTime(arreglo_tarea[j].fecha);
           fecha2:= StrToDateTime(arreglo_tarea[min].fecha);
           cmp:= CompareDateTime(fecha1, fecha2);  { <0 si fecha1 es menor a fecha2 }
           if(cmp < 0) then
             begin
                 aux:= arreglo_tarea[min];
                 arreglo_tarea[min]:= arreglo_tarea[j];
                 arreglo_tarea[min].cont:=min;
                 arreglo_tarea[j]:= aux;
                 arreglo_tarea[j].cont:=j;
             end;
         end;

     end;
end;

end.

