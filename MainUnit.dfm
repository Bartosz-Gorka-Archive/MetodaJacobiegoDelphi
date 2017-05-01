object Form1: TForm1
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
    end
  end
  object MainMenu1: TMainMenu
    Top = 376
    object Aplikacja1: TMenuItem
      Caption = 'Aplikacja'
    end
    object Pomoc1: TMenuItem
      Caption = 'Pomoc'
    end
    object Zamknij1: TMenuItem
      Caption = 'Zamknij'
    end
  end
end
