program Pruebas;
{$mode objfpc}

uses
  {$ifdef unix}
  cthreads,
  {$endif}
  Classes;

type
  TMyThread = class(TThread)
    procedure Execute; override;
  end;

procedure TMyThread.Execute;
begin
  WriteLn('I am thread with ID ',ThreadID);
end;

var
  t1,t2,t3: TThread;
  var i:integer;
begin
  // create all threads in suspended state
  t1 := TMyThread.Create(true);
  t1.FreeOnTerminate := true;
  t2 := TMyThread.Create(true);
  t2.FreeOnTerminate := true;
  t3 := TMyThread.Create(true);
  t3.FreeOnTerminate := true;

  // start them all
  t1.Start;
  t2.Start;
  t3.Start;

  for i:= 1 to 10000 do
    begin
      write(i, '+');
    end;

  // wait for them all to finish before exiting main thread
  t1.WaitFor;
  t2.WaitFor;
  t3.WaitFor;
end.

