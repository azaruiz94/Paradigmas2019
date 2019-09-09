program Ventas;
uses crt, strtools, sysutils, classes;

const
  nom_archivo='ventas.csv';
  MAX= 200;

type
  Venta= record
    anho: string;
    tienda: string;
    unidades: integer;
    monto: integer;
  end;

var
  ptr_archivo: text;
  linea: string;
  arreglo_ventas: array [1..MAX] of  Venta;
  tam: integer; {tam del arreglo ventas}

procedure importarArchivo();
  var
    partes: array of string;
    i: integer;
  begin
    assign(ptr_archivo, nom_archivo);
    reset(ptr_archivo); { va al inicio para lectura }
    i:=0;
    readln(ptr_archivo, linea); // lee la primera linea del archivo
    While NOT EOF(ptr_archivo) do
          begin
               readln(ptr_archivo, linea);
               partes:= StringSplit(linea, ',');
               tam+=1;
               arreglo_ventas[tam].anho:= partes[i];
               i:=i+1;
               arreglo_ventas[tam].tienda:= partes[i];
               i:=i+1;
               arreglo_ventas[tam].unidades:= StrToInt(partes[i]);
               i:=i+1;
               arreglo_ventas[tam].monto:= StrToInt(partes[i]);
               i:=0;
          end;
     close(ptr_archivo);
     readKey
  end;

procedure calcularDatos();
 var
   cantidad_1999A: integer;
   cantidad_2000A: integer;
   monto_1999A: integer;
   monto_2000A: integer;

   cantidad_1999B: integer;
   cantidad_2000B: integer;
   monto_1999B: integer;
   monto_2000B: integer;

   cantidad_1999C: integer;
   cantidad_2000C: integer;
   monto_1999C: integer;
   monto_2000C: integer;
   i: integer;
begin
   cantidad_1999A:=0;
   cantidad_2000A:=0;
   monto_1999A:= 0;
   monto_2000A:= 0;

   cantidad_1999B:=0;
   cantidad_2000B:=0;
   monto_1999B:= 0;
   monto_2000B:= 0;

   cantidad_1999C:=0;
   cantidad_2000C:=0;
   monto_1999C:= 0;
   monto_2000C:= 0;

   for i:=0 to MAX do
       begin
         if( (arreglo_ventas[i].anho = '1999') and  (arreglo_ventas[i].tienda = 'A') ) then
         begin
           cantidad_1999A:= cantidad_1999A + arreglo_ventas[i].unidades;
           monto_1999A:= monto_1999A + arreglo_ventas[i].monto;
         end
         else if((arreglo_ventas[i].anho = '1999') AND  (arreglo_ventas[i].tienda = 'B')) then
         begin
           cantidad_1999B:= cantidad_1999B + arreglo_ventas[i].unidades;
           monto_1999B:= monto_1999B + arreglo_ventas[i].monto;
         end
         else if((arreglo_ventas[i].anho ='1999')  AND (arreglo_ventas[i].tienda = 'C')) then
         begin
           cantidad_1999C:= cantidad_1999C + arreglo_ventas[i].unidades;
           monto_1999C:= monto_1999C + arreglo_ventas[i].monto;
         end
         else if((arreglo_ventas[i].anho = '2000') AND  (arreglo_ventas[i].tienda = 'A')) then
         begin
           cantidad_2000A:= cantidad_2000A + arreglo_ventas[i].unidades;
           monto_2000A:= monto_2000A + arreglo_ventas[i].monto;
         end
         else if((arreglo_ventas[i].anho = '2000') AND  (arreglo_ventas[i].tienda = 'B')) then
         begin
           cantidad_2000B:= cantidad_2000B + arreglo_ventas[i].unidades;
           monto_2000B:= monto_2000B + arreglo_ventas[i].monto;
         end
         else if((arreglo_ventas[i].anho =  '2000') AND  (arreglo_ventas[i].tienda = 'C' )) then
         begin
           cantidad_2000C:= cantidad_2000c + arreglo_ventas[i].unidades;
           monto_2000C:= monto_2000C + arreglo_ventas[i].monto;
         end
  end;
  writeLn('Tienda      1999        2000        total');
  writeLn('A:      ', (cantidad_1999A*monto_1999A), '  '  , (cantidad_1999A*monto_2000A));
  writeLn('B:      ', (cantidad_1999B*monto_1999B), '  '  ,(cantidad_1999B*monto_2000B));
  writeLn('C:      ', (cantidad_1999C*monto_1999C), '  '  ,(cantidad_1999C*monto_2000C));
end;


begin
  importarArchivo;
  calcularDatos;
  readkey;
end.

