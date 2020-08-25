program Project1;
uses
    crt;
const
  nomb_archivo ='archivo.txt';
var
  ptr_archivo: Text;
  c: char;
  i, cont: integer;
  oracion: array [1..100] of char;

begin
  assign(ptr_archivo, nomb_archivo);
  rewrite(ptr_archivo);
  writeln('Ingrese caracteres: ');
  cont:=0;
  while(not EOLN) and (cont < 100) do
    begin
      cont:= cont + 1;
      read(oracion[cont]);
    end;
  for i:=cont downto 1 do
    begin
      write(oracion[i]);
      write(ptr_archivo, oracion[i])
    end;
  readkey;
  close(ptr_archivo)
end.

