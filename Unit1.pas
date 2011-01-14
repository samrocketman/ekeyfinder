{
    The Magical Jelly Bean Keyfinder is a free utility that retrieves your
    Product Key (cd key) used to install Windows from your registry.
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


unit Unit1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ShellAPI;

type
  TOKBottomDlg = class(TForm)
    OKBtn: TButton;
    Memo1: TMemo;
    Button1: TButton;
    procedure OKBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg: TOKBottomDlg;

implementation

uses Main;

{$R *.dfm}

procedure TOKBottomDlg.OKBtnClick(Sender: TObject);
begin
  OKBottomDlg.Close;
end;

procedure TOKBottomDlg.Button1Click(Sender: TObject);
begin
  ShellExecute(Handle,NIL,PChar('http://www.gnu.org/licenses/gpl.txt'), nil,nil,SW_NORMAL);


end;

procedure TOKBottomDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Form1.Enabled := True;
end;

end.
