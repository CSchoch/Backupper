object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Einstellungen'
  ClientHeight = 478
  ClientWidth = 405
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btOk: TButton
    Left = 322
    Top = 13
    Width = 75
    Height = 25
    Caption = 'btOK'
    ModalResult = 1
    TabOrder = 3
  end
  object btCancel: TButton
    Left = 322
    Top = 37
    Width = 75
    Height = 25
    Caption = 'btCancel'
    ModalResult = 2
    TabOrder = 4
  end
  object gbLogging: TGroupBox
    Left = 8
    Top = 8
    Width = 308
    Height = 137
    Caption = 'gbLogging '
    TabOrder = 0
    DesignSize = (
      308
      137)
    object lLogPath: TLabel
      Left = 8
      Top = 36
      Width = 41
      Height = 13
      Caption = 'lLogPath'
    end
    object lLogLevel: TLabel
      Left = 8
      Top = 76
      Width = 44
      Height = 13
      Caption = 'lLogLevel'
    end
    object cbDescription: TCheckBox
      Left = 8
      Top = 116
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbDescription'
      TabOrder = 3
      OnClick = cbDescriptionClick
    end
    object cbLogEnabled: TCheckBox
      Left = 8
      Top = 16
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbLogEnabled'
      TabOrder = 0
      OnClick = cbLogEnabledClick
    end
    object eLogPath: TJvDirectoryEdit
      Left = 8
      Top = 52
      Width = 289
      Height = 21
      AcceptFiles = False
      OnAfterDialog = eLogPathAfterDialog
      DialogKind = dkWin32
      AutoCompleteFileOptions = []
      ButtonFlat = True
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      OnChange = eLogPathChange
    end
    object cLogLevel: TComboBox
      Left = 8
      Top = 92
      Width = 289
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 2
      OnChange = cLogLevelChange
    end
  end
  object gbProgramm: TGroupBox
    Left = 8
    Top = 151
    Width = 308
    Height = 238
    Caption = 'gbProgramm '
    TabOrder = 1
    DesignSize = (
      308
      238)
    object lPriority: TLabel
      Left = 8
      Top = 16
      Width = 36
      Height = 13
      Caption = 'lPriority'
    end
    object lCloseTimeout: TLabel
      Left = 8
      Top = 56
      Width = 66
      Height = 13
      Caption = 'lCloseTimeout'
    end
    object lSeconds: TLabel
      Left = 54
      Top = 75
      Width = 42
      Height = 13
      Caption = 'lSeconds'
    end
    object cThreadPriority: TComboBox
      Left = 8
      Top = 32
      Width = 289
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      OnChange = cThreadPriorityChange
    end
    object cbEndBackupbevoreShutdown: TCheckBox
      Left = 8
      Top = 96
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbEndBackupBevoreShutdown'
      TabOrder = 2
      OnClick = cbEndBackupbevoreShutdownClick
    end
    object cbConfirmDelete: TCheckBox
      Left = 8
      Top = 136
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbConfirmDelete'
      TabOrder = 4
      OnClick = cbConfirmDeleteClick
    end
    object cbConfirmShutdown: TCheckBox
      Left = 8
      Top = 116
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbConfirmShutdown'
      TabOrder = 3
      OnClick = cbConfirmShutdownClick
    end
    object cbAutostart: TCheckBox
      Left = 8
      Top = 156
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbAutostart'
      TabOrder = 5
      OnClick = cbAutostartClick
    end
    object cbStartInTray: TCheckBox
      Left = 8
      Top = 176
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbStartInTray'
      TabOrder = 6
      OnClick = cbStartInTrayClick
    end
    object cbMinimizetoTray: TCheckBox
      Left = 8
      Top = 196
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbMinimizetoTray'
      TabOrder = 7
      OnClick = cbMinimizetoTrayClick
    end
    object seWaitTimeout: TJvSpinEdit
      Left = 8
      Top = 72
      Width = 40
      Height = 21
      ButtonKind = bkClassic
      MaxValue = 30.000000000000000000
      Value = 30.000000000000000000
      TabOrder = 1
      OnChange = seWaitTimeoutChange
    end
    object cbExtProgress: TCheckBox
      Left = 8
      Top = 216
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbExtProgress'
      TabOrder = 8
      OnClick = cbExtProgressClick
    end
  end
  object gbAfterBackup: TGroupBox
    Left = 8
    Top = 390
    Width = 308
    Height = 78
    Caption = 'gbAfterBackup '
    TabOrder = 2
    DesignSize = (
      308
      78)
    object cbShutdown: TCheckBox
      Left = 8
      Top = 16
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbShutdown'
      TabOrder = 0
      OnClick = cbShutdownClick
    end
    object cbForce: TCheckBox
      Left = 8
      Top = 36
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbForce'
      TabOrder = 1
      OnClick = cbForceClick
    end
    object cbClose: TCheckBox
      Left = 8
      Top = 56
      Width = 289
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'cbClose'
      TabOrder = 2
      OnClick = cbCloseClick
    end
  end
  object btSetValues: TButton
    Left = 322
    Top = 61
    Width = 75
    Height = 25
    Caption = 'btSetValues'
    Enabled = False
    TabOrder = 5
    OnClick = btSetValuesClick
  end
end
