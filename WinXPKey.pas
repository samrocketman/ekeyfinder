unit WinXPKey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    procedure Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.Edit1Click(Sender: TObject);
begin
  if Edit1.Text = 'Format (XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)' then
  begin
    Edit1.Text := '';
    //Edit1.Color := 0;
  end;
end;

procedure TForm5.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    Edit1.Text := 'Format (XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)';
    //Edit1.Color := 12632256;
    //Edit1.co
  end;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Form1.Enabled := True;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  //if Edit1.Text = 'Format (XXXX-XXXX-XXXX-XXXX-XXXX)' then
    //Edit1.Color := 12632256;
end;

end.
