{
    The Enchanted Keyfinder is a free utility that retrieves your
    Product Key (cd key) used to install Windows from your registry.
    Copyright (C) 1999-2008  Magical Jelly Bean Software
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
}
unit Main;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Forms,
  Graphics, Grids,
  IniFiles, jpeg, Menus, Messages, Printers, Registry, ShellAPI, StdCtrls,
  StrUtils, SysUtils, ValEdit, Variants, Windows, XPMan;

type
  TForm1 = class(TForm)
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
    ools1:   TMenuItem;
    ModifyConfig1: TMenuItem;
    About2:  TMenuItem;
    Options1: TMenuItem;
    FontDialog: TFontDialog;
    ListBox2: TListBox;
    Panel1:  TPanel;
    Image1:  TImage;
    Label1:  TLabel;
    lblVersion: TLabel;
    lblLastUpdate: TLabel;
    Label4:  TLabel;
    PrintAll1: TMenuItem;
    Memo2:   TMemo;
    SaveDialog1: TSaveDialog;
    PrintDialog1: TPrintDialog;
    LoadHive1: TMenuItem;
    RemotePC1: TMenuItem;
    N2:      TMenuItem;
    ChangeRegistrationInfo1: TMenuItem;
    Label8:  TLabel;
    AlwaysOnTop1: TMenuItem;
    Label6:  TLabel;
    Label7:  TLabel;
    Label9:  TLabel;
    Memo3:   TMemo;
    XPManifest: TXPManifest;
    N3:      TMenuItem;
    MnuSourceforgeWeb: TMenuItem;
    MnuItmWebUpdate: TMenuItem;
    N4:      TMenuItem;
    CommunityForums1: TMenuItem;
    BugandFeatureTracker1: TMenuItem;
    CommunityWiki1: TMenuItem;
    Label2: TLabel;
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
    procedure GetMSDPID3(const sHivePath, Key: string; var sProdID, sMSKey: string);
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
    procedure Image1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure lblLastUpdateClick(Sender: TObject);
    procedure lblVersionClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure PrintAll1Click(Sender: TObject);
    procedure ModifyConfig1Click(Sender: TObject);
    procedure LoadHive1Click(Sender: TObject);
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
    function DecodeMSKey(const HexSrc: array of byte): string;
    function StripTags(const sText: string): string;
    procedure FormatAdobeKey(var sAdobeKey: string);
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
  Form1:     TForm1;
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
  bSaveSettings: boolean;
  sUserHivePath,
  sSoftwareHivePath: string;
  bWin2k, bWinXP, bVista, bWinNT4: boolean;

const
  kfVersion   = '0.1 Beta';
  kfDate      = 'January 17th, 2011';
  DefDelimCSV = ',';
  DefLogPath  = '.';
  KEY_WOW64_64KEY = $0100;

  SE_PRIVILEGE_DISABLED = 0;
  SE_RESTORE_NAME = 'SeRestorePrivilege';

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

implementation

uses
  CommDlg, Dlgs, ShlObj, Unit1, Unit2, Unit3, Unit4;

resourcestring
  rsSetPrivUserNotHaveAccess = 'The current user does not have the required ' +
    'access to load a registry hive.';
  rsSetPrivIncompatOS = 'This program is incompatible with the operating sys' +
    'tem installed on this computer.';
  rsMnuItmLoadHive    = '&Load Hive...';
  rsMnuItmUnLoadHive  = 'Un&Load Hive...';

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
    if not IsWow64Process(
      Windows.GetCurrentProcess, IsWow64Result
    ) then
      raise SysUtils.Exception.Create('IsWow64: bad process handle');
    // Return result of function
    Result := IsWow64Result;
  end
  else
    // Function not implemented: can't be running on Wow64
    Result := False;
end;

function BrowseForFolder(var Foldr: string; const Title: string): boolean;
var
  BrowseInfo:  TBrowseInfo;
  ItemIDList:  PItemIDList;
  DisplayName: array[0..MAX_PATH] of char;
begin
  Result := False;
  FillChar(BrowseInfo, SizeOf(BrowseInfo), #0);
  FillChar(DisplayName, SizeOf(DisplayName), #0);
  with BrowseInfo do
  begin
    hwndOwner := Application.Handle;
    // With this the browse dialog should appear on app main form
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
end;

function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): integer stdcall;
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
    sComputer := 'Unknown';
  end;

  if sComputer = '' then   // Test result for a string
    sComputer := 'Unknown';
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

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
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

procedure TForm1.ProgramInit;
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
    Form1.ListBox1Click(Form1);
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

procedure TForm1.LoadSettings(Sender: TObject);
var
  myINI: TINIFile;
  fs:    TFormatSettings;
begin
  myINI := TINIFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    sLogFilePath := myINI.ReadString('Settings', 'LogFilePath', '.\');
    bLogging     := myINI.ReadBool('Settings', 'Logging', False);
    //Form2.OptChkBxErrLog.Checked := bLogging;
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
    LoadFont(myINI, 'AppListFont', Form1.ListBox1.Font);
    LoadFont(myINI, 'KeyListFont', Form1.Memo1.Font);
  finally
    myINI.Free;
  end;
end;

procedure TForm1.SaveSettings(Sender: TObject);
var
  myINI: TINIFile;
begin
  try
    myINI := TINIFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
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
    SaveFont(myINI, 'AppListFont', Form1.ListBox1.Font);
    SaveFont(myINI, 'KeyListFont', Form1.Memo1.Font);
    myINI.UpdateFile;
  finally
    myINI.Free;
  end;
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

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  sCurParam: string;
begin
  Height   := 480;
  Width    := 640;
  //bLogging := False;
  //bAutoHive := False;
  //bAutoSave    := False;
  //bAppendTop  := False;
  //sLogFilePath := '.\';
  //sDelimCSV    := DefDelimCSV;
  sHiveLoc := 'Software';
  bWinNT4  := IsWinNT4;
  bWin2k   := IsWin2k;
  bWinXP   := IsWinXP;
  //bVista   := IsVista;
  
  Form1.Memo1.Font.Style := [fsBold];
  Form1.LoadSettings(Form1);
  Form1.Memo1.Font.Style := [fsBold];
  sPCName := GetPCName;
  if sPCName = '' then
    sPCName := 'Unknown';
  SaveDialog1.FileName := sPCName + '.txt';
  sAutoSaveDir    := ExtractFilePath(Application.ExeName);
  iSaveKeysToFile := -1;
  Form1.Text      := Form1.Text + kfversion;
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
        LoadHive;
      end;

    if sCurParam = '/save' then
    begin
      bAutoSave := True;
      if LeftStr(ParamStr(i + 1), 1) <> '/' then
        sAutoSaveDir := ParamStr(i + 1);
      SaveDialog1.FilterIndex := 1;
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

    if sCurParam = '/appendtop' then
      bAppendTop := True;
    if sCurParam = '/appendbottom' then
      bAppendBottom := True;
    i := i + 1;
  end;

  ProgramInit;

  if bAutoSave then
    SaveAs1Click(Form1);
  if bAutoClose then  // Time to close the main application
    Application.Terminate;
end;

procedure TForm1.Exit2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MnuSourceforgeWebClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://sourceforge.net/projects/keyfinder/'), nil, nil, SW_NORMAL);
end;

procedure TForm1.FindWinVersion;
var
  MyReg: TRegistry;
begin
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;

{  if RemotePC1.Checked then
  begin
    if MyReg.RegistryConnect(Form4.Edit1.Text) = False then
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
  // This bit won't work for NT 4 as there is no ProductName value
  if MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', False) and
    MyReg.ValueExists('ProductName') then
  begin
    ListBox1.Items.Add(MyReg.ReadString('ProductName'));
    ListBox2.Items.Add('WinXP');
  end;
  MyReg.Free;

  if bWinNT4 then   // Test for NT 4.0
  begin
    ListBox1.Items.Add('Microsoft Windows NT');
    ListBox2.Items.Add('WinNT4');
  end;

  // Win 9x/me check
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
  MyReg.Free;
end; // FindWinVersion

procedure TForm1.GetVistaKey;
var
  MyReg:     TRegistry;
  iBinarySize: integer;
  HexBuf:    array of byte;  //  => The old DigitalPidId struct prior to Vista
  HexBufID4: array of byte;  //  => the new DigitalPidId4 struct in Vista (size = 0x4F8)
  ProdSpec:  TIniFile;
  sTmp, sUnattendCDKey, sOSEdition: string;
  sCSDVersion, sProductKey, sProductID, sCompName, sRegOwn, sRegOrg: string;



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
  GetMSDPID3(sHiveLoc, '\Microsoft\Windows NT\CurrentVersion', sProductID, sProductKey);

  // Retrieve ID, User + Company name
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
    MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
  if (MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', False)) then
  begin
    sRegOwn := MyReg.ReadString('RegisteredOwner');
    sRegOrg := MyReg.ReadString('RegisteredOrganization');
    if sOSEdition = '' then
      sOSEdition := MyReg.ReadString('EditionID');
    // Get Service Pack level
    sCSDVersion := MyReg.ReadString('CSDVersion');
    MyReg.CloseKey;
  end;
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
  MyReg.CloseKey;
  MyReg.Free;

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
      Form1.ListBox1Click(Form1);
    end;
  end;
end;

procedure TForm1.GetXPKey;
var
  MyReg:     TRegistry;
  iBinarySize: integer;
  HexBuf:    array of byte;  //  => The old DigitalPidId struct prior to Vista
  HexBufID4: array of byte;
  //  Pointer to a struct with 1272 bytes where the first 4bytes are 0xF8, 0x04, 0x00, 0x00
  //  => the new DigitalPidId4 struct in Vista (size = 0x4F8)
  ProdSpec:  TIniFile;
  sTmp, 
  sUnattendCDKey, 
  sOSEdition,
  sCSDVersion, 
  sProductKey, 
  sProductID,
  sCompName,
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

  GetMSDPID3(sHiveLoc, '\Microsoft\Windows NT\CurrentVersion', sProductID, sProductKey);

  // Retrieve ID, User + Company name
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
    MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
  if (MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows NT\CurrentVersion', False)) then
  begin
    sRegOwn := MyReg.ReadString('RegisteredOwner');
    sRegOrg := MyReg.ReadString('RegisteredOrganization');
    if sOSEdition = '' then
      sOSEdition := MyReg.ReadString('EditionID');
    // Get Service Pack level
    sCSDVersion := MyReg.ReadString('CSDVersion');
    MyReg.CloseKey;
  end;
  if (MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows\CurrentVersion\Reliability', False)) then
  begin
    sCompName := MyReg.ReadString('LastComputerName');
    MyReg.CloseKey;
  end;
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

  MyReg.Free;

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
      Form1.ListBox1Click(Form1);
    end;
  end;
end;

procedure TForm1.Get9xKey;
var
  MyReg: TRegistry;
  sCSDVersion, sProductKey, sProductID, sRegOwn, sRegOrg: string;
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
    Memo1.Lines.Add(Trim('Registered Owner: ' + PChar(sRegOwn)));
  end;
  sRegOrg := MyReg.ReadString('RegisteredOrganization');
  Memo1.Lines.Add(Trim('Registered Organization: ' + PChar(sRegOrg)));

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
      Form1.ListBox1Click(Form1);
    end;
  end;
end;

procedure TForm1.GetNT4Key;
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
      Form1.ListBox1Click(Form1);
    end;
  end;
end;

procedure TForm1.GetMSDPID3(const sHivePath, Key: string; var sProdID, sMSKey: string);
var
  MyReg:      TRegistry;
  iBinarySize: integer;
  HexBuf:     array of byte;
  dwChannels, dwChannel: dword;
  dwSize: dword;
  wMajor: word;
  sText: string;
  i: integer;
begin
  sProdID := 'Not found';
  sMSKey  := 'Not found';
  MyReg   := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  // Don't change MyReg.Access method if Win2k
  if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
    MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
  if (MyReg.OpenKey(sHivePath + Key, False)) and MyReg.ValueExists('DigitalProductID') then
  begin
    if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
      MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
    iBinarySize := MyReg.GetDataSize('DigitalProductID');
    if iBinarySize >= 67 then  // Incomplete data  but still might be enough
    begin
      SetLength(HexBuf, iBinarySize);

      if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
        MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
      MyReg.ReadBinaryData('DigitalProductID', HexBuf[0], iBinarySize);

      // Product ID
      if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
        MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
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
        dwChannel := (HexBuf[83] shl 24) or (HexBuf[82] shl 16) or (HexBuf[81] shl 8) or
          (HexBuf[80]);
        case dwChannel of
          0: Memo1.Lines.Add('Installed from ''Full Packaged Product'' media.');
          1: Memo1.Lines.Add('Installed from ''Compliance Checked Product'' media.');
          2: Memo1.Lines.Add('Installed from ''OEM'' media.');
          3: Memo1.Lines.Add('Installed from ''Volume'' media.');
        end;
      end;

      sMSKey := DecodeMSKey(HexBuf);
    end
    else if iBinarySize = 0 then
      sMSKey := 'The CD Key data is empty!'
    else
      sMSKey := 'Some CD Key data is missing!';
  end;
  MyReg.CloseKey;
  MyReg.Free;
end;

procedure TForm1.GetOfficeKey;
var
  MyReg:  TRegistry;
  iBinarySize: integer;
  HexBuf: array of byte;
  i:      integer;
  sOfficeVer: string;
  sOfficeKey: string;
  sProductID: string;
  sProductKey: string;
  sTmp:   string;
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
      if MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\' + sOfficeVer +
        '.0\Registration\' + sOfficeKey) then
      begin
        iBinarySize := MyReg.GetDataSize('DigitalProductID');
        SetLength(HexBuf, iBinarySize);
        MyReg.ReadBinaryData('DigitalProductID', HexBuf[0], ibinarySize);
        sProductID  := MyReg.ReadString('ProductID');
        sProductKey := DecodeMSKey(HexBuf);
        Memo1.Lines.Add('Product ID: ' + PChar(sProductID));
        if not IsValidWinProdID(sProductID) then
        begin
          Memo1.Lines.Add('Invalid Product ID detected as listed by Microsoft KB ' +
           'http://support.microsoft.com/default.aspx?scid=kb;en-us;Q326904');
        end
        else
          Memo1.Lines.Add('CD Key: ' + sProductKey);
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
          Form1.ListBox1Click(Form1);
        end;
      end;
    end;
  end;
end;

procedure TForm1.ReadCfg;
var
  ConfigFile: TextFile;
  CurrentLine: string;
  s: string;
  i: integer;
begin
  CurrentLine := '';
  s := '';
  iEntriesRead := 0;   // Number of entries read in for processing
  bCFGVerFound := False;
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
          begin                        // other if statements will range check
            if (CurrentLine[1] <> ';') then // Don't process a comment line
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
                Form1.ListBox1Click(Form1);
              end;
            end;  // if (CurrentLine[1] <> ';')
            if (CurrentLine[1] = ';') and not bCFGVerFound then
            begin  //check comment line for version number
              i := Pos(' ', CurrentLine);
              s := TrimRight(RightStr(CurrentLine, Length(CurrentLine) - i));
              i := Pos(' ', s) + 1;
              CurrentLine := TrimRight(LeftStr(s, +i));
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
    end;
  end;
end;

procedure TForm1.ParseConfig;
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
          // define variables:
          // sRegRootKey = rootkey
          // sRegOpenKey = openkeyreadonly
          // sRegValue = value to read
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
          else if (sRegRootKey = 'HKEY_CURRENT_USER') and (sHiveLoc = 'Software') then
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
            GetMSDPID3(sHiveLoc, sRegOpenKey, sProdID, sTmp)
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
              end;
            end;
          end;

          // start reading the registry
          // Can't use MyReg.ValueExists(sRegValue) or some programs won't show when they should
          if (MyReg.OpenKeyReadOnly(sRegOpenKey)) then
          begin
          if FindRegistryValue(MyReg.Rootkey,sRegOpenKey,sRegValue) <> Null then
          sTmp := MyReg.ReadString(FindRegistryValue(MyReg.Rootkey,sRegOpenKey,sRegValue));

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
              else
                FormatAdobeKey(sTmp);
            end;

            if j > 1 then
              Memo1.Lines.Add(LeftStr(s, j - 1) + ': ' + sTmp)
            else
              Memo1.Lines.Add(sTmp);
            end

          else
          begin
            ListBox1.Items.Delete(i);
            ListBox2.Items.Delete(i);
            MyReg.Free;
            Exit;
          end;

          MyReg.Free;
          s := RightStr(s, Length(s) - Pos('|', s) + 1);
        end;
      end
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
          Form1.ListBox1Click(Form1);
        end;
      end;
    end;
  StatusBar1.Panels.Items[2].Text := 'Detected: ' + IntToStr(ListBox2.Items.Count);
end;

procedure TForm1.OfficeList;
var
  MyReg: TRegistry;
  blah:  TStringList;
  I:     integer;
  J:     integer;
  K:     string;
begin
  MyReg := TRegistry.Create;
  blah  := TStringList.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;

  if RemotePC1.Checked = True then
  begin
    if MyReg.RegistryConnect(Form4.Edit1.Text) = False then
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
  end;

  // Office XP
  if MyReg.OpenKeyReadOnly(sHiveLoc + '\Microsoft\Office\10.0\Registration') then
  begin
    MyReg.GetKeyNames(blah);
    MyReg.CloseKey;
    for I := 1 to blah.Count do
    begin
      J := I - 1;
      K := blah.Strings[J];
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
    MyReg.GetKeyNames(blah);
    MyReg.CloseKey;
    for I := 1 to blah.Count do
    begin
      J := I - 1;
      K := blah.Strings[J];
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
    MyReg.GetKeyNames(blah);
    MyReg.CloseKey;
    for I := 1 to blah.Count do
    begin
      J := I - 1;
      K := blah.Strings[J];
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
  blah.Free;
  MyReg.Free;
end;

function TForm1.DecodeMSKey(const HexSrc: array of byte): string;
const
  StartOffset: integer = $34;      // Offset 34 = Array[52]
  EndOffset:   integer = $34 + 15; // Offset 34 + 15(Bytes) = Array[64]
  Digits: array[0..23] of char =
    ('B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'M', 'P', 'Q', 'R', 'T',
    'V', 'W', 'X', 'Y', '2', '3', '4', '6', '7', '8', '9');
  DecodedLen: integer = 29;       // Length of Decoded Product Key
  EncodedLen: integer = 15;
  // Length of Encoded Product Key in Bytes (An total of 30 in chars)
var
  HexDigitalPID: array of cardinal;
  Des:   array[0..30] of char; // Length of Decoded Product Key + 1
  I:     integer;
  N:     integer;
  HN:    cardinal;
  Value: cardinal;
begin
  Result := '';
  SetLength(HexDigitalPID, DecodedLen);
  for I := StartOffset to EndOffset do
    HexDigitalPID[I - StartOffSet] := HexSrc[I];

  // SetLength(Des, DecodedLen + 1);

  for I := DecodedLen - 1 downto 0 do
    if (((I + 1) mod 6) = 0) then
      Des[I] := '-'
    else
    begin
      HN := 0;
      for N := EncodedLen - 1 downto 0 do
      begin
        Value := (HN shl 8) or HexDigitalPID[N];
        HexDigitalPID[N] := Value div 24;
        HN    := Value mod 24;
      end;
      Des[I] := Digits[HN];
    end;
  Des[DecodedLen] := Chr(0);

  //  For I := 0 To Length(Des) Do
  //    begin
  //     Result := Result + Des[I];
  //    end;
  Result := StrPas(Des);
end;

procedure TForm1.About2Click(Sender: TObject);
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

procedure TForm1.Label6Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://sourceforge.net/apps/phpbb/keyfinder/'), nil, nil, SW_NORMAL);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://www.magicaljellybean.com'), nil, nil, SW_NORMAL);
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
  About2Click(Form1);
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  About2Click(Form1);
end;

procedure TForm1.lblLastUpdateClick(Sender: TObject);
begin
  About2Click(Form1);
end;

procedure TForm1.lblVersionClick(Sender: TObject);
begin
  About2Click(Form1);
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  About2Click(Form1);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  About2Click(Form1);
end;

procedure TForm1.Options1Click(Sender: TObject);
begin
  Form2.Visible := True;
  Form1.Enabled := False;
end;

procedure TForm1.SaveAs1Click(Sender: TObject);
begin
  iSaveKeysToFile := 0;
  Assert(Memo1 <> nil);
  Memo1.Lines.Clear;
  Assert(Memo2 <> nil);
  Memo2.Lines.Clear;
  ListBox1.Selected[iSaveKeysToFile] := True;
  Form1.ListBox1Click(Form1);
end;

procedure TForm1.SaveDialogTypeChange(Sender: TObject);
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
  end;
  // Finally, change the currently selected filename in the dialog
  SendMessage(H, CDM_SETCONTROLTEXT, edt1, integer(PChar(S)));
end;

procedure TForm1.SaveFileDone;
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
          Writeln(PrintText, 'http://sourceforge.net/projects/keyfinder');
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
      end;
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
  Form1.ListBox1Click(Form1);
end;

procedure TForm1.PrintAll1Click(Sender: TObject);
begin
  bToBePrinted := True;
  SaveAs1Click(Form1);
end;

procedure TForm1.ModifyConfig1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('notepad.exe'),
    PChar(ExtractFilePath(Application.ExeName) + 'keyfinder.cfg'), nil, SW_NORMAL);
end;

procedure TForm1.LoadHive1Click(Sender: TObject);
begin
  if LoadHive1.Caption = rsMnuItmLoadHive then
    LoadHive
  else
    UnLoadHive;
end;

procedure TForm1.LoadHive;
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
    try
      GrantPrivilege(SE_RESTORE_NAME);
      MyReg := TRegistry.Create;
      MyReg.RootKey := HKEY_LOCAL_MACHINE;

      iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE'),
        PChar(sHiveLoc2 + '\system32\config\software'));
      if iRtnCode = ERROR_SUCCESS then
      begin
        sHiveLoc := 'KF_HIVE';
        LoadHive1.Caption := rsMnuItmUnLoadHive;
        ChangeRegistrationInfo1.Enabled := False;
        RemotePC1.Enabled := False;
        StatusBar1.Panels.Items[0].Text := 'Hive loaded';
        ProgramInit;
        Exit;
      end
      // try loading the backup hive 'software.sav' assuming win2k or XP
      else if iRtnCode <> ERROR_SUCCESS then
      begin
        StatusBar1.Panels.Items[0].Text := 'Trying to load backup Hive...';
        iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_SAV'),
          PChar(sHiveLoc2 + '\system32\config\software.sav'));
        if iRtnCode = ERROR_SUCCESS then
        begin
          sHiveLoc := 'KF_HIVE_SAV';
          LoadHive1.Caption := rsMnuItmUnLoadHive;
          ChangeRegistrationInfo1.Enabled := False;
          RemotePC1.Enabled := False;
          StatusBar1.Panels.Items[0].Text := 'Backup hive loaded';
          ProgramInit;
          Exit;
        end
        else if iRtnCode <> ERROR_SUCCESS then
        begin
          StatusBar1.Panels.Items[0].Text := 'Trying to load backup hive...';
          iRtnCode := RegLoadKey(MyReg.RootKey, PChar('KF_HIVE_REGBAK'),
            PChar(sHiveLoc2 + '\repair\software'));
          if iRtnCode = ERROR_SUCCESS then
          begin
            sHiveLoc := 'KF_HIVE_REGBAK';
            LoadHive1.Caption := rsMnuItmUnLoadHive;
            ChangeRegistrationInfo1.Enabled := False;
            RemotePC1.Enabled := False;
            StatusBar1.Panels.Items[0].Text := 'Backup hive loaded';
            ProgramInit;
            Exit;
          end;
        end;
      end;
      if iRtnCode <> ERROR_SUCCESS then // give up and print error message
      begin
        if bAutoHive then
          ChangeRegistrationInfo1.Enabled := False;
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
    end;
    end;
end;

procedure TForm1.UnLoadHive;
var
  MyReg: TRegistry;
begin
  try
    GrantPrivilege(SE_RESTORE_NAME);
    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    if MyReg.UnLoadKey('KF_HIVE') then
    begin
      sHiveLoc := 'Software';
      LoadHive1.Caption := rsMnuItmLoadHive;
      ChangeRegistrationInfo1.Enabled := True;
      //    RemotePC1.Enabled := True;
      ProgramInit;
      Exit;
    end;
    // Try the backup key too
    if MyReg.UnLoadKey('KF_HIVE_SAV') then
    begin
      sHiveLoc := 'Software';
      LoadHive1.Caption := rsMnuItmLoadHive;
      ChangeRegistrationInfo1.Enabled := True;
      //    RemotePC1.Enabled := True;
      ProgramInit;
    end;
    // Try the repair key too
    if MyReg.UnLoadKey('KF_HIVE_RPR') then
    begin
      sHiveLoc := 'Software';
      LoadHive1.Caption := rsMnuItmLoadHive;
      ChangeRegistrationInfo1.Enabled := True;
      //    RemotePC1.Enabled := True;
      ProgramInit;
    end;
  finally
    MyReg.CloseKey;
    MyReg.Free;
    RevokePrivilege(SE_RESTORE_NAME);
  end;
end;

procedure TForm1.MnuItmWebUpdateClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(
    'http://sourceforge.net/project/platformdownload.php?group_id=222327'), nil, nil, SW_NORMAL);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if LoadHive1.Caption = 'Un&Load Hive...' then
    UnloadHive;
  if bSaveSettings then
    Form1.SaveSettings(Form1);
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://sourceforge.net/projects/keyfinder/'),
    nil, nil, SW_NORMAL);
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
  About2Click(Form1);
end;

procedure TForm1.ChangeRegistrationInfo1Click(Sender: TObject);
var
  MyReg: TRegistry;
begin
  //reset form
  Form3.Button1.Enabled := False;
  if ListBox2.Items.Strings[0] = 'WinXP' then
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
      Form3.Edit2.Text     := MyReg.ReadString('RegisteredOwner');
      Form3.Edit2.ReadOnly := False;
      Form3.Edit3.Text     := MyReg.ReadString('RegisteredOrganization');
      Form3.Edit3.ReadOnly := False;
    end;
    MyReg.CloseKey;
    MyReg.Free;
  end;

  if ListBox2.Items.Strings[0] = 'Win9x' then
  begin
    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    // Don't change MyReg.Access method if Win2k
    if Listbox1.Items[0] <> 'Microsoft Windows 2000' then
      MyReg.Access := KEY_WOW64_64KEY or KEY_READ;
    if MyReg.OpenKey(sHiveLoc + '\Microsoft\Windows\CurrentVersion', False) and
      MyReg.ValueExists('RegisteredOwner') and
      MyReg.ValueExists('RegisteredOrganization') then
    begin
      Form3.Edit2.Text     := MyReg.ReadString('RegisteredOwner');
      Form3.Edit2.ReadOnly := False;
      Form3.Edit3.Text     := MyReg.ReadString('RegisteredOrganization');
      Form3.Edit3.ReadOnly := False;
    end;
    MyReg.CloseKey;
    MyReg.Free;
  end;

  Form3.Visible := True;
  Form1.Enabled := False;
end;

procedure TForm1.RemotePC1Click(Sender: TObject);
begin
  if RemotePC1.Checked = False then
  begin
    Form4.Visible := True;
    Form1.Enabled := False;
  end
  else
  begin
    RemotePC1.Checked := False;
    ProgramInit;
  end;
end;

procedure TForm1.AlwaysOnTop1Click(Sender: TObject);
begin
  if AlwaysOnTop1.Checked = False then
  begin
    AlwaysOnTop1.Checked := True;
    Form1.FormStyle      := fsStayOnTop;
    Form2.FormStyle      := fsStayOnTop;
    Form3.FormStyle      := fsStayOnTop;
    Form4.FormStyle      := fsStayOnTop;
  end
  else
  begin
    AlwaysOnTop1.Checked := False;
    Form1.FormStyle      := fsNormal;
    Form2.FormStyle      := fsNormal;
    Form3.FormStyle      := fsNormal;
    Form4.FormStyle      := fsNormal;
  end;
end;

procedure TForm1.BugandFeatureTracker1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://sourceforge.net/tracker/?group_id=369948'), nil, nil, SW_NORMAL);
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
  OKBottomDlg.Visible := True;
  Form1.Enabled := False;
end;

procedure TForm1.CommunityForums1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://sourceforge.net/apps/phpbb/keyfinder/'), nil, nil, SW_NORMAL);
end;

procedure TForm1.CommunityWiki1Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar('http://sourceforge.net/apps/mediawiki/keyfinder/'), nil, nil, SW_NORMAL);
end;

procedure TForm1.ConvertSaveFormat;
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
end;

procedure TForm1.FormResize(Sender: TObject);
var
  i: integer;
begin
  i := (Form1.Width div 100) * 50;
  StatusBar1.Panels.Items[0].Width := i;
  i := (i div 100) * 50;
  StatusBar1.Panels.Items[1].Width := i;
  StatusBar1.Panels.Items[2].Width := i;
end;

function TForm1.StripTags(const sText: string): string;
  // We want to strip 'Product ID: ', 'CD Key: ' etc. from csv output
var
  sSourceTest: string;
begin
  sSourceTest := sText;
  if LeftStr(sSourceTest, 12) = 'Product ID: ' then
    Delete(sSourceTest, 1, 12)
  else if LeftStr(sSourceTest, 8) = 'CD Key: ' then
    Delete(sSourceTest, 1, 8)
  else if LeftStr(sSourceTest, 18) = 'Registered Owner: ' then
    Delete(sSourceTest, 1, 18)
  else if LeftStr(sSourceTest, 25) = 'Registered Organization: ' then
    Delete(sSourceTest, 1, 25);
  Result := sSourceTest;
end;

function TForm1.DecodeAdobeKey(const sAdobeEncryptedKey: string): string;
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

procedure TForm1.FormatAdobeKey(var sAdobeKey: string);
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
