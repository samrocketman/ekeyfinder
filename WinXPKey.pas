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
    procedure Edit1Change(Sender: TObject);
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

procedure TForm5.Edit1Change(Sender: TObject);
begin
  if Edit1.Text = 'Format (XXXX-XXXX-XXXX-XXXX-XXXX)' then
    Edit1.Text := '';
end;

end.
