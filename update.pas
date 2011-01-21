unit update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm6 = class(TForm)
    Stage1: TLabel;
    ProgressBar1: TProgressBar;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses Main;

{$R *.dfm}


procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Enabled := True;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  
  Form6.Left := Form1.Left;
  Form6.Top := Form1.Top;
end;

end.