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

    Contributor(s):
    
    Website: http://sourceforge.net/projects/ekeyfinder/
    Compiles With: Delphi 7, Boreland Dev Studio 2006, DS Turbo Delphi 2006, Delphi 2007
}
unit remote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry;

type
  TfrmRemote = class(TForm)
    Label2: TLabel;
    PaswrdLbl: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ConnectBtn: TButton;
    CancelBtn: TButton;
    NameOrIP: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRemote: TfrmRemote;

implementation

uses 
  Main;

{$R *.dfm}

procedure TfrmRemote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.Enabled := True;
end;

procedure TfrmRemote.Button2Click(Sender: TObject);
begin
  Edit1.Text := '';
  Close;
end;

procedure TfrmRemote.Button1Click(Sender: TObject);
var
  s1: string;
begin
  s1 := GetPCName;
  if (Lowercase(Edit1.Text) = LowerCase(s1)) or (Lowercase(Edit1.Text) = '\\' + Lowercase(s1)) then
  begin
    ShowMessage('You cannot connect to your own computer.');
  end
  else
  begin
    frmMain.RemotePC1.Checked := True;
    frmMain.ProgramInit;
    Close;
  end;
end;

end.
