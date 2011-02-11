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

    Contributor(s): VersionBoy.

    Website: http://sourceforge.net/projects/keyfinder/
    Compiles With: Turbo Delphi 2006, Delphi 2007
}
program Keyfinder;

{$R 'UAC.res' 'UAC.rc'}
{%TogetherDiagram 'ModelSupport_Keyfinder\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Keyfinder\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Update\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\license\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Main\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Options\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\WinXPKey\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Registration\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Remote\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\VersionConsts\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\WindowsUser\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Keyfinder\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Keyfinder\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Keyfinder\license\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Keyfinder\WindowsUser\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Keyfinder\Main\default.txvpck'}

uses
  Forms,
  SysUtils,
  Main in 'Main.pas' {frmMain},
  Options in 'Options.pas' {frmOptions},
  Registration in 'Registration.pas' {frmRegistration},
  Remote in 'Remote.pas' {frmRemote},
  License in 'License.pas' {OKBottomDlg},
  WinXPKey in 'WinXPKey.pas' {frmWinXPKey},
  Update in 'Update.pas' {frmUpdate},
  WindowsUser in 'WindowsUser.pas',
  VersionConsts in 'VersionConsts.pas';

{$R *.res}

begin
  { Report memory leaks if run inside the Delphi 2006 debugger }
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  if (ParamCount = 1) and (AnsiLowerCase(ParamStr(1)) = '/?') or (AnsiLowerCase(ParamStr(1)) = '/help') then
  begin
    Application.MessageBox('Command Line Options: /save <location> /savecsv <location> /close /hive <location> /file <filename> /delim <character>', PROGRAM_NAME);
    Application.Terminate;
    Exit;
  end;
  if (ParamCount = 1) and (AnsiLowerCase(ParamStr(1)) = '/close') then
  begin
    Application.MessageBox('You can''t have ''/close'' as the only parameter. This application will now exit.', PROGRAM_NAME);
    Application.Terminate;
    Exit;
  end;
  Application.Initialize;
  Application.Title := PROGRAM_NAME;
  //Application.HelpFile := 'keyfinder.chm';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.CreateForm(TfrmRegistration, frmRegistration);
  Application.CreateForm(TfrmRemote, frmRemote);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.CreateForm(TfrmWinXPKey, frmWinXPKey);
  Application.CreateForm(TfrmUpdate, frmUpdate);
  Application.Run;
end.
