(*------------------------------------------------------------------------------
The IsWindowsAdmin function is checking if the exe running has an administrator security 
token, it doesnt check if the logged in user is an admin - it checks the actual 
process running and its security rights. Maybe renaming this custom function to 
IsRunningAsAnAdmin would be more suitable.
This is one of the misconceptions of Windows Vista/7 and XP that people have. 
In XP you run the entire OS as an admin or not. 
In Vista/7 you can specifically have exes run as an admin by elevating up, 
while the rest of the system is running as a limited user. 
When you elevate it up it doesnt change which account the entire OS is logged into, 
it just gives the exe certain rights system wide.


    The Enchanted Keyfinder is a free utility that retrieves your
    Product Key (cd key) used to install Windows from your registry.

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

    WindowsUser.pas, released January 2011.
    The initial developer of this code is VersionBoy.
    Portions created by VersionBoy are Copyright (C) 2011.
    All Rights Reserved. 

    Contributor(s): VersionBoy.

    Compiles With: Turbo Delphi 2006, Delphi 2007
------------------------------------------------------------------------------*)
unit WindowsUser;

{$IFDEF FPC}
 {$mode delphi}{$H+}
{$ENDIF}

interface
 
uses
  // delphi
  Windows;

{ Returns a boolean indicating whether or not user has admin
  privileges. (Call only then running under NT.}
function IsWindowsAdmin: Boolean;
 
implementation

uses
  SysUtils, Dialogs;
 
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS     = $00000220;
  DOMAIN_ALIAS_RID_USERS : DWORD = $00000221;
  DOMAIN_ALIAS_RID_GUESTS: DWORD = $00000222;
  DOMAIN_ALIAS_RID_POWER_: DWORD = $00000223;
  
function IsWindowsAdmin: Boolean;
var
  hAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  x: Integer;
  bSuccess: Boolean;
  LastError: Integer;
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
  begin
    Result := True;
    exit;
  end;

  Result := False;
  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True,
    hAccessToken);
  if not bSuccess then
  begin
    if GetLastError = ERROR_NO_TOKEN then
    bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY,
      hAccessToken);
  end;
  if bSuccess then
  begin
    GetMem(ptgGroups, 1024);
    {$IFDEF FPC} 
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups,
      ptgGroups, 1024, @dwInfoBufferSize);
    {$ELSE}
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups,
      ptgGroups, 1024, dwInfoBufferSize);
    {$ENDIF}
    LastError := GetLastError;
    if not bSuccess then
      ShowMessage(Format('GetLastError %d',[LastError]));
    CloseHandle(hAccessToken);
    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
        0, 0, 0, 0, 0, 0, psidAdministrators);
      {$R-}
      for x := 0 to ptgGroups.GroupCount - 1 do
        if EqualSid(psidAdministrators, ptgGroups.Groups[x].Sid) then
        begin
          Result := True;
            Break;
        end;
      {$R+}
      FreeSid(psidAdministrators);
    end;
    FreeMem(ptgGroups);
  end;
end;

end.
