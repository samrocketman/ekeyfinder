object OKBottomDlg: TOKBottomDlg
  Left = 273
  Top = 379
  BorderStyle = bsDialog
  Caption = 'License Information'
  ClientHeight = 214
  ClientWidth = 306
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 135
    Top = 181
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 306
    Height = 169
    Align = alTop
    Lines.Strings = (
      'The Enchanted Keyfinder is a free utility that retrieves '
      'your Product Key (cd key) used to install windows from '
      'your registry. '
      ''
      'Copyright (C) 2011 Enchanted Keyfinder Project'
      'Copyright (C) 1999-2008  Magical Jelly Bean Software'
      ''
      'This program is free software: you can redistribute it '
      'and/or modify it under the terms of the GNU General '
      'Public License as published by the Free Software '
      'Foundation, either version 3 of the License, or (at your '
      'option) any later version.'
      ''
      'This program is distributed in the hope that it will be '
      'useful, but WITHOUT ANY WARRANTY; without even the '
      'implied warranty of MERCHANTABILITY or FITNESS FOR '
      'A PARTICULAR PURPOSE.  See the GNU General Public '
      'License for more details.'
      ''
      'You should have received a copy of the GNU General '
      'Public License along with this program.  If not, see '
      '<http://www.gnu.org/licenses/>.')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 223
    Top = 181
    Width = 75
    Height = 25
    Caption = 'Full License'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = Button1Click
  end
end
