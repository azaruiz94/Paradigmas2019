program project1;

{Libreria contacto}
uses
  gestorDeArchivo,upersona, crt, gestordepadron;
const
  logFile = 'log.txt';
var
  criterio : String;
  votante: Persona;
  lugar: string;
  ptr_archivo: text;
  linea: string;

begin
        WriteLn('Bienvenidos al padron...');
        WriteLn;
        Assign(ptr_archivo, logFile);
        Rewrite(ptr_archivo);
        Writeln (ptr_archivo, 'Log del programa...');
        close(ptr_archivo);
  repeat

        WriteLn('Ingrese el Numero de cedula a buscar:');

        ReadLn(criterio);
        WriteLn;

        votante:= BuscarPadron(criterio);
        lugar:= verificarLugar(votante);
        linea:= criterio + ': ' + lugar;
        Append(ptr_archivo);
        Writeln(ptr_archivo, linea);
        WriteLn(criterio + ': ' + lugar);
        close(ptr_archivo);


  until criterio = '';
  close (ptr_archivo);
  readkey;

end.

