unit SettingsDialog;

interface
{$INCLUDE Compilerswitches.inc}

uses
  Windows,
  SysUtils,
  Messages,
  ShellApi,
  ShlObj,
  Controls,
  Forms,
  Spin,
  StdCtrls,
  Mask,
  JvExMask,
  JvToolEdit,
  Classes,
  JvSpin,
  csLogCls,
  csUtils;

type
  TSettingsForm = class(TForm)
    cbShutdown : TCheckBox;
    cbDescription : TCheckBox;
    cbForce : TCheckBox;
    cbEndBackupbevoreShutdown : TCheckBox;
    cbConfirmShutdown : TCheckBox;
    cbConfirmDelete : TCheckBox;
    cThreadPriority : TComboBox;
    btOk : TButton;
    btCancel : TButton;
    gbLogging : TGroupBox;
    cbLogEnabled : TCheckBox;
    lLogPath : TLabel;
    gbProgramm : TGroupBox;
    cbClose : TCheckBox;
    lPriority : TLabel;
    lCloseTimeout : TLabel;
    lSeconds : TLabel;
    gbAfterBackup : TGroupBox;
    btSetValues : TButton;
    eLogPath : TJvDirectoryEdit;
    cbAutostart : TCheckBox;
    cbStartInTray : TCheckBox;
    cbMinimizetoTray : TCheckBox;
    seWaitTimeout : TJvSpinEdit;
    cLogLevel : TComboBox;
    lLogLevel : TLabel;
    cbExtProgress : TCheckBox;
    procedure cbMinimizetoTrayClick(Sender : TObject);
    procedure cbStartInTrayClick(Sender : TObject);
    procedure cbCloseClick(Sender : TObject);
    procedure cbForceClick(Sender : TObject);
    procedure cbAutostartClick(Sender : TObject);
    procedure cbConfirmDeleteClick(Sender : TObject);
    procedure cbConfirmShutdownClick(Sender : TObject);
    procedure cbEndBackupbevoreShutdownClick(Sender : TObject);
    procedure seWaitTimeoutChange(Sender : TObject);
    procedure cbDescriptionClick(Sender : TObject);
    procedure eLogPathAfterDialog(Sender : TObject; var AName : string;
      var AAction : Boolean);
    procedure btSetValuesClick(Sender : TObject);
    procedure cbLogEnabledClick(Sender : TObject);
    procedure cbShutdownClick(Sender : TObject);
    procedure eLogPathChange(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure cLogLevelChange(Sender : TObject);
    procedure cThreadPriorityChange(Sender : TObject);
    procedure cbExtProgressClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
  private
    { Private-Deklarationen }
  public
    iThreadPriority : TThreadPriority;
    piThreadPriority : ^TThreadPriority;
    LogLevel : TLogLevel;
    pLogLevel : PLogLevel;
    piWaitTimeout : Pinteger;
    psLogPath : Pstring;
    pbShutdown, pbLog, pbUseDescription, pbEndBackupbevoreShutdown, pbConfirmShutdown : pboolean;
    pbConfirmDelete, pbClose, pbForce, pbStartInTray, pbMinimizetoTray, pbExtProgress : pboolean;
  end;

var
  SettingsForm : TSettingsForm;

implementation

{$R *.dfm}
uses
  MainFrame;

procedure TSettingsForm.FormCreate(Sender : TObject);
begin
  DragAcceptFiles(eLogPath.Handle, true);
end;

procedure TSettingsForm.FormShow(Sender : TObject);
begin
  cThreadPriority.Items.Clear;
  cThreadPriority.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'tpTimeCritical'),
    TObject(0));
  cThreadPriority.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'tpHighest'),
    TObject(1));
  cThreadPriority.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'tpHigher'),
    TObject(2));
  cThreadPriority.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'tpNormal'),
    TObject(3));
  cThreadPriority.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'tpLower'),
    TObject(4));
  cThreadPriority.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'tpLowest'),
    TObject(5));
  cThreadPriority.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'tpIdle'),
    TObject(6));
  case integer(iThreadPriority) of
    0 : cThreadPriority.Text := cThreadPriority.Items.Strings[6];
    1 : cThreadPriority.Text := cThreadPriority.Items.Strings[5];
    2 : cThreadPriority.Text := cThreadPriority.Items.Strings[4];
    3 : cThreadPriority.Text := cThreadPriority.Items.Strings[3];
    4 : cThreadPriority.Text := cThreadPriority.Items.Strings[2];
    5 : cThreadPriority.Text := cThreadPriority.Items.Strings[1];
    6 : cThreadPriority.Text := cThreadPriority.Items.Strings[0];
  end;
  cLogLevel.Items.Clear;
  cLogLevel.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'llError'), TObject(0));
  cLogLevel.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'llWarning'), TObject(1));
  cLogLevel.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'llInformation'),
    TObject(2));
  cLogLevel.Items.AddObject(MainForm.JvTranslate.Translate('GUIStrings', 'llDebug'), TObject(3));
  case LogLevel of
    llError : cLogLevel.Text := cLogLevel.Items.Strings[0];
    llWarning : cLogLevel.Text := cLogLevel.Items.Strings[1];
    llInformation : cLogLevel.Text := cLogLevel.Items.Strings[2];
    llDebug : cLogLevel.Text := cLogLevel.Items.Strings[3];
  end;
  cbForce.Enabled := cbShutdown.Checked;
  cbDescription.Enabled := cbLogEnabled.Checked;
  eLogPath.Enabled := cbLogEnabled.Checked;
  cbAutostart.Checked := fileexists(GetShellFolder(CSIDL_STARTUP) + 'Backupper.lnk');
  btSetValues.Enabled := false;
  cbStartInTray.Enabled := cbAutostart.Checked;
end;

procedure TSettingsForm.eLogPathChange(Sender : TObject);
begin
  btSetValues.Enabled := true;
  if (eLogPath.Text = '') and eLogPath.Enabled then
  begin
    eLogPath.Text := GetShellFolder(CSIDL_PERSONAL) + 'Backupper\';
  end;
end;

procedure TSettingsForm.cbShutdownClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
  cbForce.Enabled := cbShutdown.Checked;
end;

procedure TSettingsForm.cbLogEnabledClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
  cbDescription.Enabled := cbLogEnabled.Checked;
  eLogPath.Enabled := cbLogEnabled.Checked;
end;

procedure TSettingsForm.btSetValuesClick(Sender : TObject);
var
  sDir, sLog : string;
begin
  piThreadPriority^ := iThreadPriority;
  pLogLevel^ := LogLevel;
  piWaitTimeout^ := trunc(seWaitTimeout.Value * 1000);
  psLogPath^ := eLogPath.Text;
  pbShutdown^ := cbShutdown.Checked;
  pbForce^ := cbForce.Checked;
  pbLog^ := cbLogEnabled.Checked;
  pbUseDescription^ := cbDescription.Checked;
  pbEndBackupbevoreShutdown^ := cbEndBackupbevoreShutdown.Checked;
  pbConfirmShutdown^ := cbConfirmShutdown.Checked;
  pbConfirmDelete^ := cbConfirmDelete.Checked;
  pbClose^ := cbClose.Checked;
  pbStartInTray^ := cbStartInTray.Checked;
  pbMinimizetoTray^ := cbMinimizeToTray.Checked;
  pbExtProgress^ := cbExtProgress.Checked;
  sDir := GetShellFolder(CSIDL_STARTUP);
  if cbAutostart.Checked then
  begin
    CreateDirectoryRecurse('', sDir, nil);
    CreateLink(Application.ExeName, ' -Autostart', sDir + 'Backupper.lnk', '');
  end
  else
  begin
    DeleteFile(sDir + 'Backupper.lnk');
  end;
  sLog := MainForm.LogFile.Write('LogStrings', 'SettingsChanged');
  SetStatusbarText(MainForm.sbMainForm, sLog);
  btSetValues.Enabled := false;
end;

procedure TSettingsForm.eLogPathAfterDialog(Sender : TObject; var AName : string;
  var AAction : Boolean);
begin
  AName := IncludeTrailingPathdelimiter(AName);
end;

procedure TSettingsForm.cbDescriptionClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.seWaitTimeoutChange(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cbEndBackupbevoreShutdownClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cbExtProgressClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cbConfirmShutdownClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cbConfirmDeleteClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cbAutostartClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
  cbStartInTray.Enabled := cbAutostart.Checked;
end;

procedure TSettingsForm.cbForceClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cbCloseClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cbStartInTrayClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

procedure TSettingsForm.cLogLevelChange(Sender : TObject);
begin
  btSetValues.Enabled := true;
  case cLogLevel.Items.IndexOf(cLogLevel.Text) of
    0 : LogLevel := llError;
    1 : LogLevel := llWarning;
    2 : LogLevel := llInformation;
    3 : LogLevel := llDebug;
  end;
end;

procedure TSettingsForm.cThreadPriorityChange(Sender : TObject);
begin
  btSetValues.Enabled := true;
  case cThreadPriority.Items.IndexOf(cThreadPriority.Text) of
    0 : iThreadPriority := tpTimeCritical;
    1 : iThreadPriority := tpHighest;
    2 : iThreadPriority := tpHigher;
    3 : iThreadPriority := tpNormal;
    4 : iThreadPriority := tpLower;
    5 : iThreadPriority := tpLowest;
    6 : iThreadPriority := tpIdle;
  end;
end;

procedure TSettingsForm.cbMinimizetoTrayClick(Sender : TObject);
begin
  btSetValues.Enabled := true;
end;

end.

