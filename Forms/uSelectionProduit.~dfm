object FSelectProduit: TFSelectProduit
  Left = 463
  Top = 140
  Width = 447
  Height = 588
  BorderIcons = []
  Caption = 'FSelectProduit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LogoCipi: TImage
    Left = 96
    Top = 449
    Width = 201
    Height = 46
    Visible = False
  end
  object LogoActia: TImage
    Left = 91
    Top = 451
    Width = 211
    Height = 44
  end
  object lblTitreAppli: TLabel
    Left = 15
    Top = 3
    Width = 400
    Height = 74
    Alignment = taCenter
    AutoSize = False
    Caption = 'Poste'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -32
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 103
    Top = 417
    Width = 202
    Height = 13
    Alignment = taCenter
    Caption = 'Double cliquer pour selectionner un produit'
  end
  object lstProduit: TListBox
    Left = 12
    Top = 83
    Width = 401
    Height = 332
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 18
    ParentFont = False
    TabOrder = 0
    OnClick = lstProduitClick
    OnDblClick = lstProduitDblClick
  end
  object MainMenu1: TMainMenu
    Left = 10
    Top = 4
    object mnuQuitter: TMenuItem
      Caption = 'Quitter'
      OnClick = mnuQuitterClick
    end
    object mnuReglage: TMenuItem
      Caption = 'R'#233'glages'
      Enabled = False
      Visible = False
      object mnuAutomate: TMenuItem
        Caption = 'Automate'
        Checked = True
        Enabled = False
        Visible = False
        OnClick = mnuAutomateClick
      end
      object mnuRework: TMenuItem
        Caption = 'Mode Rework'
        OnClick = mnuReworkClick
        object ReworkTotale1: TMenuItem
          Caption = 'Rework Totale'
          OnClick = ReworkTotale1Click
        end
        object Reworkcapot1: TMenuItem
          Caption = 'Rework capot'
          OnClick = Reworkcapot1Click
        end
      end
    end
  end
end
