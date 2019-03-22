unit tSearchFiles;

interface

{$INCLUDE Compilerswitches.inc}

uses
  Classes,
  IniFiles,
  Generics.Collections,
  DECUtil,
  VTreeHelper,
  ProgressDialog,
  csLogCls,
  csUtils;

type
  TFoundFileValues = record
    sFileName : string;
    sHash : string;
    iSize : Int64;
    iAttributes : Integer;
    iTime : Integer;
  end;

  // TArrayofStringList = array[0..1] of THashedStringList; (* 0: Source 1: Hash *)
  // PArrayofStringList = ^TArrayofStringList;
  TFoundFilesList = TDictionary<string, TFoundFileValues>;
  PFoundFilesList = ^TFoundFilesList;
  PHashedStringList = ^THashedStringList;

  TSearchMode = (smSource, smDestination);

  TProgress = class(TInterfacedObject, IDECProgress)
    procedure Process(const Min, Max, Pos : Int64); stdcall;
    constructor Create(PF1 : TProgressForm; iSearchMode1 : TSearchMode);
    destructor Destroy; override;
  private
    iSearchMode : TSearchMode;
    PF : TProgressForm;
  end;

  TtSearchFiles = class(TThread)
  private

  protected
    procedure Execute; override;
    function GetFiles(const sDirectory : string; var Files : TFoundFilesList; var Folders : THashedStringList;
      var LogFile : TLogFile; var ErrorsList : TStringList; const SkipFiles : TStringList;
      const SkipFolders : TStringList; var bError : Boolean; const sFileMask : string = '*.*';
      const bSubFolders : Boolean = True; const bRecurse : Boolean = False) : Boolean;
    procedure HashFiles(var Files : TFoundFilesList; var LogFile : TLogFile; var ErrorsList : TStringList;
      var bError : Boolean);
  private
    sSource : string;
  public
    sDir : string;
    FileList : PFoundFilesList;
    FolderList : PHashedStringList;
    LogFile : PLogFile;
    TreeData : PTreeData;
    bError : Pboolean;
    sStatusbarText : Pstring;
    iSearchMode : TSearchMode;
    PF : TProgressForm;
  end;

implementation

uses
  SysUtils,
  dateutils,
  MainFrame,
  DECHash,
  DECFmt;

procedure TProgress.Process(const Min, Max, Pos : Int64);
begin
  case iSearchMode of
    smSource :
      begin
        PF.FileSize := (Max - Min);
        PF.FileSizeDone := (Pos - Min);
      end;
    smDestination :
      begin
        PF.FileSize2 := (Max - Min);
        PF.FileSizeDone2 := (Pos - Min);
      end;
  end;
end;

constructor TProgress.Create(PF1 : TProgressForm; iSearchMode1 : TSearchMode);
begin
  inherited Create;
  iSearchMode := iSearchMode1;
  PF := PF1;
end;

destructor TProgress.Destroy;
begin
  inherited Destroy;
end;

{ TSearchFiles }

/// ////////////////////////GetFilesSizeDate/////////////////////////////////////////////
// Autor: Daniel B
// Editor: C.Schoch
/// /////////////////////////////////////////////////////////////////////////////

// function TtSearchFiles.GetFilesSizeDate(const sDirectory : string; var Files : TFilesList;
// var Folders : THashedStringList; var LogFile : TLogFile; var ErrorsList : TStringList; const SkipFiles : TStringList;
// const SkipFolders : TStringList; var bError : Boolean; const sFileMask : string = '*.*';
// const bSubFolders : Boolean = True; const bRecurse : Boolean = False) : Boolean;
//
// function SlashSep(const Path, S : string) : string;
// // Backslash zum Pfadende hinzufügen wenn keiner vorhanden
// begin
// if AnsiLastChar(Path)^ <> '\' then
// Result := Path + '\' + S
// else
// Result := Path + S;
// end;
//
// function SkipFile(const sPath : string) : Boolean;
// var
// S : string;
// i : Integer;
// begin
// Result := False;
// for i := 0 to SkipFiles.Count - 1 do
// begin
// S := SkipFiles.Strings[i];
// if (S = extractfileext(sPath)) or (S = CutExtension(extractFileName(sPath))) or (S = extractFileName(sPath)) or
// (S = sPath) then
// begin
// Result := True;
// break;
// end;
// end;
// end;
//
// function SkipFolder(const sPath : string) : Boolean;
// var
// fName : string;
// begin
// fName := sSource + CutStartDir(sPath, sDir);
// fName := IncludeTrailingPathDelimiter(fName);
// Result := (SkipFolders.IndexOf(fName) <> - 1);
// end;
//
// var
// SearchRec : TSearchRec;
// i : Integer;
// S, sLog : string;
// iSize : Int64;
// bDoSkipFiles : Boolean;
// Value : TFoundFileValues;
// begin
// // Verzeichniss nach Dateien durchsuchen
// if Files = nil then
// begin
// Files := TFilesList.Create;
// end;
// if Folders = nil then
// begin
// Folders := THashedStringList.Create;
// Folders.Sorted := True;
// Folders.Duplicates := dupIgnore;
// end;
// bDoSkipFiles := (SkipFiles.Count >= 1);
// Result := True;
// if bRecurse or not SkipFolder(sDirectory) then
// begin
// {$WARNINGS OFF}
// if FindFirst(SlashSep(sDirectory, sFileMask), faAnyFile and not faDirectory and not faVolumeID, SearchRec) = 0 then
// {$WARNINGS ON}
// begin
// if not Terminated then
// begin
// try
// Result := (iSearchMode = smSource);
// repeat
// S := SlashSep(sDirectory, SearchRec.Name);
// if not bDoSkipFiles or not SkipFile(S) then
// begin
// sLog := LogFile.Write('LogStrings', 'SearchFilesFound', [S]);
// sStatusbarText^ := sLog;
// {$WARNINGS OFF}
// Int64Rec(iSize).Hi := SearchRec.FindData.nFileSizeHigh;
// Int64Rec(iSize).Lo := SearchRec.FindData.nFileSizeLow;
// {$WARNINGS ON}
// Value.sFileName := s;
// Value.iSize := iSize;
// Value.iTime := SearchRec.Time;
// Files.Add(S, Value);
// case iSearchMode of
// smSource :
// begin
// PF.TotalFilesCount := PF.TotalFilesCount + 1;
// PF.TotalFilesSize := PF.TotalFilesSize + iSize;
// PF.ActSourceDir := S;
// end;
// smDestination :
// begin
// PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
// PF.TotalFilesSize2 := PF.TotalFilesSize2 + iSize;
// PF.ActDestDir := S;
// end;
// end;
// end;
// until (FindNext(SearchRec) <> 0) or Terminated;
// finally
// SysUtils.FindClose(SearchRec);
// end;
// end;
// end
// else
// begin
// if GetLastError <> 18 then
// begin
// bError := True;
// sLog := LogFile.Write('LogStrings', 'SearchFilesError', [sDirectory, SysErrorMessage(GetLastError)]);
// Log(sLog, ErrorsList);
// sStatusbarText^ := sLog;
// end;
// end;
// end;
//
// if bSubFolders and not Terminated then
// begin
// // Unterordner suchen
// if FindFirst(SlashSep(sDirectory, '*.*'), faAnyFile, SearchRec) = 0 then
// begin
// try
// repeat
// if (SearchRec.Attr and faDirectory) <> 0 then
// begin
// S := SlashSep(sDirectory, SearchRec.Name);
// if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and not SkipFolder(S) then
// begin
// Result := GetFilesSizeDate(S, Files, Folders, LogFile, ErrorsList, SkipFiles, SkipFolders, bError,
// sFileMask, bSubFolders, True) and Result;
// end;
// end;
// until FindNext(SearchRec) <> 0;
// finally
// SysUtils.FindClose(SearchRec);
// end;
// end;
// end;
//
// if Result then
// begin
// Folders.Add(sDirectory);
// end;
// end;

/// ////////////////////////GetFiles/////////////////////////////////////////////
// Autor: Daniel B
// Editor: C.Schoch
/// /////////////////////////////////////////////////////////////////////////////

function TtSearchFiles.GetFiles(const sDirectory : string; var Files : TFoundFilesList; var Folders : THashedStringList;
  var LogFile : TLogFile; var ErrorsList : TStringList; const SkipFiles : TStringList; const SkipFolders : TStringList;
  var bError : Boolean; const sFileMask : string = '*.*'; const bSubFolders : Boolean = True;
  const bRecurse : Boolean = False) : Boolean;

  function SlashSep(const Path, S : string) : string;
  // Backslash zum Pfadende hinzufügen wenn keiner vorhanden
  begin
    if AnsiLastChar(Path)^ <> '\' then
      Result := Path + '\' + S
    else
      Result := Path + S;
  end;

  function SkipFile(const sPath : string) : Boolean;
  var
    S : string;
    i : Integer;
  begin
    Result := False;
    for i := 0 to SkipFiles.Count - 1 do
    begin
      S := SkipFiles.Strings[i];
      if (S = extractfileext(sPath)) or (S = CutExtension(extractFileName(sPath))) or (S = extractFileName(sPath)) or
        (S = sPath) then
      begin
        Result := True;
        break;
      end;
    end;
  end;

  function SkipFolder(const sPath : string) : Boolean;
  var
    fName : string;
  begin
    fName := IncludeTrailingPathDelimiter(sPath);
    Result := (SkipFolders.IndexOf(fName) <> - 1);
  end;

var
  SearchRec : TSearchRec;
  S, sLog : string;
  bDoSkipFiles : Boolean;
  Value : TFoundFileValues;
begin
  // Verzeichniss nach Dateien durchsuchen
  if Files = nil then
  begin
    Files := TFoundFilesList.Create;
  end;
  if Folders = nil then
  begin
    Folders := THashedStringList.Create;
    Folders.Duplicates := dupIgnore;
  end;
  bDoSkipFiles := (SkipFiles.Count >= 1);
  Result := True;
  if bRecurse or not SkipFolder(sDirectory) then
  begin
{$WARNINGS OFF}
    if FindFirst(SlashSep(sDirectory, sFileMask), faAnyFile and not faDirectory and not faVolumeID, SearchRec) = 0 then
{$WARNINGS ON}
    begin
      if not Terminated then
      begin
        try
          Result := (iSearchMode = smSource);
          repeat
            S := SlashSep(sDirectory, SearchRec.Name);
            if not bDoSkipFiles or not SkipFile(S) then
            begin
              sLog := LogFile.Write('LogStrings', 'SearchFilesFound', [S]);
              sStatusbarText^ := sLog;
              Value.sFileName := S;
              Value.iSize := SearchRec.Size;
              Value.iTime := SearchRec.Time;
              Value.iAttributes := SearchRec.Attr;
              Files.Add(S, Value);
              case iSearchMode of
                smSource :
                  begin
                    PF.TotalFilesCount := PF.TotalFilesCount + 1;
                    PF.TotalFilesSize := PF.TotalFilesSize + Value.iSize;
                    PF.ActSourceDir := S;
                  end;
                smDestination :
                  begin
                    PF.TotalFilesCount2 := PF.TotalFilesCount2 + 1;
                    PF.TotalFilesSize2 := PF.TotalFilesSize2 + Value.iSize;
                    PF.ActDestDir := S;
                  end;
              end;
            end;
          until (FindNext(SearchRec) <> 0) or Terminated;
        finally
          SysUtils.FindClose(SearchRec);
        end;
      end;
    end
    else
    begin
      if GetLastError <> 18 then
      begin
        bError := True;
        sLog := LogFile.Write('LogStrings', 'SearchFilesError', [sDirectory, SysErrorMessage(GetLastError)]);
        Log(sLog, ErrorsList);
        sStatusbarText^ := sLog;
      end;
    end;
  end;

  if bSubFolders and not Terminated then
  begin
    // Unterordner suchen
    if FindFirst(SlashSep(sDirectory, '*.*'), faAnyFile, SearchRec) = 0 then
    begin
      try
        repeat
          if (SearchRec.Attr and faDirectory) <> 0 then
          begin
            S := SlashSep(sDirectory, SearchRec.Name);
            if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and not SkipFolder(S) then
            begin
              Result := GetFiles(S, Files, Folders, LogFile, ErrorsList, SkipFiles, SkipFolders, bError, sFileMask,
                bSubFolders, True) and Result;
            end;
          end;
        until FindNext(SearchRec) <> 0;
      finally
        SysUtils.FindClose(SearchRec);
      end;
    end;
  end;

  if Result then
  begin
    Folders.Add(sDirectory);
  end;
end;

procedure TtSearchFiles.HashFiles(var Files : TFoundFilesList; var LogFile : TLogFile; var ErrorsList : TStringList;
  var bError : Boolean);
var
  sHash, sLog : string;
  P : IDECProgress;
  Value, NewValue : TFoundFileValues;
begin
  // Hashen
  sLog := LogFile.Write('LogStrings', 'Hashing');
  sStatusbarText^ := sLog;
  P := TProgress.Create(PF, iSearchMode);
  // for i := 0 to Files[0].Count - 1 do
  // begin
  // Files[1].Add('');
  // end;

  for Value in Files.Values do
  begin
    case iSearchMode of
      smSource :
        begin
          PF.DoneFilesCount := PF.DoneFilesCount + 1;
          PF.ActSourceDir := Value.sFileName;
        end;
      smDestination :
        begin
          PF.DoneFilesCount2 := PF.DoneFilesCount2 + 1;
          PF.ActDestDir := Value.sFileName;
        end;
    end;
    if Value.sFileName <> '' then
    begin
      // nicht leer: Hashen
      try
        // Versuche Hash zu ziehen
        if not Terminated then
        begin
          sLog := LogFile.Write('LogStrings', 'HashingFile', [Value.sFileName]);
          sStatusbarText^ := sLog;
          sHash := THash_MD4.CalcFile(Value.sFileName, TFormat_HEX, P);
        end
        else
        begin
          break;
        end;
      except
        // Hashen fehlgeschlagen: sHash löschen
        sHash := '';
      end;
      if sHash <> '' then
      begin
        // Hashen erfolgreich: in Liste schreiben
        NewValue := Value;
        NewValue.sHash := sHash;
        Files.Items[Value.sFileName] := NewValue;
      end
      else
      begin
        // Hashen fehlgeschlagen: in Logfile schreiben
        NewValue := Value;
        NewValue.sHash := '';
        Files.Items[Value.sFileName] := NewValue;
        bError := True;
        sLog := LogFile.Write('LogStrings', 'HashingError', [Value.sFileName, SysErrorMessage(GetLastError)]);
        Log(sLog, ErrorsList);
        sStatusbarText^ := sLog;
        case iSearchMode of
          smSource :
            PF.TotalFilesSize := PF.TotalFilesSize - Value.iSize;
          smDestination :
            PF.TotalFilesSize2 := PF.TotalFilesSize2 - Value.iSize;
        end;
        // Files[0].Delete(i);
        // Files[1].Delete(i)
      end;
    end
    else
    begin
      // leer:
      NewValue := Value;
      NewValue.sHash := '';
      Files.Items[Value.sFileName] := NewValue;
      // Files[0].Delete(i);
      // Files[1].Delete(i);
    end;
  end;
  sLog := LogFile.Write('LogStrings', 'HashingEnd');
  sStatusbarText^ := sLog;
end;

procedure TtSearchFiles.Execute;
var
  sFileMasks : TStringDynArray;
  i : Integer;
  sLog : string;
begin
  sDir := IncludeTrailingPathDelimiter(sDir);
  sSource := IncludeTrailingPathDelimiter(TreeData^.sSourceC);
  if iSearchMode = smSource then
  begin
    PF.State := bsSearch;
  end;
  sLog := LogFile.Write('LogStrings', 'SearchFiles');
  sStatusbarText^ := sLog;
  sFileMasks := Explode(';', TreeData^.sFileMask);
  for i := low(sFileMasks) to high(sFileMasks) do
  begin
    GetFiles(sDir, FileList^, FolderList^, LogFile^, TreeData^.JobErrors, TreeData^.SkipFiles, TreeData^.SkipFolders,
      bError^, sFileMasks[i], TreeData^.bSubFolders);
  end;
  sLog := LogFile.Write('LogStrings', 'SearchFilesEnd');
  sStatusbarText^ := sLog;
  if TreeData^.CompareMode = cmHash then
  begin
    PF.HashCounter := PF.HashCounter + 1;
    PF.State := bsHash;
    HashFiles(FileList^, LogFile^, TreeData^.JobErrors, bError^);
  end;
end;

end.
