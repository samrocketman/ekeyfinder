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
  Main in 'Main.pas' {MainForm},
  options in 'options.pas' {Form2},
  registration in 'registration.pas' {Form3},
  remote in 'remote.pas' {Form4},
  license in 'license.pas' {OKBottomDlg},
  WinXPKey in 'WinXPKey.pas' {Form5},
  update in 'update.pas' {Form6};

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
  Application.Title := 'Enchanted Keyfinder';
  Application.CreateForm(Tmainform, frm_MainWindow);
  Application.CreateForm(Tform2, frm_Options);
  Application.CreateForm(Tform3, frm_Registration);
  Application.CreateForm(Tform4, frm_Remote);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.CreateForm(Tform5, frm_ChangeXPkey);
  Application.CreateForm(Tform6, frm_UpdateApp);
  Application.Run;
end.
