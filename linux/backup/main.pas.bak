unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtDlgs, Menus, ExtCtrls, StdCtrls, Process, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuReadReg: TMenuItem;
    MnuSourceforgeWeb: TMenuItem;
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
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    procedure FormResize(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuReadRegClick(Sender: TObject);
    procedure MenuRefreshClick(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
    procedure MnuSourceforgeWebClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 
const
  kfVersion   = '0.1 Beta';
  kfDate      = 'January 20th, 2011';
  DefDelimCSV = ',';
  DefLogPath  = '.';
  KEY_WOW64_64KEY = $0100;
  sLineBreak = {$IFDEF LINUX} AnsiChar(#10) {$ENDIF} {$IFDEF MSWINDOWS} AnsiString(#13#10) {$ENDIF};

implementation

{ TForm1 }

{**************************************************
  This is a set of custom functions which I created
  to ease the process of certain functions
**************************************************}

function VisitWebsite(URL: string): boolean;
var
  AProcess: TProcess;
  Browser: string;
begin
  Result := True;
  //check for executable
  if FileExists('/usr/bin/firefox') then
    Browser := '/usr/bin/firefox'
  else
  begin
    ShowMessage('/usr/bin/firefox not found!');
    Result := False;
    Exit;
  end;

  //visit the website
  AProcess := TProcess.Create(nil);
  try
    AProcess.CommandLine := Browser + ' ' + URL;
    AProcess.Execute;
  finally
    AProcess.Free;
  end;
end;

function DownloadFile(sURL: string; sPath: string): boolean;
var
  AProcess: TProcess;
  downloader: string;
begin
  Result := True;
  //check for executable
  if FileExists('/usr/bin/wget') then
    downloader := '/usr/bin/wget'
  else
  begin
    ShowMessage('/usr/bin/wget not found!');
    Result := False;
    Exit;
  end;

  //download the file
  AProcess := TProcess.Create(nil);
  try
    AProcess.CommandLine := downloader + ' "' + sURL + '" -O "' + sPath + '"';// -o /var/tmp/update.ini'
    AProcess.Options := AProcess.Options + [poWaitOnExit];
    Aprocess.Execute;
  finally
    AProcess.Free;
  end;

  //check to make sure the file was downloaded correctly
  if not FileExists(sPath) then
  begin
    ShowMessage('Download failed.  Bad server connection?');
    Exit;
  end;
end;

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

procedure TForm1.MenuItem18Click(Sender: TObject);
var
  MyINI: TIniFile;
begin

  if DownloadFile('http://keyfinder.sourceforge.net/update.ini','/var/tmp/update.ini') then
    ShowMessage('Download Successful!')


  {MyINI := TIniFile.Create('/var/tmp/update.ini');
  try
    MyINI.ReadString('');
  finally
    MyINI.Free;
  end; }
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
begin
  VisitWebsite('http://sourceforge.net/tracker/?group_id=369948');
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  VisitWebsite('http://sourceforge.net/apps/phpbb/keyfinder/');
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
  VisitWebsite('http://sourceforge.net/apps/mediawiki/keyfinder/');
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem6Click(Sender: TObject);
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

procedure TForm1.MenuReadRegClick(Sender: TObject);
var
  filename: string;
  MyINI: TIniFile;
  somestring: string;
begin
  {if OpenDialog1.Execute then
  begin
    filename := OpenDialog1.Filename;
    //ShowMessage(filename);
    MyINI := TIniFile.Create(filename);
    try
      MyINI.ReadBinaryStream();
      somestring := MyINI.ReadString('HKEY_LOCAL_MACHINE\software\Axialis\IconWorkshop','"InstallDir"','');
    finally
      //MyINI.Destroy;
      MyINI.Free;
    end;
    ShowMessage(somestring);
  end; }

end;

procedure TForm1.MenuRefreshClick(Sender: TObject);
begin

end;

procedure TForm1.MenuSaveAsClick(Sender: TObject);
begin

end;

procedure TForm1.MnuSourceforgeWebClick(Sender: TObject);
begin
  VisitWebsite('http://sourceforge.net/projects/keyfinder/');
end;


initialization
  {$I main.lrs}

end.

