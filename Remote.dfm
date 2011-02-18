object frmRemote: TfrmRemote
  Left = 347
  Top = 424
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Remote PC'
  ClientHeight = 208
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 28
    Height = 13
    Caption = 'User: '
  end
  object PaswrdLbl: TLabel
    Left = 200
    Top = 8
    Width = 49
    Height = 13
    Caption = 'Password:'
  end
  object Label3: TLabel
    Left = 110
    Top = 112
    Width = 79
    Height = 13
    Caption = 'Start IP Address:'
  end
  object Label4: TLabel
    Left = 264
    Top = 112
    Width = 76
    Height = 13
    Caption = 'End IP Address:'
  end
  object ConnectBtn: TButton
    Left = 224
    Top = 161
    Width = 75
    Height = 25
    Caption = '&Connect'
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 328
    Top = 161
    Width = 75
    Height = 25
    Caption = 'C&ancel'
    TabOrder = 1
  end
  object NameOrIP: TEdit
    Left = 168
    Top = 64
    Width = 131
    Height = 21
    TabOrder = 2
    Text = '__.__.__.__'
  end
  object Edit1: TEdit
    Left = 56
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Administrator'
  end
  object Edit2: TEdit
    Left = 263
    Top = 5
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '****'
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 111
    Width = 96
    Height = 17
    Caption = 'IP Range'
    TabOrder = 5
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 35
    Width = 113
    Height = 17
    Caption = 'Local Computer'
    TabOrder = 6
  end
  object RadioButton3: TRadioButton
    Left = 8
    Top = 66
    Width = 137
    Height = 17
    Caption = 'PC name or IP address'
    TabOrder = 7
  end
end
