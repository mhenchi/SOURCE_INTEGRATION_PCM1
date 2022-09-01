object frmDefaut: TfrmDefaut
  Left = 948
  Top = 98
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'VISION'
  ClientHeight = 604
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Imagedefaut: TImage
    Left = 0
    Top = 0
    Width = 397
    Height = 565
    Stretch = True
    Visible = False
  end
  object pnlVision: TPanel
    Left = 16
    Top = 54
    Width = 365
    Height = 479
    Caption = 'v'
    TabOrder = 1
    object grpIhmContact: TGroupBox
      Left = 10
      Top = 200
      Width = 345
      Height = 77
      TabOrder = 0
      object shpMiniCam1: TShape
        Left = 307
        Top = 33
        Width = 17
        Height = 17
        Shape = stCircle
      end
      object shpControleCam1: TShape
        Left = 295
        Top = 21
        Width = 41
        Height = 41
        Shape = stCircle
      end
      object Label8: TLabel
        Left = 8
        Top = 24
        Width = 277
        Height = 26
        Alignment = taCenter
        AutoSize = False
        Caption = 'COHERENCE PRODUIT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        WordWrap = True
      end
      object Label9: TLabel
        Left = 8
        Top = 46
        Width = 277
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = 'Fermeture contact contr'#244'le coh'#233'rence produit '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object grpVisionConnecteurs: TGroupBox
      Left = 10
      Top = 380
      Width = 345
      Height = 77
      TabOrder = 1
      object shpMiniConnecteurs: TShape
        Left = 307
        Top = 33
        Width = 17
        Height = 17
        Shape = stCircle
      end
      object shpConnecteurs: TShape
        Left = 295
        Top = 21
        Width = 41
        Height = 41
        Shape = stCircle
      end
      object Label1: TLabel
        Left = 6
        Top = 31
        Width = 285
        Height = 26
        Alignment = taCenter
        AutoSize = False
        Caption = 'CONTROLE CONNECTEURS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        WordWrap = True
      end
    end
    object grpVisionModem: TGroupBox
      Left = 10
      Top = 110
      Width = 345
      Height = 77
      TabOrder = 2
      object shpMiniModem: TShape
        Left = 307
        Top = 33
        Width = 17
        Height = 17
        Shape = stCircle
      end
      object shpModem: TShape
        Left = 295
        Top = 21
        Width = 41
        Height = 41
        Shape = stCircle
      end
      object Label3: TLabel
        Left = 6
        Top = 31
        Width = 285
        Height = 26
        Alignment = taCenter
        AutoSize = False
        Caption = 'CONTROLE MODEM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        WordWrap = True
      end
    end
    object grpVisionDtx: TGroupBox
      Left = 10
      Top = 20
      Width = 345
      Height = 77
      TabOrder = 3
      object shpMiniDtx: TShape
        Left = 307
        Top = 33
        Width = 17
        Height = 17
        Shape = stCircle
      end
      object shpDtx: TShape
        Left = 295
        Top = 21
        Width = 41
        Height = 41
        Shape = stCircle
      end
      object Label4: TLabel
        Left = 6
        Top = 31
        Width = 285
        Height = 26
        Alignment = taCenter
        AutoSize = False
        Caption = 'LECTURE DATAMATRIX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        WordWrap = True
      end
    end
    object grpCapot: TGroupBox
      Left = 10
      Top = 290
      Width = 345
      Height = 77
      TabOrder = 4
      object lblCapot: TLabel
        Left = 5
        Top = 23
        Width = 284
        Height = 37
        Alignment = taCenter
        AutoSize = False
        Caption = 'METTRE CAPOT'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object shpMiniCapot: TShape
        Left = 307
        Top = 33
        Width = 17
        Height = 17
        Shape = stCircle
      end
      object shpCapot: TShape
        Left = 295
        Top = 21
        Width = 41
        Height = 41
        Shape = stCircle
      end
      object lblPresenceCapot: TLabel
        Left = 12
        Top = 28
        Width = 277
        Height = 37
        Alignment = taCenter
        AutoSize = False
        Caption = 'PRESENCE CAPOT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        WordWrap = True
      end
    end
  end
  object mnufermerDefaut: TButton
    Left = 144
    Top = 571
    Width = 105
    Height = 29
    Caption = 'Initialiser'
    TabOrder = 0
    Visible = False
    OnClick = mnufermerDefautClick
  end
end
