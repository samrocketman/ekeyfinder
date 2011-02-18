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


unit registration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry;

type
  TfrmRegistration = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistration: TfrmRegistration;
  keychange, ownerchange, organizationchange: boolean;

implementation

uses 
  Main;

{$R *.dfm}

procedure TfrmRegistration.Button1Click(Sender: TObject);
var
  Registry: TRegistry;

begin
  if ownerchange = true then
  begin
    if frmMain.ListBox2.Items.Strings[0] = 'WinXP' then
    begin
      Registry:=TRegistry.Create;
      Registry.RootKey:=HKEY_LOCAL_MACHINE;
      if Registry.OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion',False) then
      begin
        Registry.WriteString('RegisteredOwner',Edit2.Text);
      end;
      Registry.CloseKey;
      Registry.Free;
    end;

    if frmMain.ListBox2.Items.Strings[0] = 'Win9x' then
    begin
      Registry:=TRegistry.Create;
      Registry.RootKey:=HKEY_LOCAL_MACHINE;
      if Registry.OpenKey(sHiveLoc + '\Microsoft\Windows\CurrentVersion',False) then
      begin
        Registry.WriteString('RegisteredOwner',Edit2.Text);
      end;
      Registry.CloseKey;
      Registry.Free;
    end;
  end;

  if organizationchange = true then
  begin
    if frmMain.ListBox2.Items.Strings[0] = 'WinXP' then
    begin
      Registry:=TRegistry.Create;
      Registry.RootKey:=HKEY_LOCAL_MACHINE;
      if Registry.OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion',False) then
      begin
        Registry.WriteString('RegisteredOrganization',Edit3.Text);
      end;
      Registry.CloseKey;
      Registry.Free;
    end;

    if frmMain.ListBox2.Items.Strings[0] = 'Win9x' then
    begin
      Registry:=TRegistry.Create;
      Registry.RootKey:=HKEY_LOCAL_MACHINE;
      if Registry.OpenKey(sHiveLoc + '\Microsoft\Windows\CurrentVersion',False) then
      begin
        Registry.WriteString('RegisteredOrganization',Edit3.Text);
      end;
      Registry.CloseKey;
      Registry.Free;
    end;
  end;
  
  Close;
  frmMain.ListBox1.Selected[0] := True;
  frmMain.ListBox1Click(frmMain);
end;

procedure TfrmRegistration.Button2Click(Sender: TObject);
begin
  Button1.Enabled := False;
  Close;
end;

procedure TfrmRegistration.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.Enabled := True;
end;

procedure TfrmRegistration.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  ownerchange := true;
  Button1.Enabled := true;
end;

procedure TfrmRegistration.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  organizationchange := true;
  Button1.Enabled := True;
end;

procedure TfrmRegistration.FormShow(Sender: TObject);
begin
  keychange := False;
  ownerchange := false;
  organizationchange := false;
end;

procedure TfrmRegistration.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  keychange := true;
  Button1.Enabled := True
end;

end.
