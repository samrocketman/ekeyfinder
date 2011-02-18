{
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

    Contributor(s): 
                    Sam Gleske (sag47)

    Compiles With: Delphi 7, Boreland Dev Studio 2006, DS Turbo Delphi 2006, Delphi 2007
}
unit Update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ExtActns;

type
  TfrmUpdate = class(TForm)
    Stage1: TLabel;
    ProgressBar1: TProgressBar;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
     procedure URL_OnDownloadProgress(Sender: TDownLoadURL;Progress, ProgressMax: Cardinal;StatusCode: TURLDownloadStatus;StatusText: String; var Cancel: Boolean);
     //function DoDownload(var URL: string;var Filename: string;var StageText: string): string;
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

uses Main;

{$R *.dfm}

procedure TfrmUpdate.URL_OnDownloadProgress(Sender: TDownLoadURL;Progress, ProgressMax: Cardinal;StatusCode: TURLDownloadStatus;StatusText: String; var Cancel: Boolean);
begin
  ProgressBar1.Max:= ProgressMax;
  ProgressBar1.Position:= Progress;
end;

function DoDownload(var URL: string;var Filename: string;var StageText: string): string;
var
  downloader: TDownloadURL;
begin
  try
    downloader.URL := URL;
    downloader.Filename := Filename;
    downloader.OnDownloadProgress := frmUpdate.URL_OnDownloadProgress;
    downloader.ExecuteTarget(nil);
  finally
    downloader.Free;
  end;
  Result := StageText;
  { sample I am going off of
   with TDownloadURL.Create(self) do
   try
     URL:='http://0.tqn.com/6/g/delphi/b/index.xml';
     FileName := 'c:\ADPHealines.xml';
     OnDownloadProgress := URL_OnDownloadProgress;

     ExecuteTarget(nil) ;
   finally
     Free;
   end;}
end;

procedure TfrmUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.Enabled := True;
end;

end.