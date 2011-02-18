{
    The Enchanted Keyfinder is a free utility that retrieves your
    Product Key (cd key) used to install Windows from your registry.

    Copyright (C) 2011 Enchanted Keyfinder Project

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    WindowsUser.pas, released January 2011.
    The initial developer of this code is VersionBoy.
    Portions created by VersionBoy are Copyright (C) 2011.
    All Rights Reserved.

    Contributor(s):
                    Sam Gleske (sag47)

    Website: http://sourceforge.net/projects/ekeyfinder/
    Compiles With: Delphi 7, Boreland Dev Studio 2006, DS Turbo Delphi 2006, Delphi 2007
}
unit WinXPKey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, ShellAPI;

type
  TfrmWinXPKey = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWinXPKey: TfrmWinXPKey;

implementation

uses Main;

{$R *.dfm}

{Get path to temp DIR from Windows Env Variable}
function GetTempDirectory: String;
var
  tempFolder: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  result := StrPas(tempFolder);
end;

function GetSystemRoot: string;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion', False);
    result := ReadString('SystemRoot');
    if result = '' then
    begin
      CloseKey;
      OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion', False);
      result := ReadString('SystemRoot');
    end;
  finally
    Free
  end;
end;

procedure TfrmWinXPKey.Button1Click(Sender: TObject);
var
  fileName: string;
  myFile: TextFile;
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
begin

  // Write file to temp
  fileName := GetTempDirectory + 'chgxp.vbs';
  AssignFile(myFile, fileName);
  ReWrite(myFile);
  WriteLn(myFile, 'ON ERROR RESUME NEXT');
  WriteLn(myFile, 'if Wscript.arguments.count<1 then');
  WriteLn(myFile, 'Wscript.echo "An error has occurred. Please file a bug in the tracker."');
  WriteLn(myFile, 'Wscript.quit(1)');
  WriteLn(myFile, 'end if');
  WriteLn(myFile, 'Dim VOL_PROD_KEY');
  WriteLn(myFile, 'VOL_PROD_KEY = Wscript.arguments.Item(0)');
  WriteLn(myFile, 'VOL_PROD_KEY = Replace(VOL_PROD_KEY,"-","")');
  WriteLn(myFile, 'for each Obj in GetObject("winmgmts:{impersonationLevel=impersonate}").InstancesOf ("win32_WindowsProductActivation")');
  WriteLn(myFile, 'result = Obj.SetProductKey (VOL_PROD_KEY)');
  WriteLn(myFile, 'if err = 0 then');
  WriteLn(myFile, 'WScript.Echo "Your product key has been successfully updated."');
  WriteLn(myFile, 'end if');
  WriteLn(myFile, 'if err <> 0 then');
  WriteLn(myFile, 'WScript.Echo "An error has occurred. This was probably caused by the keying of an invalid number. Please check it and try again."');
  //WriteLn(myFile, 'Err.Clear');
  WriteLn(myFile, 'Wscript.quit(err)');
  WriteLn(myFile, 'end if');
  WriteLn(myFile, 'Next');
  CloseFile(myFile);

  //wait for the program to finish executing from ShellExec
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  with SEInfo do begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Application.Handle;
    //command to execute
    lpFile := PChar(GetSystemRoot + '\system32\wscript.exe');
    //parameters of command
    lpParameters := PChar('//E:vbscript ' + fileName + ' ' + Edit1.Text);
    //working directory
    lpDirectory := PChar(GetTempDirectory);
    nShow := SW_SHOWNORMAL;
  end;
  if ShellExecuteEx(@SEInfo) then begin
  repeat
    Application.ProcessMessages;
    GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;
  until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
    DeleteFile(fileName);
    if ExitCode = 0 then
    begin
      Close;   
      frmMain.ListBox1.Selected[0] := True;
      frmMain.ListBox1Click(frmMain);
    end;
  end;

  //Instant Execution
  //ShellExecute(Handle,'open', PChar(GetSystemRoot + '\system32\wscript.exe'),PChar('//E:vbscript ' + fileName + ' ' + Edit1.Text), nil, SW_SHOWNORMAL);
  //DeleteFile(fileName);
  //GetSystemRoot + '\system32\wscript.exe'
end;

procedure TfrmWinXPKey.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmWinXPKey.Edit1Change(Sender: TObject);
begin
  if (Edit1.Text <> 'Format (XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)') and (Edit1.Text <> '') then
    Button1.Enabled := True else
    Button1.Enabled := False;
end;

procedure TfrmWinXPKey.Edit1Click(Sender: TObject);
begin
  if Edit1.Text = 'Format (XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)' then
  begin
    Edit1.Text := '';
    //Edit1.Color := 0;
  end;
end;

procedure TfrmWinXPKey.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    Edit1.Text := 'Format (XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)';
    //Edit1.Color := 12632256;
    //Edit1.co
  end;
end;

procedure TfrmWinXPKey.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.Enabled := True;
end;

procedure TfrmWinXPKey.FormCreate(Sender: TObject);
begin
  //if Edit1.Text = 'Format (XXXX-XXXX-XXXX-XXXX-XXXX)' then
    //Edit1.Color := 12632256;
end;



end.
