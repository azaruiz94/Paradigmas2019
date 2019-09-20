unit StrTools;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TParts = array of string;

//Functions

function StringPart(Source: string; seperator: char; Index: integer): string;
function StringParts(Source: string; seperator: char): integer;
function StringSplit(Source: string; seperator: char): TParts;

implementation

function StringSplit(Source: string; seperator: char): TParts;
var
  Count, counter: integer;
  TArray: array of string;
begin
  //Get parts count.
  Count := StringParts(Source, seperator);

  //Set length of array.
  SetLength(TArray, Count + 1);

  for counter := 0 to Count do
  begin
    //Fill array slots with split data.
    TArray[counter] := StringPart(Source, seperator, counter);
  end;

  //Return array
  Result := TArray;
end;

function StringParts(Source: string; seperator: char): integer;
var
  Counter, Count: integer;
begin

  Count := 0;

  if Source = '' then
    Result := 0;

  for Counter := 0 to Length(Source) do
  begin
    if Source[Counter] = seperator then
      Inc(Count);
  end;

  Result := Count;
end;

function StringPart(Source: string; seperator: char; Index: integer): string;
var
  Counter, j, iLen: integer;
  ch: char;
  Buffer, Temp: string;
begin

  //Init variables.
  Buffer := '';
  ch := #0;
  j := 0;
  Counter := 0;

  iLen := Length(Source);
  Temp := Source;

  if Temp[iLen] <> seperator then
  begin
    Temp := Temp + seperator;
  end;

  for Counter := 1 to iLen + 1 do
  begin
    //Get char.
    ch := Temp[Counter];

    if (ch <> seperator) then
    begin
      //build buffer if seperator not found.
      Buffer := Buffer + ch;
    end
    else
    begin
      //Check if we at the index.
      if (j = Index) then
      begin
        //Return string part.
        Result := Buffer;
        Exit;
      end
      else
      begin
        //INC index counter.
        Inc(j, 1);
        Buffer := '';
      end;
    end;
  end;
end;
end.
