object Form2: TForm2
  Left = 465
  Top = 306
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 256
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 99
    Height = 13
    Caption = 'Default App List Font'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 132
    Top = 0
    Width = 112
    Height = 13
    Caption = 'Default CD Key List'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 8
    Top = 172
    Width = 70
    Height = 13
    Caption = 'CSV Delimiter: '
  end
  object Button3: TButton
    Left = 198
    Top = 223
    Width = 75
    Height = 25
    Caption = '&Close'
    TabOrder = 0
    OnClick = Button3Click
  end
  object EdtCSV1: TEdit
    Left = 84
    Top = 169
    Width = 29
    Height = 21
    TabOrder = 1
    Text = ','
  end
  object OptChkBxErrLog: TCheckBox
    Left = 8
    Top = 114
    Width = 91
    Height = 17
    Caption = '&Error Logging'
    TabOrder = 2
    OnClick = OptChkBxErrLogClick
  end
  object OptFontBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 89
    Caption = 'Change Fonts'
    TabOrder = 3
    object LblAppList: TLabel
      Left = 86
      Top = 18
      Width = 100
      Height = 25
      Caption = 'Application List'
      Constraints.MinHeight = 25
      Constraints.MinWidth = 100
      Layout = tlCenter
      WordWrap = True
    end
    object LblKeyDisp: TLabel
      Left = 86
      Top = 55
      Width = 100
      Height = 25
      Caption = 'Key Display'
      Constraints.MinHeight = 25
      Constraints.MinWidth = 100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object Button2: TButton
      Left = 16
      Top = 55
      Width = 54
      Height = 25
      Caption = 'F&ont...'
      Constraints.MinHeight = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 16
      Top = 18
      Width = 54
      Height = 25
      Caption = '&Font...'
      Constraints.MinHeight = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object ButOptRestDef: TButton
    Left = 94
    Top = 223
    Width = 90
    Height = 25
    Caption = '&Restore Defaults'
    Enabled = False
    TabOrder = 4
    Visible = False
    OnClick = ButOptRestDefClick
  end
  object OptChkBxSave: TCheckBox
    Left = 8
    Top = 200
    Width = 97
    Height = 17
    Caption = '&Save Settings'
    Checked = True
    State = cbChecked
    TabOrder = 7
    Visible = False
    OnClick = OptChkBxSaveClick
  end
  object Button5: TButton
    Left = 198
    Top = 110
    Width = 75
    Height = 25
    Caption = '&Browse...'
    Enabled = False
    TabOrder = 5
    OnClick = Button5Click
  end
  object EdtLogPath: TEdit
    Left = 8
    Top = 137
    Width = 266
    Height = 21
    Enabled = False
    TabOrder = 6
    Text = 'EdtLogPath'
  end
end
