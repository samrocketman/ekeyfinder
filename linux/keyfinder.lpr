program keyfinder;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main, LResources
  { you can add units after this };

{$IFDEF WINDOWS}{$R keyfinder.rc}{$ENDIF}

begin
  {$I keyfinder.lrs}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

