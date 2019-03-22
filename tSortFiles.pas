unit tSortFiles;

interface

{$INCLUDE Compilerswitches.inc}

uses
  Classes,
  SysUtils,
  DateUtils,
  IniFiles,
  Generics.Collections,
  Generics.Defaults,
  tSearchFiles,
  ProgressDialog,
  csExplode,
  VTreeHelper,
  csLogCls,
  csUtils;

type
  TSortedFileValues = record
    sSourceFileName : string;
    sDestFileName : string;
    sManipulateFileName : String;
    sHash : string;
    iSize : Int64;
    iTime : Integer;
    bSkip : Boolean;
    procedure Fill(SourceFileName, DestFileName : String; Values : TFoundFileValues);
  end;

  // TArrayofStringList = array [0 .. 2] of TStringlist; (* 0: Source 1: Destination 2: Hash *)
  // PArrayofStringList = ^TArrayofStringList;
  TSortedFilesList = TList<TSortedFileValues>;
  PSortedFilesList = ^TSortedFilesList;

  TSortedFileValuesComparer = class(TComparer<TSortedFileValues>)
  public
    function Compare(const Left, Right : TSortedFileValues) : Integer; override;
  end;

  TtSortFiles = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure SortFilesHash(const SourceFiles : TFoundFilesList; const DestFiles : TFoundFilesList;
      const SourceFolders : THashedStringList; const DestFolders : THashedStringList; var CopyFiles : TSortedFilesList;
      var MoveFiles : TSortedFilesList; var DeleteFiles : TSortedFilesList; var DeleteDirs : TStringlist;
      var LogFile : TLogFile; var ErrorsList : TStringlist; var bError : Boolean; const bDeleteFiles : Boolean;
      const sSourceDir : string; const sDestDir : string);
    procedure SortFilesSizeTime(const SourceFiles : TFoundFilesList; const DestFiles : TFoundFilesList;
      const SourceFolders : THashedStringList; const DestFolders : THashedStringList; var CopyFiles : TSortedFilesList;
      var MoveFiles : TSortedFilesList; var DeleteFiles : TSortedFilesList; var DeleteDirs : TStringlist;
      var LogFile : TLogFile; var ErrorsList : TStringlist; var bError : Boolean; const bDeleteFiles : Boolean;
      const sSourceDir : string; const sDestDir : string);
    procedure GetNonExistingFolders(var Files : TStringlist; const SourceFolders : THashedStringList;
      const DestFolders : THashedStringList; const sSourceDir : string; const sDestDir : string);
  public
    SourceFiles : PFoundFilesList;
    DestFiles : PFoundFilesList;
    SourceFolders : tSearchFiles.PHashedStringList;
    DestFolders : tSearchFiles.PHashedStringList;
    CopyFiles : PSortedFilesList;
    MoveFiles : PSortedFilesList;
    DeleteFiles : PSortedFilesList;
    DeleteDirs : PTStringList;
    LogFile : PLogFile;
    TreeData : PTreeData;
    bError : Pboolean;
    sStatusbarText : Pstring;
    PF : TProgressForm;
  end;

implementation

uses
  MainFrame,
  Windows;

// vermeidet Untit Types
const
  GreaterThanValue = 1;

  { tSortFiles }

procedure TtSortFiles.GetNonExistingFolders(var Files : TStringlist; const SourceFolders : THashedStringList;
  const DestFolders : THashedStringList; const sSourceDir : string; const sDestDir : string);

// function IsEmptyFolder(const AsFolder : string) : boolean;
// var
// sr : TSearchRec;
// begin
// Result := FindFirst(AsFolder + '\*.*', faAnyFile - faDirectory, sr) = 0;
// if not Result then
// exit;
// repeat
// {$WARNINGS OFF}
// if (sr.Name <> '.') and (sr.Name <> '..') and (sr.Attr and faVolumeID = 0) then
// {$WARNINGS ON}
// begin
// Result := false;
// Break;
// end;
// until FindNext(sr) <> 0;
// SysUtils.FindClose(sr);
// end;

var
  sLog, sTemp : string;
  i, iFindResult : Integer;
begin
  if not Terminated then
  begin
    for i := 0 to DestFolders.Count - 1 do
    begin
      sTemp := DestFolders.Strings[i];
      PF.DoneFilesCount := PF.DoneFilesCount + 1;
      PF.ActDestDir := sTemp;
      if Terminated then
      begin
        break;
      end;
      if sTemp <> '' then
      begin
        iFindResult := SourceFolders.IndexOf(sSourceDir + CutStartDir(sTemp, sDestDir));
        if iFindResult = - 1 then
        begin
          // if IsEmptyFolder(DestFolders[0].Strings[i]) then
          // begin
          Files.Add(sTemp);
          PF.TotalFilesCount2 := PF.TotalFilesCount + 1;
          sLog := LogFile.Write('LogStrings', 'DeltingDirsFound', [sTemp]);
          sStatusbarText^ := sLog;
          // end;
        end
        else
        begin
          PF.ActSourceDir := SourceFolders.Strings[iFindResult];
        end;
      end;
    end;
  end;
end;

procedure TtSortFiles.SortFilesHash(const SourceFiles : TFoundFilesList; const DestFiles : TFoundFilesList;
  const SourceFolders : THashedStringList; const DestFolders : THashedStringList; var CopyFiles : TSortedFilesList;
  var MoveFiles : TSortedFilesList; var DeleteFiles : TSortedFilesList; var DeleteDirs : TStringlist;
  var LogFile : TLogFile; var ErrorsList : TStringlist; var bError : Boolean; const bDeleteFiles : Boolean;
  const sSourceDir : string; const sDestDir : string);
var
  h, i, n, q : Integer;
  iFindResult : Integer;
  sLog : string;
  SourceValue, DestValue : TFoundFileValues;
  Value, NewValue, DelValue : TSortedFileValues;
label
  lNext;
begin
  // Listen erstellen
  DeleteDirs := TStringlist.Create;
  CopyFiles := TSortedFilesList.Create(TSortedFileValuesComparer.Create);;
  MoveFiles := TSortedFilesList.Create(TSortedFileValuesComparer.Create);
  DeleteFiles := TSortedFilesList.Create(TSortedFileValuesComparer.Create);
  sLog := LogFile.Write('LogStrings', 'SortFiles');
  sStatusbarText^ := sLog;
  // neue und geänderte Dateien suchen
  sLog := LogFile.Write('LogStrings', 'SearchNewFiles');
  sStatusbarText^ := sLog;
  PF.TotalFilesCount := SourceFiles.Count + DestFiles.Count + DestFolders.Count;
  PF.State := bsSortNew;
  PF.TotalFilesCount := SourceFiles.Count + DestFiles.Count + DestFolders.Count;
  for SourceValue in SourceFiles.Values do
  begin
    PF.DoneFilesCount := PF.DoneFilesCount + 1;
    PF.ActSourceDir := SourceValue.sFileName;
    if Terminated then
    begin
      break;
    end;
    if SourceValue.sHash = '' then
    begin
      continue;
    end;
    if DestFiles.TryGetValue(sDestDir + CutStartDir(SourceValue.sFileName, sSourceDir), DestValue) then
    begin
      // File gefunden
      PF.ActDestDir := DestValue.sFileName;
      if ((SourceValue.sHash <> DestValue.sHash) and (DestValue.sHash <> '')) then
      begin
        // Dateien ungleich
        NewValue.Fill(SourceValue.sFileName, DestValue.sFileName, SourceValue);
        CopyFiles.Add(NewValue);
        PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
        PF.TotalFilesSize := PF.TotalFilesSize + SourceValue.iSize;
        sLog := LogFile.Write('LogStrings', 'SearchChangedFilesFound', [SourceValue.sFileName, DestValue.sFileName]);
        sStatusbarText^ := sLog;
      end;
    end
    else
    begin
      // neue Datei
      NewValue.Fill(SourceValue.sFileName, sDestDir + CutStartDir(SourceValue.sFileName, sSourceDir), SourceValue);
      CopyFiles.Add(NewValue);
      PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
      PF.TotalFilesSize := PF.TotalFilesSize + SourceValue.iSize;
      sLog := LogFile.Write('LogStrings', 'SearchNewFilesFound',
        [SourceValue.sFileName, sDestDir + CutStartDir(SourceValue.sFileName, sSourceDir)]);
      sStatusbarText^ := sLog;
    end;
  end;
  LogFile.Write('LogStrings', 'SearchNewFilesEnd');
  if bDeleteFiles then // Dateien löschen?
  begin
    // gelöschte Dateien suchen
    sLog := LogFile.Write('LogStrings', 'SearchDeletedFiles');
    sStatusbarText^ := sLog;
    PF.State := bsSortDelFile;
    for DestValue in DestFiles.Values do
    begin
      PF.DoneFilesCount := PF.DoneFilesCount + 1;
      PF.ActDestDir := DestValue.sFileName;
      if Terminated then
      begin
        break;
      end;
      if DestValue.sFileName <> '' then
      begin
        if not SourceFiles.TryGetValue(sSourceDir + CutStartDir(DestValue.sFileName, sDestDir), SourceValue) then
        begin
          // Datei in Source nicht vorhanden: Datei in Destination löschen
          NewValue.Fill(DestValue.sFileName, '', DestValue);
          DeleteFiles.Add(NewValue);
          PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
          PF.TotalFilesSize := PF.TotalFilesSize + DestValue.iSize;
          sLog := LogFile.Write('LogStrings', 'SearchDeletedFilesFound', [DestValue.sFileName]);
          sStatusbarText^ := sLog;
        end
        else
        begin
          PF.ActSourceDir := SourceValue.sFileName;
        end;
      end;
    end;
    LogFile.Write('LogStrings', 'SearchDeletedFilesEnd');
    // Gelöschte Verzeichnisse suchen
    sLog := LogFile.Write('LogStrings', 'SearchDeletedDirs');
    sStatusbarText^ := sLog;
    DeleteDirs.Sorted := true;
    DeleteDirs.Duplicates := dupIgnore;
    PF.State := bsSortDelDir;
    GetNonExistingFolders(DeleteDirs, SourceFolders, DestFolders, sSourceDir, sDestDir);
    LogFile.Write('LogStrings', 'SearchDeletedDirsEnd');
    // Verschobene Dateien suchen
    sLog := LogFile.Write('LogStrings', 'SearchMovedFiles');
    sStatusbarText^ := sLog;
    PF.TotalFilesCount := CopyFiles.Count;
    PF.State := bsSortMoved;
    PF.TotalFilesCount := CopyFiles.Count;
    for i := 0 to CopyFiles.Count - 1 do
    begin
      if Terminated then
      begin
        break;
      end;
      Value := CopyFiles.Items[i];
      PF.DoneFilesCount := PF.DoneFilesCount + 1;
      PF.ActSourceDir := Value.sSourceFileName;
      PF.ActDestDir := Value.sDestFileName;
      iFindResult := DeleteFiles.IndexOf(Value);
      if iFindResult <> - 1 then
      begin
        // Hash gleich: Dateien verschoben oder umbenannt Strings aus beiden Listen löschen
        NewValue.sSourceFileName := DelValue.sSourceFileName;
        NewValue.sDestFileName := Value.sDestFileName;
        NewValue.sManipulateFileName := Value.sSourceFileName;
        NewValue.sHash := DelValue.sHash;
        NewValue.iSize := DelValue.iSize;
        NewValue.iTime := DelValue.iTime;
        MoveFiles.Add(NewValue);
        PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
        PF.TotalFilesSize := PF.TotalFilesSize + DelValue.iSize;
        sLog := LogFile.Write('LogStrings', 'SearchMovedFilesFound',
          [NewValue.sSourceFileName, NewValue.sDestFileName]);
        sStatusbarText^ := sLog;
        NewValue := Value;
        NewValue.bSkip := true;
        CopyFiles.Items[i] := NewValue;
        DeleteFiles.Delete(iFindResult);
      end;
    end;
    LogFile.Write('LogStrings', 'SearchMovedFilesEnd');
  end;
  sLog := LogFile.Write('LogStrings', 'SortFilesEnd');
  sStatusbarText^ := sLog;
end;

procedure TtSortFiles.SortFilesSizeTime(const SourceFiles : TFoundFilesList; const DestFiles : TFoundFilesList;
  const SourceFolders : THashedStringList; const DestFolders : THashedStringList; var CopyFiles : TSortedFilesList;
  var MoveFiles : TSortedFilesList; var DeleteFiles : TSortedFilesList; var DeleteDirs : TStringlist;
  var LogFile : TLogFile; var ErrorsList : TStringlist; var bError : Boolean; const bDeleteFiles : Boolean;
  const sSourceDir : string; const sDestDir : string);
var
  bFileTimeError : Boolean;
  h, i, n, q, iFindResult : Integer;
  dtSourceDate, dtDestDate : TDateTime;
  sLog : string;
  SourceValue, DestValue : TFoundFileValues;
  Value, NewValue, DelValue : TSortedFileValues;
label
  lNext;
begin
  // Listen erstellen
  DeleteDirs := TStringlist.Create;
  CopyFiles := TSortedFilesList.Create;
  MoveFiles := TSortedFilesList.Create;
  DeleteFiles := TSortedFilesList.Create;
  sLog := LogFile.Write('LogStrings', 'SortFiles');
  sStatusbarText^ := sLog;
  // neue und geänderte Dateien suchen
  sLog := LogFile.Write('LogStrings', 'SearchNewFiles');
  sStatusbarText^ := sLog;
  PF.TotalFilesCount := SourceFiles.Count + DestFiles.Count + DestFolders.Count;
  PF.State := bsSortNew;
  PF.TotalFilesCount := SourceFiles.Count + DestFiles.Count + DestFolders.Count;
  for SourceValue in SourceFiles.Values do
  begin
    bFileTimeError := False;
    PF.DoneFilesCount := PF.DoneFilesCount + 1;
    PF.ActSourceDir := SourceValue.sFileName;
    if Terminated then
    begin
      break;
    end;
    // prüfen ob Datei in DestDir existiert
    if DestFiles.TryGetValue(sDestDir + CutStartDir(SourceValue.sFileName, sSourceDir), DestValue) then
    begin
      // File gefunden
      PF.ActDestDir := DestValue.sFileName;
      LogFile.Write(Format('DateString for File: %s => Source: %d Destination: %d',
        [SourceValue.sFileName, SourceValue.iTime, DestValue.iTime]), llDebug);
      try
        dtSourceDate := FileDatetoDateTime(SourceValue.iTime);
        dtDestDate := FileDatetoDateTime(DestValue.iTime);
      except
        dtSourceDate := 0;
        dtDestDate := 0;
        bFileTimeError := true;
      end;
      if (bFileTimeError and (SourceValue.iTime <> DestValue.iTime)) or (SourceValue.iSize <> DestValue.iSize) or
        ( not bFileTimeError and (CompareDateTime(dtSourceDate - dtDestDate, TreeData^.iTimeDiff * OneSecond)
        = GreaterThanValue) and (TreeData^.CompareMode <> cmArchive)) or
        ((SourceValue.iAttributes and faArchive <> 0) and (TreeData^.CompareMode = cmArchive)) then
      begin
        // Dateien ungleich
        LogFile.Write(Format('Changed File: %s => Source: %s Destination: %s',
          [SourceValue.sFileName, FormatDateTime('c', dtSourceDate), FormatDateTime('c', dtDestDate)]), llDebug);
        NewValue.Fill(SourceValue.sFileName, DestValue.sFileName, SourceValue);
        NewValue.sHash := Format('%d;%d', [SourceValue.iSize, SourceValue.iTime]);
        CopyFiles.Add(NewValue);
        PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
        PF.TotalFilesSize := PF.TotalFilesSize + SourceValue.iSize;
        sLog := LogFile.Write('LogStrings', 'SearchChangedFilesFound', [SourceValue.sFileName, SourceValue.sFileName]);
        sStatusbarText^ := sLog;
      end;
    end
    else
    begin
      // neue Datei
      NewValue.Fill(SourceValue.sFileName, sDestDir + CutStartDir(SourceValue.sFileName, sSourceDir), SourceValue);
      NewValue.sHash := Format('%d;%d', [SourceValue.iSize, SourceValue.iTime]);
      CopyFiles.Add(NewValue);
      PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
      PF.TotalFilesSize := PF.TotalFilesSize + SourceValue.iSize;
      sLog := LogFile.Write('LogStrings', 'SearchNewFilesFound',
        [SourceValue.sFileName, sDestDir + CutStartDir(SourceValue.sFileName, sSourceDir)]);
      sStatusbarText^ := sLog;
    end;
  end;
  LogFile.Write('LogStrings', 'SearchNewFilesEnd');
  if bDeleteFiles then // Dateien löschen?
  begin
    // gelöschte Dateien suchen
    sLog := LogFile.Write('LogStrings', 'SearchDeletedFiles');
    PF.State := bsSortDelFile;
    sStatusbarText^ := sLog;
    for DestValue in DestFiles.Values do
    begin
      PF.DoneFilesCount := PF.DoneFilesCount + 1;
      PF.ActDestDir := DestValue.sFileName;
      if Terminated then
      begin
        break;
      end;
      if DestValue.sFileName <> '' then
      begin
        if not SourceFiles.TryGetValue(sSourceDir + CutStartDir(DestValue.sFileName, sDestDir), SourceValue) then
        begin
          // Datei in Source nicht vorhanden: Datei in Destination löschen
          NewValue.Fill(DestValue.sFileName, '', DestValue);
          NewValue.sHash := Format('%d;%d', [DestValue.iSize, DestValue.iTime]);
          DeleteFiles.Add(NewValue);
          PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
          PF.TotalFilesSize := PF.TotalFilesSize + DestValue.iSize;
          sLog := LogFile.Write('LogStrings', 'SearchDeletedFilesFound', [DestValue.sFileName]);
          sStatusbarText^ := sLog;
        end
        else
        begin
          PF.ActSourceDir := SourceValue.sFileName;
        end;
      end;
    end;
    LogFile.Write('LogStrings', 'SearchDeletedFilesEnd');
    // Gelöschte Verzeichnisse suchen
    sLog := LogFile.Write('LogStrings', 'SearchDeletedDirs');
    sStatusbarText^ := sLog;
    PF.State := bsSortDelDir;
    DeleteDirs.Sorted := true;
    DeleteDirs.Duplicates := dupIgnore;
    GetNonExistingFolders(DeleteDirs, SourceFolders, DestFolders, sSourceDir, sDestDir);
    LogFile.Write('LogStrings', 'SearchDeletedDirsEnd');
    // Verschobene Dateien suchen
    sLog := LogFile.Write('LogStrings', 'SearchMovedFiles');
    sStatusbarText^ := sLog;
    PF.TotalFilesCount := CopyFiles.Count;
    PF.State := bsSortMoved;
    PF.TotalFilesCount := CopyFiles.Count;
    for i := 0 to CopyFiles.Count - 1 do
    begin
      if Terminated then
      begin
        break;
      end;
      Value := CopyFiles.Items[i];
      PF.DoneFilesCount := PF.DoneFilesCount + 1;
      PF.ActSourceDir := Value.sSourceFileName;
      PF.ActDestDir := Value.sDestFileName;
      iFindResult := DeleteFiles.IndexOf(Value);
      if iFindResult <> - 1 then
      begin
        // Hash gleich: Dateien verschoben oder umbenannt Strings aus beiden Listen löschen
        NewValue.sSourceFileName := DelValue.sSourceFileName;
        NewValue.sDestFileName := Value.sDestFileName;
        NewValue.sManipulateFileName := Value.sSourceFileName;
        NewValue.sHash := DelValue.sHash;
        NewValue.iSize := DelValue.iSize;
        NewValue.iTime := DelValue.iTime;
        MoveFiles.Add(NewValue);
        PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
        PF.TotalFilesSize := PF.TotalFilesSize + DelValue.iSize;
        sLog := LogFile.Write('LogStrings', 'SearchMovedFilesFound',
          [NewValue.sSourceFileName, NewValue.sDestFileName]);
        sStatusbarText^ := sLog;
        NewValue := Value;
        NewValue.bSkip := true;
        CopyFiles.Items[i] := NewValue;
        DeleteFiles.Delete(iFindResult);
      end;
    end;
    LogFile.Write('LogStrings', 'SearchMovedFilesEnd');
  end;
  sLog := LogFile.Write('LogStrings', 'SortFilesEnd');
  sStatusbarText^ := sLog;
end;

procedure TtSortFiles.Execute;
var
  sSource, sDest : string;
begin
  MainForm.DestThread.WaitFor;
  MainForm.SourceThread.WaitFor;
  if not Terminated then
  begin
    sSource := IncludeTrailingPathDelimiter(TreeData^.sSourceC);
    sDest := IncludeTrailingPathDelimiter(TreeData^.sDestC);
    case TreeData^.CompareMode of
      cmHash :
        SortFilesHash(SourceFiles^, DestFiles^, SourceFolders^, DestFolders^, CopyFiles^, MoveFiles^, DeleteFiles^,
          DeleteDirs^, LogFile^, TreeData^.JobErrors, bError^, TreeData^.bDeleteFiles, sSource, sDest);
      cmSizeTime, cmArchive :
        SortFilesSizeTime(SourceFiles^, DestFiles^, SourceFolders^, DestFolders^, CopyFiles^, MoveFiles^, DeleteFiles^,
          DeleteDirs^, LogFile^, TreeData^.JobErrors, bError^, TreeData^.bDeleteFiles, sSource, sDest);
    end;
  end;
end;

{ TSortedFileValues }

procedure TSortedFileValues.Fill(SourceFileName, DestFileName : String; Values : TFoundFileValues);
begin
  Self.sSourceFileName := SourceFileName;
  Self.sDestFileName := DestFileName;
  Self.sHash := Values.sHash;
  Self.iSize := Values.iSize;
  Self.iTime := Values.iTime;
end;

{ TSortedFileValuesComparer }

function TSortedFileValuesComparer.Compare(const Left, Right : TSortedFileValues) : Integer;
begin
  Result := TComparer<String>.Default.Compare(Left.sHash, Right.sHash);
end;

end.
