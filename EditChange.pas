unit EditChange;

interface

{$INCLUDE Compilerswitches.inc}

uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  ShellApi,
  Messages,
  AppEvnts,
  StdCtrls,
  ComCtrls,
  JvComponentBase,
  JvBaseDlg,
  JvBrowseFolder,
  JvToolEdit,
  Mask,
  JvExMask,
  JvCtrls,
  JvExStdCtrls,
  JvButton,
  Controls,
  JvExComCtrls,
  JvDateTimePicker,
  JvSpin,
  VirtualTrees,
  VTreeHelper,
  VPropertyTreeEditors,
  csUtils,
  Graphics;

type
  TTEditChange = class(TForm)
    btOk : TButton;
    btCancel : TButton;
    pcAddChange : TPageControl;
    tsBasicOptions : TTabSheet;
    tsAdvancedOptions : TTabSheet;
    tsTimerOptions : TTabSheet;
    gbBasicOptions : TGroupBox;
    lSource : TLabel;
    lDestination : TLabel;
    lName : TLabel;
    eSourcePath : TJvDirectoryEdit;
    eDestinationPath : TJvDirectoryEdit;
    cbEnabled : TCheckBox;
    eName : TEdit;
    gbAdvancedOptions : TGroupBox;
    lFileMask : TLabel;
    lCompareMode : TLabel;
    lTimeDiff : TLabel;
    lSeconds : TLabel;
    cbSubFolders : TCheckBox;
    eFileMask : TEdit;
    cbDeleteFiles : TCheckBox;
    cCompareMode : TComboBox;
    seTimeDiff : TJvSpinEdit;
    gbTimerOptions : TGroupBox;
    lTimerDate : TLabel;
    lTimerNumber : TLabel;
    lTimerTime : TLabel;
    lTimerMode : TLabel;
    cbTimerEnabled : TCheckBox;
    cbOnShutdown : TCheckBox;
    dtpTimerDateTime : TJvDateTimePicker;
    dtpTimerTime : TJvDateTimePicker;
    seTimerNumber : TJvSpinEdit;
    cTimerMode : TComboBox;
    tsSkip : TTabSheet;
    gbSkipFolders : TGroupBox;
    gbSkipFiles : TGroupBox;
    eSkipFolders : TJvDirectoryEdit;
    lvSkipFolders : TListView;
    lvSkipFiles : TListView;
    eSkipFiles : TJvFilenameEdit;
    btAddChangeFolder : TJvImgBtn;
    btDelFolder : TJvImgBtn;
    btAddChangeFile : TJvImgBtn;
    btDelFile : TJvImgBtn;
    lEach : TLabel;
    seTimerMulti : TJvSpinEdit;
    lWatchMode : TLabel;
    cWatchMode : TComboBox;
    vstApplications : TVirtualStringTree;
    tsDrive : TTabSheet;
    gbDrive : TGroupBox;
    cbSourceDriveLabel : TCheckBox;
    eSourceDriveLabel : TEdit;
    cbDestDriveLabel : TCheckBox;
    eDestDriveLabel : TEdit;
    lUsername : TLabel;
    eUsername : TEdit;
    ePassword : TEdit;
    lPassword : TLabel;
    cbEnableNetworkLogon : TCheckBox;
    aeBackupper : TApplicationEvents;
    lApplications : TLabel;
    cbDoNotCopyFlags : TCheckBox;

    /// /////////////////////////tsBasicOptions//////////////////////////////////
    procedure tsBasicOptionsShow(Sender : TObject);
    procedure eDestinationPathAfterDialog(Sender : TObject; var AName : string; var AAction : Boolean);
    procedure eSourcePathAfterDialog(Sender : TObject; var AName : string; var AAction : Boolean);
    /// /////////////////////////////////////////////////////////////////////////

    /// ///////////////////////tsAdvancedOptions/////////////////////////////////
    procedure tsAdvancedOptionsShow(Sender : TObject);
    procedure vstApplicationsGetText(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
      TextType : TVSTTextType; var CellText : String);
    procedure vstApplicationsCreateEditor(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
      out EditLink : IVTEditLink);
    procedure vstApplicationsEditing(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
      var Allowed : Boolean);
    procedure vstApplicationsMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
    procedure vstApplicationsEdited(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);
    procedure vstApplicationsGetHint(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
      var LineBreakStyle : TVTTooltipLineBreakStyle; var HintText : String);
    procedure cCompareModeChange(Sender : TObject);
    procedure vstApplicationsFreeNode(Sender : TBaseVirtualTree; Node : PVirtualNode);
    /// /////////////////////////////////////////////////////////////////////////

    /// /////////////////////////tsTimerOptions//////////////////////////////////
    procedure tsTimerOptionsShow(Sender : TObject);
    procedure seTimerNumberChange(Sender : TObject);
    procedure dtpTimerTimeChange(Sender : TObject);
    procedure dtpTimerDateTimeChange(Sender : TObject);
    procedure cbOnShutdownClick(Sender : TObject);
    procedure cbTimerEnabledClick(Sender : TObject);
    procedure cTimerModeChange(Sender : TObject);
    procedure cWatchModeChange(Sender : TObject);
    procedure seTimerMultiChange(Sender : TObject);
    /// /////////////////////////////////////////////////////////////////////////

    /// ///////////////////////////////tsSkip////////////////////////////////////
    procedure lvSkipFilesSelectItem(Sender : TObject; Item : TListItem; Selected : Boolean);
    procedure btDelFileClick(Sender : TObject);
    procedure btAddChangeFileClick(Sender : TObject);
    procedure lvSkipFoldersSelectItem(Sender : TObject; Item : TListItem; Selected : Boolean);
    procedure btDelFolderClick(Sender : TObject);
    procedure btAddChangeFolderClick(Sender : TObject);
    procedure lvSkipFoldersCustomDrawItem(Sender : TCustomListView; Item : TListItem; State : TCustomDrawState;
      var DefaultDraw : Boolean);
    procedure lvSkipFilesCustomDrawItem(Sender : TCustomListView; Item : TListItem; State : TCustomDrawState;
      var DefaultDraw : Boolean);
    procedure tsSkipShow(Sender : TObject);
    procedure eSkipFilesKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure eSkipFoldersKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure lvSkipFilesKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure lvSkipFoldersKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    /// /////////////////////////////////////////////////////////////////////////

    /// ///////////////////////////////tsDrive////////////////////////////////////
    procedure tsDriveShow(Sender : TObject);
    procedure cbSourceDriveLabelClick(Sender : TObject);
    procedure cbDestDriveLabelClick(Sender : TObject);
    procedure eDestDriveLabelChange(Sender : TObject);
    procedure eSourceDriveLabelChange(Sender : TObject);
    /// /////////////////////////////////////////////////////////////////////////

    procedure aeBackupperMessage(var Msg : tagMSG; var Handled : Boolean);
    procedure FormShow(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure vstApplicationsBeforeItemErase(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode;
      ItemRect : TRect; var ItemColor : TColor; var EraseAction : TItemEraseAction);
  private
    procedure FillApplication(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; var Abort : Boolean);
  public
    iTimeout : Integer;
    CompareMode : TCompareMode;
    SkipFolders, SkipFiles : TStringList;
    Timer : ATimerData;
    Application : AApplicationData;
  end;

var
  TEditChange : TTEditChange;

implementation

{$R *.dfm}

uses
  MainFrame;

/// ///////////////////////////tsBasicOptions////////////////////////////////////

procedure TTEditChange.tsBasicOptionsShow(Sender : TObject);
begin
  pcAddChange.Height := gbBasicOptions.Height + 34;
  TEditChange.Height := gbBasicOptions.Height + 108;
end;

procedure TTEditChange.eSourcePathAfterDialog(Sender : TObject; var AName : string; var AAction : Boolean);
begin
  AAction := IsNetworkPath(AName) or (GetDriveType(PChar(ExtractFileDrive(AName))) <> DRIVE_NO_ROOT_DIR);
end;

procedure TTEditChange.eDestinationPathAfterDialog(Sender : TObject; var AName : string; var AAction : Boolean);
begin
  AAction := IsNetworkPath(AName) or (GetDriveType(PChar(ExtractFileDrive(AName))) <> DRIVE_NO_ROOT_DIR);
end;

/// /////////////////////////////////////////////////////////////////////////////

/// /////////////////////////tsAdvancedOptions///////////////////////////////////

procedure TTEditChange.tsAdvancedOptionsShow(Sender : TObject);
begin
  pcAddChange.Height := gbAdvancedOptions.Height + 34;
  TEditChange.Height := gbAdvancedOptions.Height + 108;
end;

procedure TTEditChange.vstApplicationsBeforeItemErase(Sender : TBaseVirtualTree; TargetCanvas : TCanvas;
  Node : PVirtualNode; ItemRect : TRect; var ItemColor : TColor; var EraseAction : TItemEraseAction);
begin
  if Odd(Node.Index) then
  begin
    ItemColor := $FFEEEE;
    EraseAction := eaColor;
  end;
end;

procedure TTEditChange.vstApplicationsCreateEditor(Sender : TBaseVirtualTree; Node : PVirtualNode;
  Column : TColumnIndex; out EditLink : IVTEditLink);
begin
  EditLink := TPropertyEditLink.Create;
end;

procedure TTEditChange.vstApplicationsEdited(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);
var
  Data : PApplicationData;
  NodeI : PVirtualNode;
begin
  Data := Sender.GetNodeData(Node);
  if Data^.sFileName = '' then
  begin
    Data^.Action := aaNone;
  end;
  Node := Sender.GetLast();
  if Assigned(Node) then
  begin
    Data := Sender.GetNodeData(Node);
    if (Data^.sFileName <> '') and (Node.Index <= High(AApplicationData) - 1) then
    begin
      Node := Sender.AddChild(nil);
      vstApplications.ValidateNode(Node, false);
      Data := Sender.GetNodeData(Node);
      Data^.sFileName := '';
      Data^.sParam := '';
      Data^.iTimeout := iTimeout;
      Data^.Action := aaNone;
    end;
  end;
  NodeI := Sender.GetFirst;
  Node := Sender.GetLast();
  while (NodeI <> nil) and (NodeI <> Node) do
  begin
    Data := Sender.GetNodeData(NodeI);
    if Data^.sFileName = '' then
    begin
      Sender.DeleteNode(NodeI);
    end;
    NodeI := Sender.GetNext(NodeI);
  end;
end;

procedure TTEditChange.vstApplicationsEditing(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
  var Allowed : Boolean);
var
  Data : PApplicationData;
begin
  Data := Sender.GetNodeData(Node);
  Allowed := (Data^.sFileName <> '') or (Column = 0);
end;

procedure TTEditChange.vstApplicationsFreeNode(Sender : TBaseVirtualTree; Node : PVirtualNode);
var
  Data : PApplicationData;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
  begin
    Data^.sFileName := '';
    Data^.sParam := '';
    Data^.iTimeout := 0;
    Data^.Action := aaNone;
  end;
end;

procedure TTEditChange.vstApplicationsGetHint(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
  var LineBreakStyle : TVTTooltipLineBreakStyle; var HintText : String);
var
  Data : PApplicationData;
begin
  Data := Sender.GetNodeData(Node);
  case Column of
    0 :
      if Data^.sFileName <> '' then
      begin
        HintText := Data^.sFileName;
      end
      else
      begin
        HintText := MainForm.JvTranslate.Translate('GUIStrings', 'ClickToChange');
      end;
    1 :
      if Data^.sFileName <> '' then
      begin
        with MainForm.JvTranslate do
        begin
          case Data^.Action of
            aaNone :
              HintText := Translate('GUIStrings', 'None');
            aaRunBefore :
              HintText := Translate('GUIStrings', 'RunBevore');
            aaRunAfter :
              HintText := Translate('GUIStrings', 'RunAfter');
            aaCloseBefore :
              HintText := Translate('GUIStrings', 'CloseBevore');
            aaCloseAfter :
              HintText := Translate('GUIStrings', 'CloseAfter');
            aaRunBeforeAndWait :
              HintText := Translate('GUIStrings', 'RunBevoreAndWait');
            aaRunAfterAndWait :
              HintText := Translate('GUIStrings', 'RunAfterAndWait');
            aaCloseBeforeAndWait :
              HintText := Translate('GUIStrings', 'CloseBevoreAndWait');
            aaCloseAfterAndWait :
              HintText := Translate('GUIStrings', 'CloseAfterAndWait');
          end;
        end;
      end
      else
      begin
        HintText := '';
      end;
    2 :
      if Data^.sFileName <> '' then
      begin
        HintText := inttostr(Data^.iTimeout div 1000);
      end
      else
      begin
        HintText := '';
      end;
    3 :
      if Data^.sFileName <> '' then
      begin
        HintText := Data^.sParam;
      end
      else
      begin
        HintText := '';
      end;
  end;
end;

procedure TTEditChange.vstApplicationsGetText(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
  TextType : TVSTTextType; var CellText : String);
var
  Data : PApplicationData;
begin
  Data := vstApplications.GetNodeData(Node);
  case Column of
    0 :
      if Data^.sFileName <> '' then
      begin
        CellText := Data^.sFileName;
      end
      else
      begin
        CellText := MainForm.JvTranslate.Translate('GUIStrings', 'ClickToChange');
      end;
    1 :
      if Data^.sFileName <> '' then
      begin
        with MainForm.JvTranslate do
        begin
          case Data^.Action of
            aaNone :
              CellText := Translate('GUIStrings', 'None');
            aaRunBefore :
              CellText := Translate('GUIStrings', 'RunBevore');
            aaRunAfter :
              CellText := Translate('GUIStrings', 'RunAfter');
            aaCloseBefore :
              CellText := Translate('GUIStrings', 'CloseBevore');
            aaCloseAfter :
              CellText := Translate('GUIStrings', 'CloseAfter');
            aaRunBeforeAndWait :
              CellText := Translate('GUIStrings', 'RunBevoreAndWait');
            aaRunAfterAndWait :
              CellText := Translate('GUIStrings', 'RunAfterAndWait');
            aaCloseBeforeAndWait :
              CellText := Translate('GUIStrings', 'CloseBevoreAndWait');
            aaCloseAfterAndWait :
              CellText := Translate('GUIStrings', 'CloseAfterAndWait');
          end;
        end;
      end
      else
      begin
        CellText := '';
      end;
    2 :
      if Data^.sFileName <> '' then
      begin
        CellText := inttostr(Data^.iTimeout div 1000);
      end
      else
      begin
        CellText := '';
      end;
    3 :
      if Data^.sFileName <> '' then
      begin
        CellText := Data^.sParam;
      end
      else
      begin
        CellText := '';
      end;
  end;
end;

procedure TTEditChange.vstApplicationsMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  Node : PVirtualNode;
  Column : Integer;
begin
  Node := vstApplications.GetNodeAt(X, Y);
  Column := vstApplications.Header.Columns.ColumnFromPosition(Point(X, Y));
  if Assigned(Node) then
  begin
    vstApplications.EditNode(Node, Column);
  end;
end;

procedure TTEditChange.cCompareModeChange(Sender : TObject);
begin
  case cCompareMode.Items.IndexOf(cCompareMode.Text) of
    0 :
      begin
        CompareMode := cmHash;
        seTimeDiff.Enabled := false;
        lTimeDiff.Enabled := false;
        lSeconds.Enabled := false;
      end;
    1 :
      begin
        CompareMode := cmSizeTime;
        seTimeDiff.Enabled := true;
        lTimeDiff.Enabled := true;
        lSeconds.Enabled := true;
      end;
    2 :
      begin
        CompareMode := cmArchive;
        seTimeDiff.Enabled := false;
        lTimeDiff.Enabled := false;
        lSeconds.Enabled := false;
      end;
  else
    cCompareMode.Text := cCompareMode.Items.Strings[0];
    CompareMode := cmHash;
    seTimeDiff.Enabled := false;
    lTimeDiff.Enabled := false;
    lSeconds.Enabled := false;
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////

/// ///////////////////////////tsTimerOptions////////////////////////////////////

procedure TTEditChange.tsTimerOptionsShow(Sender : TObject);
begin
  pcAddChange.Height := gbTimerOptions.Height + 34;
  TEditChange.Height := gbTimerOptions.Height + 108;
end;

procedure TTEditChange.cTimerModeChange(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  case cTimerMode.Items.IndexOf(cTimerMode.Text) of
    0 :
      Timer[i].Kind := tkOneShot;
    1 :
      begin
        Timer[i].Kind := tkEachMinute;
        seTimerMulti.MaxValue := 59;
      end;
    2 :
      begin
        Timer[i].Kind := tkEachHour;
        seTimerMulti.MaxValue := 23;
      end;
    3 :
      begin
        Timer[i].Kind := tkEachDay;
        seTimerMulti.MaxValue := 30;
      end;
    4 :
      begin
        Timer[i].Kind := tkEachMonth;
        seTimerMulti.MaxValue := 12;
      end;
  end;
  seTimerMulti.CheckMaxValue := true;
  Timer[i].iMulti := trunc(seTimerMulti.Value);
  lEach.Enabled := (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
  seTimerMulti.Enabled := (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
end;

procedure TTEditChange.cWatchModeChange(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  Timer[i].WatchMode := TWatchMode(cWatchMode.Items.IndexOf(cWatchMode.Text));
  lTimerMode.Enabled := (Timer[i].WatchMode <> wmChange);
  lTimerDate.Enabled := (Timer[i].WatchMode <> wmChange);
  lTimerTime.Enabled := (Timer[i].WatchMode <> wmChange);
  cTimerMode.Enabled := (Timer[i].WatchMode <> wmChange);
  dtpTimerDateTime.Enabled := (Timer[i].WatchMode <> wmChange);
  dtpTimerTime.Enabled := (Timer[i].WatchMode <> wmChange);
  lEach.Enabled := (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
  seTimerMulti.Enabled := (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
end;

procedure TTEditChange.cbTimerEnabledClick(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  with cbTimerEnabled do
  begin
    Timer[i].bEnabled := Checked;
    lTimerMode.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lTimerDate.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lTimerTime.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lWatchMode.Enabled := Checked;
    cTimerMode.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    cWatchMode.Enabled := Checked;
    dtpTimerDateTime.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    dtpTimerTime.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lEach.Enabled := Checked and (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
    seTimerMulti.Enabled := Checked and (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
  end;
end;

procedure TTEditChange.cbOnShutdownClick(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  Timer[i].bOnShutDown := cbOnShutdown.Checked;
end;

procedure TTEditChange.dtpTimerDateTimeChange(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  Timer[i].Time := dtpTimerDateTime.DateTime;
end;

procedure TTEditChange.dtpTimerTimeChange(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  dtpTimerDateTime.Time := dtpTimerTime.Time;
  Timer[i].Time := dtpTimerDateTime.DateTime;
end;

procedure TTEditChange.seTimerNumberChange(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  case Timer[i].Kind of
    tkOneShot :
      cTimerMode.Text := cTimerMode.Items.Strings[0];
    tkEachMinute :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[1];
        seTimerMulti.MaxValue := 59;
      end;
    tkEachHour :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[2];
        seTimerMulti.MaxValue := 23;
      end;
    tkEachDay :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[3];
        seTimerMulti.MaxValue := 30;
      end;
    tkEachMonth :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[4];
        seTimerMulti.MaxValue := 12;
      end;
  end;
  seTimerMulti.CheckMaxValue := true;
  seTimerMulti.Value := Timer[i].iMulti;
  cbTimerEnabled.Checked := Timer[i].bEnabled;
  case Timer[i].WatchMode of
    wmNone :
      cWatchMode.Text := cWatchMode.Items.Strings[0];
    wmChange :
      cWatchMode.Text := cWatchMode.Items.Strings[1];
    wmChangeAndTimer :
      cWatchMode.Text := cWatchMode.Items.Strings[2];
    wmChangeOrTimer :
      cWatchMode.Text := cWatchMode.Items.Strings[3];
  end;
  cbOnShutdown.Enabled := i = 0;
  cbOnShutdown.Checked := Timer[i].bOnShutDown;
  if Timer[i].Time = 0 then
  begin
    dtpTimerDateTime.DateTime := now;
    dtpTimerTime.DateTime := now;
  end
  else
  begin
    dtpTimerDateTime.DateTime := Timer[i].Time;
    dtpTimerTime.DateTime := Timer[i].Time;
  end;
  with cbTimerEnabled do
  begin
    lTimerMode.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lTimerDate.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lTimerTime.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lWatchMode.Enabled := Checked;
    cTimerMode.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    cWatchMode.Enabled := Checked;
    dtpTimerDateTime.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    dtpTimerTime.Enabled := Checked and (Timer[i].WatchMode <> wmChange);
    lEach.Enabled := Checked and (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
    seTimerMulti.Enabled := Checked and (Timer[i].Kind <> tkOneShot) and (Timer[i].WatchMode <> wmChange);
  end;
end;

procedure TTEditChange.seTimerMultiChange(Sender : TObject);
var
  i : Integer;
begin
  i := trunc(seTimerNumber.Value) - 1;
  Timer[i].iMulti := trunc(seTimerMulti.Value);
end;
/// /////////////////////////////////////////////////////////////////////////////

/// /////////////////////////////////tsSkip//////////////////////////////////////

procedure TTEditChange.tsSkipShow(Sender : TObject);
begin
  pcAddChange.Height := gbSkipFolders.Height + gbSkipFiles.Height + 34;
  TEditChange.Height := gbSkipFolders.Height + gbSkipFiles.Height + 108;
end;

procedure TTEditChange.lvSkipFilesCustomDrawItem(Sender : TCustomListView; Item : TListItem; State : TCustomDrawState;
  var DefaultDraw : Boolean);
begin
  with Sender.Canvas.Brush do
  begin
    if Item.Index mod 2 = 0 then
    begin
      Color := $FFFFFF;
    end
    else
    begin
      Color := $00FFF5EC;
    end;
  end;
end;

procedure TTEditChange.lvSkipFoldersCustomDrawItem(Sender : TCustomListView; Item : TListItem; State : TCustomDrawState;
  var DefaultDraw : Boolean);
begin
  with Sender.Canvas.Brush do
  begin
    if Item.Index mod 2 = 0 then
    begin
      Color := $FFFFFF;
    end
    else
    begin
      Color := $00FFF5EC;
    end;
  end;
end;

procedure TTEditChange.lvSkipFoldersKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if Key = VK_Delete then
  begin
    lvSkipFolders.DeleteSelected;
  end;
end;

procedure TTEditChange.lvSkipFilesKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if Key = VK_Delete then
  begin
    lvSkipFiles.DeleteSelected;
  end;
end;

procedure TTEditChange.eSkipFoldersKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if Key = VK_Return then
  begin
    btAddChangeFolderClick(Sender);
  end;
end;

procedure TTEditChange.eSkipFilesKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if Key = VK_Return then
  begin
    btAddChangeFileClick(Sender);
  end;
end;

procedure TTEditChange.btAddChangeFolderClick(Sender : TObject);
var
  s : string;
begin
  s := eSkipFolders.Text;
  if (s = '') and not BrowseForFolder(eSkipFolders.DialogText, true, s, 0) then
  begin
    s := '';
  end;
  if s <> '' then
  begin
    if s[1] = '"' then
    begin
      s := copy(s, 2, length(s) - 2);
    end;
    s := IncludeTrailingPathDelimiter(s);
    if lvSkipFolders.Selected <> nil then
    begin
      lvSkipFolders.Selected.Caption := s;
    end
    else
    begin
      lvSkipFolders.Items.Add.Caption := s;
    end;
  end;
end;

procedure TTEditChange.btDelFolderClick(Sender : TObject);
begin
  lvSkipFolders.DeleteSelected;
end;

procedure TTEditChange.lvSkipFoldersSelectItem(Sender : TObject; Item : TListItem; Selected : Boolean);
begin
  if Selected then
  begin
    eSkipFolders.Text := lvSkipFolders.Selected.Caption;
    btAddChangeFolder.ImageIndex := 2;
    btDelFolder.Enabled := true;
  end
  else
  begin
    btAddChangeFolder.ImageIndex := 0;
    btDelFolder.Enabled := false;
  end;
end;

procedure TTEditChange.btAddChangeFileClick(Sender : TObject);
var
  s : string;
begin
  s := eSkipFiles.Text;
  if (s = '') and eSkipFiles.Dialog.Execute then
  begin
    s := eSkipFiles.Dialog.FileName;
  end;
  if s <> '' then
  begin
    if s[1] = '"' then
    begin
      s := copy(s, 2, length(s) - 2);
    end;
    if lvSkipFiles.Selected <> nil then
    begin
      lvSkipFiles.Selected.Caption := s;
    end
    else
    begin
      lvSkipFiles.Items.Add.Caption := s;
    end;
  end;
end;

procedure TTEditChange.btDelFileClick(Sender : TObject);
begin
  lvSkipFiles.DeleteSelected;
end;

procedure TTEditChange.lvSkipFilesSelectItem(Sender : TObject; Item : TListItem; Selected : Boolean);
begin
  if Selected then
  begin
    eSkipFiles.Text := lvSkipFiles.Selected.Caption;
    btAddChangeFile.ImageIndex := 2;
    btDelFile.Enabled := true;
  end
  else
  begin
    btAddChangeFile.ImageIndex := 0;
    btDelFile.Enabled := false;
  end;
end;
/// /////////////////////////////////////////////////////////////////////////////

/// ////////////////////////////////tsDrive//////////////////////////////////////

/// /////////////////////////////////////////////////////////////////////////////

/// //////////////////////////////TTEditCange////////////////////////////////////

procedure TTEditChange.FormCreate(Sender : TObject);
begin
  vstApplications.NodeDataSize := SizeOf(TApplicationData);
  DragAcceptFiles(eSourcePath.Handle, true);
  DragAcceptFiles(eDestinationPath.Handle, true);
  DragAcceptFiles(eFileMask.Handle, true);
  DragAcceptFiles(eFileMask.Handle, true);
  DragAcceptFiles(eSkipFolders.Handle, true);
  DragAcceptFiles(eSkipFiles.Handle, true);
  DragAcceptFiles(vstApplications.Handle, true);
end;

procedure TTEditChange.FillApplication(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer;
  var Abort : Boolean);
var
  NodeData : PApplicationData;
begin
  NodeData := Sender.GetNodeData(Node);
  Application[Node.Index] := NodeData^;
end;

procedure TTEditChange.FormClose(Sender : TObject; var Action : TCloseAction);
var
  i : Integer;
begin
  vstApplications.EndEditNode;
  for i := 0 to High(AApplicationData) do
  begin
    Application[i].sFileName := '';
    Application[i].sParam := '';
    Application[i].iTimeout := iTimeout;
    Application[i].Action := aaNone;
  end;
  vstApplications.IterateSubtree(nil, FillApplication, nil)
end;

procedure TTEditChange.aeBackupperMessage(var Msg : tagMSG; var Handled : Boolean);
var
  i, iAnzahl, iSize : Integer;
  sExt : string;
  Dateiname : PChar;
  Data : PApplicationData;
  Node, NodeI : PVirtualNode;
  slExtensions : TStringList;
begin
  Dateiname := '';
  if Msg.message = WM_DROPFILES then
  begin
    if Msg.hwnd = eFileMask.Handle then
    begin
      iAnzahl := DragQueryFile(Msg.WParam, $FFFFFFFF, Dateiname, 255);
      if (iAnzahl <> 0) and (eFileMask.Text = '*.*') then
      begin
        eFileMask.Text := '';
      end;
      slExtensions := TStringList.Create;
      slExtensions.Sorted := true;
      slExtensions.Duplicates := dupIgnore;
      slExtensions.Delimiter := ';';
      slExtensions.DelimitedText := eFileMask.Text;
      for i := 0 to (iAnzahl - 1) do
      begin
        iSize := DragQueryFile(Msg.WParam, i, nil, 0) + 1;
        Dateiname := StrAlloc(iSize);
        DragQueryFile(Msg.WParam, i, Dateiname, iSize);
        sExt := ExtractFileExt(StrPas(Dateiname));
        if sExt <> '' then
        begin
          slExtensions.Add('*' + sExt);
        end;
        StrDispose(Dateiname);
      end;
      if slExtensions.Count = 0 then
      begin
        eFileMask.Text := '*.*';
      end
      else
      begin
        eFileMask.Text := slExtensions.DelimitedText;
      end;
      DragFinish(Msg.WParam);
      FreeandNil(slExtensions);
    end;
    if Msg.hwnd = vstApplications.Handle then
    begin
      iAnzahl := DragQueryFile(Msg.WParam, $FFFFFFFF, Dateiname, 255);
      for i := 0 to (iAnzahl - 1) do
      begin
        iSize := DragQueryFile(Msg.WParam, i, nil, 0) + 1;
        Dateiname := StrAlloc(iSize);
        DragQueryFile(Msg.WParam, i, Dateiname, iSize);
        sExt := ExtractFileExt(StrPas(Dateiname));
        if CaseStringIOf(sExt, ['.exe', '.cmd', '.bat']) = 0 then
        begin
          Node := vstApplications.GetLast();
          if Assigned(Node) then
          begin
            Data := vstApplications.GetNodeData(Node);
            if Data^.sFileName = '' then
            begin
              Data^.sFileName := Dateiname;
              Data^.sParam := '';
              Data^.iTimeout := iTimeout;
              Data^.Action := aaNone;
            end;
            if Node.Index <= High(AApplicationData) - 1 then
            begin
              Node := vstApplications.AddChild(nil);
              vstApplications.ValidateNode(Node, false);
              Data := vstApplications.GetNodeData(Node);
              Data^.sFileName := '';
              Data^.sParam := '';
              Data^.iTimeout := iTimeout;
              Data^.Action := aaNone;
            end;
          end;
        end;
        StrDispose(Dateiname);
      end;
      DragFinish(Msg.WParam);
      NodeI := vstApplications.GetFirst;
      Node := vstApplications.GetLast();
      while (NodeI <> nil) and (NodeI <> Node) do
      begin
        Data := vstApplications.GetNodeData(NodeI);
        if Data^.sFileName = '' then
        begin
          vstApplications.DeleteNode(NodeI);
        end;
        NodeI := vstApplications.GetNext(NodeI);
      end;
    end;
  end;
end;

procedure TTEditChange.FormShow(Sender : TObject);
var
  i : Integer;
  Node : PVirtualNode;
  Data : PApplicationData;
begin
  pcAddChange.ActivePage := tsBasicOptions;
  /// //////////////////////////tsAdvancedOptions////////////////////////////////
  cCompareMode.Items.Clear;
  cCompareMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeHash'));
  cCompareMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeFile'));
  cCompareMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeArchive'));
  case CompareMode of
    cmHash :
      begin
        cCompareMode.Text := cCompareMode.Items.Strings[0];
        seTimeDiff.Enabled := false;
        lTimeDiff.Enabled := false;
        lSeconds.Enabled := false;
      end;
    cmSizeTime :
      begin
        cCompareMode.Text := cCompareMode.Items.Strings[1];
        seTimeDiff.Enabled := true;
        lTimeDiff.Enabled := true;
        lSeconds.Enabled := true;
      end;
    cmArchive :
      begin
        cCompareMode.Text := cCompareMode.Items.Strings[2];
        seTimeDiff.Enabled := false;
        lTimeDiff.Enabled := false;
        lSeconds.Enabled := false;
      end;
  else
    cCompareMode.Text := cCompareMode.Items.Strings[0];
    seTimeDiff.Enabled := false;
    lTimeDiff.Enabled := false;
    lSeconds.Enabled := false;
  end;
  vstApplications.Clear;
  for i := 0 to High(AApplicationData) do
  begin
    if Application[i].sFileName <> '' then
    begin
      Node := vstApplications.AddChild(nil);
      vstApplications.ValidateNode(Node, false);
      Data := vstApplications.GetNodeData(Node);
      Data^.sFileName := Application[i].sFileName;
      Data^.sParam := Application[i].sParam;
      Data^.iTimeout := Application[i].iTimeout;
      Data^.Action := Application[i].Action;
    end;
  end;
  Node := vstApplications.AddChild(nil);
  vstApplications.ValidateNode(Node, false);
  Data := vstApplications.GetNodeData(Node);
  Data^.sFileName := '';
  Data^.sParam := '';
  Data^.iTimeout := iTimeout;
  Data^.Action := aaNone;
  /// ///////////////////////////////////////////////////////////////////////////

  /// ///////////////////////////tsTimerOptions//////////////////////////////////
  cTimerMode.Items.Clear;
  cTimerMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeOneShot'));
  cTimerMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeEachMinute'));
  cTimerMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeEachHour'));
  cTimerMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeEachDay'));
  cTimerMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeEachMonth'));
  case Timer[0].Kind of
    tkOneShot :
      cTimerMode.Text := cTimerMode.Items.Strings[0];
    tkEachMinute :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[1];
        seTimerMulti.MaxValue := 59;
      end;
    tkEachHour :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[2];
        seTimerMulti.MaxValue := 23;
      end;
    tkEachDay :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[3];
        seTimerMulti.MaxValue := 30;
      end;
    tkEachMonth :
      begin
        cTimerMode.Text := cTimerMode.Items.Strings[4];
        seTimerMulti.MaxValue := 12;
      end;
  end;
  cWatchMode.Items.Clear;
  cWatchMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeNone'));
  cWatchMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeChange'));
  cWatchMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeChangeAndTimer'));
  cWatchMode.Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'ModeChangeOrTimer'));
  cWatchMode.Text := cWatchMode.Items.Strings[Integer(Timer[0].WatchMode)];
  seTimerMulti.Value := Timer[0].iMulti;
  seTimerMulti.CheckMaxValue := true;
  cbTimerEnabled.Checked := Timer[0].bEnabled;
  cbOnShutdown.Checked := Timer[0].bOnShutDown;
  if Timer[0].Time = 0 then
  begin
    dtpTimerDateTime.DateTime := now;
    dtpTimerTime.DateTime := now;
  end
  else
  begin
    dtpTimerDateTime.DateTime := Timer[0].Time;
    dtpTimerTime.DateTime := Timer[0].Time;
  end;
  with cbTimerEnabled do
  begin
    lTimerMode.Enabled := Checked and (Timer[0].WatchMode <> wmChange);
    lTimerDate.Enabled := Checked and (Timer[0].WatchMode <> wmChange);
    lTimerTime.Enabled := Checked and (Timer[0].WatchMode <> wmChange);
    lWatchMode.Enabled := Checked;
    cTimerMode.Enabled := Checked and (Timer[0].WatchMode <> wmChange);
    cWatchMode.Enabled := Checked;
    dtpTimerDateTime.Enabled := Checked and (Timer[0].WatchMode <> wmChange);
    dtpTimerTime.Enabled := Checked and (Timer[0].WatchMode <> wmChange);
    lEach.Enabled := Checked and (Timer[0].Kind <> tkOneShot) and (Timer[0].WatchMode <> wmChange);
    seTimerMulti.Enabled := Checked and (Timer[0].Kind <> tkOneShot) and (Timer[0].WatchMode <> wmChange);
  end;
  seTimerNumber.Value := 1;
  /// ///////////////////////////////////////////////////////////////////////////

  /// ////////////////////////////////tsSkip/////////////////////////////////////
  btAddChangeFolder.ImageIndex := 0;
  btDelFolder.Enabled := false;
  btAddChangeFile.ImageIndex := 0;
  btDelFile.Enabled := false;
  eSkipFolders.Text := '';
  eSkipFiles.Text := '';
  eSkipFolders.InitialDir := eSourcePath.Text;
  eSkipFiles.InitialDir := eSourcePath.Text;
  lvSkipFolders.Clear;
  if SkipFolders <> nil then
  begin
    for i := 0 to SkipFolders.Count - 1 do
    begin
      lvSkipFolders.Items.Add.Caption := SkipFolders.Strings[i];
    end;
  end;
  lvSkipFiles.Clear;
  if SkipFiles <> nil then
  begin
    for i := 0 to SkipFiles.Count - 1 do
    begin
      lvSkipFiles.Items.Add.Caption := SkipFiles.Strings[i];
    end;
  end;
  /// ///////////////////////////////////////////////////////////////////////////

end;
/// /////////////////////////////////tsDrive/////////////////////////////////////

procedure TTEditChange.tsDriveShow(Sender : TObject);
begin
  pcAddChange.Height := gbDrive.Height + 34;
  TEditChange.Height := gbDrive.Height + 108;
end;

procedure TTEditChange.cbSourceDriveLabelClick(Sender : TObject);
begin
  if cbSourceDriveLabel.Checked then
  begin
    if eSourceDriveLabel.Text = '' then
    begin
      eSourceDriveLabel.Text := GetVolumeLabel(ExtractFileDrive(eSourcePath.Text));
    end;
  end
  else
  begin
    eSourceDriveLabel.Text := '';
  end;
  cbSourceDriveLabel.Checked := eSourceDriveLabel.Text <> '';
end;

procedure TTEditChange.cbDestDriveLabelClick(Sender : TObject);
begin
  if cbDestDriveLabel.Checked then
  begin
    if eDestDriveLabel.Text = '' then
    begin
      eDestDriveLabel.Text := GetVolumeLabel(ExtractFileDrive(eDestinationPath.Text));
    end;
  end
  else
  begin
    eDestDriveLabel.Text := '';
  end;
  cbDestDriveLabel.Checked := eDestDriveLabel.Text <> '';
end;

procedure TTEditChange.eDestDriveLabelChange(Sender : TObject);
begin
  cbDestDriveLabel.Checked := eDestDriveLabel.Text <> '';
end;

procedure TTEditChange.eSourceDriveLabelChange(Sender : TObject);
begin
  cbSourceDriveLabel.Checked := eSourceDriveLabel.Text <> '';
end;

/// /////////////////////////////////////////////////////////////////////////////

/// /////////////////////////////////////////////////////////////////////////////

end.
