unit tFileOperation;

interface

{$INCLUDE Compilerswitches.inc}

uses
  Classes,
  Windows,
  SysUtils,
  tSortFiles,
  VTreeHelper,
  ProgressDialog,
  csLogCls,
  csUtils;

type
  PTStringList = ^TStringList;

  TtFileOperation = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure OperateFiles(const CopyFiles : TSortedFilesList; const MoveFiles : TSortedFilesList;
      const DeleteFiles : TSortedFilesList; const DeleteDirs : TStringList; var LogFile : TLogFile;
      var ErrorsList : TStringList; var bError : boolean; const bDeleteFiles : boolean;
      const bDoNotCopyFlags : boolean);
    function FastFileCopy(const InFileName, OutFileName : string; InFileSize : Int64; InFileDate : integer) : integer;
  public
    CopyFiles : PSortedFilesList;
    MoveFiles : PSortedFilesList;
    DeleteFiles : PSortedFilesList;
    DeleteDirs : PTStringList;
    LogFile : PLogFile;
    TreeData : PTreeData;
    ErrorsList : PTStringList;
    sStatusbarText : Pstring;
    bDeleteFiles : boolean;
    bDoNotCopyFlags : boolean;
    bError : Pboolean;
    PF : TProgressForm;
  end;

implementation

uses
  MainFrame;
{ tFileOperation }

/// ///////////////////////////FastFileCopy//////////////////////////////////////
// Autor: Thomas Stutz
/// /////////////////////////////////////////////////////////////////////////////

function TtFileOperation.FastFileCopy(const InFileName, OutFileName : string; InFileSize : Int64; InFileDate : integer)
  : integer;
{$I-}
const
  BufSize = 49152;
  // 49152; {3 * 4 * 4096 48Kbytes gives me the best results }
type
  PBuffer = ^TBuffer;
  TBuffer = array [1 .. BufSize] of Byte;
var
  Size : DWORD;
  Buffer : PBuffer;
  infile, outfile : file;
  iSizeDone, iDummi, iFreeSpace : Int64;
  s : string;
begin
  iSizeDone := - 1;
  result := 5;
  if GetDiskFreeSpaceEx(PChar(ExtractFileDir(OutFileName)), iFreeSpace, iDummi, @iDummi) then
  begin
    if InFileSize > iFreeSpace then
    begin
      result := 112;
    end;
  end;
  if InFileName = OutFileName then
  begin
    result := 32;
    Exit;
  end;
  if result <> 112 then
  begin
    s := ChangeFileExt(OutFileName, '.bck');
    if FileExists(OutFileName) and not RenameFile(OutFileName, s) then
    begin
      result := GetLastError;
      Exit;
    end;
    Buffer := nil;
    try
      Assign(infile, InFileName);
      filemode := fmOpenRead;
      Reset(infile, 1);
      result := IOResult;
      if result <> 0 then
      begin
        if result < 5 then
        begin
          result := 2;
        end
        else
        begin
          result := 5;
        end;
        Exit;
      end;
      filemode := fmOpenReadWrite;
      if result = 0 then
      begin
        try
          Assign(outfile, OutFileName);
          Rewrite(outfile, 1);
          iSizeDone := 0;
          New(Buffer);
          repeat
            result := IOResult;
            if result <> 0 then
            begin
              if result < 5 then
              begin

                result := 2;
              end
              else
              begin
                result := 5;
              end;
              break;
            end;
            filemode := fmOpenRead;
            BlockRead(infile, Buffer^, BufSize, Size);
            result := IOResult;
            if result <> 0 then
            begin
              if result < 5 then
              begin
                result := 2;
              end
              else
              begin
                result := 5;
              end;
              break;
            end;
            filemode := fmOpenReadWrite;
            Inc(iSizeDone, Size);
            PF.FileSize := InFileSize;
            PF.FileSizeDone := iSizeDone;
            BlockWrite(outfile, Buffer^, Size);
            result := IOResult;
            if result <> 0 then
            begin
              // OutputDebugString(PChar(InFileName +  ' (' + inttostr(result) + ')'));
              if result < 5 then
              begin
                result := 2;
              end
              else
              begin
                result := 5;
              end;
              break;
            end;
          until Size < BufSize;
{$WARNINGS OFF}
          if result = 0 then
          begin
            // iDateTime := FileGetDate(TFileRec(infile).Handle);
            // CodeSite.SendFmtMsg('Datum: %d',[iDateTime]);
            FileSetDate(TFileRec(outfile).Handle, InFileDate);
          end;
{$WARNINGS ON}
        finally
          if Buffer <> nil then
            Dispose(Buffer);
          CloseFile(outfile);
        end;
      end
      else
      begin
        // OutputDebugString(PChar(InFileName +  ' (' + inttostr(result) + ')'));
        if result < 5 then
        begin
          result := 2;
        end
        else
        begin
          result := 5;
        end;
      end;
    finally
      CloseFile(infile);
    end;
    if result = 0 then
    begin
      result := InFileSize - iSizeDone;
      if result <> 0 then
      begin
        if FileExists(ChangeFileExt(OutFileName, '.bck')) then
        begin
          DeleteFile(OutFileName);
          RenameFile(ChangeFileExt(OutFileName, '.bck'), OutFileName)
        end;
        result := 5;
      end
      else
      begin
        DeleteFile(ChangeFileExt(OutFileName, '.bck'));
      end;
    end
    else
    begin
      if FileExists(ChangeFileExt(OutFileName, '.bck')) then
      begin
        RenameFile(ChangeFileExt(OutFileName, '.bck'), OutFileName)
      end;
    end;
  end;
{$I+}
end;

procedure TtFileOperation.OperateFiles(const CopyFiles : TSortedFilesList; const MoveFiles : TSortedFilesList;
  const DeleteFiles : TSortedFilesList; const DeleteDirs : TStringList; var LogFile : TLogFile;
  var ErrorsList : TStringList; var bError : boolean; const bDeleteFiles : boolean; const bDoNotCopyFlags : boolean);
var
  i, iCopyResult, iSourceFileAttr : integer;
  sLog, sTemp, sLastErrorFolder : string;
  Value : TSortedFileValues;
begin
  // Dateien kopieren
  sLog := LogFile.Write('LogStrings', 'Copy');
  sStatusbarText^ := sLog;
  if CopyFiles <> nil then
  begin
    PF.State := bsOpCopy;
    for Value in CopyFiles do
    begin
      if not Value.bSkip then
      begin
        PF.DoneFilesCount2 := PF.DoneFilesCount2 + 1;
        PF.ActSourceDir := Value.sSourceFileName;
        PF.ActDestDir := Value.sDestFileName;
        if not Terminated then
        begin
          sLog := LogFile.Write('LogStrings', 'Copying', [Value.sSourceFileName, Value.sDestFileName]);
          sStatusbarText^ := sLog;
          if (sLastErrorFolder = '') or (ExtractFilePath(Value.sDestFileName) <> sLastErrorFolder) then
          begin

            if not CreateDirectoryRecurse(ExtractFilePath(Value.sSourceFileName),
              ExtractFilePath(Value.sDestFileName), nil) then
            begin
              bError := true;
              sLastErrorFolder := ExtractFilePath(Value.sDestFileName);
              sLog := LogFile.Write('LogStrings', 'ErrorCreatingDir', [ExtractFilePath(Value.sDestFileName),
                SysErrorMessage(GetLastError)]);
              Log(sLog, ErrorsList);
              sStatusbarText^ := sLog;
              if ExcludeTrailingPathDelimiter(sLastErrorFolder) = TreeData^.sDestC then
              begin
                break;
              end;
            end
            else
            begin
{$WARNINGS OFF}
              iSourceFileAttr := FileGetAttr(Value.sSourceFileName);
              FileSetAttr(Value.sDestFileName, FileGetAttr(Value.sDestFileName) and not faReadOnly);
              FileSetAttr(Value.sDestFileName, FileGetAttr(Value.sDestFileName) and not faSysFile);
              FileSetAttr(Value.sDestFileName, FileGetAttr(Value.sDestFileName) and not faHidden);
              FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faSysFile);
              FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faHidden);
              iCopyResult := FastFileCopy(Value.sSourceFileName, Value.sDestFileName, Value.iSize, Value.iTime);
              if iCopyResult = 0 then
              begin
                if not bDoNotCopyFlags then
                begin
                  FileSetAttr(Value.sDestFileName, iSourceFileAttr);
                end;
                if TreeData^.CompareMode = cmArchive then
                begin
                  FileSetAttr(Value.sSourceFileName, iSourceFileAttr and not faArchive);
                end
                else
                begin
                  FileSetAttr(Value.sSourceFileName, iSourceFileAttr);
                end;
              end;
{$WARNINGS ON}
              if (iCopyResult <> 0) then
              begin
                bError := true;
                sLog := LogFile.Write('LogStrings', 'ErrorCopying', [Value.sSourceFileName, Value.sDestFileName,
                  SysErrorMessage(iCopyResult)]);
                Log(sLog, ErrorsList);
                sStatusbarText^ := sLog;
              end;
            end;
          end;
        end
        else
        begin
          break;
        end;
      end;
    end;
  end
  else
  begin
    bError := true;
    sLog := LogFile.Write('LogStrings', 'ErrorCopyingListEmpty');
    Log(sLog, ErrorsList);
    sStatusbarText^ := sLog;
  end;
  LogFile.Write('LogStrings', 'CopyEnd');
  if bDeleteFiles then // Dateien löschen?
  begin
    // Dateien verschieben
    PF.State := bsOpMove;
    sLastErrorFolder := '';
    sLog := LogFile.Write('LogStrings', 'Move');
    sStatusbarText^ := sLog;
    if MoveFiles <> nil then
    begin
      for Value in MoveFiles do
      begin
        PF.DoneFilesCount2 := PF.DoneFilesCount2 + 1;
        PF.ActSourceDir := Value.sSourceFileName;
        PF.ActDestDir := Value.sDestFileName;
        if not Terminated then
        begin
          sLog := LogFile.Write('LogStrings', 'Moving', [Value.sSourceFileName, Value.sDestFileName]);
          sStatusbarText^ := sLog;
          if (sLastErrorFolder = '') or (ExtractFilePath(Value.sDestFileName) <> sLastErrorFolder) then
          begin
            if not CreateDirectoryRecurse(ExtractFilePath(Value.sSourceFileName),
              ExtractFilePath(Value.sDestFileName), nil) then
            begin
              bError := true;
              sLastErrorFolder := ExtractFilePath(Value.sDestFileName);
              sLog := LogFile.Write('LogStrings', 'ErrorCreatingDir', [ExtractFilePath(Value.sDestFileName),
                SysErrorMessage(GetLastError)]);
              Log(sLog, ErrorsList);
              sStatusbarText^ := sLog;
              if ExcludeTrailingPathDelimiter(sLastErrorFolder) = TreeData^.sDestC then
              begin
                break;
              end;
            end
            else
            begin
{$WARNINGS OFF}
              iSourceFileAttr := FileGetAttr(Value.sSourceFileName);
              FileSetAttr(Value.sDestFileName, FileGetAttr(Value.sDestFileName) and not faReadOnly);
              FileSetAttr(Value.sDestFileName, FileGetAttr(Value.sDestFileName) and not faSysFile);
              FileSetAttr(Value.sDestFileName, FileGetAttr(Value.sDestFileName) and not faHidden);
              FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faReadOnly);
              FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faSysFile);
              FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faHidden);
{$WARNINGS ON}
              PF.DoneFilesSize := PF.DoneFilesSize + Value.iSize;
              if FileExists(Value.sDestFileName) and not RenameFile(Value.sDestFileName,
                ChangeFileExt(Value.sDestFileName, '.bck')) then
              begin
                bError := true;
                sLog := LogFile.Write('LogStrings', 'ErrorMoving', [Value.sSourceFileName, Value.sDestFileName,
                  SysErrorMessage(GetLastError)]);
                Log(sLog, ErrorsList);
                sStatusbarText^ := sLog;
              end
              else
              begin
                if not MoveFile(PChar(Value.sSourceFileName), PChar(Value.sDestFileName)) then
                begin
                  bError := true;
                  sLog := LogFile.Write('LogStrings', 'ErrorMoving', [Value.sSourceFileName, Value.sDestFileName,
                    SysErrorMessage(GetLastError)]);
                  Log(sLog, ErrorsList);
                  sStatusbarText^ := sLog;
                  if FileExists(ChangeFileExt(Value.sDestFileName, '.bck')) then
                  begin
                    RenameFile(ChangeFileExt(Value.sDestFileName, '.bck'), Value.sDestFileName)
                  end;
                end
                else
                begin
{$WARNINGS OFF}
                  if not bDoNotCopyFlags then
                  begin
                    FileSetAttr(Value.sDestFileName, iSourceFileAttr);
                  end;
                  if TreeData^.CompareMode = cmArchive then
                  begin
                    FileSetAttr(Value.sManipulateFileName, FileGetAttr(Value.sManipulateFileName) and not faArchive);
                  end;
{$WARNINGS ON}
                  if FileExists(ChangeFileExt(Value.sDestFileName, '.bck')) then
                  begin
                    DeleteFile(ChangeFileExt(Value.sDestFileName, '.bck'));
                  end;
                end;
              end;
            end;
          end;
        end
        else
        begin
          break;
        end;
      end;
    end
    else
    begin
      bError := true;
      sLog := LogFile.Write('LogStrings', 'ErrorMovingListEmpty');
      Log(sLog, ErrorsList);
      sStatusbarText^ := sLog;
    end;
    LogFile.Write('LogStrings', 'MoveEnd');
    // Dateien löschen
    PF.State := bsOpDelFile;
    sLog := LogFile.Write('LogStrings', 'Delete');
    sStatusbarText^ := sLog;
    if DeleteFiles <> nil then
    begin
      for Value in DeleteFiles do
      begin
        if not Value.bSkip then
        begin
          PF.DoneFilesCount2 := PF.DoneFilesCount2 + 1;
          PF.ActSourceDir := Value.sSourceFileName;
          if not Terminated then
          begin
            sLog := LogFile.Write('LogStrings', 'Deleting', [Value.sSourceFileName]);
            sStatusbarText^ := sLog;
{$WARNINGS OFF}
            FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faReadOnly);
            FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faSysFile);
            FileSetAttr(Value.sSourceFileName, FileGetAttr(Value.sSourceFileName) and not faHidden);
{$WARNINGS ON}
            PF.DoneFilesSize := PF.DoneFilesSize + Value.iSize;
            if not DeleteFile(Value.sSourceFileName) then
            begin
              bError := true;
              sLog := LogFile.Write('LogStrings', 'ErrorDelting',
                [Value.sSourceFileName, SysErrorMessage(GetLastError)]);
              Log(sLog, ErrorsList);
              sStatusbarText^ := sLog;
            end;
          end
          else
          begin
            break;
          end;
        end;
      end;
    end
    else
    begin
      bError := true;
      sLog := LogFile.Write('LogStrings', 'ErrorDeletingListEmpty');
      Log(sLog, ErrorsList);
      sStatusbarText^ := sLog;
    end;
    LogFile.Write('LogStrings', 'DeleteEnd');
    // Verzeichnisse löschen
    PF.State := bsOpDelDir;
    sLog := LogFile.Write('LogStrings', 'DeleteDirs');
    sStatusbarText^ := sLog;
    if DeleteDirs <> nil then
    begin
      for i := DeleteDirs.Count - 1 downto 0 do
      begin
        sTemp := DeleteDirs.Strings[i];
        PF.DoneFilesCount2 := PF.DoneFilesCount2 + 1;
        PF.ActSourceDir := sTemp;
        if not Terminated then
        begin
          sLog := LogFile.Write('LogStrings', 'DeltingDirs', [sTemp]);
          sStatusbarText^ := sLog;
          if not RemoveDir(sTemp) then
          begin
            bError := true;
            sLog := LogFile.Write('LogStrings', 'ErrorDeltingDirs', [sTemp, SysErrorMessage(GetLastError)]);
            Log(sLog, ErrorsList);
            sStatusbarText^ := sLog;
          end
        end
        else
        begin
          break;
        end;
      end;
    end
    else
    begin
      bError := true;
      LogFile.Write('LogStrings', 'ErrorDeleteDirsListEmpty');
      Log(sLog, ErrorsList);
      sStatusbarText^ := sLog;
    end;
    LogFile.Write('LogStrings', 'DeleteDirsEnd');
  end;
  sLastErrorFolder := '';
end;

procedure TtFileOperation.Execute;
begin
  MainForm.DestThread.WaitFor;
  MainForm.SourceThread.WaitFor;
  MainForm.SortThread.WaitFor;
  if not Terminated then
  begin
    OperateFiles(CopyFiles^, MoveFiles^, DeleteFiles^, DeleteDirs^, LogFile^, ErrorsList^, bError^, bDeleteFiles,
      bDoNotCopyFlags);
  end;
end;

end.
