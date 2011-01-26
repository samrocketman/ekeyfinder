unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtDlgs, Menus, ExtCtrls, StdCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MnuSourceforgeWebClick: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem4: TMenuItem;
    MenuSaveAs: TMenuItem;
    MenuExit: TMenuItem;
    MenuItem7: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormResize(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuRefreshClick(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
    procedure MnuSourceforgeWebClickClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 
const
  sLineBreak = {$IFDEF LINUX} AnsiChar(#10) {$ENDIF} {$IFDEF MSWINDOWS} AnsiString(#13#10) {$ENDIF};

implementation

{ TForm1 }

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  ShowMessage('About Enchanted Keyfinder Linux Edition' + sLineBreak + sLineBreak + 'Built for Ubuntu Linux.' + sLineBreak + 'GTK2 Interface' + sLineBreak + 'Built using Lazarus from freepascal.org.' + sLineBreak + sLineBreak + 'Created by Sam Gleske (sag47)');
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin

end;

procedure TForm1.FormResize(Sender: TObject);
var
  i: integer;
begin
  i := (Form1.Width div 100) * 50;
  StatusBar1.Panels.Items[0].Width := i;
  i := (i div 100) * 50;
  StatusBar1.Panels.Items[1].Width := i;
  StatusBar1.Panels.Items[2].Width := i;
end;

procedure TForm1.MenuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
var
  AProcess: TProcess;
  Browser: string;
begin
  if FileExists('/usr/bin/firefox') then
    Browser := '/usr/bin/firefox'
  else
  begin
    ShowMessage('/usr/bin/firefox not found!');
    Exit;
  end;

  try
    AProcess := TProcess.Create(nil);
    AProcess.CommandLine := Browser + ' http://sourceforge.net/tracker/?group_id=369948';
    AProcess.Execute;
  finally
    AProcess.Free;
  end;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
var
  AProcess: TProcess;
  Browser: string;
begin
  if FileExists('/usr/bin/firefox') then
    Browser := '/usr/bin/firefox'
  else
  begin
    ShowMessage('/usr/bin/firefox not found!');
    Exit;
  end;

  try
    AProcess := TProcess.Create(nil);
    AProcess.CommandLine := Browser + ' http://sourceforge.net/apps/phpbb/keyfinder/';
    AProcess.Execute;
  finally
    AProcess.Free;
  end;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
var
  AProcess: TProcess;
  Browser: string;
begin
  if FileExists('/usr/bin/firefox') then
    Browser := '/usr/bin/firefox'
  else
  begin
    ShowMessage('/usr/bin/firefox not found!');
    Exit;
  end;

  try
    AProcess := TProcess.Create(nil);
    AProcess.CommandLine := Browser + ' http://sourceforge.net/apps/mediawiki/keyfinder/';
    AProcess.Execute;
  finally
    AProcess.Free;
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var
  AProcess: TProcess;
  Editor: string;
begin
  if FileExists('/usr/bin/gedit') then
    Editor := '/usr/bin/gedit'
  else
  begin
    ShowMessage('/usr/bin/gedit not found!');
    Exit;
  end;
  if FileExists(ExtractFilePath(Application.ExeName) + 'keyfinder.cfg') then
  begin
    try
      AProcess := TProcess.Create(nil);
      AProcess.CommandLine := Editor + ' ''' + ExtractFilePath(Application.ExeName) + 'keyfinder.cfg''';
      AProcess.Execute;
    finally
      AProcess.Free;
    end;
  end
  else
    ShowMessage('There is no keyfinder.cfg file.');
end;

procedure TForm1.MenuRefreshClick(Sender: TObject);
begin

end;

procedure TForm1.MenuSaveAsClick(Sender: TObject);
begin

end;

procedure TForm1.MnuSourceforgeWebClickClick(Sender: TObject);
var
  AProcess: TProcess;
  Browser: string;
begin
  if FileExists('/usr/bin/firefox') then
    Browser := '/usr/bin/firefox'
  else
  begin
    ShowMessage('/usr/bin/firefox not found!');
    Exit;
  end;

  try
    AProcess := TProcess.Create(nil);
    AProcess.CommandLine := Browser + ' http://sourceforge.net/projects/keyfinder/';
    AProcess.Execute;
  finally
    AProcess.Free;
  end;
end;


initialization
  {$I main.lrs}

end.

