object ApplicationData: TApplicationData
  Left = 555
  Top = 281
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Dane aplikacji'
  ClientHeight = 219
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfo: TLabel
    Left = 8
    Top = 8
    Width = 154
    Height = 29
    Caption = 'Problem nr 9'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelTitle: TLabel
    Left = 17
    Top = 34
    Width = 420
    Height = 23
    Caption = 'Rozwi'#261'zywanie uk'#322'adu r'#243'wna'#324' metod'#261' Jacobiego.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object LabelAuthor: TLabel
    Left = 8
    Top = 88
    Width = 66
    Height = 29
    Caption = 'Autor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelName: TLabel
    Left = 17
    Top = 114
    Width = 98
    Height = 19
    Caption = 'Bartosz G'#243'rka'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelGroup: TLabel
    Left = 17
    Top = 134
    Width = 106
    Height = 19
    Caption = 'Informatyka I4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelIndex: TLabel
    Left = 17
    Top = 153
    Width = 84
    Height = 19
    Caption = 'INF 127228'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelURL: TLabel
    Left = 160
    Top = 193
    Width = 139
    Height = 18
    Cursor = crHandPoint
    Caption = 'www.bartosz-gorka.pl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = LabelURLClick
  end
end
