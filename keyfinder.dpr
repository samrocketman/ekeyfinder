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
  options in 'options.pas' {Form_Options},
  registration in 'registration.pas' {Form_Registration},
  remote in 'remote.pas' {Form_Remote},
  license in 'license.pas' {OKBottomDlg},
  WinXPKey in 'WinXPKey.pas' {Form_ChangeXPKey},
  update in 'update.pas' {Form_UpdateApp};

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
  Application.CreateForm(TForm_Options, frm_Options);
  Application.CreateForm(TForm_Registration, frm_Registration);
  Application.CreateForm(TForm_Remote, frm_Remote);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.CreateForm(TForm_ChangeXPKey, frm_ChangeXPkey);
  Application.CreateForm(TForm_UpdateApp, frm_UpdateApp);
  Application.Run;
end.
