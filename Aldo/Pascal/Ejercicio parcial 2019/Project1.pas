program Project1;
uses
    crt;
const
  nomb_archivo ='archivo.txt';
  TAM = 100;
var
  ptr_archivo: Text;
  c: char;
  i, cont: integer;
  oracion: array [1..TAM] of char;

begin
  writeln('Ingrese caracteres: ');
  cont:=0;
  while(not EOLN) and (cont < 100) do
    begin
      read(c);
      oracion[cont]:= c;
      cont:= cont + 1;
      //read(oracion[cont]);
    end;
  assign(ptr_archivo, nomb_archivo);
  rewrite(ptr_archivo);
  for i:=cont-1 downto 0 do
    begin
      write(oracion[i]);
      write(ptr_archivo, oracion[i])
    end;
  close(ptr_archivo);
  readkey;

end.

