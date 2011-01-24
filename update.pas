unit update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ExtActns;

type
  TForm6 = class(TForm)
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
  frm_UpdateApp: TForm6;

implementation

uses Main;

{$R *.dfm}

procedure TForm6.URL_OnDownloadProgress(Sender: TDownLoadURL;Progress, ProgressMax: Cardinal;StatusCode: TURLDownloadStatus;StatusText: String; var Cancel: Boolean);
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
  downloader.OnDownloadProgress := frm_UpdateApp.URL_OnDownloadProgress;
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

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frm_MainWindow.Enabled := True;
end;

end.