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

    Coded by: versionboy
    Website : http://sourceforge.net/projects/keyfinder/
    Compiles in: Turbo Delphi 2006
}
program keyfinder;

{$define debug}   //debug setting - comment out for release version
{$ASSERTIONS ON}  //debug setting - comment out for release version

uses
  Forms,
  SysUtils,
  Main in 'Main.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit1 in 'Unit1.pas' {OKBottomDlg};

{$R *.res}

begin
  { Report memory leaks if run inside the Delphi 2006 debugger }
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  if (ParamCount = 1) and (AnsiLowerCase(ParamStr(1)) = '/?') or (AnsiLowerCase(ParamStr(1)) = '/help') then
  begin
    Application.MessageBox('Command Line Options: /save <location> /savecsv <location> /close /hive <location> /file <filename>', 'Magical Jelly Bean Keyfinder');
    Application.Terminate;
    Exit;
  end;
  if (ParamCount = 1) and (AnsiLowerCase(ParamStr(1)) = '/close') then
  begin
    Application.MessageBox('You can''t have ''/close'' as the only parameter. This application will now exit.', 'Magical Jelly Bean Keyfinder');
    Application.Terminate;
    Exit;
  end;
  Application.Initialize;
  Application.Title := 'Magical Jelly Bean Keyfinder';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.Run;
end.
