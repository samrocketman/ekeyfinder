object Form3: TForm3
  Left = 279
  Top = 314
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Change Registration Information'
  ClientHeight = 141
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 32
    Top = 8
    Width = 125
    Height = 13
    Caption = 'Change Registered Owner'
  end
  object Label3: TLabel
    Left = 32
    Top = 56
    Width = 153
    Height = 13
    Caption = 'Change Registered Organization'
  end
  object Button1: TButton
    Left = 189
    Top = 108
    Width = 77
    Height = 25
    Caption = 'Change'
    Enabled = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 32
    Top = 24
    Width = 329
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = 'Error...'
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 32
    Top = 72
    Width = 329
    Height = 21
    ReadOnly = True
    TabOrder = 1
    Text = 'Error...'
    OnKeyPress = Edit3KeyPress
  end
end
