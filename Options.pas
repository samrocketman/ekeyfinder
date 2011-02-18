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


unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;//, Registry, IniFiles;

{function SaveFont1(F_Font: TFont): boolean;
function SaveFont2(F_Font: TFont): boolean;
function SetFont1(F_Font: TFont): boolean;
function SetFont2(F_Font: TFont): boolean;}

type
  TfrmOptions = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtCSV1: TEdit;
    OptChkBxErrLog: TCheckBox;
    OptFontBox1: TGroupBox;
    LblAppList: TLabel;
    LblKeyDisp: TLabel;
    Button5: TButton;
    EdtLogPath: TEdit;
    OptUnstableUpdates: TCheckBox;
    procedure OptUnstableUpdatesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure OptChkBxErrLogClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses
  Main;

{$R *.dfm}

procedure TfrmOptions.Button1Click(Sender: TObject);
begin
  frmMain.FontDialog.Font := frmMain.ListBox1.Font;
  frmMain.FontDialog.Execute;
  frmMain.ListBox1.Font := frmMain.FontDialog.Font;
  LblAppList.Font := frmMain.ListBox1.Font;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.Enabled := True;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  Label2.Font     := frmMain.ListBox1.Font;
  LblAppList.Font := frmMain.ListBox1.Font;
  Label3.Font     := frmMain.Memo1.Font;
  LblKeyDisp.Font := frmMain.Memo1.Font;
  LblAppList.Font := frmMain.ListBox1.Font;
  LblKeyDisp.Font := frmMain.Memo1.Font;
  EdtCSV1.Text     := frmMain.sDelimCSV;
  EdtLogPath.Text := sLogFilePath;
  OptChkBxErrLog.Checked := bLogging;
  Button5.Enabled := OptChkBxErrLog.Checked;
  EdtLogPath.Enabled := OptChkBxErrLog.Checked;
  OptUnstableUpdates.Checked := followUnstable;

end;

procedure TfrmOptions.Button2Click(Sender: TObject);
begin
  frmMain.FontDialog.Font := frmMain.Memo1.Font;
  frmMain.FontDialog.Execute;
  frmMain.Memo1.Font := frmMain.FontDialog.Font;
  LblKeyDisp.Font  := frmMain.Memo1.Font;
end;

procedure TfrmOptions.Button3Click(Sender: TObject);
begin
  bSaveSettings := True;

  if EdtCSV1.Text = '"' then
  begin
    Application.MessageBox('You can''t use a double quote as a delimiter.', 'CSV Note');
    Exit;
  end;
  if EdtCSV1.Text <> '' then
    frmMain.sDelimCSV := EdtCSV1.Text;
  if EdtLogPath.Text <> '' then
    frmMain.sLogPath := EdtLogPath.Text;
  frmMain.SaveSettings(frmMain);
  Close;
end;

procedure TfrmOptions.Button5Click(Sender: TObject);
//var
  //bBrowse: boolean;
begin
  //bBrowse := BrowseForFolder(frmMain.sLogPath, 'Select The Log Directory...');
  BrowseForFolder(frmMain.sLogPath, 'Select The Log Directory...');
  EdtLogPath.Text := frmMain.sLogPath;
  sLogFilePath := frmMain.sLogPath;
end;

procedure TfrmOptions.OptChkBxErrLogClick(Sender: TObject);
begin
  Button5.Enabled := OptChkBxErrLog.Checked;
  EdtLogPath.Enabled := OptChkBxErrLog.Checked;
  bLogging := OptChkBxErrLog.Checked;
end;

procedure TfrmOptions.OptUnstableUpdatesClick(Sender: TObject);
begin
  followUnstable := OptUnstableUpdates.Checked;
end;

end.
