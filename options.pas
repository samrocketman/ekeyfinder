{
    The Enchanted Keyfinder is a free utility that retrieves your
    Product Key (cd key) used to install Windows from your registry.

    Copyright (C) 2011 Enchanted Keyfinder Project
    Copyright (C) 1999-2008  Magical Jelly Bean Software

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
  TForm_Options = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    ButOptRestDef: TButton;
    Label4: TLabel;
    EdtCSV1: TEdit;
    OptChkBxErrLog: TCheckBox;
    OptChkBxSave: TCheckBox;
    OptFontBox1: TGroupBox;
    LblAppList: TLabel;
    LblKeyDisp: TLabel;
    Button5: TButton;
    EdtLogPath: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButOptRestDefClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure OptChkBxErrLogClick(Sender: TObject);
    procedure OptChkBxSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Options: TForm_Options;

implementation

uses
  Main;

{$R *.dfm}

procedure TForm_Options.Button1Click(Sender: TObject);
begin
  frm_MainWindow.FontDialog.Font := frm_MainWindow.ListBox1.Font;
  frm_MainWindow.FontDialog.Execute;
  frm_MainWindow.ListBox1.Font := frm_MainWindow.FontDialog.Font;
  //Button1.Font := Form1.ListBox1.Font;
  LblAppList.Font := frm_MainWindow.ListBox1.Font;
end;

procedure TForm_Options.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frm_MainWindow.Enabled := True;
end;

procedure TForm_Options.FormCreate(Sender: TObject);
begin
  Label2.Font     := frm_MainWindow.ListBox1.Font;
  LblAppList.Font := frm_MainWindow.ListBox1.Font;
  Label3.Font     := frm_MainWindow.Memo1.Font;
  LblKeyDisp.Font := frm_MainWindow.Memo1.Font;
  {SetFont1(Form1.ListBox1.Font);
  SetFont2(Form1.Memo1.Font);}
  LblAppList.Font := frm_MainWindow.ListBox1.Font;
  LblKeyDisp.Font := frm_MainWindow.Memo1.Font;
  //Button1.Font := Form1.ListBox1.Font;
  //Button2.Font := Form1.Memo1.Font;
  EdtCSV1.Text     := frm_MainWindow.sDelimCSV;
  EdtLogPath.Text := sLogFilePath;
  OptChkBxErrLog.Checked := bLogging;
  Button5.Enabled := OptChkBxErrLog.Checked;
  EdtLogPath.Enabled := OptChkBxErrLog.Checked;

end;

procedure TForm_Options.Button2Click(Sender: TObject);
begin
  frm_MainWindow.FontDialog.Font := frm_MainWindow.Memo1.Font;
  frm_MainWindow.FontDialog.Execute;
  frm_MainWindow.Memo1.Font := frm_MainWindow.FontDialog.Font;
  LblKeyDisp.Font  := frm_MainWindow.Memo1.Font;
  //Button2.Font := Form1.Memo1.Font;
end;

procedure TForm_Options.Button3Click(Sender: TObject);
{var
  MyINI: TINIFile;}
begin
  bSaveSettings := OptChkBxSave.Checked;
  {SaveFont1(Button1.Font);
  SaveFont2(Button2.Font);}
  {try
    myINI := TINIFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    SaveFont(myINI, 'AppListFont', Form1.ListBox1.Font);
    SaveFont(myINI, 'KeyListFont', Form1.Memo1.Font);
  finally
    myINI.Free;
  end;     }
  if EdtCSV1.Text = '"' then
  begin
    Application.MessageBox('You can''t use a double quote as a delimiter.', 'CSV Note');
    Exit;
  end;
  if EdtCSV1.Text <> '' then
    frm_MainWindow.sDelimCSV := EdtCSV1.Text;
  if EdtLogPath.Text <> '' then
    frm_MainWindow.sLogPath := EdtLogPath.Text;
  frm_MainWindow.SaveSettings(frm_MainWindow);
  Close;
end;

procedure TForm_Options.Button5Click(Sender: TObject);
//var
  //bBrowse: boolean;
begin
  //bBrowse := BrowseForFolder(Form1.sLogPath, 'Select The Log Directory...');
  BrowseForFolder(frm_MainWindow.sLogPath, 'Select The Log Directory...');
  EdtLogPath.Text := frm_MainWindow.sLogPath;
  sLogFilePath := frm_MainWindow.sLogPath;
end;

procedure TForm_Options.OptChkBxErrLogClick(Sender: TObject);
begin
  Button5.Enabled := OptChkBxErrLog.Checked;
  EdtLogPath.Enabled := OptChkBxErrLog.Checked;
  bLogging := OptChkBxErrLog.Checked;
end;

procedure TForm_Options.OptChkBxSaveClick(Sender: TObject);
begin
  bSaveSettings := OptChkBxSave.Checked; 
end;

procedure TForm_Options.ButOptRestDefClick(Sender: TObject);
//var
  //MyINI: TINIFile;
begin
  frm_MainWindow.ListBox1.Font := Label2.Font;
  frm_MainWindow.Memo1.Font    := Label3.Font;
  {SaveFont1(Form1.ListBox1.Font);
  SaveFont2(Form1.Memo1.Font);}
  {try
    myINI := TINIFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    SaveFont(myINI, 'AppListFont', Form1.ListBox1.Font);
    SaveFont(myINI, 'KeyListFont', Form1.Memo1.Font);
  finally
    myINI.Free;
  end;    }
  frm_Options.FormCreate(frm_Options);
  EdtCSV1.Text     := DefDelimCSV;
  EdtLogPath.Text := DefLogPath;
  OptChkBxErrLog.Checked := False;
  OptChkBxSave.Checked := False;
  frm_Options.OptChkBxErrLogClick(frm_Options);
end;

//old method for storing font settings.
//kept for archive purposes, do not reinstate
//keyfinder should remain portable
{function SaveFont1(F_Font: TFont): boolean;
var
  FontInfo: Windows.TLogFont; // font definition structure
  MyReg: TRegistry;
begin
  GetObject(F_Font.Handle, SizeOf(FontInfo), @FontInfo);
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_CURRENT_USER;
  try
    MyReg.OpenKey('Software\Enchanted Keyfinder\Keyfinder', True);
    MyReg.WriteBinaryData('Font1', FontInfo, SizeOf(FontInfo));
    Result := True;
  finally
    MyReg.Free;
  end;
end;}

{function SetFont1(F_Font: TFont): boolean;
var
  FontInfo: Windows.TLogFont; // font definition structure
  MyReg: TRegistry;
  NewFHnd: HFONT;
begin
  Result := False;
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_CURRENT_USER;
  try
    if MyReg.OpenKey('Software\Enchanted Keyfinder\Keyfinder', False) and
      MyReg.ValueExists('Font1') then
    begin
      MyReg.ReadBinaryData('Font1', FontInfo, SizeOf(FontInfo));
      //set Font to the retrieved font
      NewFHnd := CreateFontIndirect(FontInfo);
      Result  := (NewFHnd <> 0);
      if Result then
        F_Font.Handle := NewFHnd;
    end;
  finally
    MyReg.Free;
  end;
end;}

{function SaveFont2(F_Font: TFont): boolean;
var
  FontInfo: Windows.TLogFont; // font definition structure
  MyReg: TRegistry;
begin
  GetObject(F_Font.Handle, SizeOf(FontInfo), @FontInfo);
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_CURRENT_USER;
  try
    MyReg.OpenKey('Software\Enchanted Keyfinder\Keyfinder', True);
    MyReg.WriteBinaryData('Font2', FontInfo, SizeOf(FontInfo));
    Result := True;
  finally
    MyReg.Free;
  end;
end;}

{function SetFont2(F_Font: TFont): boolean;
var
  FontInfo: Windows.TLogFont; // font definition structure
  MyReg:   TRegistry;
  NewFHnd: HFONT;
begin
  Result := False;
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_CURRENT_USER;
  try
    if MyReg.OpenKey('Software\Enchanted Keyfinder\Keyfinder', False) and
      MyReg.ValueExists('Font2') then
    begin
      MyReg.ReadBinaryData('Font2', FontInfo, SizeOf(FontInfo));
      //set Font to the retrieved font
      NewFHnd := CreateFontIndirect(FontInfo);
      Result  := (NewFHnd <> 0);
      if Result then
        F_Font.Handle := NewFHnd;
    end;
  finally
    MyReg.Free;
  end;
end;}

end.
