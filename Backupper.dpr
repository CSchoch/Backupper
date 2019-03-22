program Backupper;
 {$DEFINE Profile}

uses
  FastMM4,
  Forms,
  MainFrame in 'MainFrame.pas' {MainForm},
  EditChange in 'EditChange.pas' {TEditChange},
  tSearchFiles in 'tSearchFiles.pas',
  tSortFiles in 'tSortFiles.pas',
  tFileOperation in 'tFileOperation.pas',
  About in 'About.pas' {AboutBox},
  SettingsDialog in 'SettingsDialog.pas' {SettingsForm},
  ShowErrors in 'ShowErrors.pas' {ShowErrors},
  VTreeHelper in 'VTreeHelper.pas',
  ShutdownRestart in 'ShutdownRestart.pas' {ShutdownRestartDialog},
  tUpdate in 'tUpdate.pas',
  ProgressDialog in 'ProgressDialog.pas' {ProgressForm},
  tDirWatch in 'tDirWatch.pas',
  VPropertyTreeEditors in 'VPropertyTreeEditors.pas',
  FileCopier in 'FileCopier.pas',
  SRDialog in 'SRDialog.pas' {SRForm};

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'Backupper';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TTEditChange, TEditChange);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TTShowErrors, TShowErrors);
  Application.CreateForm(TShutdownRestartDialog, ShutdownRestartDialog);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.CreateForm(TSRForm, SRForm);
  Application.Run;
end.

