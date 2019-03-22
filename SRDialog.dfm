object SRForm: TSRForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Suchen und Ersetzen'
  ClientHeight = 215
  ClientWidth = 428
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lComp: TLabel
    Left = 8
    Top = 8
    Width = 29
    Height = 13
    Caption = 'lComp'
  end
  object lReplace: TLabel
    Left = 8
    Top = 51
    Width = 40
    Height = 13
    Caption = 'lReplace'
  end
  object lMode: TLabel
    Left = 8
    Top = 140
    Width = 28
    Height = 13
    Caption = 'lMode'
  end
  object eComp: TEdit
    Left = 8
    Top = 24
    Width = 412
    Height = 21
    TabOrder = 0
  end
  object eReplace: TEdit
    Left = 8
    Top = 67
    Width = 412
    Height = 21
    TabOrder = 1
  end
  object cbCaseSens: TCheckBox
    Left = 8
    Top = 94
    Width = 412
    Height = 17
    Caption = 'cbCaseSens'
    TabOrder = 2
  end
  object cbQuitChanges: TCheckBox
    Left = 8
    Top = 117
    Width = 412
    Height = 17
    Caption = 'cbQuitChanges'
    TabOrder = 3
  end
  object btOK: TButton
    Left = 136
    Top = 183
    Width = 75
    Height = 25
    Caption = 'btOK'
    ModalResult = 1
    TabOrder = 4
  end
  object btCancel: TButton
    Left = 217
    Top = 182
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'btCancel'
    ModalResult = 2
    TabOrder = 5
  end
  object cMode: TComboBox
    Left = 8
    Top = 156
    Width = 412
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = 'cMode'
  end
end
