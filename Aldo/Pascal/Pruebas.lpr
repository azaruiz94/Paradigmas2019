program Pruebas;
uses sysutils, crt;
var
  title,  title2,
  underline,
  line, row1, row2, row3,
  fmt : string;
  i : integer;
begin
  fmt := '%-12s';
  title := format(fmt,['Column 1']) + format(fmt,['Column 2']) ;
  for i := 1 to 12 do underline := underline + '-';
  underline := underline + underline ;
  fmt := '%-12d';
  line := format(fmt,[15]) + format(fmt,[8]) ;
  fmt := '%12s';
  title2 := format(fmt,['Column 1']) + format(fmt,['Column 2']) ;
  fmt := '%12d';
  row1 := format(fmt,[15]) + format(fmt,[8]) ;
  row2 := format(fmt,[1005]) + format(fmt,[809]) ;
  fmt := '%12.5d';
  row3 := format(fmt,[1005]) + format(fmt,[809]) ;
  readkey;
end.
