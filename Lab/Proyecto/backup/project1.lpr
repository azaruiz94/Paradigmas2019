program project1;

{Libreria contacto}
uses
  gestorDeArchivo, crt;

var
  criterio : String;

begin
        WriteLn('Bienvenidos al padron...');
        WriteLn;
  repeat

        WriteLn('Ingrese el Numero de cedula a buscar:');

        ReadLn(criterio);
        WriteLn;

        BuscarPadron(criterio, 'M');
        //crearContacto();

  until criterio = '';
  readkey;

end.

