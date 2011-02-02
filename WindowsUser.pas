{
In Windows there are two main types of user acount types: "Computer Administrator" and "Limited".
Computer Administrator accounts allow the user to change all computer settings: install programs, make system wide changes, etc.
If you need to check, from your Delphi application, if the currently logged user is an administrator or a member of the Administrators group, use the "IsWindowsAdmin" function: 

The IsAdmin function is checking if the exe running has an administrator security token, it doesnt check if the logged in user is an admin - it checks the actual process running and its security rights. Maybe renaming this custom function to IsRunningAsAnAdmin would be more suitable.
This is one of the misconceptions of Windows Vista/7 and XP that people have. 
In XP you run the entire OS as an admin or not. In Vista/7 you can specifically have exes run as an admin by elevating up, while the rest of the system is running as a limited user. When you elevate it up it doesnt change which account the entire OS is logged into, it just gives the exe certain rights system wide.
}
unit WindowsUser;
 
 interface
   uses Windows;
 
 //returns True if the currently logged Windows user has Administrator rights
 function IsWindowsAdmin: Boolean;
 
 implementation
 
 const
   SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5)) ;
   SECURITY_BUILTIN_DOMAIN_RID = $00000020;
   DOMAIN_ALIAS_RID_ADMINS = $00000220;
 
 
 function IsWindowsAdmin: Boolean;
 var
   hAccessToken: THandle;
   ptgGroups: PTokenGroups;
   dwInfoBufferSize: DWORD;
   psidAdministrators: PSID;
   x: Integer;
  bSuccess: BOOL;
begin
  try
    Result := False;
    bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, hAccessToken);
    if (not(bSuccess)) then
    begin
      if (GetLastError = ERROR_NO_TOKEN) then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hAccessToken);
    end;
    if (bSuccess) then
    begin
      GetMem(ptgGroups, 1024);
      bSuccess := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups, 1024, dwInfoBufferSize);
      CloseHandle(hAccessToken);
      if (bSuccess) then
      begin
        AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, psidAdministrators);
        {$R-}
        for x := 0 to ptgGroups.GroupCount - 1 do
          if (EqualSid(psidAdministrators, ptgGroups.Groups[x].Sid)) then
          begin
            Result := True;
            Break;
          end;
        {$R+}
        FreeSid(psidAdministrators);
      end;
      FreeMem(ptgGroups);
    end;
  except
    Result := False;
  end;
end;

end.