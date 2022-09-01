object DlgErreur: TDlgErreur
  Left = 447
  Top = 348
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Visualisation des messages'
  ClientHeight = 293
  ClientWidth = 548
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 175
    Top = 260
    Width = 210
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 529
    Height = 241
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 1
  end
end
