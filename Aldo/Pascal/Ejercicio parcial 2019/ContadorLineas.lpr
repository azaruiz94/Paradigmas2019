program ContadorLineas;

uses
    crt;

var
  contador:Integer;
  nomb_archivo, linea: String;
  ptr_archivo:Text;

begin
  contador:= 0;
  writeln('Ingrese el path del archivo:');
  readln(nomb_archivo);
  assign(ptr_archivo, nomb_archivo);
  reset(ptr_archivo);
  while (not EOF(ptr_archivo)) do
  begin
    readln(ptr_archivo, linea);
    contador:= contador + 1;
  end;
  writeln('El archivo contiene ', contador, ' lineas');
  readkey;
end.

