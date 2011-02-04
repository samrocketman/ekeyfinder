object frmWinXPKey: TfrmWinXPKey
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Change Windows XP Key'
  ClientHeight = 104
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 117
    Top = 71
    Width = 75
    Height = 25
    Caption = 'Change Key'
    Enabled = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 198
    Top = 71
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 57
    Caption = 'Enter new Windows Product Key'
    TabOrder = 2
    object Edit1: TEdit
      Left = 16
      Top = 19
      Width = 233
      Height = 21
      TabOrder = 0
      Text = 'Format (XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)'
      OnChange = Edit1Change
      OnClick = Edit1Click
      OnExit = Edit1Exit
    end
  end
end
