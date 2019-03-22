unit ProgressDialog;

interface
{$INCLUDE Compilerswitches.inc}

uses
  Windows,
  SysUtils,
  SyncObjs,
  Classes,
  Forms,
  Controls,
  StdCtrls,
  ExtCtrls,
  JvTranslator,
  csProgressBarEx,
  EstimatedTime,
  csUtils,
  ComCtrls;

type
  TLangStrings = record
    sInit : string;
    sApplication : string;
    sFinished : string;
    slFilesCount1 : string;
    slFilesCount2 : string;
    slTimeDone1 : string;
    slTimeDone2 : string;
    slTimeLeft1 : string;
    slTimeLeft2 : string;
    slActionFileName1 : string;
    slActionFileName2 : string;
    slActionFileName3 : string;
    slActionFileName4 : string;
    slActionFileName5 : string;
    slActionFileName6 : string;
    slActionFileName7 : string;
    slActionFileName8 : string;
    slActionFileName9 : string;
    slActionFileName10 : string;
    slActionFileName11 : string;
    slActionFileName12 : string;
    slSizeDoneTotal1 : string;
    slSizeDoneTotal2 : string;
    slFrom1 : string;
    slFrom3 : string;
    slTo1 : string;
    slTo3 : string;
  end;
  PTStringList = ^TStringList;
  TBackupperState = (bsInit, bsStartApp, bsCloseApp, bsSearch, bsHash, bsSortNew, bsSortDelFile,
    bsSortDelDir, bsSortMoved,
    bsOpCopy, bsOpMove, bsOpDelFile, bsOpDelDir, bsFinished);
  TProgressForm = class(TForm)
    lJobName : TLabel;
    lActionFileName : TLabel;
    lFilesCount : TLabel;
    lTimeDone : TLabel;
    lTimeLeft : TLabel;
    lSizeDoneTotal : TLabel;
    lFrom : TLabel;
    lFromPath : TLabel;
    lTo : TLabel;
    lToPath : TLabel;
    lSizeDoneFile : TLabel;
    btSuspend : TButton;
    mErrors : TMemo;
    tUpdatErrors : TTimer;
    btCancel : TButton;
    lSizeDoneFile2 : TLabel;
    tUpdate : TTimer;
    btBackup : TButton;
    pbSizeDoneTotal : TProgressBarEx;
    pbSizeDoneFile : TProgressBarEx;
    pbSizeDoneFile2 : TProgressBarEx;
    pbFilesCount : TProgressBarEx;
    procedure FormShow(Sender : TObject);
    procedure tUpdatErrorsTimer(Sender : TObject);
    procedure btCancelClick(Sender : TObject);
    procedure btSuspendClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure tUpdateTimer(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
  private
    FCS : TCriticalSection;
    FTotalFilesCount : int64;
    FTotalFilesCount2 : int64;
    FDoneFilesCount : int64;
    FDoneFilesCount2 : int64;
    FTotalFilesSize : int64;
    FTotalFilesSize2 : int64;
    FDoneFilesSize : int64;
    FDoneFilesSize2 : int64;
    FFileSize : int64;
    FFileSizeDone : int64;
    FFileSize2 : int64;
    FFileSizeDone2 : int64;
    FHashCounter : integer;
    FJobName : string;
    FApplicationName : string;
    FSourceDir : string;
    FDestDir : string;
    FActSourceDir : string;
    FActDestDir : string;
    bNewFile : boolean;
    bNewFile2 : boolean;
    FError : PTStringList;
    FErrorBuffer : TStringList;
    FState : TBackupperState;
    FFormatSettings : TFormatSettings;
    FTranslate : TJvTranslator;
    FEstTime : TEstimatedTime;
    FLangStrings : TLangStrings;
    bToggleShow : boolean;
    bDoNotClose : boolean;
    function UserFriendlySize(Value1, Value2 : int64; sText : string) : string;
    function CalcProgress(DoneValue, TotalValue : int64) : extended;
    function CalcRelation(Value1, Value2 : int64) : extended;
    procedure CalcHeight();
    procedure SetTotalFilesCount(Value : int64);
    procedure SetTotalFilesCount2(Value : int64);
    procedure SetDoneFilesCount(Value : int64);
    procedure SetDoneFilesCount2(Value : int64);
    procedure SetTotalFilesSize(Value : int64);
    procedure SetTotalFilesSize2(Value : int64);
    procedure SetDoneFilesSize(Value : int64);
    procedure SetDoneFilesSize2(Value : int64);
    procedure SetFileSize(Value : int64);
    procedure SetFileSizeDone(Value : int64);
    procedure SetFileSize2(Value : int64);
    procedure SetFileSizeDone2(Value : int64);
    procedure SetSourceDir(Value : string);
    procedure SetDestDir(Value : string);
    procedure SetActSourceDir(Value : string);
    procedure SetActDestDir(Value : string);
    procedure SetJobName(Value : string);
    procedure SetApplicationName(const Value : string);
    procedure SetState(Value : TBackupperState);
    procedure ChangelJobName;
    procedure ChangelActionFileName;
    procedure ChangelFilesCount;
    procedure ChangelTimeDone;
    procedure ChangelTimeLeft;
    procedure ChangepbFilesCount;
    procedure ChangelSizeDoneTotal;
    procedure ChangepbSizeDoneTotal;
    procedure ChangelFrom;
    procedure ChangelFromPath;
    procedure ChangelTo;
    procedure ChangelToPath;
    procedure ChangelSizeDoneFile;
    procedure ChangepbSizeDoneFile;
    procedure ChangelSizeDoneFile2;
    procedure ChangepbSizeDoneFile2;
    procedure ChangeEstTime;
  public
    procedure ClearErrors;
    procedure Suspend;
    procedure Resume;
    function Progress : extended;
    property TotalFilesCount : int64 read FTotalFilesCount write SetTotalFilesCount default 0;
    property TotalFilesCount2 : int64 read FTotalFilesCount2 write SetTotalFilesCount2 default 0;
    property DoneFilesCount : int64 read FDoneFilesCount write SetDoneFilesCount default 0;
    property DoneFilesCount2 : int64 read FDoneFilesCount2 write SetDoneFilesCount2 default 0;
    property TotalFilesSize : int64 read FTotalFilesSize write SetTotalFilesSize default 0;
    property TotalFilesSize2 : int64 read FTotalFilesSize2 write SetTotalFilesSize2 default 0;
    property DoneFilesSize : int64 read FDoneFilesSize write SetDoneFilesSize default 0;
    property DoneFilesSize2 : int64 read FDoneFilesSize2 write SetDoneFilesSize2 default 0;
    property FileSize : int64 read FFileSize write SetFileSize default 0;
    property FileSizeDone : int64 read FFileSizeDone write SetFileSizeDone default 0;
    property FileSize2 : int64 read FFileSize2 write SetFileSize2 default 0;
    property FileSizeDone2 : int64 read FFileSizeDone2 write SetFileSizeDone2 default 0;
    property HashCounter : integer read FHashCounter write FHashCounter default 0;
    property SourceDir : string write SetSourceDir;
    property DestDir : string write SetDestDir;
    property ActSourceDir : string write SetActSourceDir;
    property ActDestDir : string write SetActDestDir;
    property JobName : string write SetJobName;
    property ApplicationName : string write SetApplicationName;
    property Error : PTStringList read FError write FError;
    property State : TBackupperState write SetState;
    property ToggleShow : boolean write bToggleShow;
    property DoNotClose : boolean read bDoNotClose write bDoNotClose default false;
  end;

var
  ProgressForm : TProgressForm;
  bTimer : boolean = true;
implementation
uses
  MainFrame;
{$R *.dfm}

procedure TProgressForm.ChangelJobName;
var
  s : string;
begin
  //  case FState of
  //    bsInit : s := FLangStrings.sInit;
  //  else
  //    s := FJobName;
  //  end;
  s := FJobName;
  lJobName.Caption := s;
end;

procedure TProgressForm.ChangelActionFileName;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp :
      begin
        s := FLangStrings.slActionFileName11;
        s := Format(s, [FApplicationName], FFormatSettings);
      end;
    bsCloseApp :
      begin
        s := FLangStrings.slActionFileName12;
        s := Format(s, [FApplicationName], FFormatSettings);
      end;
    bsSearch :
      begin
        s := FLangStrings.slActionFileName1;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsHash :
      begin
        s := FLangStrings.slActionFileName2;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slActionFileName3;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slActionFileName4;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsSortDelDir : s := FLangStrings.slActionFileName5;
    bsSortMoved :
      begin
        s := FLangStrings.slActionFileName6;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slActionFileName7;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slActionFileName8;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slActionFileName9;
        s := Format(s, [ExtractFileName(FActSourceDir), ExtractFileName(FActDestDir)],
          FFormatSettings);
      end;
    bsOpDelDir : s := FLangStrings.slActionFileName10;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lActionFileName.Caption := s;
end;

procedure TProgressForm.ChangelFilesCount;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch : s := FLangStrings.slFilesCount1;
    bsHash :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [(FDoneFilesCount + FDoneFilesCount2), (FTotalFilesCount +
            FTotalFilesCount2)], FFormatSettings);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount, FTotalFilesCount], FFormatSettings);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount, FTotalFilesCount], FFormatSettings);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount, FTotalFilesCount], FFormatSettings);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount, FTotalFilesCount], FFormatSettings);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount2, FTotalFilesCount2], FFormatSettings);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount2, FTotalFilesCount2], FFormatSettings);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount2, FTotalFilesCount2], FFormatSettings);
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slFilesCount2;
        s := Format(s, [FDoneFilesCount, FTotalFilesCount], FFormatSettings);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lFilesCount.Caption := s;
end;

procedure TProgressForm.ChangelTimeDone;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch :
      begin
        s := FLangStrings.slTimeDone1;
        s := Format(s, [FTotalFilesCount], FFormatSettings);
      end;
    bsHash :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slTimeDone2;
        s := Format(s, [UserfriendlyTime(FEstTime.ElapsedTime)], FFormatSettings);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lTimeDone.Caption := s;
end;

procedure TProgressForm.ChangelTimeLeft;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch :
      begin
        s := FLangStrings.slTimeLeft1;
        s := Format(s, [FTotalFilesCount2], FFormatSettings);
      end;
    bsHash :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slTimeLeft2;
        s := Format(s, [UserfriendlyTime(FEstTime.LeftTime)], FFormatSettings);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lTimeLeft.Caption := s;
end;

procedure TProgressForm.ChangepbFilesCount;
var
  e : extended;
begin
  e := 0;
  case FState of
    bsInit : e := 0;
    bsStartApp : e := 0;
    bsCloseApp : e := 0;
    bsSearch : e := CalcRelation(FTotalFilesCount, FTotalFilesCount2);
    bsHash : e := CalcProgress(FDoneFilesCount + FDoneFilesCount2, FTotalFilesCount +
        FTotalFilesCount2);
    bsSortNew : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsSortDelFile : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsSortDelDir : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsSortMoved : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsOpCopy : e := CalcProgress(FDoneFilesCount2, FTotalFilesCount2);
    bsOpMove : e := CalcProgress(FDoneFilesCount2, FTotalFilesCount2);
    bsOpDelFile : e := CalcProgress(FDoneFilesCount2, FTotalFilesCount2);
    bsOpDelDir : e := CalcProgress(FDoneFilesCount2, FTotalFilesCount2);
    bsFinished : e := 0;
  end;
  pbFilesCount.Position := e;
end;

procedure TProgressForm.ChangelSizeDoneTotal;
var
  s : string;
begin
  case FState of
    bsInit : s := '';
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch :
      begin
        s := FLangStrings.slSizeDoneTotal1;
        s := UserFriendlySize(FTotalFilesSize, FTotalFilesSize2, s);
        s := s + ' (' + Format('%d', [FEstTime.StepsPerSecond], FFormatSettings) + '/s)';
      end;
    bsHash :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize((FDoneFilesSize + FDoneFilesSize2), (FTotalFilesSize +
          FTotalFilesSize2), s);
        s := s + UserFriendlySize(FEstTime.StepsPerSecond, FEstTime.StepsPerSecond, ' (%s/s)');
      end;
    bsSortNew :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
        s := s + UserFriendlySize(FEstTime.StepsPerSecond, FEstTime.StepsPerSecond, ' (%s/s)');
      end;
    bsOpMove :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
        s := s + UserFriendlySize(FEstTime.StepsPerSecond, FEstTime.StepsPerSecond, ' (%s/s)');
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
        s := s + UserFriendlySize(FEstTime.StepsPerSecond, FEstTime.StepsPerSecond, ' (%s/s)');
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FDoneFilesSize, FTotalFilesSize, s);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lSizeDoneTotal.Caption := s;
end;

procedure TProgressForm.ChangepbSizeDoneTotal;
var
  e : extended;
begin
  e := 0;
  case FState of
    bsInit : e := 0;
    bsStartApp : e := 0;
    bsCloseApp : e := 0;
    bsSearch : e := CalcRelation(FTotalFilesSize, FTotalFilesSize2);
    bsHash : e := CalcProgress(FDoneFilesSize + FDoneFilesSize2, FTotalFilesSize +
        FTotalFilesSize2);
    bsSortNew : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsSortDelFile : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsSortDelDir : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsSortMoved : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsOpCopy : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsOpMove : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsOpDelFile : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsOpDelDir : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsFinished : e := 0;
  end;
  pbSizeDoneTotal.Position := e;
end;

procedure TProgressForm.ChangelFrom;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch :
      begin
        s := FLangStrings.slFrom1;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsHash :
      begin
        s := FLangStrings.slFrom1;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slFrom3;
        s := Format(s, [FSourceDir], FFormatSettings);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lFrom.Caption := ExcludeTrailingPathDelimiter(s);
end;

procedure TProgressForm.ChangelFromPath;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsHash :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsSortNew :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsSortDelFile :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsSortDelDir :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsSortMoved :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsOpCopy :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsOpMove :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsOpDelFile :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsOpDelDir :
      begin
        s := CutStartDir(FActSourceDir, FSourceDir);
        s := ExtractFilePath(s);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lFromPath.Caption := ExcludeTrailingPathDelimiter(s);
end;

procedure TProgressForm.ChangelTo;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch :
      begin
        s := FLangStrings.slTo1;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsHash :
      begin
        s := FLangStrings.slTo1;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slTo3;
        s := Format(s, [FDestDir], FFormatSettings);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lTo.Caption := ExcludeTrailingPathDelimiter(s);
end;

procedure TProgressForm.ChangelToPath;
var
  s : string;
begin
  case FState of
    bsInit : s := FLangStrings.sInit;
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsHash :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsSortNew :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsSortDelFile :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsSortDelDir :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsSortMoved :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsOpCopy :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsOpMove :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsOpDelFile :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsOpDelDir :
      begin
        s := CutStartDir(FActDestDir, FDestDir);
        s := ExtractFilePath(s);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lToPath.Caption := ExcludeTrailingPathDelimiter(s);
end;

procedure TProgressForm.ChangelSizeDoneFile;
var
  s : string;
begin
  case FState of
    bsInit : s := '';
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch : s := '';
    bsHash :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize((FFileSizeDone), (FFileSize), s);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone, FFileSize, s);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lSizeDoneFile.Caption := s;
end;

procedure TProgressForm.ChangepbSizeDoneFile;
var
  e : extended;
begin
  e := 0;
  case FState of
    bsInit : e := 0;
    bsStartApp : e := 0;
    bsCloseApp : e := 0;
    bsSearch : e := 0;
    bsHash : e := CalcProgress(FFileSizeDone, FFileSize);
    bsSortNew : e := CalcProgress(FFileSizeDone, FFileSize);
    bsSortDelFile : e := CalcProgress(FFileSizeDone, FFileSize);
    bsSortDelDir : e := CalcProgress(FFileSizeDone, FFileSize);
    bsSortMoved : e := CalcProgress(FFileSizeDone, FFileSize);
    bsOpCopy : e := CalcProgress(FFileSizeDone, FFileSize);
    bsOpMove : e := CalcProgress(FFileSizeDone, FFileSize);
    bsOpDelFile : e := CalcProgress(FFileSizeDone, FFileSize);
    bsOpDelDir : e := CalcProgress(FFileSizeDone, FFileSize);
    bsFinished : e := 0;
  end;
  pbSizeDoneFile.Position := e;

end;

procedure TProgressForm.ChangelSizeDoneFile2;
var
  s : string;
begin
  case FState of
    bsInit : s := '';
    bsStartApp : s := '';
    bsCloseApp : s := '';
    bsSearch : s := '';
    bsHash :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize((FFileSizeDone2), (FFileSize2), s);
      end;
    bsSortNew :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsSortDelFile :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsSortDelDir :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsSortMoved :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsOpCopy :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsOpMove :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsOpDelFile :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsOpDelDir :
      begin
        s := FLangStrings.slSizeDoneTotal2;
        s := UserFriendlySize(FFileSizeDone2, FFileSize2, s);
      end;
    bsFinished : s := FLangStrings.sFinished;
  end;
  lSizeDoneFile2.Caption := s;
end;

procedure TProgressForm.ChangepbSizeDoneFile2;
var
  e : extended;
begin
  if pbSizeDoneFile2 <> nil then
  begin
    e := 0;
    case FState of
      bsInit : e := 0;
      bsStartApp : e := 0;
      bsCloseApp : e := 0;
      bsSearch : e := 0;
      bsHash : e := CalcProgress(FFileSizeDone2, FFileSize2);
      bsSortNew : e := 0;
      bsSortDelFile : e := 0;
      bsSortDelDir : e := 0;
      bsSortMoved : e := 0;
      bsOpCopy : e := 0;
      bsOpMove : e := 0;
      bsOpDelFile : e := 0;
      bsOpDelDir : e := 0;
      bsFinished : e := 0;
    end;
    pbSizeDoneFile2.Position := e;
  end;
end;

procedure TProgressForm.ChangeEstTime;
begin
  case FState of
    bsInit : ;
    bsStartApp : ;
    bsCloseApp : ;
    bsSearch : FEstTime.Value := FTotalFilesCount + FTotalFilesCount2;
    bsHash : FEstTime.Value := FDoneFilesSize + FDoneFilesSize2;
    bsSortNew : FEstTime.Value := FDoneFilesCount;
    bsSortDelFile : FEstTime.Value := FDoneFilesCount;
    bsSortDelDir : FEstTime.Value := FDoneFilesCount;
    bsSortMoved : FEstTime.Value := FDoneFilesCount;
    bsOpCopy : FEstTime.Value := FDoneFilesSize;
    bsOpMove : FEstTime.Value := FDoneFilesSize;
    bsOpDelFile : FEstTime.Value := FDoneFilesSize;
    bsOpDelDir : ;
    bsFinished : ;
  end;
end;

function TProgressForm.UserFriendlySize(Value1, Value2 : int64; sText : string) : string;
var
  e1, e2 : extended;
  s1, s2 : string;
begin
  if (Value1 > 53687091200) or (Value2 > 53687091200) then // 50 GB
  begin
    e1 := Value1 / 1073741824;
    e2 := Value2 / 1073741824;
    s1 := Format('%.3n GB', [e1], FFormatSettings);
    s2 := Format('%.3n GB', [e2], FFormatSettings);
  end
  else
    if (Value1 > 52428800) or (Value2 > 52428800) then // 50 MB
    begin
      e1 := Value1 / 1048576;
      e2 := Value2 / 1048576;
      s1 := Format('%.3n MB', [e1], FFormatSettings);
      s2 := Format('%.3n MB', [e2], FFormatSettings);
    end
    else
    begin
      e1 := Value1 / 1024;
      e2 := Value2 / 1024;
      s1 := Format('%.0n kb', [e1], FFormatSettings);
      s2 := Format('%.0n kb', [e2], FFormatSettings);
    end;
  result := Format(sText, [s1, s2]);
end;

function TProgressForm.CalcProgress(DoneValue, TotalValue : Int64) : extended;
begin
  if TotalValue > 0 then
  begin
    result := (DoneValue / TotalValue) * 100
  end
  else
  begin
    result := 0;
  end;
end;

function TProgressForm.CalcRelation(Value1, Value2 : int64) : extended;
begin
  if (Value1 + Value2) <> 0 then
  begin
    result := (Value2 / (Value1 + Value2)) * 100;
  end
  else
  begin
    result := 0;
  end;
end;

procedure TProgressForm.CalcHeight();
var
  i : integer;
begin
  i := 277;
  if pbSizeDoneFile.Visible then
  begin
    i := i + 40;
  end;
  if pbSizeDoneFile2.Visible then
  begin
    i := i + 40
  end;
  if mErrors.Visible then
  begin
    i := i + 243;
  end;
  ProgressForm.Height := i;
end;

procedure TProgressForm.ClearErrors;
begin
  mErrors.Visible := false;
  mErrors.Lines.Clear;
  FErrorBuffer.Clear;
end;

procedure TProgressForm.Suspend;
begin
  FEstTime.Suspend;
end;

procedure TProgressForm.Resume;
begin
  FEstTime.Resume;
end;

function TProgressForm.Progress : extended;
var
  e : extended;
begin
  e := 0;
  case FState of
    bsInit : ;
    bsStartApp : ;
    bsCloseApp : ;
    bsSearch : ;
    bsHash : e := CalcProgress(FDoneFilesSize + FDoneFilesSize2, FTotalFilesSize + FTotalFilesSize2);
    bsSortNew : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsSortDelFile : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsSortDelDir : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsSortMoved : e := CalcProgress(FDoneFilesCount, FTotalFilesCount);
    bsOpCopy : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsOpMove : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsOpDelFile : e := CalcProgress(FDoneFilesSize, FTotalFilesSize);
    bsOpDelDir : e := CalcProgress(FDoneFilesCount2, FTotalFilesCount2);
    bsFinished : ;
  end;
  result := e;
end;

procedure TProgressForm.SetTotalFilesCount(Value : int64);
begin
  FTotalFilesCount := Value;
  if not bTimer then
  begin
    ChangelFilesCount;
    ChangelTimeDone;
  end;
end;

procedure TProgressForm.SetTotalFilesCount2(Value : int64);
begin
  FTotalFilesCount2 := Value;
  if not bTimer then
  begin
    ChangelFilesCount;
    ChangelTimeLeft;
  end;
end;

procedure TProgressForm.SetDoneFilesCount(Value : int64);
begin
  FDoneFilesCount := Value;
  if not bTimer then
  begin
    ChangelFilesCount;
  end;
end;

procedure TProgressForm.SetDoneFilesCount2(Value : int64);
begin
  FDoneFilesCount2 := Value;
  if not bTimer then
  begin
    ChangelFilesCount;
  end;
end;

procedure TProgressForm.SetTotalFilesSize(Value : int64);
begin
  FTotalFilesSize := Value;
  if not bTimer then
  begin
    ChangelSizeDoneTotal;
  end;
end;

procedure TProgressForm.SetTotalFilesSize2(Value : int64);
begin
  FTotalFilesSize2 := Value;
  if not bTimer then
  begin
    ChangelSizeDoneTotal;
  end;
end;

procedure TProgressForm.SetDoneFilesSize(Value : int64);
begin
  FDoneFilesSize := Value;
  if not bTimer then
  begin
    ChangelSizeDoneTotal;
    ChangelTimeDone;
    ChangelTimeLeft;
  end;
end;

procedure TProgressForm.SetDoneFilesSize2(Value : int64);
begin
  FDoneFilesSize2 := Value;
  if not bTimer then
  begin
    ChangelSizeDoneTotal;
    ChangelTimeDone;
    ChangelTimeLeft;
  end;
end;

procedure TProgressForm.SetFileSize(Value : int64);
begin
  bNewFile := bNewFile or (FFileSize <> Value);
  FFileSize := Value;
  if not bTimer and bNewFile then
  begin
    ChangelSizeDoneFile;
  end;
end;

procedure TProgressForm.SetFileSizeDone(Value : int64);
begin
  if bNewFile then
  begin
    DoneFilesSize := FDoneFilesSize + Value;
    bNewFile := false;
  end
  else
  begin
    DoneFilesSize := FDoneFilesSize + (Value - FFileSizeDone);
  end;
  FFileSizeDone := Value;
  if not bTimer then
  begin
    ChangelSizeDoneFile;
  end;
end;

procedure TProgressForm.SetFileSize2(Value : int64);
begin
  bNewFile2 := bNewFile2 or (FFileSize2 <> Value);
  FFileSize2 := Value;
  if not bTimer and bNewFile2 then
  begin
    ChangelSizeDoneFile2;
  end;
end;

procedure TProgressForm.SetFileSizeDone2(Value : int64);
begin
  if bNewFile2 then
  begin
    DoneFilesSize2 := FDoneFilesSize2 + Value;
    bNewFile2 := false;
  end
  else
  begin
    DoneFilesSize2 := FDoneFilesSize2 + (Value - FFileSizeDone2);
  end;
  FFileSizeDone2 := Value;
  if not bTimer then
  begin
    ChangelSizeDoneFile2;
  end;
end;

procedure TProgressForm.SetSourceDir(Value : string);
begin
  FSourceDir := Value;
  if not bTimer then
  begin
    ChangelFrom;
  end;
end;

procedure TProgressForm.SetDestDir(Value : string);
begin
  FDestDir := Value;
  if not bTimer then
  begin
    ChangelTo;
  end;
end;

procedure TProgressForm.SetActSourceDir(Value : string);
begin
  bNewFile := bNewFile or (FActSourceDir <> Value);
  FActSourceDir := Value;
  if not bTimer then
  begin
    ChangelActionFileName;
    ChangelFromPath;
  end;
end;

procedure TProgressForm.SetApplicationName(const Value : string);
begin
  FApplicationName := Value;
  if not bTimer then
  begin
    ChangelActionFileName;
  end;
end;

procedure TProgressForm.SetActDestDir(Value : string);
begin
  bNewFile2 := bNewFile2 or (FActDestDir <> Value);
  FActDestDir := Value;
  if not bTimer then
  begin
    ChangelActionFileName;
    ChangelToPath;
  end;
end;

procedure TProgressForm.SetJobName(Value : string);
begin
  FJobName := Value;
  if not bTimer then
  begin
    ChangelJobName
  end;
end;

procedure TProgressForm.SetState(Value : TBackupperState);
begin
  if (Value <> bsHash) or (FHashCounter = 2) then
  begin
    FState := Value;
    case FState of
      bsInit :
        begin
          TotalFilesCount := 0;
          TotalFilesCount2 := 0;
          DoneFilesCount := 0;
          DoneFilesCount2 := 0;
          TotalFilesSize := 0;
          TotalFilesSize2 := 0;
          DoneFilesSize := 0;
          DoneFilesSize2 := 0;
          FileSize := 0;
          FileSizeDone := 0;
          FileSize2 := 0;
          FileSizeDone2 := 0;
          HashCounter := 0;
          SourceDir := '';
          DestDir := '';
          ActSourceDir := '';
          ActDestDir := '';
          JobName := '';
          //mErrors.Visible := false;
          //mErrors.Lines.Clear;
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
          tUpdatErrorsTimer(tUpdatErrors);
        end;
      bsStartApp :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          tUpdatErrorsTimer(tUpdatErrors);
        end;
      bsCloseApp :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          tUpdatErrorsTimer(tUpdatErrors);
        end;
      bsSearch :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
          FEstTime.MinValue := 0;
          FEstTime.MaxValue := 0;
          FEstTime.Start;
        end;
      bsHash :
        begin
          lSizeDoneFile.Visible := true;
          lSizeDoneFile2.Visible := true;
          FEstTime.MinValue := 0;
          FEstTime.MaxValue := FTotalFilesSize + FTotalFilesSize2;
          FEstTime.Start;
          //          pbSizeDoneFile.Visible := true;
          //          pbSizeDoneFile2.Visible := true;
          DoneFilesCount := 0;
          DoneFilesCount2 := 0;
          DoneFilesSize := 0;
          DoneFilesSize2 := 0;
        end;
      bsSortNew :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
          FEstTime.MinValue := 0;
          FEstTime.MaxValue := FTotalFilesCount;
          FEstTime.Start;
          TotalFilesCount := 0;
          DoneFilesCount := 0;
          TotalFilesCount2 := 0;
          DoneFilesCount2 := 0;
          TotalFilesSize := 0;
          DoneFilesSize := 0;
          TotalFilesSize2 := 0;
          DoneFilesSize2 := 0;
          FileSize := 0;
          FileSizeDone := 0;
          FileSize2 := 0;
          FileSizeDone2 := 0;
        end;
      bsSortDelFile :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
        end;
      bsSortDelDir :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
        end;
      bsSortMoved :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
          FEstTime.MinValue := 0;
          FEstTime.MaxValue := FTotalFilesCount;
          FEstTime.Start;
        end;
      bsOpCopy :
        begin
          lSizeDoneFile.Visible := true;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := true;
          //          pbSizeDoneFile2.Visible := False;
          FEstTime.MinValue := 0;
          FEstTime.MaxValue := FTotalFilesSize;
          FEstTime.Start;
        end;
      bsOpMove :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
        end;
      bsOpDelFile :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
        end;
      bsOpDelDir :
        begin
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
          FEstTime.MinValue := 0;
          FEstTime.MaxValue := FTotalFilesCount2;
          FEstTime.Start;
        end;
      bsFinished :
        begin
          TotalFilesCount := 0;
          TotalFilesCount2 := 0;
          DoneFilesCount := 0;
          DoneFilesCount2 := 0;
          TotalFilesSize := 0;
          TotalFilesSize2 := 0;
          DoneFilesSize := 0;
          DoneFilesSize2 := 0;
          FileSize := 0;
          FileSizeDone := 0;
          FileSize2 := 0;
          FileSizeDone2 := 0;
          HashCounter := 0;
          SourceDir := '';
          DestDir := '';
          ActSourceDir := '';
          ActDestDir := '';
          JobName := '';
          lSizeDoneFile.Visible := false;
          lSizeDoneFile2.Visible := false;
          //          pbSizeDoneFile.Visible := False;
          //          pbSizeDoneFile2.Visible := False;
        end;
    end;
  end;
  CalcHeight;
  ChangelJobName;
  //  ChangelActionFileName;
  //  ChangelFilesCount;
  //  ChangelTimeDone;
  //  ChangelTimeLeft;
  //  ChangepbFilesCount;
  //  ChangelSizeDoneTotal;
  //  ChangepbSizeDoneTotal;
  //  ChangelFrom;
  //  ChangelFromPath;
  //  ChangelTo;
  //  ChangelToPath;
  //  ChangelSizeDoneFile;
  //  ChangepbSizeDoneFile;
  //  ChangelSizeDoneFile2;
  //  ChangepbSizeDoneFileTwo;
end;

procedure TProgressForm.btCancelClick(Sender : TObject);
begin
  MainForm.btCancel.Click;
end;

procedure TProgressForm.btSuspendClick(Sender : TObject);
begin
  MainForm.btSuspend.Click;
end;

procedure TProgressForm.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  DoNotClose := false;
  tUpdate.Enabled := false;
  tUpdatErrors.Enabled := false;
  MainForm.Enabled := true;
end;

procedure TProgressForm.FormCreate(Sender : TObject);
begin
  FCS := TCriticalSection.Create;
  FTranslate := MainForm.JvTranslate;
  FEstTime := TEstimatedTime.Create;
  FErrorBuffer := TStringList.Create;
  FErrorBuffer.Sorted := true;
  FErrorBuffer.Duplicates := dupIgnore;
  FFormatSettings.DecimalSeparator := ',';
  FFormatSettings.ThousandSeparator := '.';
end;

procedure TProgressForm.FormDestroy(Sender : TObject);
begin
  FCS.Destroy;
  FreeAndNil(FEstTime);
  FreeAndNil(FErrorBuffer);
  MainForm.Enabled := true;
end;

procedure TProgressForm.FormShow(Sender : TObject);
begin
  tUpdate.Enabled := true;
  tUpdatErrors.Enabled := true;
  mErrors.Visible := false;
  lSizeDoneFile2.Visible := false;
  lSizeDoneFile2.Visible := false;
  //SetState(FState);
  if not bToggleShow then
  begin
    bToggleShow := true;
    with FLangStrings do
    begin
      sInit := FTranslate.Translate('GUIStrings', 'Init');
      sFinished := FTranslate.Translate('GUIStrings', 'Finished');
      slFilesCount1 := FTranslate.Translate('GUIStrings', 'lFilesCount1');
      slFilesCount2 := FTranslate.Translate('GUIStrings', 'lFilesCount2');
      slTimeDone1 := FTranslate.Translate('GUIStrings', 'lTimeDone1');
      slTimeDone2 := FTranslate.Translate('GUIStrings', 'lTimeDone2');
      slTimeLeft1 := FTranslate.Translate('GUIStrings', 'lTimeLeft1');
      slTimeLeft2 := FTranslate.Translate('GUIStrings', 'lTimeLeft2');
      slActionFileName1 := FTranslate.Translate('GUIStrings', 'lActionFileName1');
      slActionFileName2 := FTranslate.Translate('GUIStrings', 'lActionFileName2');
      slActionFileName3 := FTranslate.Translate('GUIStrings', 'lActionFileName3');
      slActionFileName4 := FTranslate.Translate('GUIStrings', 'lActionFileName4');
      slActionFileName5 := FTranslate.Translate('GUIStrings', 'lActionFileName5');
      slActionFileName6 := FTranslate.Translate('GUIStrings', 'lActionFileName6');
      slActionFileName7 := FTranslate.Translate('GUIStrings', 'lActionFileName7');
      slActionFileName8 := FTranslate.Translate('GUIStrings', 'lActionFileName8');
      slActionFileName9 := FTranslate.Translate('GUIStrings', 'lActionFileName9');
      slActionFileName10 := FTranslate.Translate('GUIStrings', 'lActionFileName10');
      slActionFileName11 := FTranslate.Translate('GUIStrings', 'lActionFileName11');
      slActionFileName12 := FTranslate.Translate('GUIStrings', 'lActionFileName12');
      slSizeDoneTotal1 := FTranslate.Translate('GUIStrings', 'lSizeDoneTotal1');
      slSizeDoneTotal2 := FTranslate.Translate('GUIStrings', 'lSizeDoneTotal2');
      slFrom1 := FTranslate.Translate('GUIStrings', 'lFrom1');
      slFrom3 := FTranslate.Translate('GUIStrings', 'lFrom3');
      slTo1 := FTranslate.Translate('GUIStrings', 'lTo1');
      slTo3 := FTranslate.Translate('GUIStrings', 'lTo3');
    end;
  end;
  ChangelJobName;
  CalcHeight;
end;

procedure TProgressForm.tUpdatErrorsTimer(Sender : TObject);
var
  i : integer;
begin
  if FError <> nil then
  begin
    for i := 0 to FError.Count - 1 do
    begin
      FErrorBuffer.Add(FError.Strings[i]);
    end;
    if FErrorBuffer.Count > mErrors.Lines.Count then
    begin
      for i := mErrors.Lines.Count to FErrorBuffer.Count - 1 do
      begin
        mErrors.Lines.Add(FErrorBuffer.Strings[i]);
      end;
    end;
  end;
  if not mErrors.Visible and (FErrorBuffer.Count <> 0) then
  begin
    mErrors.Visible := true;
    CalcHeight;
  end;
end;

procedure TProgressForm.tUpdateTimer(Sender : TObject);
begin
  if bTimer then
  begin
    ChangelActionFileName;
    ChangelFilesCount;
    ChangelTimeDone;
    ChangelTimeLeft;
    ChangelSizeDoneTotal;
    ChangelFrom;
    ChangelFromPath;
    ChangelTo;
    ChangelToPath;
    ChangelSizeDoneFile;
    ChangelSizeDoneFile2;
  end;
  ChangeEstTime;
  ChangepbFilesCount;
  ChangepbSizeDoneTotal;
  ChangepbSizeDoneFile;
  ChangepbSizeDoneFile2;
end;

end.

