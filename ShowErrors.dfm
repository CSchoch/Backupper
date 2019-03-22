object TShowErrors: TTShowErrors
  Left = 250
  Top = 108
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Job Fehler '
  ClientHeight = 597
  ClientWidth = 473
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  ParentFont = True
  OldCreateOrder = True
  Position = poMainFormCenter
  DesignSize = (
    473
    597)
  PixelsPerInch = 96
  TextHeight = 13
  object btClose: TButton
    Left = 200
    Top = 562
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = '&Schlie'#223'en'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btCloseClick
  end
  object mErrors: TMemo
    Left = 0
    Top = 0
    Width = 473
    Height = 553
    Lines.Strings = (
      'mErrors')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WantReturns = False
  end
end
