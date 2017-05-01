object MainForm: TMainForm
  Left = 299
  Top = 118
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
  Position = poDesigned
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
      Left = 209
      Top = 1
      Height = 399
      ResizeStyle = rsUpdate
      ExplicitLeft = 583
      ExplicitTop = 2
    end
    object Splitter2: TSplitter
      Left = 580
      Top = 1
      Height = 399
      Align = alRight
      ExplicitLeft = 584
      ExplicitTop = 0
    end
    object Panel2: TPanel
      Left = 212
      Top = 1
      Width = 368
      Height = 399
      Align = alClient
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 0
      ExplicitLeft = 292
      ExplicitWidth = 213
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 208
      Height = 399
      Align = alLeft
      Caption = 'Panel3'
      Constraints.MinWidth = 30
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 340
      object LabelSetting: TLabel
        Left = 26
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
      object LabelVarNumber: TLabel
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
      object LabelIterNumber: TLabel
        Left = 8
        Top = 67
        Width = 85
        Height = 18
        Caption = 'Liczba iteracji'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LabelEpsilon: TLabel
        Left = 8
        Top = 99
        Width = 73
        Height = 18
        Caption = 'Przybli'#380'enie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 79
        Top = 122
        Width = 63
        Height = 18
        Caption = '1 * 10^ -'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
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
      object ButtonSolve: TButton
        Left = 8
        Top = 168
        Width = 177
        Height = 25
        Caption = '&Oblicz'
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
      object UpDownIterNumber: TUpDown
        Left = 169
        Top = 68
        Width = 16
        Height = 21
        Associate = IterNumber
        Min = 1
        Max = 999
        Position = 1
        TabOrder = 3
      end
      object IterNumber: TEdit
        Left = 143
        Top = 68
        Width = 26
        Height = 21
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 4
        Text = '1'
        OnChange = IterNumberChange
      end
      object EditEpsilon: TEdit
        Left = 143
        Top = 123
        Width = 26
        Height = 21
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 5
        Text = '1'
        OnChange = EditEpsilonChange
      end
      object UpDownEpsilon: TUpDown
        Left = 169
        Top = 123
        Width = 16
        Height = 21
        Associate = EditEpsilon
        Min = 1
        Max = 16
        Position = 1
        TabOrder = 6
      end
      object Memo1: TMemo
        Left = 8
        Top = 288
        Width = 177
        Height = 105
        Enabled = False
        Lines.Strings = (
          '9. Rozwi'#261'zywanie uk'#322'ad'#243'w '
          'r'#243'wna'#324' metod'#261' Jacobiego.'
          ''
          'Autor:'
          'Bartosz G'#243'rka'
          'Informatyka I4'
          'INF127228')
        TabOrder = 7
      end
    end
    object Panel4: TPanel
      Left = 583
      Top = 1
      Width = 185
      Height = 399
      Align = alRight
      Caption = 'Panel4'
      ShowCaption = False
      TabOrder = 2
      ExplicitLeft = 584
      ExplicitTop = 0
      ExplicitHeight = 401
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
