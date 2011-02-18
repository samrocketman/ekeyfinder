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
                    Oliver Schneider (assarbad)
                    Sam Gleske (sag47)
                    VersionBoy (versionboy)

    Compiles With: Delphi 7, Boreland Dev Studio 2006, DS Turbo Delphi 2006, Delphi 2007
}
unit Main;

interface

uses
  // Delphi
  Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Forms,
  Graphics, Grids,
  IniFiles, jpeg, Menus, Messages, Printers, Registry, ShellAPI, StdCtrls,
  StrUtils, SysUtils, ValEdit, Variants, Windows, ExtActns;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    About1:  TMenuItem;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    Memo1:   TMemo;
    StatusBar1: TStatusBar;
    File2:   TMenuItem;
    Exit2:   TMenuItem;
    N1:      TMenuItem;
    SaveAs1: TMenuItem;
    Tools1: TMenuItem;
    ModifyConfig1: TMenuItem;
    About2:  TMenuItem;
    Options1: TMenuItem;
    FontDialog: TFontDialog;
    ListBox2: TListBox;
    Panel1:  TPanel;
    RefreshPanel:  TPanel;
    lblVersion: TLabel;
    lblLastUpdate: TLabel;
    PrintAll1: TMenuItem;
    Memo2:   TMemo;
    SaveDialog1: TSaveDialog;
    PrintDialog1: TPrintDialog;
    MnuItmLoadHive1: TMenuItem;
    RemotePC1: TMenuItem;
    N2:      TMenuItem;
    ChangeRegistrationInfo1: TMenuItem;
    Label8:  TLabel;
    AlwaysOnTop1: TMenuItem;
    Label6:  TLabel;
    Label7:  TLabel;
    Label9:  TLabel;
    Memo3:   TMemo;
    N3:      TMenuItem;
    MnuSourceforgeWeb: TMenuItem;
    MnuItmWebUpdate: TMenuItem;
    N4:      TMenuItem;
    CommunityForums1: TMenuItem;
    BugandFeatureTracker1: TMenuItem;
    CommunityWiki1: TMenuItem;
    Label2: TLabel;
    ChangeWindowsKey1: TMenuItem;
    Label3: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Logo: TImage;
    Label1: TLabel;
    Refresh1: TMenuItem;
    lblRefresh: TLabel;
    procedure Refresh1Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure ChangeWindowsKey1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure CommunityWiki1Click(Sender: TObject);
    procedure CommunityForums1Click(Sender: TObject);
    procedure BugandFeatureTracker1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure FindWinVersion;
    procedure GetVistaKey;
    procedure GetXPKey;
    procedure GetNT4Key;
    procedure Get9xKey;
    procedure GetOfficeKey;
    procedure OfficeList;
    procedure SaveFileDone;
    procedure ReadCfg;
    procedure ProgramInit;
    procedure LoadHive;
    procedure UnLoadHive;
    procedure ParseConfig;
    procedure ConvertSaveFormat;
    procedure About2Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure lblLastUpdateClick(Sender: TObject);
    procedure lblVersionClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure PrintAll1Click(Sender: TObject);
    procedure ModifyConfig1Click(Sender: TObject);
    procedure MnuItmLoadHive1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure ChangeRegistrationInfo1Click(Sender: TObject);
    procedure RemotePC1Click(Sender: TObject);
    procedure AlwaysOnTop1Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure MnuSourceforgeWebClick(Sender: TObject);
    procedure MnuItmWebUpdateClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SaveDialogTypeChange(Sender: TObject);
    procedure LoadSettings(Sender: TObject);
    procedure SaveSettings(Sender: TObject);
  private
    // Private declarations
    function DecodeAdobeKey(const sAdobeEncryptedKey: string): string;
    function DecodeMSKey(const HexSrc: array of byte; const ID: boolean): string;
    function StripTags(const sText: string): string;
    procedure FormatAdobeKey(var sAdobeKey: string);
    procedure GetMSDPID3(const sHivePath: string; var sProdID, sMSKey: string);
  public
    // Public declarations
    sDelimCSV:    string;
    sPCName:      string;
    sLogPath:     string;
    bLogOverwrite: boolean;
    bAutoSave:    boolean;
    bAutoClose:   boolean;
    bAppendTop:   boolean;
    bAppendBottom: boolean;
    bCFGVerFound: boolean;
    sCFGVer:      string;
    iEntriesRead: integer;
  end;

var
  frmMain:     TfrmMain;
  iSaveKeysToFile: integer;
  bToBePrinted: boolean;
  sAutoSaveDir: string;
  bAutoHive: boolean;     // True if a hive load is requested from cmd line.
  bHiveLoaded: boolean;  // True when a registry hive is loaded.
  sHiveLoc:  string;
  sHiveLoc2: string;
  sReportsPath: string;
  sLogFilePath: string;
  bLogging:  boolean;
  followUnstable: boolean;
  bSaveSettings: boolean;
  sUserHivePath,
  sSoftwareHivePath: string;
  bWin2k, bWinXP,
  bVista, bWinNT4: boolean;

{$INCLUDE VersionConsts.inc}

const
  kfDate      = PROGRAM_RELEASE_DATE;
  DefDelimCSV = ',';
  DefLogPath  = '.';
  KEY_WOW64_64KEY = $0100;
  KEY_WOW64_32KEY = $0200;

  SE_PRIVILEGE_DISABLED = 0;
  SE_RESTORE_NAME = 'SeRestorePrivilege';
  sLineBreak = {$IFDEF LINUX} AnsiChar(#10) {$ENDIF}
               {$IFDEF MSWINDOWS} AnsiString(#13#10) {$ENDIF}
               {$IFDEF MACOSX} AnsiChar(#10) {$ENDIF};

function IsWow64: boolean;
function BrowseForFolder(var Foldr: string; const Title: string): boolean;
function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): integer stdcall;
function StringToCaseSelect(const Selector: string; const CaseList: array of string): integer;
function IsValidWinProdID(const sProdID: string): boolean;
function GetCurrentUser: string;
function GetPCName: string;
function IsWinXP: boolean;
function IsWinNT4: boolean;
procedure SaveFont(FStream: TIniFile; Section: string; smFont: TFont);
procedure LoadFont(FStream: TIniFile; Section: string; smFont: TFont);
function IsNumeric(Value: string; const AllowFloat: boolean): boolean;
procedure convertIniFile(filename : string);

implementation

uses
  CommDlg, Dlgs, ShlObj, License, Options, Registration, Remote, WindowsUser,
  WinXPKey, ActnList;

resourcestring
  rsSetPrivUserNotHaveAccess = 'The current user does not have the required ' +
    'access to load a registry hive.';
  rsSetPrivIncompatOS = 'This program is incompatible with the operating sys' +
    'tem installed on this computer.';
  rsMnuItmLoadHive = '&Load Hive...';
  rsMnuItmUnLoadHive = 'Un&Load Hive...';
  rsNotFound = 'Not found';
  rsLicenseKeyEmpty = 'The license key registry entry is empty!';

{$R *.dfm}  // Include form definitions

function IsWow64: boolean;
type
  TIsWow64Process = function( // Type of IsWow64Process API fn
    Handle: Windows.THandle;
    var Res: Windows.BOOL
  ): Windows.BOOL; stdcall;
var
  IsWow64Result: Windows.BOOL;      // Result from IsWow64Process
  IsWow64Process: TIsWow64Process;  // IsWow64Process fn reference
begin
  // Try to load required function from kernel32
  IsWow64Process := Windows.GetProcAddress(
    Windows.GetModuleHandle('kernel32.dll'), 'IsWow64Process'
  );
  if Assigned(IsWow64Process) then
  begin
    // Function is implemented: call it
    if not IsWow64Process(Windows.GetCurrentProcess, IsWow64Result) then
      raise SysUtils.Exception.Create('IsWow64: bad process handle');
    // Return result of function
    Result := IsWow64Result;
  end
  else
    // Function not implemented: can't be running on Wow64
    Result := False;
end; // IsWow64

function BrowseForFolder(var Foldr: string; const Title: string): boolean;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  DisplayName: array[0..MAX_PATH] of char;
begin
  Result := False;
  FillChar(BrowseInfo, SizeOf(BrowseInfo), #0);
  FillChar(DisplayName, SizeOf(DisplayName), #0);
  with BrowseInfo do
  begin
    hwndOwner := Application.Handle;
    // With this the browse dialog should appear on the application's main form
    pszDisplayName := @DisplayName[0];
    lpszTitle := PChar(Title);
    ulFlags := BIF_RETURNONLYFSDIRS;
    lpfn    := BrowseDialogCallBack;
  end;
  ItemIDList := SHBrowseForFolder(BrowseInfo);
  if Assigned(ItemIDList) then
    if SHGetPathFromIDList(ItemIDList, DisplayName) then
    begin
      Foldr  := StrPas(DisplayName);
      Result := True;
      GlobalFreePtr(ItemIDList);
    end;
end; // BrowseForFolder

function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): integer stdcall;
// In later versions of Delphi you may find the two constants for BIF_NEWDIALOGSTYLE and BIF_NONEWFOLDERBUTTON  are defined in the unit  shlobj, but these were missing in Delphi 7
const
  BIF_NEWDIALOGSTYLE    = $40;
  BIF_NONEWFOLDERBUTTON = $200;
  
var
  wa, rect: TRect;
  dialogPT: TPoint;
begin
  // Center dialog in work area
  if uMsg = BFFM_INITIALIZED then
  begin
    wa := Screen.WorkAreaRect;
    GetWindowRect(Wnd, Rect);
    dialogPT.X := ((wa.Right - wa.Left) div 2) - ((rect.Right - rect.Left) div 2);
    dialogPT.Y := ((wa.Bottom - wa.Top) div 2) - ((rect.Bottom - rect.Top) div 2);
    MoveWindow(Wnd, dialogPT.X, dialogPT.Y, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, True);
    SendMessage(Wnd, BFFM_SETSELECTIONA, Longint(true), lpData);
   end;

  Result := 0;
end; // BrowseDialogCallBack

procedure SetTokenPrivilege(aSystemName: PChar; aPrivilegeName: PChar; aEnabled: boolean);
{******************************************************************************
  SetTokenPrivilege
  A helper function that enables or disables specific privileges on the
  specified computer.  A NIL in SystemName means the privilege will be granted
  for the current computer.  Any other value must match the name of a computer
  on your network.

  Written by Brian Layman (AKA Capt. Queeg)
  Visit him at http://www.TheCodeCave.com
******************************************************************************}
var
  TTokenHd:     THandle;
  TTokenPvg:    TTokenPrivileges;
  cbtpPrevious: DWORD;
  rTTokenPvg:   TTokenPrivileges;
  pcbtpPreviousRequired: DWORD;
  TokenOpened, ValueFound: boolean;

begin
  // SetPrivilege
  // The privilege system is only available on NT and beyond
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then
  begin
    // Retrieve the Token that represents this current application session
    TokenOpened := OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or
      TOKEN_QUERY, TTokenHd);

    // Check for failure
    if (not TokenOpened) then
      raise Exception.Create(
        'The current user does not have the access required to run this program.')
    else
    begin
      // Get the name of the privilege (since Windows is multi-lingual, this must be done)
      ValueFound := LookupPrivilegeValue(aSystemName, aPrivilegeName,
        TTokenPvg.Privileges[0].Luid);
      TTokenPvg.PrivilegeCount := 1;

      // Enable or disable the flag according to the bool passed
      if (aEnabled) then
        TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
      else
        TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_DISABLED;
      // See note on local constant declaration
      cbtpPrevious := SizeOf(rTTokenPvg);
      pcbtpPreviousRequired := 0;
      if (not ValueFound) then
        raise Exception.Create(rsSetPrivIncompatOS)
      else
        try
          // Adjust the permissions as required.
          Windows.AdjustTokenPrivileges(TTokenHd, False, TTokenPvg, cbtpPrevious,
            rTTokenPvg, pcbtpPreviousRequired);
        except
          raise Exception.Create(rsSetPrivUserNotHaveAccess)
        end;
    end;
  end;
end;  // SetPrivilege

procedure GrantPrivilege(const aPrivilegeName: string);
begin
  SetTokenPrivilege(nil, PChar(aPrivilegeName), True);
end;  // GrantPrivilege

procedure RevokePrivilege(const aPrivilegeName: string);
begin
  SetTokenPrivilege(nil, PChar(aPrivilegeName), False);
end;  // RevokePrivilege

function GetCurrentUser: string;
const
  cnMaxUserNameLen = 254;
var
  sUserName:     string;
  dwUserNameLen: DWORD;
begin
  try
    dwUserNameLen := cnMaxUserNameLen - 1;
    SetLength(sUserName, cnMaxUserNameLen);
    GetUserName(PChar(sUserName), dwUserNameLen);
    SetLength(sUserName, dwUserNameLen - 1); // -1 to remove null char
    Result := sUserName;
  except
    Result := '';
  end;
end;

function GetPCName: string;
var
  i: cardinal;
  sComputer: string;
begin
  try
    i := 255;
    SetLength(sComputer, i);
    GetComputerName(PChar(sComputer), i);
    SetLength(sComputer, (i));
  except
    // ShowMessage('Can''t get local PC name!');
    sComputer := 'Unknown PC';
  end;

  if sComputer = '' then   // Test result for a string
    sComputer := 'Unknown PC';
  Result := sComputer;
end;

function StringToCaseSelect(const Selector: string; const CaseList: array of string): integer;
{Usage:
case StringToCaseSelect('Delphi', ['About','Borland','Delphi']) of
   0:ShowMessage('You''ve picked About') ;
   1:ShowMessage('You''ve picked Borland') ;
   2:ShowMessage('You''ve picked Delphi') ;
end;
}
var
  cnt: integer;
begin
  Result := -1;
  for cnt := 0 to Length(CaseList) - 1 do
    if CompareText(Selector, CaseList[cnt]) = 0 then
    begin
      Result := cnt;
      Break;
    end;
end;

function IsWinXP: boolean;
  // Returns true if the operating system is Windows XP
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion = 5) and
    (Win32MinorVersion = 1);
end;

function IsWinPE: boolean;
begin
  Result := FileExists(GetEnvironmentVariable('SystemRoot') + '\system32\winpeshl.exe');
end;

function IsWinNT4: boolean;
  // Returns true if the operating system is Windows NT
  // (excluding 2000 and XP) and false if not.
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion = 4);
end;

function IsWin2k: boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion = 5) and
    (Win32MinorVersion = 0);
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.ListBox1Click(Sender: TObject);
var
  i: integer;
begin
  Assert(Memo1 <> nil);
  Memo1.Clear;
  About2.Checked := False;
  Panel1.Visible := False;
  for i := 0 to (ListBox1.Items.Count - 1) do
    if ListBox1.Selected[i] then
    begin
      //StatusBar1.Panels[0].Text := Trim(ListBox1.Items.Strings[i]);  //trim any spaces
      Memo1.Lines.Add(ListBox1.Items.Strings[i]);
      if ListBox2.Items.Strings[i] = 'Vista' then
        GetVistaKey;
      if ListBox2.Items.Strings[i] = 'WinXP' then
        GetXPKey;
      if ListBox2.Items.Strings[i] = 'WinNT4' then
        GetNT4Key;
      if ListBox2.Items.Strings[i] = 'Win9x' then
        Get9xKey;
      if LeftStr(ListBox2.Items.Strings[i], 6) = 'Office' then
        GetOfficeKey;
      if LeftStr(ListBox2.Items.Strings[i], 6) = 'Config' then
        ParseConfig;
    end;
  StatusBar1.Panels.Items[2].Text := 'Detected: ' + IntToStr(ListBox2.Items.Count);
end;

procedure TfrmMain.ProgramInit;
begin
  ListBox1.Clear;
  Listbox2.Clear;
  Memo1.Clear;
  FindWinVersion;
  OfficeList;
  ReadCfg;

  if ListBox1.Items.Count > 0 then
  begin
    ListBox1.Selected[0] := True;
    frmMain.ListBox1Click(frmMain);
  end;
end;

function IsValidWinProdID(const sProdID: string): boolean;
type
  TBadProductIDS = array[1..23] of string;
const
  // Represents the stripped list of bad Product ID's.
  BadProductIDList: TBadProductIDS =
    ('64064371823', '64130937623', '64206458023', '64246436423',
     '64333470123', '64408177223', '64445126523', '64487489623',
     '64493370423', '64496239623', '64583325423', '64599496223',
     '64603184323', '64610408123', '64610510323', '64731883823',
     '64759202923', '64767783423', '64830169123', '64881999223',
     '64910676523', '64994139223', '65029231223');
var
  sStripedProdID: string;
begin
  Result := True;
  if isWinXP then
  begin
    // Remove hyphens if any from Product ID.
    sStripedProdID := StringReplace(sProdID, '-', '', [rfReplaceAll, rfIgnoreCase]);
    // Remove the first 5 characters from Product ID.
    Delete(sStripedProdID, 1, 5);
    // Remove the last 3 characters from Product ID.
    Delete(sStripedProdID, 13, 3);
    // Devel's own
    if (sStripedProdID = '640000035623') or (sStripedProdID = '640200176523') then
    begin
      Result := False;
      Exit;
    end;
    // Remove the 10th character from Product ID.
    Delete(sStripedProdID, 10, 1);
    case StringToCaseSelect(sStripedProdID, BadProductIDList) of
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
      20, 21, 22, 23: Result := False;
    end;
  end;
end;

procedure TfrmMain.LoadSettings(Sender: TObject);
var
  myINI: TINIFile;
  fs:    TFormatSettings;
begin
  myINI := TINIFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    sLogFilePath := myINI.ReadString('Settings', 'LogFilePath', '.\');
    bLogging     := myINI.ReadBool('Settings', 'Logging', False);
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, FS);
    sDelimCSV     := myINI.ReadString('Settings', 'CSVDelim', fs.ListSeparator);
    bAppendTop    := myINI.ReadBool('Settings', 'AppendTop', False);
    bAutoSave     := myINI.ReadBool('Settings', 'AutoSave', False);
    bAutoHive     := myINI.ReadBool('Settings', 'LoadHive', False);
    bLogOverwrite := myINI.ReadBool('Settings', 'LogOverwrite', False);
    bToBePrinted  := myINI.ReadBool('Settings', 'PrintKeys', False);
    sAutoSaveDir  := myINI.ReadString('Settings', 'SavePath', '');
    sReportsPath  := myINI.ReadString('Settings', 'ReportsPath', '');
    sUserHivePath := myINI.ReadString('Settings', 'UserHivePath', '');
    sSoftwareHivePath := myINI.ReadString('Settings', 'SoftwareHivePath', '');
    if kfVersion = kfUnstableVersion then
      followUnstable := myINI.ReadBool('Settings', 'UnstableUpdates', True)
    else
      followUnstable := myINI.ReadBool('Settings', 'UnstableUpdates', False);
    LoadFont(myINI, 'AppListFont', frmMain.ListBox1.Font);
    LoadFont(myINI, 'KeyListFont', frmMain.Memo1.Font);
  finally
    myINI.Free;
  end; // try..finally
end;

procedure TfrmMain.SaveSettings(Sender: TObject);
var
  myINI: TINIFile;
begin
  myINI := TINIFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    myINI.WriteString('Settings', 'LogFilePath', sLogFilePath);
    myINI.WriteBool('Settings', 'Logging', bLogging);
    myINI.WriteString('Settings', 'CSVDelim', sDelimCSV);
    myINI.WriteBool('Settings', 'AppendTop', bAppendTop);
    myINI.WriteBool('Settings', 'AutoSave', bAutoSave);
    myINI.WriteBool('Settings', 'LoadHive', bAutoHive);
    myINI.WriteBool('Settings', 'LogOverwrite', bLogOverwrite);
    myINI.WriteBool('Settings', 'PrintKeys', bToBePrinted);
    myINI.WriteString('Settings', 'SavePath', sAutoSaveDir);
    myINI.WriteString('Settings', 'ReportsPath', sReportsPath);
    myINI.WriteString('Settings', 'UserHivePath', sUserHivePath);
    myINI.WriteString('Settings', 'SoftwareHivePath', sSoftwareHivePath);
    myINI.WriteBool('Settings', 'UnstableUpdates', followUnstable);
    SaveFont(myINI, 'AppListFont', frmMain.ListBox1.Font);
    SaveFont(myINI, 'KeyListFont', frmMain.Memo1.Font);
    myINI.UpdateFile;
  finally
    myINI.Free;
  end; // try..finally
end;

procedure SaveFont(FStream: TIniFile; Section: string; smFont: TFont);
begin
  FStream.WriteString(Section, 'Font', smFont.Name + ',' +
    IntToStr(smFont.CharSet) + ',' +
    IntToStr(smFont.Color) + ',' +
    IntToStr(smFont.Size) + ',' +
    IntToStr(byte(smFont.Style)));
end;

procedure LoadFont(FStream: TIniFile; Section: string; smFont: TFont);
var
  s, Data: string;
  i: integer;
begin
  s := FStream.ReadString(Section, 'Font', ',,,,');
  try
    i := Pos(',', s);
    if i > 0 then
    begin
      {Name}
      Data := Trim(Copy(s, 1, i - 1));
      if Data <> '' then
        smFont.Name := Data;
      Delete(s, 1, i);
      i := Pos(',', s);
      if i > 0 then
      begin
        {CharSet}
        Data := Trim(Copy(s, 1, i - 1));
        if Data <> '' then
          smFont.Charset := TFontCharSet(StrToIntDef(Data, smFont.Charset));
        Delete(s, 1, i);
        i := Pos(',', s);
        if i > 0 then
        begin
          {Color}
          Data := Trim(Copy(s, 1, i - 1));
          if Data <> '' then
            smFont.Color := TColor(StrToIntDef(Data, smFont.Color));
          Delete(s, 1, i);
          i := Pos(',', s);
          if i > 0 then
          begin
            {Size}
            Data := Trim(Copy(s, 1, i - 1));
            if Data <> '' then
              smFont.Size := StrToIntDef(Data, smFont.Size);
            Delete(s, 1, i);
            {Style}
            Data := Trim(s);
            if Data <> '' then
              smFont.Style := TFontStyles(byte(StrToIntDef(Data, byte(smFont.Style))));
          end;
        end;
      end;
    end;
  except
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
  sCurParam: string;
begin
  // Program startup default settings
  Width    := 640;
  Height   := 480;
  //bLogging := False;
  //bAutoHive := False;
  //bAutoSave    := False;
  //bAppendTop  := False;
  //sLogFilePath := '.\';
  sDelimCSV    := DefDelimCSV;
  sHiveLoc := 'Software';
  bWinNT4  := IsWinNT4;
  bWin2k   := IsWin2k;
  bWinXP   := IsWinXP;
  //bVista   := IsVista;

  frmMain.Memo1.Font.Style := [fsBold];
  frmMain.LoadSettings(frmMain);
  if bWinXP then
    ChangeWindowsKey1.Enabled := True;
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
  begin
	  ChangeWindowsKey1.Enabled := False;
    MnuItmLoadHive1.Enabled := False;

  end;
  if IsWinPE then
  begin
    // Switch off I/O error checking
    {$IOChecks off}
    MkDir(GetEnvironmentVariable('SystemRoot') + '\system32\config\systemprofile\Desktop');
    {$IOChecks on}
    frmMain.Scaled := False;
    ChangeRegistrationInfo1.Enabled := False;
    PrintAll1.Enabled := False;
	  ChangeWindowsKey1.Enabled := False;
  end;

  sPCName := GetPCName;
  if sPCName = '' then
    sPCName := 'Unknown';
  frmMain.SaveDialog1.DefaultExt := '.txt';
  SaveDialog1.FileName := sPCName + '.txt';
  sAutoSaveDir    := ExtractFilePath(Application.ExeName);
  iSaveKeysToFile := -1;
  frmMain.Text    := frmMain.Text + kfversion;
  lblVersion.Caption  := lblVersion.Caption + kfversion;
  lblLastUpdate.Caption  := lblLastUpdate.Caption + kfdate;

  // Parse the command line switches
  i := 1;
  while i <= ParamCount do
  begin
    while (i < ParamCount) and (ParamStr(i)[1] <> '/') do
      i := i + 1;
    sCurParam := AnsiLowerCase(ParamStr(i));
    if (sCurParam = '/close') or (sCurParam = '/quiet') or (sCurParam = '/silent') then
    begin
      bAutoClose := True;
      // Minimise the application so it's main window is not visable.
      //Application.Minimize;
    end;
    if sCurParam = '/delim' then
      sDelimCSV := ParamStr(i + 1);

    if sCurParam = '/file' then
      if LeftStr(ParamStr(i + 1), 1) <> '/' then
        SaveDialog1.FileName := ParamStr(i + 1);

    if sCurParam = '/hive' then
      if LeftStr(ParamStr(i + 1), 1) <> '/' then
      begin
        bAutoHive := True;
        sHiveLoc2 := ParamStr(i + 1);
        // Are we running with admin privledges??
        if IsWindowsAdmin then
          LoadHive
        else ShowMessage('Not running with admin privledges, Can''t load hive.');
      end;

    if sCurParam = '/save' then
    begin
      bAutoSave := True;
      if LeftStr(ParamStr(i + 1), 1) <> '/' then
        sAutoSaveDir := ParamStr(i + 1);
      SaveDialog1.FilterIndex := 1;
      frmMain.SaveDialog1.DefaultExt := '.txt';
      SaveDialog1.FileName := sPCName + '.txt';  // Use PC name as default save name
    end;

    if sCurParam = '/savecsv' then
    begin
      bAutoSave := True;
      if LeftStr(ParamStr(i + 1), 1) <> '/' then
        sAutoSaveDir := ParamStr(i + 1);
      SaveDialog1.FilterIndex := 2;
      SaveDialog1.FileName := sPCName + '.csv';
    end;

		if sCurParam = '/saveini' then
		begin
			bAutoSave := True;
			if LeftStr(ParamStr(i + 1), 1) <> '/' then
				sAutoSaveDir := ParamStr(i + 1);
			SaveDialog1.FilterIndex := 3;
			SaveDialog1.FileName := sPCName + '.ini';
		end;

		if sCurParam = '/savehtml' then
		begin
			bAutoSave := True;
			if LeftStr(ParamStr(i + 1), 1) <> '/' then
				sAutoSaveDir := ParamStr(i + 1);
			SaveDialog1.FilterIndex := 4;
			SaveDialog1.FileName := sPCName + '.html';
		end;

    if sCurParam = '/appendtop' then
      bAppendTop := True;
    if sCurParam = '/appendbottom' then
      bAppendBottom := True;
    i := i + 1;
  end;

  ProgramInit;

  if bAutoSave then
  begin
    SaveAs1Click(frmMain);
    if SaveDialog1.FilterIndex = 3 then 
      convertIniFile(sAutoSaveDir + SaveDialog1.FileName);
  end;
  if bAutoClose then  // Time to close the main application
    Application.Terminate;
end;

procedure TfrmMain.Exit2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.MnuSourceforgeWebClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(PROGRAM_SOURCEFORGE_HOME_PAGE), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.FindWinVersion;
var
  MyReg: TRegistry;
begin

{  if RemotePC1.Checked then
  begin
    if MyReg.RegistryConnect(frmRemote.Edit1.Text) = False then
    begin
      ShowMessage('Unable to connect to remote mchine.');
      RemotePC1.Checked := False;
    end
    else if not MyReg.OpenKey('Software\Microsoft\Windows NT\CurrentVersion', False) then
    begin
      ShowMessage('No access to registry key.');
      RemotePC1.Checked := False;
      MyReg.Free;
      MyReg := TRegistry.Create;
      MyReg.RootKey := HKEY_LOCAL_MACHINE;
    end;
  end;
}
  MyReg := TRegistry.Create;
  try
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    // This bit won't work for NT 4 as there is no ProductName value
    if MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', False) and
      MyReg.ValueExists('ProductName') then
    begin
      ListBox1.Items.Add(MyReg.ReadString('ProductName'));
      ListBox2.Items.Add('WinXP');
    end;
  finally
    MyReg.Free;
  end;

  if bWinNT4 then   // Test for NT 4.0
  begin
    ListBox1.Items.Add('Microsoft Windows NT');
    ListBox2.Items.Add('WinNT4');
  end;

  // Win 9x/me check
  try
    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    if MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Windows\CurrentVersion') and
      MyReg.ValueExists('Version') then
    begin
      ListBox2.Items.Add('Win9x');
    if MyReg.ReadString('ProductName') <> '' then
      ListBox1.Items.Add(MyReg.ReadString('ProductName'))
    else
      ListBox1.Items.Add(MyReg.ReadString('Version'));
    end;
  finally
    MyReg.Free;
  end;
end; // FindWinVersion

procedure TfrmMain.GetVistaKey;
var
  ProdSpec: TIniFile;
  sOSEdition: string;
  sCSDVersion, sProductKey,
  sProductID, sRegOwn,
  sRegOrg: string;

begin
  sCSDVersion := '';
  sOSEdition  := '';

  if (sHiveLoc = 'Software') and
    (FileExists(GetEnvironmentVariable('SystemRoot') + '\system32\prodspec.ini')) then
  begin
    ProdSpec   := TIniFile.Create(GetEnvironmentVariable('SystemRoot') + '\system32\prodspec.ini');
    sOSEdition := ProdSpec.ReadString('Product Specification', 'Product', '');
    ProdSpec.Free;
  end;

  // Check for other OS location
  if (sHiveLoc <> 'Software') and (FileExists(sHiveLoc2 + '\System32\Prodspec.ini')) then
  begin
    ProdSpec   := TIniFile.Create(sHiveLoc2 + '\system32\prodspec.ini');
    sOSEdition := ProdSpec.ReadString('Product Specification', 'Product', '');
    ProdSpec.Free;
  end;
  if sOSEdition <> '' then
    Memo1.Lines[0] := ('Microsoft ' + sOSEdition); // Don't want sOSEdition on seperate line
  GetMSDPID3(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', sProductID, sProductKey);

  // Retrieve ID, User + Company name
  with TRegistry.Create() do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    Access := KEY_WOW64_64KEY or KEY_READ;
    if (OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', False)) then
    begin
      sRegOwn := ReadString('RegisteredOwner');
      sRegOrg := ReadString('RegisteredOrganization');
      if sOSEdition = '' then
        sOSEdition := ReadString('EditionID');
      // Get Service Pack level
      sCSDVersion := ReadString('CSDVersion');
      CloseKey;
    end;
  finally
    Free;
  end; // try..finally
  if sCSDVersion <> '' then
    Memo1.Lines[0] := Memo1.Lines[0] + ' ' + sCSDVersion;
  Memo1.Lines.Add('Product ID: ' + PChar(sProductID));
  if not IsValidWinProdID(sProductID) then
  begin
    Memo1.Lines.Add('Invalid Product ID detected as listed by Microsoft KB ' +
      'http://support.microsoft.com/default.aspx?scid=kb;en-us;Q326904');
  end
  else
    Memo1.Lines.Add('CD Key: ' + sProductKey);

  Memo1.Lines.Add(Trim('Computer Name: ' + GetPCName()));
  Memo1.Lines.Add(Trim('Registered Owner: ' + PChar(sRegOwn)));
  Memo1.Lines.Add(Trim('Registered Organization: ' + PChar(sRegOrg)));

  if iSaveKeysToFile > -1 then
  begin
    Memo2.Lines.Append(Memo1.Lines.GetText);
    // Memo2.Lines.Append(''); // No blank lines in saved files
    if iSaveKeysToFile = ListBox1.Items.Count - 1 then
      SaveFileDone
    else
    begin
      iSaveKeysToFile := iSaveKeysToFile + 1;
      ListBox1.Selected[iSaveKeysToFile] := True;
      frmMain.ListBox1Click(frmMain);
    end;
  end;
end;

procedure TfrmMain.GetXPKey;
var
  ProdSpec: TIniFile;
  sOSEdition,
  sCSDVersion,
  sProductKey,
  sProductID,
  sRegOwn,
  sRegOrg: string;

  function IsTabletOS: boolean;
  const
    SM_TABLETPC = 86;     // Windows XP Tablet PC Edition
    //  SM_SERVERR2 = 89;     // Windows Server 2003 R2
  begin
    Result := GetSystemMetrics(SM_TABLETPC) <> 0;
  end;

  function IsMediaCenterOS: boolean;
  const
    SM_MEDIACENTER = 87;  // Detects XP Media Center Edition
  begin
    Result := GetSystemMetrics(SM_MEDIACENTER) <> 0;
  end;

  function IsStarterOS: boolean;
  const
    SM_STARTER = 88;     // Windows XP Starter Edition
  begin
    Result := GetSystemMetrics(SM_STARTER) <> 0;
  end;

begin
  sCSDVersion := '';
  sOSEdition  := '';

  if (LowerCase(sHiveLoc) = 'software') and
    (FileExists(GetEnvironmentVariable('SystemRoot') + '\system32\prodspec.ini')) then
  begin
    ProdSpec   := TIniFile.Create(GetEnvironmentVariable('SystemRoot') + '\system32\prodspec.ini');
    sOSEdition := ProdSpec.ReadString('Product Specification', 'Product', '');
    ProdSpec.Free;
  end;

  // Check for other OS location
  if (LowerCase(sHiveLoc) <> 'software') and (FileExists(sHiveLoc2 + '\System32\Prodspec.ini')) then
  begin
    ProdSpec   := TIniFile.Create(sHiveLoc2 + '\system32\prodspec.ini');
    sOSEdition := ProdSpec.ReadString('Product Specification', 'Product', '');
    ProdSpec.Free;
  end;
  // Test for different types of Windows XP
  if IsWinXP then
  begin
    if IsTabletOS then
      sOSEdition := 'Windows XP Tablet PC Edition';
    if IsMediaCenterOS then
      sOSEdition := 'Windows XP Media Center Edition';
    if IsStarterOS then
      sOSEdition := 'Windows XP Starter Edition';
    if sOSEdition <> '' then
      Memo1.Lines[0] := ('Microsoft ' + sOSEdition); // Don't want sOSEdition on seperate line
  end;

  GetMSDPID3(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', sProductID, sProductKey);

  // Retrieve ID, User + Company name
  with TRegistry.Create() do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    Access := KEY_WOW64_64KEY or KEY_READ;
    if (OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', False)) then
    begin
      sRegOwn := ReadString('RegisteredOwner');
      sRegOrg := ReadString('RegisteredOrganization');
      if sOSEdition = '' then
        sOSEdition := ReadString('EditionID');
      // Get Service Pack level
      sCSDVersion := ReadString('CSDVersion');
      CloseKey;
    end;
  //if (OpenKey(sHiveLoc + '\Microsoft\Windows\CurrentVersion\Reliability', False)) then
  //begin
  //  sCompName := ReadString('LastComputerName');
  //  CloseKey;
  //end;	
  finally
    Free;
  end; // try..finally

  if sCSDVersion <> '' then
    Memo1.Lines[0] := Memo1.Lines[0] + ' ' + sCSDVersion;
  Memo1.Lines.Add('Product ID: ' + PChar(sProductID));
  if not IsValidWinProdID(sProductID) then
  begin
    Memo1.Lines.Add('Invalid Product ID detected as listed by Microsoft KB ' +
      'http://support.microsoft.com/default.aspx?scid=kb;en-us;Q326904');
  end
  else
    Memo1.Lines.Add('CD Key: ' + sProductKey);

  Memo1.Lines.Add('Computer Name: ' + GetPCName());
  Memo1.Lines.Add('Registered Owner: ' + PChar(sRegOwn));
  Memo1.Lines.Add('Registered Organization: ' + PChar(sRegOrg));

  if iSaveKeysToFile > -1 then
  begin
    Memo2.Lines.Append(Memo1.Lines.GetText);
    // Memo2.Lines.Append(''); // No blank lines in saved files
    if iSaveKeysToFile = ListBox1.Items.Count - 1 then
      SaveFileDone
    else
    begin
      iSaveKeysToFile := iSaveKeysToFile + 1;
      ListBox1.Selected[iSaveKeysToFile] := True;
      frmMain.ListBox1Click(frmMain);
    end;
  end;
end;

procedure TfrmMain.Get9xKey;
var
  MyReg: TRegistry;
  sProductKey,
  sProductID,
  sRegOwn,
  sRegOrg: string;
begin
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  if (MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Windows\CurrentVersion')) and
    MyReg.ValueExists('Version') then
    if MyReg.ValueExists('ProductID') then
    begin
      sProductID := MyReg.ReadString('ProductID');
      Memo1.Lines.Add('Product ID: ' + sProductID);
    end;
  if MyReg.ValueExists('ProductKey') then
  begin
    sProductKey := MyReg.ReadString('ProductKey');
    Memo1.Lines.Add('CD Key: ' + sProductKey);
  end;
  if MyReg.ValueExists('RegisteredOwner') then
  begin
    sRegOwn := MyReg.ReadString('RegisteredOwner');
    Memo1.Lines.Add('Registered Owner: ' + PChar(sRegOwn));
  end;
  sRegOrg := MyReg.ReadString('RegisteredOrganization');
  Memo1.Lines.Add('Registered Organization: ' + PChar(sRegOrg));

  MyReg.Free;
  if iSaveKeysToFile > -1 then
  begin
    Memo2.Lines.Append(Memo1.Lines.GetText);
    // Memo2.Lines.Append('');  //Don't want blank lines in txt or csv output
    if iSaveKeysToFile = ListBox1.Items.Count - 1 then
      SaveFileDone
    else
    begin
      iSaveKeysToFile := iSaveKeysToFile + 1;
      ListBox1.Selected[iSaveKeysToFile] := True;
      frmMain.ListBox1Click(frmMain);
    end;
  end;
end; // Get9xKey

procedure TfrmMain.GetNT4Key;
var
  MyReg:    TRegistry;
  sOSEdition: string;
  sTmp:     string;
  ProdSpec: TIniFile;
  sCSDVersion, sProductKey, sRegOwn, sRegOrg: string;
begin
  sOSEdition := 'Unknown Windows NT Edition';
  if (sHiveLoc = 'Software') and (FileExists(GetEnvironmentVariable('SystemRoot') +
    '\system32\prodspec.ini')) then
  begin
    ProdSpec   := TIniFile.Create(GetEnvironmentVariable('SystemRoot') +
      '\system32\prodspec.ini');
    sOSEdition := ProdSpec.ReadString('Product Specification', 'Product', '');
    ProdSpec.Free;
  end;
  if (sHiveLoc <> 'Software') and (FileExists(sHiveLoc2 + '\system32\prodspec.ini')) then
  begin
    ProdSpec   := TIniFile.Create(sHiveLoc2 + '\system32\prodspec.ini');
    sOSEdition := ProdSpec.ReadString('Product Specification', 'Product', '');
    ProdSpec.Free;
  end;
  if sOSEdition <> '' then
    Memo1.Lines[0] := ('Microsoft ' + sOSEdition + ' ' + IntToStr(Win32MajorVersion) +
      '.' + IntToStr(Win32MinorVersion));

  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  MyReg.OpenKeyReadOnly('Software\Microsoft\Windows NT\CurrentVersion');
  sRegOwn     := MyReg.ReadString('RegisteredOwner');
  sRegOrg     := MyReg.ReadString('RegisteredOrganization');
  // Get Service Pack level
  sCSDVersion := MyReg.ReadString('CSDVersion');
  if sCSDVersion <> '' then
    Memo1.Lines[0] := Memo1.Lines[0] + ' ' + sCSDVersion;
  sTmp := MyReg.ReadString('ProductID');
  sProductKey := sTmp;
  // Product ID is in 'xxx-xxxxxxx' or 'xxxxx-OEM-xxxxxxx-xxxxx' format with regard to NT4.
  sTmp := MidStr(sTmp, 6, 10);
  if LeftStr(sTmp, 3) = 'OEM' then
  begin
    sTmp := sProductKey;
    sProductKey := LeftStr(sTmp, 5) + '-OEM-' + MidStr(sTmp, 9, 7) + '-' + RightStr(sTmp, 5);
    Memo1.Lines.Add('Product ID: ' + PChar(sProductKey));
    Memo1.Lines.Add('OEM CD Key');
  end
  else
  begin
    sProductKey := LeftStr(sTmp, 3) + '-' + RightStr(sTmp, 7);
    Memo1.Lines.Add('Product ID: ' + PChar(sProductKey));
    Memo1.Lines.Add('Retail CD Key');
  end;

  Memo1.Lines.Add(Trim('Registered Owner: ' + PChar(sRegOwn)));
  Memo1.Lines.Add(Trim('Registered Organization: ' + PChar(sRegOrg)));

  MyReg.CloseKey;
  MyReg.Free;

  if iSaveKeysToFile > -1 then
  begin
    Memo2.Lines.Append(Memo1.Lines.GetText);
    //Memo2.Lines.Append('');  Don't want blank lines in txt or csv output
    if iSaveKeysToFile = ListBox1.Items.Count - 1 then
      SaveFileDone
    else
    begin
      iSaveKeysToFile := iSaveKeysToFile + 1;
      ListBox1.Selected[iSaveKeysToFile] := True;
      frmMain.ListBox1Click(frmMain);
    end;
  end;
end; // GetNT4Key

procedure TfrmMain.GetMSDPID3(const sHivePath: string; var sProdID, sMSKey: string);
var
  MyReg: TRegistry;
  iBinarySize: integer;
  HexBuf: array of byte;
  dwChannel : DWord;
  wMajor: word;
  sText: string;
  i: integer;
  cSAMDesired: cardinal;

begin
  cSAMDesired := KEY_READ;
  if IsWow64 then
    cSAMDesired := KEY_WOW64_64KEY or KEY_READ;
  MyReg   := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
    MyReg.Access := cSAMDesired;
  if (MyReg.OpenKey(sHivePath, False)) and MyReg.ValueExists('DigitalProductID') then
  begin
      MyReg.Access := cSAMDesired;
    iBinarySize := MyReg.GetDataSize('DigitalProductID');
    if iBinarySize >= 67 then  // Incomplete data  but still might be enough
    begin
      SetLength(HexBuf, iBinarySize);

        MyReg.Access := cSAMDesired;
      MyReg.ReadBinaryData('DigitalProductID', HexBuf[0], iBinarySize);

      // Product ID
        sProdID := rsNotFound;
        MyReg.Access := cSAMDesired;
      sProdID := PChar(MyReg.ReadString('ProductID'));

      for i := 5 to 30 do
        if char(HexBuf[i]) <> #0 then
          sText := sText + char(HexBuf[i]);
      // Compare Product ID's
      if sText = sProdID then
        sProdID := sProdID + '  match to CD Key data'
      else
        sProdID := sProdID + '  not a match to CD Key data';

      // Edition ID
      sText := 'Product Part No.: ';
      for i := 33 to 44 do
        if char(HexBuf[i]) <> #0 then
          sText := sText + char(HexBuf[i]);
      Memo1.Lines.Add(sText);

      // Channel Type
      // the 2 bytes need to be shifted in reverse order, as the WORD is stored in little-endian.
      wMajor := (HexBuf[5] shl 8) or (HexBuf[4]);
      if wMajor = 3 then
      begin
        dwChannel := (HexBuf[83] shl 24) or (HexBuf[82] shl 16) or (HexBuf[81] shl 8) or HexBuf[80];
        case dwChannel of
          0: Memo1.Lines.Add('Installed from ''Full Packaged Product'' media.');
          1: Memo1.Lines.Add('Installed from ''Compliance Checked Product'' media.');
          2: Memo1.Lines.Add('Installed from ''OEM'' media.');
          3: Memo1.Lines.Add('Installed from ''Volume'' media.');
          end; // case dwChannel of
        end; // if wMajor
        sMSKey := rsNotFound;
      sMSKey := DecodeMSKey(HexBuf, wMajor <> 3);
    end
    else if iBinarySize = 0 then
      sMSKey := 'The CD Key data is empty!'
    else
      sMSKey := 'Some CD Key data is missing!';
  end;
  MyReg.CloseKey;
  MyReg.Free;
end; // GetMSDPID3

procedure TfrmMain.GetOfficeKey;
var
  MyReg: TRegistry;
  i: integer;
  sOfficeVer: string;
  sOfficeKey: string;
  sProductID: string;
  sProductKey: string;
  sOffRegPath: string;
const
  rel1='Release: ';
  rel2='Release Type: ';
begin
  for i := 0 to (ListBox1.Items.Count - 1) do
  begin
    if ListBox1.Selected[i] then
    begin
      sOfficeKey := RightStr(ListBox2.Items.Strings[i], Length(
        ListBox2.Items.Strings[i]) - 8);
      sOfficeVer := MidStr(ListBox2.Items.Strings[i], 7, 2);
      MyReg      := TRegistry.Create;
      MyReg.RootKey := HKEY_LOCAL_MACHINE;
      sOffRegPath := sHiveLoc + '\Microsoft\Office\' + sOfficeVer + '.0\Registration\' + sOfficeKey;
      if MyReg.OpenKeyReadOnly(sOffRegPath) then
      begin
        sProductID  := MyReg.ReadString('ProductID');
        GetMSDPID3(sOffRegPath, sProductID, sProductKey);

        Memo1.Lines.Add('Product ID: ' + PChar(sProductID));
        if not IsValidWinProdID(sProductID) then
        begin
          Memo1.Lines.Add('Invalid Product ID detected as listed by Microsoft KB ' +
          'http://support.microsoft.com/default.aspx?scid=kb;en-us;Q326904');
        end
        else
        begin
          Memo1.Lines.Add('CD Key: ' + sProductKey);
          //ShowMessage('sOfficeKey='+sOfficeKey+sLineBreak+ RightStr(LeftStr(sOfficeKey,2),1) + ' ' + RightStr(LeftStr(sOfficeKey,3),1));
          //RightStr(LeftStr(sOfficeKey,2),1) + ' ' + RightStr(LeftStr(sOfficeKey,3),1)
          //http://support.microsoft.com/kb/2186281
          case StrToInt('0x' + RightStr(LeftStr(sOfficeKey, 2), 1)) of
            0: Memo1.Lines.Add(rel1+'Pre Beta');
            1: Memo1.Lines.Add(rel1+'Beta 1');
            2: Memo1.Lines.Add(rel1+'Beta 2');
            3: Memo1.Lines.Add(rel1+'Release Candidate 0'); 
            4: Memo1.Lines.Add(rel1+'Release Candidate 1/OEM Preview Release');
            9: Memo1.Lines.Add(rel1+'RTM');
            10: Memo1.Lines.Add(rel1+'Service Pack 1');
            11: Memo1.Lines.Add(rel1+'Service Pack 2');
            12: Memo1.Lines.Add(rel1+'Service Pack 3'); 
          end;
          case StrToInt('0x' + RightStr(LeftStr(sOfficeKey, 3), 1)) of
            0: Memo1.Lines.Add(rel2+'Volume License'); 
            1: Memo1.Lines.Add(rel2+'Retail/OEM'); 
            2: Memo1.Lines.Add(rel2+'Trial'); 
            5: Memo1.Lines.Add(rel2+'Download'); 
          end;
        end;
      end;
      MyReg.Free;
      if iSaveKeysToFile > -1 then
      begin
        Memo2.Lines.Append(Memo1.Lines.GetText);
        if iSaveKeysToFile = ListBox1.Items.Count - 1 then
          SaveFileDone
        else
        begin
          iSaveKeysToFile := iSaveKeysToFile + 1;
          ListBox1.Selected[iSaveKeysToFile] := True;
          frmMain.ListBox1Click(frmMain);
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ReadCfg;
var
  ConfigFile: TextFile;
  CurrentLine: string;
  s: string;
  i: integer;
begin
  CurrentLine := '';
  s := '';
  iEntriesRead := 0;   // Number of entries read in for processing
  bCFGVerFound := False;  // Version of cfg file
  // Input keyfinder.cfg file
  if (FileExists(ExtractFilePath(Application.ExeName) + 'keyfinder.cfg')) and
    (RemotePC1.Checked = False) then
  begin
    AssignFile(ConfigFile, ExtractFilePath(Application.ExeName) + 'keyfinder.cfg');
    try
      try
        Reset(ConfigFile);
        while not EOF(ConfigFile) do
        begin
          ReadLn(ConfigFile, CurrentLine);
          if (CurrentLine <> '') then  // Don't process a blank line because the
          begin                        // other 'if' statements will range check
            if (CurrentLine[1] <> ';') then // Don't process a comment line here
            begin
              i := Pos('|', CurrentLine) - 1;
              s := TrimRight(RightStr(CurrentLine, Length(CurrentLine) - i));
              if i > 0 then
              begin
                iEntriesRead := iEntriesRead + 1;
                ListBox1.Items.Add(Trim(LeftStr(CurrentLine, i)));
                ListBox2.Items.Add('Config-' + s);
                ListBox1.Selected[ListBox1.Items.Count - 1] := True;
                StatusBar1.Panels.Items[1].Text := 'Loaded ' + IntToStr(iEntriesRead) + ' key locations';
                frmMain.ListBox1Click(frmMain);
              end;
            end;  // if (CurrentLine[1] <> ';')
            if (CurrentLine[1] = ';') and not bCFGVerFound then
            begin  //check comment line for version number
              i := Pos(' ', CurrentLine);
              s := TrimRight(RightStr(CurrentLine, Length(CurrentLine) - i));
              i := Pos(' ', s) + 1;
              CurrentLine := TrimRight(LeftStr(s, + i));
              if i > 3 then
              begin
                sCFGVer      := 'CFG Version: ' + CurrentLine;
                bCFGVerFound := True;
              end;
            end;
          end;  // if (CurrentLine <> '')
        end;
      except
        on E: EInOutError do
          MessageDlg('Can''t read keyfinder.cfg. Error: ' + E.Message, mtError, [mbOK], 0);
      end;
    finally
      CloseFile(ConfigFile);
    end; // try..finally
  end;
end;

procedure TfrmMain.Refresh1Click(Sender: TObject);
begin
  //Refresh the program
  lblRefresh.Top := Round( Height/2 - lblRefresh.Height/2 );
  lblRefresh.Left := Round( Width/2 - lblRefresh.Width/2 );
  RefreshPanel.Visible := True;
  RefreshPanel.Height := Height;
  RefreshPanel.Width := Width;
  ListBox1.Visible := False;
  Memo1.Visible := False;
  frmMain.Enabled := False;
  ProgramInit;
  frmMain.Enabled := True;
  RefreshPanel.Visible := False;
  ListBox1.Visible := True;
  Memo1.Visible := True;
end;

function FindRegistryValue(RootKey: HKEY;           //Funtion Finds Wildcard Key Name and Path
                               RootPath: String; 
                               ValueWithWildCard: String): String; 
var 
  MyReg: TRegistry;
  Subkeys: TStrings; 
  I: Integer; 
  PrefixKey: String; 
begin 
  I := 1; 
  while i < length(ValueWithWildCard) do
   begin 
    if ValueWithWildCard[i] = '*' then break; 
    PrefixKey := PrefixKey+ValueWithWildCard[i]; 
    inc(i); 
   end; 
  Result := ''; 
  MyReg := TRegistry.Create;
  Subkeys := TStringList.Create; 
  try 
    MyReg.RootKey := RootKey;
    if (MyReg.OpenKey(RootPath, False)) then
      begin 
      MyReg.GetValueNames(Subkeys);
      for I := 0 to (Subkeys.Count - 1) do 
          begin 
          If pos(PrefixKey,Subkeys[I]) > 0 then 
          //Result := RootPath + '\' + Subkeys[I];
          Result := Subkeys[I];
          if (Result <> '') then 
            Break; 
          end; 
      end; 
  finally 
    Subkeys.Free; 
    MyReg.Free;
  end; 
end;

procedure TfrmMain.ParseConfig;
var
  MyReg: TRegistry;
  RegDataType: TRegDataType;
  i: integer;
  j: integer;
  s: string;
  s2: string;
  sRegRootKey: string;
  sRegOpenKey: string;
  sRegValue: string;
  sTmp: string;
  sProdID: string;
begin
  for i := 0 to (ListBox1.Items.Count - 1) do
    if ListBox1.Selected[i] then
    begin
      s := RightStr(ListBox2.Items.Strings[i], Length(ListBox2.Items.Strings[i]) - 7);
      j := Pos('=', s);
      if j > 0 then      // if an = is found, go on.. otherwise, delete the items
      begin
        while Pos('|', s) > 0 do
        begin
          s  := RightStr(s, Length(s) - 1);
          j  := Pos('=', s);
          s2 := RightStr(s, Length(s) - Pos('\', s));
          sRegRootKey := UpperCase(MidStr(s, j + 1, Pos('\', s) - j - 1));
          sRegOpenKey := LeftStr(s2, Pos('=', s2) - 1);
          if Pos('|', s2) > 0 then
            sRegValue := MidStr(s2, Pos('=', s2), Pos('|', s2) - Pos('=', s2))
          else
            sRegValue := RightStr(s2, Pos('=', ReverseString(s2)));
          sRegValue := RightStr(sRegValue, Length(sRegValue) - 1);
          sTmp := Uppercase(LeftStr(sRegOpenKey, 8));
          if (sRegRootKey = 'HKEY_LOCAL_MACHINE') or (sRegRootKey = 'HKEY_CURRENT_USER') and (sTmp = 'SOFTWARE') then
            sRegOpenKey := sHiveLoc + RightStr(sRegOpenKey, Length(sRegOpenKey) - 8);

          // Set the registry rootkeys

          MyReg := TRegistry.Create;
          if sRegRootKey = 'HKEY_LOCAL_MACHINE' then
            MyReg.RootKey := HKEY_LOCAL_MACHINE
          else if (sRegRootKey = 'HKEY_CURRENT_USER') and (Uppercase(sHiveLoc) = 'SOFTWARE') then
            MyReg.RootKey := HKEY_CURRENT_USER
          // this is done to avoid confusion - reading current registry instead of hive
          else
          begin
            ListBox1.Items.Delete(i);
            ListBox2.Items.Delete(i);
            MyReg.Free;
            Exit;
          end;

          // Check for MS digital id entry in .cfg and decode if true
          sTmp := '';
          if LowerCase(sRegValue) = 'digitalproductid' then
            GetMSDPID3(sHiveLoc + sRegOpenKey, sProdID, sTmp)
          else // not an ms digital id
          begin
            if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
              MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
            if MyReg.OpenKey(sHiveLoc + sRegOpenKey, False) then
            begin
              try
                try
                  RegDataType := MyReg.GetDataType(sRegValue);
                  if (RegDataType = rdString) or (RegDataType = rdExpandString) then
                    sTmp := MyReg.ReadString(sRegValue)
                  else if RegDataType = rdInteger then
                    sTmp := IntToStr(MyReg.ReadInteger(sRegValue));
                except
                  on E: ERegistryException do
                    //MessageDlg('Can''t read a Registry key. [' + sRegOpenKey + ']' + #13 + 'Error: ' + E.Message, mtError, [mbOK], 0);
                    MessageDlg('Keyfinder ' + E.Message + '.', mtError, [mbOK], 0);
                end;
              finally
                MyReg.CloseKey;
                MyReg.Free;
              end; // try .. finally
            end; // if MyReg.OpenKey
          end;

          // start reading the registry
          // Can't use MyReg.ValueExists(sRegValue) or some programs won't show when they should
          if (MyReg.OpenKeyReadOnly(sRegOpenKey)) then
          begin
            if FindRegistryValue(MyReg.Rootkey,sRegOpenKey,sRegValue) <> Null then
            try
              sTmp := MyReg.ReadString(FindRegistryValue(MyReg.Rootkey,sRegOpenKey,sRegValue));
            except
              on E: Exception do
                sTmp := 'Error! Invalid data type.  Check key.';
            end;
          end;

            // Do a quick test for an Adobe entry in .cfg and decode if true
            if (pos('adobe ', LowerCase(ListBox1.Items.Strings[i])) <> 0) and
              (IsNumeric(sTmp, True)) then
            begin
              if (pos('lightroom 1', LowerCase(ListBox1.Items.Strings[i])) = 0) and
                 (pos('photoshop 7', LowerCase(ListBox1.Items.Strings[i])) = 0) then
              begin  // The Lightroom 1 & Photoshop 7 serial is not encoded
                if (LowerCase(sRegValue) = 'epic_serial') or (LowerCase(sRegValue) = 'serial') or
                  (LowerCase(sRegValue) = 'serial_number') then
                begin  // Only try decode serial keys
                  sRegValue := DecodeAdobeKey(sTmp);  // Just stealing use of sRegValue
                  sTmp      := sRegValue;             // to do some string swapping
                end;
              end
            end
            else
              FormatAdobeKey(sTmp);

            //fix bug for blank entry
            //MessageDlg('Lines:  ' + IntToStr(Memo1.Lines.Count) + '; Length: ' + IntToStr(Length(sTmp)), mtInformation , [mbOK], 0);
            //add entry to the list
            if j > 1 then
            begin
              if Length(sTmp) > 0 then
                Memo1.Lines.Add(LeftStr(s, j - 1) + ': ' + sTmp);
              //Memo1.Lines.Count;
            end
            else
              if Length(sTmp) > 0 then
                Memo1.Lines.Add(sTmp)
          else
          begin
            ListBox1.Items.Delete(i);
            ListBox2.Items.Delete(i);
            MyReg.Free;
            Exit;
          end;

          MyReg.Free;
          s := RightStr(s, Length(s) - Pos('|', s) + 1);
        end; // while Pos('|', s) > 0 do
      end // if j > 0 then
      else
      begin
        ListBox1.Items.Delete(i);
        ListBox2.Items.Delete(i);
      end;

      if iSaveKeysToFile > -1 then
      begin
        Memo2.Lines.Append(Memo1.Lines.GetText);
        if iSaveKeysToFile = ListBox1.Items.Count - 1 then
          SaveFileDone
        else
        begin
          iSaveKeysToFile := iSaveKeysToFile + 1;
          ListBox1.Selected[iSaveKeysToFile] := True;
          frmMain.ListBox1Click(frmMain);
        end;
      end;

      if Memo1.Lines.Count < 2 then
      begin
        ListBox1.Items.Delete(i);
        ListBox2.Items.Delete(i);
      end;


    end; // if ListBox1.Selected[i] then

  //fix bug to remove empty keys
  {for i := 0 to (ListBox1.Items.Count - 1) do
  begin
    MessageDlg(ListBox2.Items.Text, mtInformation , [mbOK], 0);
  end; }

  StatusBar1.Panels.Items[2].Text := 'Detected: ' + IntToStr(ListBox2.Items.Count);
end; // TfrmMain.ParseConfig

procedure TfrmMain.OfficeList;
var
  MyReg: TRegistry;
  slOfficeList: TStringList;
  I: integer;
  J: integer;
  K: string;
begin
  MyReg := TRegistry.Create;
  slOfficeList  := TStringList.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;

  if RemotePC1.Checked = True then
  begin
    if MyReg.RegistryConnect(frmRemote.Edit1.Text) = False then
    begin
      if bAutoClose then
        begin

        end
      else
        ShowMessage('Unable to connect to remote mchine registry.');
      RemotePC1.Checked := False;
    end
    else if not (MyReg.OpenKeyReadOnly('Software\Microsoft\Windows NT\CurrentVersion')) then
    begin
      if bAutoClose then
        begin

        end
      else
        ShowMessage('No access to registry.');
      RemotePC1.Checked := False;
      MyReg.Free;
      MyReg := TRegistry.Create;
      MyReg.RootKey := HKEY_LOCAL_MACHINE;
    end;
  end; // if RemotePC1.Checked

  // Office XP
  if MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\10.0\Registration') then
  begin
    MyReg.GetKeyNames(slOfficeList);
    MyReg.CloseKey;
    for I := 1 to slOfficeList.Count do
    begin
      J := I - 1;
      K := slOfficeList.Strings[J];
      if LeftStr(K, 1) = '{' then
      begin
        MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\10.0\Registration\' + K);
        if MyReg.ValueExists('DigitalProductID') then
        begin
          if MyReg.ReadString('ProductName') <> '' then
            ListBox1.Items.Add(MyReg.ReadString('ProductName'))
          else
          begin
            MyReg.CloseKey;
            MyReg.OpenKeyReadOnly(sHiveLoc +
              '\Microsoft\Windows\CurrentVersion\Uninstall\' + K);
            if MyReg.ReadString('DisplayName') <> '' then
              ListBox1.Items.Add(MyReg.ReadString('DisplayName'))
            else
              ListBox1.Items.Add('Unidentifiable Office XP Installation');
          end;
          ListBox2.Items.Add('Office10' + K);
        end;
        MyReg.CloseKey;
      end;
    end;
  end;

  // Office 2003
  // Office 2003 with no service packs {90110409-6000-11D3-8CFE-0150048383C9}
  // Office 2003 with SP1 {91110409-6000-11D3-8CFE-0150048383C9}
  if MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\11.0\Registration') then
  begin
    MyReg.GetKeyNames(slOfficeList);
    MyReg.CloseKey;
    for I := 1 to slOfficeList.Count do
    begin
      J := I - 1;
      K := slOfficeList.Strings[J];
      if LeftStr(K, 1) = '{' then
      begin
        MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\11.0\Registration\' + K);
        if MyReg.ValueExists('DigitalProductID') then
        begin
          if MyReg.ReadString('ProductName') <> '' then
            ListBox1.Items.Add(MyReg.ReadString('ProductName'))
          else
          begin
            MyReg.CloseKey;
            MyReg.OpenKeyReadOnly(sHiveLoc +
              '\Microsoft\Windows\CurrentVersion\Uninstall\' + K);
            if MyReg.ReadString('DisplayName') <> '' then
              ListBox1.Items.Add(MyReg.ReadString('DisplayName'))
            else
              ListBox1.Items.Add('Unidentifiable Office 2003 Installation');
          end;
          ListBox2.Items.Add('Office11' + K);
        end;
        MyReg.CloseKey;
      end;
    end;
  end;

  // Office 2007
  if MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\12.0\Registration') then
  begin
    MyReg.GetKeyNames(slOfficeList);
    MyReg.CloseKey;
    for I := 1 to slOfficeList.Count do
    begin
      J := I - 1;
      K := slOfficeList.Strings[J];
      if LeftStr(K, 1) = '{' then
      begin
        MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\12.0\Registration\' + K);
        if MyReg.ValueExists('DigitalProductID') then
        begin
          if MyReg.ReadString('ProductName') <> '' then
            ListBox1.Items.Add(MyReg.ReadString('ProductName'))
          else
          begin
            MyReg.CloseKey;
            MyReg.OpenKeyReadOnly(sHiveLoc +
              '\Microsoft\Windows\CurrentVersion\Uninstall\' + K);
            if MyReg.ReadString('DisplayName') <> '' then
              ListBox1.Items.Add(MyReg.ReadString('DisplayName'))
            else
              ListBox1.Items.Add('Unidentifiable Office 2007 Installation');
          end;
          ListBox2.Items.Add('Office12' + K);
        end;
        MyReg.CloseKey;
      end;
    end;
  end;

  // Office 2010
  if MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\14.0\Registration') then
  begin
    MyReg.GetKeyNames(slOfficeList);
    MyReg.CloseKey;
    for I := 1 to slOfficeList.Count do
    begin
      J := I - 1;
      K := slOfficeList.Strings[J];
      if LeftStr(K, 1) = '{' then
      begin
        MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\14.0\Registration\' + K);
        if MyReg.ValueExists('DigitalProductID') then
        begin
          if MyReg.ReadString('ProductName') <> '' then
            ListBox1.Items.Add(MyReg.ReadString('ProductName'))
          else
          begin
            MyReg.CloseKey;
            MyReg.OpenKeyReadOnly(sHiveLoc +
              '\Microsoft\Windows\CurrentVersion\Uninstall\' + K);
            if MyReg.ReadString('DisplayName') <> '' then
              ListBox1.Items.Add(MyReg.ReadString('DisplayName'))
            else
              ListBox1.Items.Add('Unidentifiable Office 2010 Installation');
          end;
          ListBox2.Items.Add('Office14' + K);
        end;
        MyReg.CloseKey;
      end;
    end;
  end;

  slOfficeList.Free;
  MyReg.Free;
end; // TfrmMain.OfficeList;

function TfrmMain.DecodeMSKey(const HexSrc: array of byte; const ID: boolean): string;
const
  Digits: array[0..23] of char =
    ('B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'M', 'P', 'Q', 'R', 'T',
    'V', 'W', 'X', 'Y', '2', '3', '4', '6', '7', '8', '9');
  iDecodedLen: integer = 29;       // Length of Decoded Product Key
  iEncodedLen: integer = 15;
  // Length of Encoded Product Key in Bytes (An total of 30 in chars)
var
  HexDigitalPID: array of cardinal;
  Des: array[0..30] of char; // Length of Decoded Product Key + 1
  iStartOffset: integer;
  iEndOffset: integer;
  I: integer;
  N: integer;
  HN: cardinal;
  Value: cardinal;
begin
  if ID then
    iStartOffset := $328
  else
    iStartOffset := $34;
  iEndOffset := iStartOffset + 15;

  Result := '';
  SetLength(HexDigitalPID, iDecodedLen);
  for I := iStartOffset to iEndOffset do
    HexDigitalPID[I - iStartOffSet] := HexSrc[I];

  for I := iDecodedLen - 1 downto 0 do
    if (((I + 1) mod 6) = 0) then
      Des[I] := '-'
    else
    begin
      HN := 0;
      for N := iEncodedLen - 1 downto 0 do
      begin
        Value := (HN shl 8) or HexDigitalPID[N];
        HexDigitalPID[N] := Value div 24;
        HN    := Value mod 24;
      end;
      Des[I] := Digits[HN];
    end;
  Des[iDecodedLen] := Chr(0);
  Result := StrPas(Des);
end; // TfrmMain.DecodeMSKey

procedure TfrmMain.About2Click(Sender: TObject);
begin
  if Panel1.Visible = False then
  begin
    Panel1.Visible := True;
    About2.Checked := True;
  end
  else
  begin
    Panel1.Visible := False;
    About2.Checked := False;
  end;
end;

procedure TfrmMain.Label6Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(PROGRAM_SOURCEFORGE_PHPBB_PAGE), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.LogoClick(Sender: TObject);
begin
  About2Click(frmMain);
  //ShellExecute(Handle, nil, PChar('http://'), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.Panel1Click(Sender: TObject);
begin
  About2Click(frmMain);
end;

procedure TfrmMain.Label4Click(Sender: TObject);
begin
  About2Click(frmMain);
end;

procedure TfrmMain.Label5Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://www.pages.drexel.edu/~sag47/'), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.lblLastUpdateClick(Sender: TObject);
begin
  About2Click(frmMain);
end;

procedure TfrmMain.lblVersionClick(Sender: TObject);
begin
  About2Click(frmMain);
end;

procedure TfrmMain.Label10Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://sourceforge.net/users/sag47'), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.Label13Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://davidwoodfx.blogspot.com'), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.Label15Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://gimper.net/'), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.Label1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('https://sourceforge.net/apps/phpbb/keyfinder/viewtopic.php?f=1&t=3'), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.Label2Click(Sender: TObject);
begin
  About2Click(frmMain);
end;

procedure TfrmMain.Options1Click(Sender: TObject);
begin
  frmOptions.Visible := True;
  frmMain.Enabled := False;
end;

procedure TfrmMain.SaveAs1Click(Sender: TObject);
begin
  iSaveKeysToFile := 0;
  Assert(Memo1 <> nil);
  Memo1.Lines.Clear;
  Assert(Memo2 <> nil);
  Memo2.Lines.Clear;
  ListBox1.Selected[iSaveKeysToFile] := True;
  frmMain.ListBox1Click(frmMain);
end;

procedure TfrmMain.SaveDialogTypeChange(Sender: TObject);
var
  buf: array [0..MAX_PATH] of char;
  S:   string;
  od:  TSaveDialog;
  H:   THandle;
begin
  // Get a pointer to the dialog
  od := (Sender as TSaveDialog);
  // Send the message to the dialogs parent so it can handle it the normal way 
  H  := GetParent(od.Handle);
  // Get the currently entered filename
  SendMessage(H, CDM_GETSPEC, MAX_PATH, integer(@buf));
  S := buf;
  // Change the extension to the correct one
  case od.FilterIndex of
    1: S := ChangeFileExt(S, '.txt');
    2: S := ChangeFileExt(S, '.csv');
    3: S := ChangeFileExt(S, '.ini');
    4: S := ChangeFileExt(S, '.html');
  end;
  // Finally, change the currently selected filename in the dialog
  SendMessage(H, CDM_SETCONTROLTEXT, edt1, integer(PChar(S)));
end; // TfrmMain.SaveDialogTypeChange

procedure TfrmMain.SaveFileDone;
var
  Line:      integer;
  PrintText: TextFile;   // declares a file variable
begin
  if bToBePrinted then
  begin
    if PrintDialog1.Execute then
    begin
      AssignPrn(PrintText);
      Rewrite(PrintText);
      try
        try
          Printer.Canvas.Font := Memo2.Font;
          Writeln(PrintText, 'Enchanted Keyfinder  v' + kfversion);
          Writeln(PrintText, 'http://sourceforge.net/projects/ekeyfinder');
          Writeln(PrintText, '');
          for Line := 0 to Memo2.Lines.Count - 1 do
            Writeln(PrintText, Memo2.Lines[Line]);
        except
          on E: EInOutError do
          begin
            if bAutoClose then
            else
              MessageDlg('Can''t Print. Error: ' + IntToStr(E.ErrorCode), mtError, [mbOK], 0);
          end;
        end;
      finally
        CloseFile(PrintText);
      end; // try..finally
    end;
    bToBePrinted    := False;
    iSaveKeysToFile := -1;
  end
  else
  begin
    if bAutoSave = True then
    begin
      ConvertSaveFormat;
      try
        Memo2.Lines.SaveToFile(sAutoSaveDir + SaveDialog1.FileName);
      except
        on E: EFCreateError do
        begin
          if bAutoClose then
          begin
             // don't display error
          end
          else
            MessageDlg('Can''t save file. Error: ' + E.Message, mtError, [mbOK], 0);
        end;
      end;
      bAutoSave := False;
    end
    else if SaveDialog1.Execute then
    begin
      ConvertSaveFormat;
      try
        Memo2.Lines.SaveToFile(SaveDialog1.FileName);
      except
        on E: EFCreateError do
        begin
          if bAutoClose then
          begin
            // don't display error
          end
          else
            MessageDlg('Can''t save file. Error!' + E.Message, mtError, [mbOK], 0);
        end;
      end;
    end;
    bToBePrinted    := False;
    iSaveKeysToFile := -1;
  end;
  ListBox1.Selected[0] := True;
  frmMain.ListBox1Click(frmMain);
end;

procedure TfrmMain.PrintAll1Click(Sender: TObject);
begin
  bToBePrinted := True;
  SaveAs1Click(frmMain);
end;

procedure TfrmMain.ModifyConfig1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('notepad.exe'),
    PChar(ExtractFilePath(Application.ExeName) + 'keyfinder.cfg'), nil, SW_NORMAL);
end;

procedure TfrmMain.MnuItmLoadHive1Click(Sender: TObject);
begin
  if MnuItmLoadHive1.Caption = rsMnuItmLoadHive then
    LoadHive
  else
    UnLoadHive;
end;

procedure TfrmMain.LoadHive;
var
  MyReg:     TRegistry;
  bBrowsing: boolean;  // We have selected a path for SOFTWARE hive
  iRtnCode:  integer;
begin
  bBrowsing := False; // No path selected
  StatusBar1.Panels.Items[0].Text := 'Loading Hive...';
  if not bAutoHive then  // was a path included at command line, else select now
    bBrowsing := BrowseForFolder(sHiveLoc2, 'Select The Windows Directory...');

  if bBrowsing or bAutoHive then
  begin
     GrantPrivilege(SE_RESTORE_NAME);
     MyReg := TRegistry.Create;
    try
      MyReg.RootKey := HKEY_LOCAL_MACHINE;
      //try different paths for the Backup hive
      if FileExists(sHiveLoc2 + '\software') then
        iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE'), PChar(sHiveLoc2 + '\software'))
      else if FileExists(sHiveLoc2 + '\WINDOWS\system32\config\software') then
        iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE'), PChar(sHiveLoc2 + '\WINDOWS\system32\config\software'))
      else
        iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE'), PChar(sHiveLoc2 + '\system32\config\software'));

      if iRtnCode = ERROR_SUCCESS then
      begin
        sHiveLoc := 'KF_HIVE';
        MnuItmLoadHive1.Caption := rsMnuItmUnLoadHive;
        ChangeRegistrationInfo1.Enabled := False;
        RemotePC1.Enabled := False;
        StatusBar1.Panels.Items[0].Text := 'Hive loaded';
        Refresh1Click(nil);
        //ProgramInit;
        Exit;
      end
      // try loading the backup hive 'software.sav' assuming win2k or XP
      else if iRtnCode <> ERROR_SUCCESS then
      begin
        StatusBar1.Panels.Items[0].Text := 'Trying to load backup Hive...';
        //try different paths
        if FileExists(sHiveLoc2 + '\software.sav') then
          iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_SAV'), PChar(sHiveLoc2 + '\software.sav'))
        else if FileExists(sHiveLoc2 + '\WINDOWS\system32\config\software.sav') then
          iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_SAV'), PChar(sHiveLoc2 + '\WINDOWS\system32\config\software.sav'))
        else
          iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_SAV'), PChar(sHiveLoc2 + '\system32\config\software.sav'));

        if iRtnCode = ERROR_SUCCESS then
        begin
          sHiveLoc := 'KF_HIVE_SAV';
          MnuItmLoadHive1.Caption := rsMnuItmUnLoadHive;
          ChangeRegistrationInfo1.Enabled := False;
          RemotePC1.Enabled := False;
          StatusBar1.Panels.Items[0].Text := 'Backup hive loaded';
          Refresh1Click(nil);
          //ProgramInit;
          Exit;
        end
        else if iRtnCode <> ERROR_SUCCESS then
        begin
          StatusBar1.Panels.Items[0].Text := 'Trying to load backup hive...';

          //try different locations for repair
          if FileExists(sHiveLoc2 + '\software') then
            iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_REGBAK'), PChar(sHiveLoc2 + '\software'))
          else if FileExists(sHiveLoc2 + '\WINDOWS\repair\software') then
            iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_REGBAK'), PChar(sHiveLoc2 + '\WINDOWS\repair\software'))
          else
            iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_REGBAK'), PChar(sHiveLoc2 + '\repair\software'));

          if iRtnCode = ERROR_SUCCESS then
          begin
            sHiveLoc := 'KF_HIVE_REGBAK';
            MnuItmLoadHive1.Caption := rsMnuItmUnLoadHive;
            ChangeRegistrationInfo1.Enabled := False;
            RemotePC1.Enabled := False;
            StatusBar1.Panels.Items[0].Text := 'Backup hive loaded';
            Refresh1Click(nil);
            //ProgramInit;
            Exit;
          end;
        end;
      end;
      if iRtnCode <> ERROR_SUCCESS then // give up and print error message
      begin
        if bAutoHive then
          ChangeRegistrationInfo1.Enabled := False;
        SaveAs1.Enabled := False;
        PrintAll1.Enabled := False;
        ShowMessage('Can''t load registry hive from: ' + sHiveLoc2 +
          '\system32\config\software' + #13#10#13#10 + SysUtils.SysErrorMessage(iRtnCode));
        // MessageBox(0, PChar(SysUtils.SysErrorMessage(iRtnCode)), nil, MB_OK);
        StatusBar1.Panels.Items[0].Text := 'Loading the Software hive has failed.';
        sHiveLoc := '';
      end;
    finally
      MyReg.CloseKey;
      MyReg.Free;
      RevokePrivilege(SE_RESTORE_NAME);
      bAutoHive := False;  // Turn off autohive for next time through.
    end; // try..finally
  end
  else
    StatusBar1.Panels.Items[0].Text := '';
end;  // LoadHive

procedure TfrmMain.UnLoadHive;
var
  MyReg: TRegistry;
begin
  GrantPrivilege(SE_RESTORE_NAME);
  MyReg := TRegistry.Create;
  try
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    if MyReg.UnLoadKey('KF_HIVE') then
    begin
      sHiveLoc := 'Software';
      MnuItmLoadHive1.Caption := rsMnuItmLoadHive;
      ChangeRegistrationInfo1.Enabled := True;
      //    RemotePC1.Enabled := True;
      StatusBar1.Panels.Items[0].Text := '';
      Refresh1Click(nil);
      //ProgramInit;
      Exit;
    end;
    // Try the backup key too
    if MyReg.UnLoadKey('KF_HIVE_SAV') then
    begin
      sHiveLoc := 'Software';
      MnuItmLoadHive1.Caption := rsMnuItmLoadHive;
      ChangeRegistrationInfo1.Enabled := True;
      //    RemotePC1.Enabled := True;    
      StatusBar1.Panels.Items[0].Text := '';
      Refresh1Click(nil);
      //ProgramInit;
    end;
    // Try the repair key too
    if MyReg.UnLoadKey('KF_HIVE_RPR') then
    begin
      sHiveLoc := 'Software';
      MnuItmLoadHive1.Caption := rsMnuItmLoadHive;
      ChangeRegistrationInfo1.Enabled := True;
      //    RemotePC1.Enabled := True;    
      StatusBar1.Panels.Items[0].Text := '';
      Refresh1Click(nil);
      //ProgramInit;
    end;
  finally
    MyReg.CloseKey;
    MyReg.Free;
    RevokePrivilege(SE_RESTORE_NAME);
  end;
end;

{Get path to temp DIR from Windows Env Variable}
function GetTempDirectory: String;
var
  tempFolder: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  result := StrPas(tempFolder);
end;

{download a remote file to a local file}
function DoDownload(const sRemoteFile, sLocalFile: string): boolean;
begin
  Result := True;
  with TDownloadURL.Create(nil) do
  try
    URL := sRemoteFile;
    Filename := sLocalFile;
    //OnDownloadProgress := frmUpdate.URL_OnDownloadProgress;
    try
      ExecuteTarget(nil);
    except
      on E: Exception do
      begin
        ShowMessage(E.Message);
        Result := False;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmMain.MnuItmWebUpdateClick(Sender: TObject);
var
  kfUpdate, cfgUpdate : boolean;
  CFGVer, newCFG, kfStableURL, kfStableDownload, kfUnstableURL, kfUnstableDownload, StableVersion, UnstableVersion, cfgURL, Section : string;
  myINI : TINIFile;
  unstablever, curunstable, stablever, curstable : extended;


begin
{ Ask sag47 any questions about this.
  Here is the update process explained.

  Definitions
  unstable updates is a setting in keyfinder.ini
  the following are in update.ini
    unstablever
    stablever
  the following are constants in the program
    curstable
    curunstable

  Process
  Using only major versions (e.g. 0.1 0.2 and so on)
  If unstable updates = on then
    if unstablever > stablever then
      if unstablever != curunstable then
        update to unstablever
      else
        nothing to do
    else if stablever != curstable then
      update to stablever
    else
      nothing to do
  else
    if stablever != curstable then
      update to stablever
    else
      nothing to do
}

  if MessageDlg('This will connect to the internet to check for any Keyfinder or cfg updates.  Do you want to continue?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
  begin
    kfUpdate := False;
    cfgUpdate := False;
    //download update.ini to parse version information
    if not DoDownload(UPDATE_URL,GetTempDirectory + 'update.ini') then
      Exit;
    Section := 'Update Software';
    myINI := TINIFile.Create(GetTempDirectory + 'update.ini');
    try
      StableVersion := myINI.ReadString(Section,'StableVersion','');
      kfStableURL := myINI.ReadString(Section,'StableURL','');
      kfStableDownload := myINI.ReadString(Section,'StableDownload','');
      UnstableVersion := myINI.ReadString(Section,'UnstableVersion','');
      kfUnstableURL := myINI.ReadString(Section,'UnstableURL','');
      kfUnstableDownload := myINI.ReadString(Section,'UnstableDownload','');
      newCFG := myINI.ReadString(Section,'ConfigVersion','');
      cfgURL := myINI.ReadString(Section,'ConfigPath','');
      CFGVer := RightStr(sCFGVer,Length(sCFGVer) - Pos(' ',sCFGVer));
      CFGVer := RightStr(CFGVer,Length(CFGVer) - Pos(' ',CFGVer));
    finally
      myINI.Free;
    end;

    //get unstablever, curunstable, stablever, and curstable major versions
    unstablever := StrToFloat(LeftStr(UnstableVersion,3));
    curunstable := StrToFloat(LeftStr(kfUnstableVersion,3));
    stablever := StrToFloat(LeftStr(StableVersion,3));
    curstable := StrToFloat(LeftStr(kfStableVersion,3));

    //keyfinder update process
    if followUnstable then
    begin
      if unstablever > stablever then
      begin
        if not (unstablever = curunstable) then
        begin
          kfUpdate := True;
          //yes=6 and no=7
          if MessageDlg('There is a new version of Keyfinder: v' + UnstableVersion + sLineBreak + 'Download replacement update?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
          begin
            if FileExists(ChangeFileExt(Application.ExeName, '.bak')) then
              DeleteFile(PChar(ChangeFileExt(Application.ExeName, '.bak')));
            RenameFile(Application.ExeName, ChangeFileExt(Application.ExeName, '.bak'));
            DoDownload(kfUnstableDownload,ChangeFileExt(Application.ExeName, '.exe'));
            if FileExists(ChangeFileExt(Application.ExeName, '.exe')) then
            begin
              ShellExecute(Handle, nil, PChar(ChangeFileExt(Application.ExeName, '.exe')), nil, nil, SW_NORMAL);
              Close;
            end;
          end;
        end;
      end
      else if not (stablever = curstable) then
      begin
        kfUpdate := True;
        //yes=6 and no=7
        if MessageDlg('There is a new version of Keyfinder: v' + StableVersion + sLineBreak + 'Download replacement update?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
        begin
          if FileExists(ChangeFileExt(Application.ExeName, '.bak')) then
            DeleteFile(PChar(ChangeFileExt(Application.ExeName, '.bak')));
          RenameFile(Application.ExeName, ChangeFileExt(Application.ExeName, '.bak'));
          DoDownload(kfStableDownload,ChangeFileExt(Application.ExeName, '.exe'));
          if FileExists(ChangeFileExt(Application.ExeName, '.exe')) then
          begin
            ShellExecute(Handle, nil, PChar(ChangeFileExt(Application.ExeName, '.exe')), nil, nil, SW_NORMAL);
            Close;
          end;
        end;
      end;
    end
    else if not (stablever = curstable) then
    begin
      kfUpdate := True;
      //yes=6 and no=7
      if MessageDlg('There is a new version of Keyfinder: v' + StableVersion + sLineBreak + 'Download replacement update?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
      begin
        if FileExists(ChangeFileExt(Application.ExeName, '.bak')) then
          DeleteFile(PChar(ChangeFileExt(Application.ExeName, '.bak')));
        RenameFile(Application.ExeName, ChangeFileExt(Application.ExeName, '.bak'));
        DoDownload(kfStableDownload,ChangeFileExt(Application.ExeName, '.exe'));
        if FileExists(ChangeFileExt(Application.ExeName, '.exe')) then
        begin
          ShellExecute(Handle, nil, PChar(ChangeFileExt(Application.ExeName, '.exe')), nil, nil, SW_NORMAL);
          Close;
        end;
      end;
    end;


    //keyfinder.cfg update check
    if not FileExists(ExtractFilePath(Application.ExeName) + 'keyfinder.cfg') then
    begin
      cfgUpdate := True;
      if MessageDlg('You don''t appear to have a keyfinder.cfg file.  This will allow you to detect the keys of more software.' + sLineBreak + 'Do you want the latest version?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
        if DoDownload(cfgURL,ExtractFilePath(Application.ExeName) + 'keyfinder.cfg') then
        begin
          MessageDlg( 'Success!' , mtInformation , [mbOK], 0);
          Refresh1Click(nil);
        end
        else
        begin
          if MessageDlg('Automatic update of keyfinder.cfg seems to have failed.' + sLineBreak + 'Would you like to try to manually download the new config?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
          begin
            ShellExecute(Handle, nil, PChar(cfgURL), nil, nil, SW_NORMAL);
          end;
        end;
    end
    else if not (CFGVer = newCFG) then
    begin
      cfgUpdate := True;
      if MessageDlg('There is a new version of keyfinder.cfg: ' + newCFG + sLineBreak + 'This will allow you to detect the keys of more software.' + sLineBreak + 'Do you want the latest version?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
        if DoDownload(cfgURL,ExtractFilePath(Application.ExeName) + 'keyfinder.cfg') then
        begin
          MessageDlg( 'Success!' , mtInformation , [mbOK], 0);
          Refresh1Click(nil);
        end
        else
        begin
          if MessageDlg('Automatic update of keyfinder.cfg seems to have failed.' + sLineBreak + 'Would you like to try to manually download the new config?', mtConfirmation , [mbYes,mbNo], 0) = 6 then
          begin
            ShellExecute(Handle, nil, PChar(cfgURL), nil, nil, SW_NORMAL);
          end;
        end;
    end
    else
    begin
      //this statement executes if there was a software update but I still want
      //to let the user know that their config is up to date.
      if kfUpdate then
        MessageDlg( 'You have the latest keyfinder.cfg.' , mtInformation , [mbOK], 0);
    end;

    if not (kfUpdate or cfgUpdate) then
      MessageDlg( 'Nothing to update.' , mtInformation , [mbOK], 0);
    if FileExists(GetTempDirectory + 'update.ini') then
      DeleteFile( PChar(GetTempDirectory + 'update.ini') );
  end;       
  

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MnuItmLoadHive1.Caption = 'Un&Load Hive...' then
    UnloadHive;
  if bSaveSettings then
    frmMain.SaveSettings(frmMain);
end;

procedure TfrmMain.Label7Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(PROGRAM_SOURCEFORGE_HOME_PAGE), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.Label8Click(Sender: TObject);
begin
  About2Click(frmMain);
end;

procedure TfrmMain.ChangeRegistrationInfo1Click(Sender: TObject);
var
  MyReg: TRegistry;
begin
  //reset form
  frmRegistration.Button1.Enabled := False;
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    // Don't change MyReg.Access method if Win2k
    if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
      MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
    if MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', False) and
      MyReg.ValueExists('RegisteredOwner') and
      MyReg.ValueExists('RegisteredOrganization') then
    begin
      frmRegistration.Edit2.Text     := MyReg.ReadString('RegisteredOwner');
      frmRegistration.Edit2.ReadOnly := False;
      frmRegistration.Edit3.Text     := MyReg.ReadString('RegisteredOrganization');
      frmRegistration.Edit3.ReadOnly := False;
    end;
    MyReg.CloseKey;
    MyReg.Free;
  end;

  if Win32Platform <> VER_PLATFORM_WIN32_NT then
  begin
    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    MyReg.Access := KEY_READ;
    if MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows\CurrentVersion', False) and
      MyReg.ValueExists('RegisteredOwner') and
      MyReg.ValueExists('RegisteredOrganization') then
    begin
      frmRegistration.Edit2.Text     := MyReg.ReadString('RegisteredOwner');
      frmRegistration.Edit2.ReadOnly := False;
      frmRegistration.Edit3.Text     := MyReg.ReadString('RegisteredOrganization');
      frmRegistration.Edit3.ReadOnly := False;
    end;
    MyReg.CloseKey;
    MyReg.Free;
  end;

  frmRegistration.Visible := True;
  frmMain.Enabled := False;
end;

procedure TfrmMain.ChangeWindowsKey1Click(Sender: TObject);
begin
  frmWinXPKey.Visible := True;
  frmMain.Enabled := False;
end;

procedure TfrmMain.RemotePC1Click(Sender: TObject);
begin
  if RemotePC1.Checked = False then
  begin
    frmRemote.Visible := True;
    frmMain.Enabled := False;
  end
  else
  begin
    RemotePC1.Checked := False;
    ProgramInit;
  end;
end;

procedure TfrmMain.AlwaysOnTop1Click(Sender: TObject);
begin
  if AlwaysOnTop1.Checked = False then
  begin
    AlwaysOnTop1.Checked := True;
    frmMain.FormStyle      := fsStayOnTop;
    frmOptions.FormStyle      := fsStayOnTop;
    frmRegistration.FormStyle      := fsStayOnTop;
    frmRemote.FormStyle      := fsStayOnTop;
    frmWinXPKey.FormStyle      := fsStayOnTop;
    //frmUpdate.FormStyle      := fsStayOnTop;
  end
  else
  begin
    AlwaysOnTop1.Checked := False;
    frmMain.FormStyle     := fsNormal;
    frmOptions.FormStyle  := fsNormal;
    frmRegistration.FormStyle := fsNormal;
    frmRemote.FormStyle      := fsNormal;
    frmWinXPKey.FormStyle    := fsNormal;
    //frmUpdate.FormStyle      := fsNormal;
  end;
end;

procedure TfrmMain.BugandFeatureTracker1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(PROGRAM_FEATURE_TRACKER), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.Label9Click(Sender: TObject);
begin
  OKBottomDlg.Visible := True;
  frmMain.Enabled := False;
end;

procedure TfrmMain.CommunityForums1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(PROGRAM_SOURCEFORGE_PHPBB_PAGE), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.CommunityWiki1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(PROGRAM_SOURCEFORGE_WIKI_PAGE), nil, nil, SW_NORMAL);
end;

procedure convertIniFile(filename: string);
var
  myINI: TMemIniFile;
  seclist, strlist: TStringlist;
  i, k : integer;
  newheader, aktsection: string;
begin
	seclist := TStringlist.Create;
	strlist := TStringlist.Create;
	myINI := TMemIniFile.Create(FileName);
	myINI.readsections(seclist);
	for i := 0 to seclist.count - 1 do
	begin
		aktsection := seclist[i];
		myINI.ReadSectionValues(aktsection,strlist);
		newheader := strlist.Values['Uninstall Product ID'];
		if newheader <> '' then
			for k := 0 to strlist.count-1 do
				myINI.WriteString(newheader,strlist.Names[k],strlist.ValueFromIndex[k]);
		myINI.EraseSection(seclist[i]);
	end;
	seclist.free;
	strlist.free;
	myINI.UpdateFile;
	myINI.Free;
end;

procedure TfrmMain.ConvertSaveFormat;
var
  i: integer;     // Memo2 current line count
  j: integer;     // Memo3 current line count
  sCurrentUserName: string;
begin
  sCurrentUserName := 'Unknown User';
  sCurrentUserName := GetCurrentUser;
  Assert(Memo3 <> nil);
  Memo3.Clear;

  { SaveDialog1.FilterIndex
    1 = TXT, No conversion necessary.
    2 = CSV
    3 = INI
    4 = HTML
  }

  if SaveDialog1.FilterIndex = 2 then  // CSV Save Format
  begin
    j := 0;
    for i := 0 to Memo2.Lines.Count do
    begin
      if Memo2.Lines[i] = '' then     // Look for line break
      begin
        j := j + 1;
        Memo3.Lines.Add('');
      end;
      if Memo3.Lines[j] <> '' then
        // If line is not blank, insert a comma & double quotes 
        Memo3.Lines[j] := Memo3.Lines[j] + '"' + sDelimCSV + '"';
      Memo3.Lines[j] := Memo3.Lines[j] + StripTags(Memo2.Lines[i]);
    end;
    Memo2.Clear;
    // CSV headder
    Memo2.Lines.Add('"User Name"' + sDelimCSV + '"PC Name"' + sDelimCSV +
      '"Audit Date"' + sDelimCSV + '"Unique ID"' + sDelimCSV + '"Product Name"' + sDelimCSV + '"Product ID"' +
      sDelimCSV + '"Key/Serial"' + sDelimCSV + '"Other 1"' + sDelimCSV +
      '"Other 2"' + sDelimCSV + '"Other 3"');
    for j := 0 to Memo3.Lines.Count do
      if Memo3.Lines[j] <> '' then
        Memo2.Lines.Add('"' + sCurrentUserName + '"' + sDelimCSV + '"' +
          sPCName + '"' + sDelimCSV + '"' + DateToStr(Now) + '"' + sDelimCSV +
          '"' + Memo3.Lines[j] + '"');
  end;
  
  if SaveDialog1.FilterIndex = 3 then  // INI Save Format
  begin
    for i := 0 to Memo2.Lines.Count-1 do
	begin
	  Memo2.Lines[i] := StringReplace(Memo2.Lines[i],':','=',[]);
	  if 0 = pos('=',Memo2.Lines[i]) then
	  Memo2.Lines[i] := '[' + Memo2.Lines[i] + ']';
	end;
  end;
	
  if SaveDialog1.FilterIndex = 4 then  // HTML Save Format
  begin
    Memo3.Lines.Add('<HTML>');
    Memo3.Lines.Add('<HEAD>');
    Memo3.Lines.Add('<META HTTP-EQUIV="Content-Type" CONTENT="text/html">');
    Memo3.Lines.Add(' <TITLE>' + PROGRAM_NAME + '  v' + kfVersion + '</TITLE>');
    Memo3.Lines.Add('</HEAD>');
    Memo3.Lines.Add('<BODY BACKCOLOR="#000000" TEXT="#000000">');
    Memo3.Lines.Add('<TABLE WIDTH="100%" BORDER=1 CELLSPACING="0" ALIGN="CENTER" style = "border-collapse: collapse" >');
    Memo3.Lines.Add(' <CAPTION ALIGN="TOP"><FONT style="font-size: 18pt; font-family: tahoma,courrier,arial,helvetica,sans-serif">' + PROGRAM_NAME + '  v' + kfversion + '</FONT></CAPTION>');
    Memo3.Lines.Add('<TR  ALIGN="LEFT" style="font-family: tahoma,courrier,arial,helvetica,sans-serif">');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">User Name</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">PC Name</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Audit Date</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Product Name</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Product ID</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Key/Serial</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Other 1</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Other 2</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Other 3</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Other 4</FONT>');
    Memo3.Lines.Add(' <TH  BGCOLOR="#7799CC"><FONT SIZE="3" COLOR="#FFFFFF">Other 5</FONT>');

    Memo3.Lines.Add('<TR  ALIGN="LEFT" style="font-family: tahoma,courrier,arial,helvetica,sans-serif">');
    Memo3.Lines.Add(' <TD WIDTH="5%" BGCOLOR="#FFFFFF"><FONT SIZE="2" COLOR="#000000">' + sCurrentUserName + '</FONT>');
    Memo3.Lines.Add(' <TD WIDTH="5%" BGCOLOR="#FFFFFF"><FONT SIZE="2" COLOR="#000000">' + sPCName + '</FONT>');
    Memo3.Lines.Add(' <TD WIDTH="5%" BGCOLOR="#FFFFFF"><FONT SIZE="2" COLOR="#000000">' + DateToStr(Now) + '</FONT>');

    for i := 0 to Memo2.Lines.Count - 2 do  // assume last 2 lines are blank so don't want them
    begin
      if Memo2.Lines[i] = '' then     // Look for line break &
      begin
        Memo3.Lines.Add(' <TD  BGCOLOR="#FFFFFF"><FONT SIZE="2" COLOR="#000000"></FONT>');
        Memo3.Lines.Add('<TR  ALIGN="LEFT" style="font-family: tahoma,courrier,arial,helvetica,sans-serif">');
        Memo3.Lines.Add(' <TD WIDTH="5%" BGCOLOR="#E7E7E7"><FONT SIZE="2" COLOR="#000000">' + sCurrentUserName + '</FONT>');
        Memo3.Lines.Add(' <TD WIDTH="5%" BGCOLOR="#E7E7E7"><FONT SIZE="2" COLOR="#000000">' + sPCName + '</FONT>');
        Memo3.Lines.Add(' <TD WIDTH="5%" BGCOLOR="#E7E7E7"><FONT SIZE="2" COLOR="#000000">' + DateToStr(Now) + '</FONT>');
      end;
      Memo3.Lines.Add(' <TD WIDTH="10%" BGCOLOR="#FFFFFF"><FONT SIZE="2" COLOR="#000000">' + StripTags(Memo2.Lines[i]) + '</FONT>');
    end;
    Memo3.Lines.Add('</TABLE>');
    Memo3.Lines.Add('</BODY>');
    Memo3.Lines.Add('</HTML>');

    Memo2.Clear;
    Memo3.SelectAll;
    Memo3.CopyToClipboard;
    Memo3.Clear;
    Memo2.PasteFromClipboard;

    //for j := 0 to Memo3.Lines.Count do
    //  if Memo3.Lines[j] <> '' then
    //    Memo2.Lines.Add(Memo3.Lines[j]);
  end;
end; // TfrmMain.ConvertSaveFormat

procedure TfrmMain.FormResize(Sender: TObject);
var
  i: integer;
begin
  i := (frmMain.Width div 100) * 50;
  StatusBar1.Panels.Items[0].Width := i;
  i := (i div 100) * 50;
  StatusBar1.Panels.Items[1].Width := i;
  StatusBar1.Panels.Items[2].Width := i;
end;

function TfrmMain.StripTags(const sText: string): string;
  // We want to strip 'Product ID: ', 'CD Key: ' etc. from csv output
var
  sSourceTest: string;
begin
  sSourceTest := sText;
  if LeftStr(sSourceTest, 12) = 'Product ID: ' then
    Delete(sSourceTest, 1, 12)
  else if LeftStr(sSourceTest, 8) = 'CD Key: ' then
    Delete(sSourceTest, 1, 8)
  else if LeftStr(sSourceTest, 13) = 'License Key: ' then
    Delete(sSourceTest, 1, 13)
  else if LeftStr(sSourceTest, 18) = 'Registered Owner: ' then
    Delete(sSourceTest, 1, 18)
  else if LeftStr(sSourceTest, 25) = 'Registered Organization: ' then
    Delete(sSourceTest, 1, 25);
  Result := sSourceTest;
end;

function TfrmMain.DecodeAdobeKey(const sAdobeEncryptedKey: string): string;
  // Decode Adobe Key Encryption. A simple substitution cipher.
  // Converted from Dave Hope's original C++ version  
  // Copyright (C) 2008 VersionBoy
  // Version 1.0
type
  TAdobeCipher = array[1..24] of string;
const
  // It basically represents the decrypted versions of each char in the key.
  // aaaa-bbbb-cccc-dddd-eeee-ffff
  AdobeCipher: TAdobeCipher =
    // Section A.
    ('0000000001', '5038647192', '1456053789', '2604371895',
    // Section B.
    '4753896210', '8145962073', '0319728564', '7901235846',
    // Section C.
    '7901235846', '0319728564', '8145962073', '4753896210',
    // Section D.
    '2604371895', '1426053789', '5038647192', '3267408951',
    // Section E.
    '5038647192', '2604371895', '8145962073', '7901235846',
    // Section F.
    '3267408951', '1426053789', '4753896210', '0319728564');
var
  sAdobeDecryptedKey: string;
  i: integer;
begin
  // Ensure we're dealing with a key we can support:
  if (sAdobeEncryptedKey <> '') and (IsNumeric(sAdobeEncryptedKey, True)) and (Length(sAdobeEncryptedKey) = 24) then
  begin
    sAdobeDecryptedKey := sAdobeEncryptedKey; // Set length of sAdobeDecryptedKey
    // Iterate through each char in the key.
    for i := 1 to Length(sAdobeEncryptedKey) do
      sAdobeDecryptedKey[i] := adobeCipher[i][(StrToInt(sAdobeDecryptedKey[i]) + 1)];
    FormatAdobeKey(sAdobeDecryptedKey);
  end
  else  // We don't understand the format we're given, return empty string.
    sAdobeDecryptedKey := 'corrupt serial';
  Result := sAdobeDecryptedKey;
end;

procedure TfrmMain.FormatAdobeKey(var sAdobeKey: string);
begin
  if Length(sAdobeKey) <> 24 then // key string too short or too long
    exit;
  Insert('-', sAdobeKey, 5);
  Insert('-', sAdobeKey, 10);
  Insert('-', sAdobeKey, 15);
  Insert('-', sAdobeKey, 20);
  Insert('-', sAdobeKey, 25);
end;

function IsNumeric(Value: string; const AllowFloat: boolean): boolean;
  // ---------------------------------------------------------------------------
  procedure PreventHint(const V);
  begin
    {Does nothing except help prevent "value never used" hint for dummy values}
  end;
  // ---------------------------------------------------------------------------
var
  ValueInt:   integer;     // dummy integer value passed to Val procedure
  ValueFloat: extended;    // dummy float value passed to Val procedure
  ErrCode:    integer;     // error code returned by Val procedure
begin
  // Check for integer: Val only accepts integers when passed integer param
  Value := SysUtils.Trim(Value);
  Val(Value, ValueInt, ErrCode);
  PreventHint(ValueInt);      // prevents "value never used" hint
  Result := ErrCode = 0;      // Val sets error code 0 if OK
  if not Result and AllowFloat then
  begin
    // Check for float: Val accepts floats when passed float param
    Val(Value, ValueFloat, ErrCode);
    PreventHint(ValueFloat);  // prevents "value never used" hint
    Result := ErrCode = 0;    // Val sets error code 0 if OK
  end;
end;

initialization

finalization

end.
