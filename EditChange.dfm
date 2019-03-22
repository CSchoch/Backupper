object TEditChange: TTEditChange
  Left = 427
  Top = 189
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Hinzuf'#252'gen / '#196'ndern'
  ClientHeight = 468
  ClientWidth = 444
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  ParentFont = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    444
    468)
  PixelsPerInch = 96
  TextHeight = 13
  object btOk: TButton
    Left = 141
    Top = 435
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btCancel: TButton
    Left = 222
    Top = 435
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object pcAddChange: TPageControl
    Left = 1
    Top = 1
    Width = 443
    Height = 420
    ActivePage = tsAdvancedOptions
    TabOrder = 2
    object tsBasicOptions: TTabSheet
      Caption = 'tsBasicOptions'
      OnShow = tsBasicOptionsShow
      object gbBasicOptions: TGroupBox
        Left = 4
        Top = 0
        Width = 428
        Height = 180
        Caption = 'gbBasicOptions'
        TabOrder = 0
        DesignSize = (
          428
          180)
        object lSource: TLabel
          Left = 8
          Top = 85
          Width = 35
          Height = 13
          Caption = 'lSource'
        end
        object lDestination: TLabel
          Left = 8
          Top = 131
          Width = 56
          Height = 13
          Caption = 'lDestination'
        end
        object lName: TLabel
          Left = 8
          Top = 39
          Width = 29
          Height = 13
          Caption = 'lName'
        end
        object eSourcePath: TJvDirectoryEdit
          Left = 8
          Top = 104
          Width = 411
          Height = 21
          AcceptFiles = False
          OnAfterDialog = eSourcePathAfterDialog
          DialogKind = dkWin32
          AutoCompleteFileOptions = [acfFileSysDirs]
          DialogOptions = [sdAllowCreate, sdPerformCreate]
          ButtonFlat = True
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Text = 'eSourcePath'
        end
        object eDestinationPath: TJvDirectoryEdit
          Left = 8
          Top = 150
          Width = 411
          Height = 21
          AcceptFiles = False
          OnAfterDialog = eDestinationPathAfterDialog
          DialogKind = dkWin32
          AutoCompleteFileOptions = [acfFileSysDirs]
          ButtonFlat = True
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Text = 'eDestinationPath'
        end
        object cbEnabled: TCheckBox
          Left = 8
          Top = 18
          Width = 409
          Height = 15
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbEnabled'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
        object eName: TEdit
          Left = 8
          Top = 58
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          Text = 'eName'
        end
      end
    end
    object tsAdvancedOptions: TTabSheet
      Caption = 'tsAdvancedOptions'
      ImageIndex = 1
      OnShow = tsAdvancedOptionsShow
      object gbAdvancedOptions: TGroupBox
        Left = 4
        Top = 0
        Width = 428
        Height = 369
        Caption = 'gbAdvancedOptions'
        TabOrder = 0
        DesignSize = (
          428
          369)
        object lFileMask: TLabel
          Left = 8
          Top = 91
          Width = 42
          Height = 13
          Caption = 'lFileMask'
        end
        object lCompareMode: TLabel
          Left = 8
          Top = 277
          Width = 71
          Height = 13
          Caption = 'lCompareMode'
        end
        object lTimeDiff: TLabel
          Left = 8
          Top = 320
          Width = 41
          Height = 13
          Caption = 'lTimeDiff'
        end
        object lSeconds: TLabel
          Left = 63
          Top = 339
          Width = 42
          Height = 13
          Caption = 'lSeconds'
        end
        object lApplications: TLabel
          Left = 8
          Top = 134
          Width = 59
          Height = 13
          Caption = 'lApplications'
        end
        object cbSubFolders: TCheckBox
          Left = 8
          Top = 18
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbSubFolders'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
        object eFileMask: TEdit
          Left = 8
          Top = 107
          Width = 411
          Height = 21
          Hint = 'Mehrere durch ";" getrennt.'
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Text = 'eFileMask'
        end
        object cbDeleteFiles: TCheckBox
          Left = 8
          Top = 45
          Width = 411
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbDeleteFiles'
          TabOrder = 1
        end
        object cCompareMode: TComboBox
          Left = 8
          Top = 293
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          Text = 'cCompareMode'
          OnChange = cCompareModeChange
        end
        object seTimeDiff: TJvSpinEdit
          Left = 8
          Top = 336
          Width = 49
          Height = 21
          ButtonKind = bkStandard
          Decimal = 0
          MaxValue = 9999.000000000000000000
          TabOrder = 4
        end
        object vstApplications: TVirtualStringTree
          Left = 8
          Top = 150
          Width = 411
          Height = 121
          Anchors = [akLeft, akTop, akRight]
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.Options = [hoColumnResize, hoDrag, hoVisible]
          HintAnimation = hatFade
          HintMode = hmHint
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toExtendedFocus]
          OnBeforeItemErase = vstApplicationsBeforeItemErase
          OnCreateEditor = vstApplicationsCreateEditor
          OnEdited = vstApplicationsEdited
          OnEditing = vstApplicationsEditing
          OnFreeNode = vstApplicationsFreeNode
          OnGetText = vstApplicationsGetText
          OnGetHint = vstApplicationsGetHint
          OnMouseUp = vstApplicationsMouseUp
          Columns = <
            item
              Position = 0
              Width = 200
              WideText = 'Application'
            end
            item
              Position = 2
              Width = 149
              WideText = 'Action'
            end
            item
              Position = 3
              WideText = 'Timeout (s)'
            end
            item
              Position = 1
              Width = 65
              WideText = 'Parameter'
            end>
          WideDefaultText = ''
        end
        object cbDoNotCopyFlags: TCheckBox
          Left = 8
          Top = 68
          Width = 411
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbDoNotCopyFlags'
          TabOrder = 6
        end
      end
    end
    object tsTimerOptions: TTabSheet
      Caption = 'tsTimerOptions'
      ImageIndex = 2
      OnShow = tsTimerOptionsShow
      object gbTimerOptions: TGroupBox
        Left = 4
        Top = 0
        Width = 428
        Height = 281
        Caption = 'gbTimerOptions'
        TabOrder = 0
        DesignSize = (
          428
          281)
        object lTimerDate: TLabel
          Left = 8
          Top = 185
          Width = 51
          Height = 13
          Caption = 'lTimerDate'
        end
        object lTimerNumber: TLabel
          Left = 63
          Top = 21
          Width = 65
          Height = 13
          Caption = 'lTimerNumber'
        end
        object lTimerTime: TLabel
          Left = 8
          Top = 231
          Width = 50
          Height = 13
          Caption = 'lTimerTime'
        end
        object lTimerMode: TLabel
          Left = 8
          Top = 93
          Width = 54
          Height = 13
          Caption = 'lTimerMode'
        end
        object lEach: TLabel
          Left = 8
          Top = 115
          Width = 25
          Height = 13
          Caption = 'lEach'
        end
        object lWatchMode: TLabel
          Left = 8
          Top = 139
          Width = 59
          Height = 13
          Caption = 'lWatchMode'
        end
        object cbTimerEnabled: TCheckBox
          Left = 8
          Top = 45
          Width = 411
          Height = 19
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbTimerEnabled'
          TabOrder = 0
          OnClick = cbTimerEnabledClick
        end
        object cbOnShutdown: TCheckBox
          Left = 8
          Top = 70
          Width = 411
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbOnShutdown'
          TabOrder = 1
          OnClick = cbOnShutdownClick
        end
        object dtpTimerDateTime: TJvDateTimePicker
          Left = 8
          Top = 204
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Date = 39074.996716030090000000
          Time = 39074.996716030090000000
          TabOrder = 2
          OnChange = dtpTimerDateTimeChange
          DropDownDate = 39074.000000000000000000
        end
        object dtpTimerTime: TJvDateTimePicker
          Left = 8
          Top = 250
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Date = 39075.002339224540000000
          Time = 39075.002339224540000000
          Kind = dtkTime
          TabOrder = 3
          OnChange = dtpTimerTimeChange
          DropDownDate = 39075.000000000000000000
        end
        object seTimerNumber: TJvSpinEdit
          Left = 8
          Top = 18
          Width = 49
          Height = 21
          ButtonKind = bkStandard
          MaxValue = 5.000000000000000000
          MinValue = 1.000000000000000000
          Value = 1.000000000000000000
          TabOrder = 4
          OnChange = seTimerNumberChange
        end
        object cTimerMode: TComboBox
          Left = 94
          Top = 112
          Width = 325
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 5
          Text = 'cTimerMode'
          OnChange = cTimerModeChange
        end
        object seTimerMulti: TJvSpinEdit
          Left = 39
          Top = 112
          Width = 49
          Height = 21
          ButtonKind = bkStandard
          Decimal = 0
          MaxValue = 60.000000000000000000
          MinValue = 1.000000000000000000
          Value = 1.000000000000000000
          TabOrder = 6
          OnChange = seTimerMultiChange
        end
        object cWatchMode: TComboBox
          Left = 8
          Top = 158
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 7
          Text = 'cWatchMode'
          OnChange = cWatchModeChange
        end
      end
    end
    object tsSkip: TTabSheet
      Caption = 'tsSkip'
      ImageIndex = 3
      OnShow = tsSkipShow
      object gbSkipFolders: TGroupBox
        Left = 5
        Top = 0
        Width = 427
        Height = 145
        Caption = 'gbSkipFolders'
        TabOrder = 0
        DesignSize = (
          427
          145)
        object eSkipFolders: TJvDirectoryEdit
          Left = 8
          Top = 116
          Width = 368
          Height = 21
          AcceptFiles = False
          DialogKind = dkWin32
          AutoCompleteFileOptions = [acfFileSysDirs]
          ButtonFlat = True
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 0
          Text = 'eSkipFolders'
          OnKeyDown = eSkipFoldersKeyDown
        end
        object lvSkipFolders: TListView
          Left = 8
          Top = 16
          Width = 411
          Height = 97
          Anchors = [akLeft, akTop, akRight, akBottom]
          Columns = <
            item
              Width = 330
            end>
          ColumnClick = False
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          ShowColumnHeaders = False
          TabOrder = 1
          ViewStyle = vsReport
          OnCustomDrawItem = lvSkipFoldersCustomDrawItem
          OnKeyDown = lvSkipFoldersKeyDown
          OnSelectItem = lvSkipFoldersSelectItem
        end
        object btAddChangeFolder: TJvImgBtn
          Left = 376
          Top = 116
          Width = 22
          Height = 21
          Anchors = [akRight, akBottom]
          ImageIndex = 0
          Images = MainForm.imlPopupMenu
          TabOrder = 2
          OnClick = btAddChangeFolderClick
          AnimateFrames = 200
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = []
          Spacing = 2
        end
        object btDelFolder: TJvImgBtn
          Left = 397
          Top = 116
          Width = 22
          Height = 21
          Anchors = [akRight, akBottom]
          ImageIndex = 1
          Images = MainForm.imlPopupMenu
          TabOrder = 3
          OnClick = btDelFolderClick
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = []
          Spacing = 2
        end
      end
      object gbSkipFiles: TGroupBox
        Left = 5
        Top = 145
        Width = 427
        Height = 145
        Caption = 'gbSkipFiles'
        TabOrder = 1
        DesignSize = (
          427
          145)
        object lvSkipFiles: TListView
          Left = 8
          Top = 16
          Width = 411
          Height = 97
          Anchors = [akLeft, akRight, akBottom]
          Columns = <
            item
              Width = 330
            end>
          ColumnClick = False
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          ShowColumnHeaders = False
          TabOrder = 0
          ViewStyle = vsReport
          OnCustomDrawItem = lvSkipFilesCustomDrawItem
          OnKeyDown = lvSkipFilesKeyDown
          OnSelectItem = lvSkipFilesSelectItem
        end
        object eSkipFiles: TJvFilenameEdit
          Left = 8
          Top = 116
          Width = 368
          Height = 21
          DialogOptions = [ofForceShowHidden]
          ButtonFlat = True
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 1
          Text = 'eSkipFiles'
          OnKeyDown = eSkipFilesKeyDown
        end
        object btAddChangeFile: TJvImgBtn
          Left = 376
          Top = 116
          Width = 22
          Height = 21
          Anchors = [akRight, akBottom]
          ImageIndex = 0
          Images = MainForm.imlPopupMenu
          TabOrder = 2
          OnClick = btAddChangeFileClick
          AnimateFrames = 200
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = []
          Spacing = 2
        end
        object btDelFile: TJvImgBtn
          Left = 397
          Top = 116
          Width = 22
          Height = 21
          Anchors = [akRight, akBottom]
          ImageIndex = 1
          Images = MainForm.imlPopupMenu
          TabOrder = 3
          OnClick = btDelFileClick
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = []
          Spacing = 2
        end
      end
    end
    object tsDrive: TTabSheet
      Caption = 'tsDrive'
      ImageIndex = 4
      OnShow = tsDriveShow
      object gbDrive: TGroupBox
        Left = 3
        Top = 3
        Width = 429
        Height = 235
        Caption = 'gbDrive'
        TabOrder = 0
        DesignSize = (
          429
          235)
        object lUsername: TLabel
          Left = 8
          Top = 139
          Width = 50
          Height = 13
          Caption = 'lUsername'
        end
        object lPassword: TLabel
          Left = 8
          Top = 185
          Width = 48
          Height = 13
          Caption = 'lPassword'
        end
        object cbSourceDriveLabel: TCheckBox
          Left = 8
          Top = 16
          Width = 411
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbSourceDriveLabel'
          TabOrder = 0
          OnClick = cbSourceDriveLabelClick
        end
        object eSourceDriveLabel: TEdit
          Left = 8
          Top = 39
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Text = 'eSourceDriveLabel'
          OnChange = eSourceDriveLabelChange
        end
        object cbDestDriveLabel: TCheckBox
          Left = 8
          Top = 66
          Width = 411
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbDestDriveLabel'
          TabOrder = 2
          OnClick = cbDestDriveLabelClick
        end
        object eDestDriveLabel: TEdit
          Left = 8
          Top = 89
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          Text = 'eDestDriveLabel'
          OnChange = eDestDriveLabelChange
        end
        object eUsername: TEdit
          Left = 8
          Top = 158
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
          Text = 'eUsername'
        end
        object ePassword: TEdit
          Left = 8
          Top = 204
          Width = 411
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          PasswordChar = '*'
          TabOrder = 5
          Text = 'ePassword'
        end
        object cbEnableNetworkLogon: TCheckBox
          Left = 8
          Top = 116
          Width = 411
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'cbEnableNetworkLogon'
          TabOrder = 6
        end
      end
    end
  end
  object aeBackupper: TApplicationEvents
    OnMessage = aeBackupperMessage
    Left = 336
    Top = 432
  end
end
