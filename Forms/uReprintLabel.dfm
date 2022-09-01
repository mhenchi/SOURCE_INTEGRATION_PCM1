object FReprintLabel: TFReprintLabel
  Left = 256
  Top = 194
  Width = 784
  Height = 376
  BorderIcons = []
  Caption = 'R'#233'impression label'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grpReprint: TGroupBox
    Left = 7
    Top = 4
    Width = 760
    Height = 311
    TabOrder = 0
    object lblReprint: TLabel
      Left = 25
      Top = 21
      Width = 716
      Height = 36
      Alignment = taCenter
      AutoSize = False
      Caption = 'R'#233'impression Etiquette'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object GroupBox4: TGroupBox
      Left = 23
      Top = 53
      Width = 715
      Height = 156
      TabOrder = 0
      TabStop = True
      object Shape1: TShape
        Left = 632
        Top = 108
        Width = 32
        Height = 37
        Shape = stCircle
        Visible = False
      end
      object lblEtatReprint: TLabel
        Left = 3
        Top = 9
        Width = 708
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Caption = 'Saisir manuellement ou Scanner le code barre du produit '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Visible = False
        WordWrap = True
      end
      object txtScanReprint: TCDEdit
        Left = 32
        Top = 36
        Width = 649
        Height = 64
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -48
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnlyNumbers = False
        TextAlignment = taCenter
      end
      object cmdManuel: TButton
        Left = 280
        Top = 112
        Width = 173
        Height = 29
        Caption = 'Imprimer'
        TabOrder = 1
        OnClick = cmdManuelClick
      end
    end
    object grpInfo: TGroupBox
      Left = 21
      Top = 218
      Width = 716
      Height = 79
      Caption = 'Info'
      TabOrder = 1
      object lblInfo: TLabel
        Left = 7
        Top = 14
        Width = 702
        Height = 57
        AutoSize = False
        Color = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 11
    Top = 12
    object Annuler1: TMenuItem
      Caption = 'Effacer'
      OnClick = Annuler1Click
    end
    object mnuRetour: TMenuItem
      Caption = 'Retour'
      OnClick = mnuRetourClick
    end
  end
end
