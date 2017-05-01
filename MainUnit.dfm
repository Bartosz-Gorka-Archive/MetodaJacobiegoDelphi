object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Metoda Jacobiego - Bartosz G'#243'rka INF127228'
  ClientHeight = 402
  ClientWidth = 769
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  DesignSize = (
    769
    402)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 769
    Height = 401
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 241
      Top = 1
      Height = 399
      ResizeStyle = rsUpdate
      ExplicitLeft = 184
      ExplicitTop = 152
      ExplicitHeight = 100
    end
    object Panel2: TPanel
      Left = 244
      Top = 1
      Width = 524
      Height = 399
      Align = alClient
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 0
      ExplicitLeft = 201
      ExplicitWidth = 399
      ExplicitHeight = 176
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 240
      Height = 399
      Align = alLeft
      Caption = 'Panel3'
      Constraints.MinWidth = 30
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 4
      object LabelSetting: TLabel
        Left = 47
        Top = 0
        Width = 132
        Height = 29
        Caption = 'Ustawienia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 35
        Width = 113
        Height = 18
        Caption = 'Liczba zmiennych'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object VarNumber: TEdit
        Left = 143
        Top = 35
        Width = 26
        Height = 21
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 0
        Text = '2'
        OnChange = VarNumberChange
      end
      object Button1: TButton
        Left = 104
        Top = 248
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 1
      end
      object UpDownVarNumber: TUpDown
        Left = 169
        Top = 35
        Width = 16
        Height = 21
        Associate = VarNumber
        Min = 2
        Max = 999
        Position = 2
        TabOrder = 2
      end
    end
  end
  object MainMenu1: TMainMenu
    Top = 376
    object Application: TMenuItem
      Caption = '&Aplikacja'
    end
    object HelpOption: TMenuItem
      Caption = '&Pomoc'
      OnClick = HelpOptionClick
    end
    object CloseApplication: TMenuItem
      Caption = '&Zamknij'
      OnClick = CloseApplicationClick
    end
  end
end
