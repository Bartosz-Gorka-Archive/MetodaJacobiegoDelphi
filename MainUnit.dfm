object MainForm: TMainForm
  Left = 299
  Top = 118
  Caption = 'Metoda Jacobiego - Bartosz G'#243'rka INF127228'
  ClientHeight = 419
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
  OnCreate = FormCreate
  DesignSize = (
    769
    419)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 769
    Height = 418
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 209
      Top = 1
      Height = 416
      ResizeStyle = rsUpdate
      ExplicitLeft = 583
      ExplicitTop = 2
      ExplicitHeight = 399
    end
    object Splitter2: TSplitter
      Left = 580
      Top = 1
      Height = 416
      Align = alRight
      ExplicitLeft = 584
      ExplicitTop = 0
      ExplicitHeight = 399
    end
    object Panel2: TPanel
      Left = 212
      Top = 1
      Width = 368
      Height = 416
      Align = alClient
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 0
      object LabelEquations: TLabel
        Left = 98
        Top = 0
        Width = 166
        Height = 29
        Caption = 'Uk'#322'ad r'#243'wna'#324
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelFirstVal: TLabel
        Left = 42
        Top = 313
        Width = 296
        Height = 29
        Caption = 'Pocz'#261'tkowe przybli'#380'enie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object StringGridEquations: TStringGrid
        Left = 3
        Top = 35
        Width = 362
        Height = 272
        ColCount = 4
        RowCount = 3
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
      end
      object StringGridStartVal: TStringGrid
        Left = 3
        Top = 346
        Width = 362
        Height = 70
        ColCount = 3
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 208
      Height = 416
      Align = alLeft
      Caption = 'Panel3'
      Constraints.MinWidth = 30
      ShowCaption = False
      TabOrder = 1
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
      object LabelRownanie: TLabel
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
      object LabelArytm: TLabel
        Left = 8
        Top = 146
        Width = 76
        Height = 18
        Caption = 'Arytmetyka'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LabelClear: TLabel
        Left = 8
        Top = 258
        Width = 98
        Height = 18
        Caption = 'Wyczy'#347#263' uk'#322'ad'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LabelExample: TLabel
        Left = 8
        Top = 313
        Width = 113
        Height = 18
        Caption = 'Wczytaj przyk'#322'ad'
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
      object ButtonSolve: TButton
        Left = 8
        Top = 206
        Width = 177
        Height = 25
        Caption = '&Oblicz'
        TabOrder = 1
        OnClick = ButtonSolveClick
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
      object EditEpsilon: TEdit
        Left = 143
        Top = 123
        Width = 26
        Height = 21
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 4
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
        Max = 26
        Position = 1
        TabOrder = 5
      end
      object RadioButtonZmienno: TRadioButton
        Left = 45
        Top = 165
        Width = 140
        Height = 17
        Caption = 'Zmiennopozycyjna'
        Checked = True
        TabOrder = 6
        TabStop = True
      end
      object RadioButtonPrzedzialowa: TRadioButton
        Left = 45
        Top = 183
        Width = 140
        Height = 17
        Caption = 'Przedzia'#322'owa'
        TabOrder = 7
      end
      object ButtonClear: TButton
        Left = 8
        Top = 282
        Width = 177
        Height = 25
        Caption = '&Wykonaj'
        TabOrder = 8
        OnClick = ButtonClearClick
      end
      object ButtonReadExample: TButton
        Left = 8
        Top = 340
        Width = 177
        Height = 25
        Caption = 'W&czytaj'
        TabOrder = 9
        OnClick = ButtonReadExampleClick
      end
      object IterNumber: TEdit
        Left = 143
        Top = 68
        Width = 26
        Height = 21
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 10
        Text = '1'
        OnChange = IterNumberChange
      end
      object UpDown1: TUpDown
        Left = 170
        Top = 312
        Width = 16
        Height = 21
        Associate = ExampleNumber
        Min = 1
        Max = 7
        Position = 1
        TabOrder = 11
      end
      object ExampleNumber: TEdit
        Left = 144
        Top = 312
        Width = 26
        Height = 21
        MaxLength = 1
        NumbersOnly = True
        TabOrder = 12
        Text = '1'
        OnChange = ExampleNumberChange
      end
    end
    object Panel4: TPanel
      Left = 583
      Top = 1
      Width = 185
      Height = 416
      Align = alRight
      Caption = 'Panel4'
      ShowCaption = False
      TabOrder = 2
      object LabelResults: TLabel
        Left = 59
        Top = 0
        Width = 82
        Height = 29
        Caption = 'Wyniki'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object MemoResults: TMemo
        Left = 0
        Top = 35
        Width = 185
        Height = 272
        TabOrder = 0
      end
      object ButtonCopy: TButton
        Left = 6
        Top = 313
        Width = 171
        Height = 25
        Caption = 'Skopiuj do schowka'
        TabOrder = 1
        OnClick = ButtonCopyClick
      end
      object ButtonClearResults: TButton
        Left = 6
        Top = 344
        Width = 171
        Height = 25
        Caption = 'Wyczy'#347#263' wyniki'
        TabOrder = 2
        OnClick = ButtonClearResultsClick
      end
    end
  end
  object MainMenu1: TMainMenu
    Top = 376
    object Application: TMenuItem
      Caption = '&Aplikacja'
      OnClick = ApplicationClick
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
