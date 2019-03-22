(******************************************************************************
                                 _\\|//_
                                (` * * ')
 ______________________________ooO_(_)_Ooo_____________________________________
 ******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***               Copyright (c) 2007 by C.Schoch                           ***
 ***                                                                        ***
 ***   File:       tDirWatch.pas                                            ***
 ***   Version:    2.0                                                      ***
 ***                                                                        ***
 ***   Autor:      C.Schoch                                                 ***
 ***               C.Schoch@web.de                                          ***
 ***               ICQ: 335208821                                           ***
 ***                                                                        ***
 ***   Function:  Watching directories for changes                           ***
 ***                                                                        ***
 ***   Version  Date        Description                                     ***
 ***   -------  ----------  ----------------------------------------------- ***
 ***   1.0      2007-07-10  First release                                   ***
 ***   1.1      2007-07-25  Fixed Exception on exiting DirWatch             ***
 ***   2.0      2007-08-30  Complete rewritten to use new System to fix     ***
 ***                        hanging up sometimes                            ***
 ***                                                                        ***
 ******************************************************************************
 ******************************************************************************
                             .oooO     Oooo.
 ____________________________(   )_____(   )___________________________________
                              \ (       ) /
                               \_)     (_/

******************************************************************************)

unit tDirWatch;
interface
{$INCLUDE Compilerswitches.inc}

uses
  Classes,
  Windows,
  SysUtils,
  csExplode,
  csUtils,
  VTreeHelper;

type
  PFILE_NOTIFY_INFORMATION = ^FILE_NOTIFY_INFORMATION;
  FILE_NOTIFY_INFORMATION = record
    dwNextEntryOffset : DWORD;
    dwAction : DWORD;
    dwFileNameLength : DWORD;
    FileName : array[1..(MAX_PATH * 2) shr 1] of WCHAR;
  end;
  TWatchData = record
    iArrayIndex : integer;
    sActDir : string;
    Data : TOverlapped;
    hFile : THandle;
    pBuffer : Pointer;
  end;
  TtDirWatch = class(TThread)
  private
    d : TStringDivider;
    aTreeData : array of PTreeData;
    fBreakEvent : THandle;
    aWatchData : array[0..2048] of TWatchData;
  public
    procedure AddWatchNode(Data : PTreeData; sRootName : string);
    procedure Terminate;
  protected
    procedure Execute; override;
  end;

implementation
uses MainFrame;
{ TDirWatch }

const
  fNotifyFilters = FILE_NOTIFY_CHANGE_FILE_NAME
    or FILE_NOTIFY_CHANGE_DIR_NAME
    or FILE_NOTIFY_CHANGE_ATTRIBUTES
    or FILE_NOTIFY_CHANGE_SIZE
    or FILE_NOTIFY_CHANGE_LAST_WRITE
    or FILE_NOTIFY_CHANGE_CREATION
    {or FILE_NOTIFY_CHANGE_SECURITY};

  FILE_LIST_DIRECTORY = $0001;

procedure TtDirWatch.AddWatchNode(Data : PTreeData; sRootName : string);
var
  sNetworkPath : csExplode.TStringDynArray;
begin
  if Data <> nil then
  begin
    if d = nil then
    begin
      d := TStringDivider.Create;
      d.Pattern := '|';
    end;
    Data^.sSourceC := Data^.sSource;
    Data^.sDestC := Data^.sDest;
    if IsNetworkPath(Data^.sSource) then // beim Quellnetzlaufwerk anmelden
    begin
      d.Explode(Data^.sSourceC, sNetworkPath);
      Data^.sSourceC := GetFreeDriveLetter + ':\';
      if d.Count > 1 then
      begin
        if sNetworkPath[1][1] = '\' then
        begin
          Data^.sSourceC := ExcludeTrailingPathDelimiter(Data^.sSourceC);
        end;
        Data^.sSourceC := Data^.sSourceC + sNetworkPath[1];
      end;
      if Data^.bEnableNetworkLogon then
      begin
        ConnectToNetworkDriveW(ExtractFileDrive(Data^.sSourceC), sNetworkPath[0],
          Data^.sUsername, MainForm.DecryptPW(Data^.sPassword, sRootName + Data^.sName));
      end
      else
      begin
        ConnectToNetworkDriveW(ExtractFileDrive(Data^.sSourceC), sNetworkPath[0]);
      end;
    end;
    if IsNetworkPath(Data^.sDest) then // beim Zielnetzlaufwerk anmelden
    begin
      d.Explode(Data^.sDestC, sNetworkPath);
      Data^.sDestC := GetFreeDriveLetter + ':\';
      if d.Count > 1 then
      begin
        if sNetworkPath[1][1] = '\' then
        begin
          Data^.sDestC := ExcludeTrailingPathDelimiter(Data^.sDestC);
        end;
        Data^.sDestC := Data^.sDestC + sNetworkPath[1];
      end;
      if Data^.bEnableNetworkLogon then
      begin
        ConnectToNetworkDriveW(ExtractFileDrive(Data^.sDestC), sNetworkPath[0],
          Data^.sUsername, MainForm.DecryptPW(Data^.sPassword, sRootName + Data^.sName));
      end
      else
      begin
        ConnectToNetworkDriveW(ExtractFileDrive(Data^.sDestC), sNetworkPath[0]);
      end;
    end;
    if DirectoryExists(Data^.sSourceC) then
    begin
      SetLength(aTreeData, length(aTreeData) + 1);
      aTreeData[high(aTreeData)] := Data;
    end;
    FreeAndNil(d);
  end;
end;

procedure TtDirWatch.Terminate;
begin
  inherited Terminate;
  SetEvent(fBreakEvent);
  FreeAndNil(d);
end;

procedure TtDirWatch.Execute;

  function SkipFile(const sPath : string; TreeData : PTreeData) : boolean;
  var
    s : string;
    i : integer;
  begin
    result := false;
    for i := 0 to TreeData^.SkipFiles.Count - 1 do
    begin
      s := TreeData^.SkipFiles.Strings[i];
      if (s = extractfileext(sPath)) or (s = CutExtension(extractFileName(sPath))) or (s =
        extractfilename(sPath)) or (s = sPath) then
      begin
        result := true;
        break;
      end;
    end;
  end;

  function SkipFolder(const sPath, sDir : string; TreeData : PTreeData) : boolean;
  var
    fName : string;
  begin
    fName := TreeData^.sSourceC + CutStartDir(sPath, sDir);
    fName := IncludeTrailingPathDelimiter(fName);
    result := (TreeData^.SkipFolders.IndexOf(fName) <> -1);
  end;

  procedure Callback(dwErrorCode, dwNumberOfBytesTransfered : DWORD; pOverlapped :  // Dummy Funktion für ReadDirectoryChangesW
    POverlapped);
  begin
    nop;
  end;

var
  dwWaitResult, dwBufLen, dwRead : DWORD;
  i, j, iActIndex : integer;
  bDoSkipFiles, bDoSkipFolders, bWatchOverflow : boolean;
  sActDir, sChangedFile, sChangedDir : string;
  FNI : FILE_NOTIFY_INFORMATION;
  pWork : Pointer;
  hFile : THandle;
  Stamp, Current : TTimeStamp;
begin
  try
    fBreakEvent := windows.CreateEvent(nil, False, False, nil); // Abbruchevent estellen
    dwBufLen := 65536;
    if length(aTreeData) = 0 then
    begin
      Terminate;
    end;
    j := 0;
    bWatchOverflow := false;
    for i := 0 to high(aTreeData) do // durch Überwachungsjobs gehen
    begin
      aWatchData[j].pBuffer := AllocMem(dwBufLen);
      hFile := CreateFile(PChar(aTreeData[i].sSourceC), GENERIC_READ or FILE_LIST_DIRECTORY,  // Handle zur Quelle holen
        FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE, nil, OPEN_EXISTING,
        FILE_FLAG_BACKUP_SEMANTICS or FILE_FLAG_OVERLAPPED, 0);
      if (hFile <> 0) and (hFile <> INVALID_HANDLE_VALUE) then
      begin
        ZeroMemory(aWatchData[j].pBuffer, dwBufLen);
        aWatchData[j].Data.hEvent := j;
        aWatchData[j].hFile := hFile;
        aWatchData[j].iArrayIndex := i;
        aWatchData[j].sActDir := aTreeData[i].sSourceC;
        ReadDirectoryChangesW(hFile, aWatchData[j].pBuffer, dwBufLen, aTreeData[i]^.bSubFolders,  // Überwachung der Quelle initialisieren
          fNotifyFilters, @dwRead, @aWatchData[j].Data, @Callback);
      end;
      inc(j);
      if DirectoryExists(aTreeData[i].sDestC) then
      begin
        dwBufLen := 65536;
        aWatchData[j].pBuffer := AllocMem(dwBufLen);
        hFile := CreateFile(PChar(aTreeData[i].sSourceC), GENERIC_READ or FILE_LIST_DIRECTORY,  // Handle zum Ziel holen
          FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE, nil, OPEN_EXISTING,
          FILE_FLAG_BACKUP_SEMANTICS or FILE_FLAG_OVERLAPPED, 0);
        if (hFile <> 0) and (hFile <> INVALID_HANDLE_VALUE) then
        begin
          ZeroMemory(aWatchData[j].pBuffer, dwBufLen);
          aWatchData[j].Data.hEvent := j;
          aWatchData[j].hFile := hFile;
          aWatchData[j].iArrayIndex := i;
          aWatchData[j].sActDir := aTreeData[i].sDestC;
          ReadDirectoryChangesW(hFile, aWatchData[j].pBuffer, dwBufLen, aTreeData[i]^.bSubFolders,  // Überwachung des Ziels initialisieren
            fNotifyFilters, @dwRead, @aWatchData[j].Data, @Callback);
        end;
      end;
      inc(j);
      if j >= 2048 then
      begin
        bWatchOverflow := true;
        break;
      end;
    end;
    repeat
      dwWaitResult := WaitForSingleObject(fBreakEvent, 10);
      if dwWaitResult = Wait_Timeout then
      begin
        for i := 0 to (length(aTreeData) * 2 - 1) do // Alle Überwachungen prüfen
        begin
          if aWatchData[i].hFile <> 0 then
          begin
            if GetOverlappedResult(aWatchData[i].hFile, aWatchData[i].Data, dwRead,
              false) then // Änderung vorhanden?
            begin
              iActIndex := aWatchData[i].iArrayIndex;
              if not aTreeData[iActIndex]^.bChanged then // schon eine Änderung signalisiert?
              begin
                sActDir := aWatchData[i].sActDir;
                Current := DateTimeToTimeStamp(Now);
                Stamp := Current;
                if sActDir = aTreeData[iActIndex]^.sDestC then
                begin
                  Stamp := DateTimeToTimeStamp(aTreeData[iActIndex]^.LastRun);
                  inc(Stamp.Time, 10 * 1000);
                end;
                if (Current.Time >= Stamp.Time) and (Current.Date >= Stamp.Date) then
                begin
                  bDoSkipFiles := (aTreeData[iActIndex]^.SkipFiles.Count >= 1);
                  bDoSkipFolders := (aTreeData[iActIndex]^.SkipFolders.Count >= 1);
                  pWork := aWatchData[i].pBuffer;
                  repeat
                    ZeroMemory(@FNI, SizeOf(FNI));
                    CopyMemory(@FNI, pWork, dwRead);
                    sChangedFile := trim(WideCharLenToString(@FNI.FileName[1],
                      FNI.dwFileNameLength));
                    PChar(pWork) := PChar(pWork) + FNI.dwNextEntryOffset;
                    sChangedFile := IncludeTrailingPathDelimiter(sActDir) + sChangedFile;
                    if CutExtension(sChangedFile) <> sChangedFile then // Ist sChangedFile ein Ordner?
                    begin
                      sChangedDir := IncludeTrailingPathDelimiter(ExtractFilePath(sChangedFile));
                    end
                    else
                    begin
                      sChangedDir := IncludeTrailingPathDelimiter(sChangedFile);
                    end;
                    if (not bDoSkipFolders or not SkipFolder(sChangedDir, sActDir,
                      aTreeData[iActIndex])) then
                    begin
                      if (not bDoSkipFiles or not SkipFile(sChangedFile, aTreeData[iActIndex])) then
                      begin
                        //OutputDebugString(PChar(sChangedFile + ' Grund: ' + IntToStr(FNI.dwAction)));
                        aTreeData[iActIndex]^.bChanged := true;
                        break;
                      end;
                    end;
                  until ((FNI.dwNextEntryOffset = 0) or Terminated);
                end;
              end;
              ZeroMemory(aWatchData[i].pBuffer, dwBufLen);
              ReadDirectoryChangesW(aWatchData[i].hFile, aWatchData[i].pBuffer, dwBufLen,  // Überwachung erneut anstoßen und somit alte Änderung ablöschen
                aTreeData[iActIndex]^.bSubFolders, fNotifyFilters, @dwRead, @aWatchData[i].Data,
                @Callback);
            end;
          end;
        end;
        if dwWaitResult = WAIT_FAILED then
        begin
          raise Exception.Create('Directory watch failed');
        end;
      end;
    until dwWaitResult <> Wait_Timeout;
    if bWatchOverflow then
    begin
      raise Exception.Create('Too much directorys in progress');
    end;
  finally
    CloseHandle(fBreakEvent); // Abbruchevent schließen
    for i := 0 to (length(aTreeData) * 2 - 1) do // aWatchData freigeben
    begin
      FreeMem(aWatchData[i].pBuffer);
      if WaitForSingleObject(aWatchData[i].hFile, 1) <> WAIT_FAILED then  // Abfrage ob noch verfügbar da sonst eine Exception geworfen wird
      begin
        CloseHandle(aWatchData[i].hFile);
      end;
    end;
    for i := 0 to high(aTreeData) do // aTreeData freigeben
    begin
      if aTreeData[i] <> nil then
      begin
        if aTreeData[i]^.sSource <> aTreeData[i]^.sSourceC then // Bei Quellnetzlaufwerk abmelden
        begin
          DisconnectNetworkDriveW(ExtractFileDrive(aTreeData[i]^.sSourceC));
        end;
        if aTreeData[i]^.sDest <> aTreeData[i]^.sDestC then // Bei Zielnetzlaufwerk abmelden
        begin
          DisconnectNetworkDriveW(ExtractFileDrive(aTreeData[i]^.sDestC));
        end;
        aTreeData[i]^.bChanged := false;
        aTreeData[i] := nil;
      end;
    end;
  end;
end;

end.

