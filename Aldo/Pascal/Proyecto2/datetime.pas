unit DateTime;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils;

Const
  Fmt = 'dd mm yyyy hh:nn';
Var
  Cmp : Integer;

Function Test(D1,D2 : TDateTime):Integer;
implementation

Function Test(D1,D2 : TDateTime):Integer;
  begin
    Test:= CompareDateTime(D1,D2);
  end;



end.

