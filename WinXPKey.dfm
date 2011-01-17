object Form5: TForm5
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Change Windows XP Key'
  ClientHeight = 138
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 118
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Change Key'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 206
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 89
    Caption = 'Enter new Windows Product Key'
    TabOrder = 2
    object Edit1: TEdit
      Left = 16
      Top = 35
      Width = 233
      Height = 21
      TabOrder = 0
      Text = 'Format (XXXX-XXXX-XXXX-XXXX-XXXX)'
      OnChange = Edit1Change
    end
  end
end
