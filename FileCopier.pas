unit FileCopier;
//
interface
//{.$INCLUDE Compilerswitches.inc}
//
//uses
//  Classes,
//  Windows,
//  SysUtils,
//  csUtils {,
//  ProgressDialog};
//
//type
//  PBufferElem = ^TBufferElem;
//  TBufferElem = record
//    dwSize : DWORD;
//    Buff : array of Byte;
//  end;
//  PBuffer = ^TBuffer;
//  TBuffer = array[0..199] of TBufferElem;
//  TRead = class(TThread)
//  private
//    Buffer : PBuffer;
//    FiFileSize : Int64;
//    FsFileName : string;
//    FiResult : PInteger;
//    FiDeltaPos : PInteger;
//    FReadEvent : PHandle;
//    FWriteEvent : PHandle;
//    FTermEvent : PHandle;
//    FsResult : PString;
//  public
//    constructor Create(const FileName : string; const iFileSize : Int64; var iResult : Integer;
//      sResult : string; var Buf : TBuffer; var iDeltaPos : Integer; var ReadEvent, WriteEvent,
//      TermEvent : THandle);
//  protected
//    procedure Execute; override;
//    procedure DoTerminate(); override;
//  end;
//  TWrite = class(TThread)
//  private
//    Buffer : PBuffer;
//    FiResult : PInteger;
//    FsFileName : string;
//    FiFileSize : Int64;
//    FiDeltaPos : PInteger;
//    FReadEvent : PHandle;
//    FWriteEvent : PHandle;
//    FTermEvent : PHandle;
//    FsResult : PString;
//  public
//    constructor Create(const FileName : string; const iFileSize : Int64; var iResult : Integer;
//      sResult : string; var Buf : TBuffer; var iDeltaPos : Integer; var ReadEvent, WriteEvent,
//      TermEvent : THandle);
//  protected
//    procedure Execute; override;
//    procedure DoTerminate(); override;
//  end;
//  TFileCopier = class(TObject)
//  private
//    ReadThread : TRead;
//    WriteThread : TWrite;
//    FiResult : Integer;
//    FiFileSize : Int64;
//    FsResult : string;
//    Buffer : TBuffer;
//    iDeltaPos : integer;
//    ReadEvent, WriteEvent, TermEvent : THandle;
//    bReadSuspended : Boolean;
//    bWriteSuspended : Boolean;
//    sInFileName : string;
//    sOutFileName : string;
//    function GetResult : string;
//  public
//    procedure SuspendRead;
//    procedure SuspendWrite;
//    procedure RunCopy;
//    property Result : string read GetResult;
//    constructor Create(const InFileName, OutFileName : string);
//  end;
//
implementation
////uses
//  //unit2;
//{ TRead }
//
////function FastFileCopy1(const InFileName, OutFileName : string; out iResult : integer; out sResult :
////  string) : boolean;
////var
////  dwClusterSize, dwDummi : DWORD;
////  InFile, OutFile : TFileStream;
////  InBuffer, OutBuffer : array of Byte;
////  iSizeDone, iSize, iSizeFile, iOutFileSize, iDummi, iFreeSpace : int64;
////begin
////  iSizeDone := 0;
////  iSize := 0;
////  result := true;
////  InFile := nil;
////  OutFile := nil;
//
////      if not FileExists(OutFileName) then
////      begin
////        OutFile := TFileStream.Create(OutFileName, fmCreate);
////        FreeAndNil(OutFile);
////      end;
////      OutFile := TFileStream.Create(OutFileName, fmOpenReadWrite);
////      iSizeFile := InFile.Size;
////      iOutFileSize := OutFile.Size;
//
////      if (iResult <> 112) then
////      begin
////
////        OutFile.Seek(0, soFromBeginning);
////        repeat
////
////          OutFile.Read(OutBuffer[0], dwClusterSize);
////          if not CompareMem(InBuffer, OutBuffer, dwClusterSize) then
////          begin
////            OutFile.Position := iSizeDone;
////            OutFile.Write(InBuffer[0], dwClusterSize);
////          end;
//
////          ProgressForm.FileSize := iSizeFile;
////          ProgressForm.FileSizeDone := iSizeDone;
////        until iSizeDone >= iSizeFile;
/////        iResult := iSizeFile - iSizeDone;
////        if iResult <> 0 then
////        begin
////          result := false;
////          iResult := 5;
////        end;
////      end;
////    except
//
////      on E : Exception do
////      begin
////        sResult := E.Message;
////        result := false;
////      end;
////    end;
////  finally
////    FreeAndNil(InFile);
////    FreeAndNil(OutFile);
////  end;
////end;
//
//constructor TRead.Create(const FileName : string; const iFileSize : Int64; var iResult : Integer;
//  sResult : string; var Buf : TBuffer; var iDeltaPos : Integer; var ReadEvent, WriteEvent, TermEvent
//  : THandle);
//begin
//  inherited Create(true);
//  FiResult := @iResult;
//  FsResult := @sResult;
//  FsFileName := FileName;
//  Buffer := @Buf;
//  FiFileSize := iFileSize;
//  FiDeltaPos := @iDeltaPos;
//  FReadEvent := @ReadEvent;
//  FWriteEvent := @WriteEvent;
//  FTermEvent := @TermEvent;
//end;
//
//procedure TRead.DoTerminate;
//begin
//  inherited;
//  SetEvent(FTermEvent^)
//end;
//
//procedure TRead.Execute;
//var
//  iArrayPos : Integer;
//  iPos : Int64;
//  fsFile : TFileStream;
//  HandleArray : array[0..1] of THandle;
//  iWaitResult : integer;
//begin
//  iArrayPos := 0;
//  iPos := 0;
//  HandleArray[0] := FWriteEvent^;
//  HandleArray[1] := FTermEvent^;
//  try
//    try
//      Form2.sReadSuspended := 'Read Running';
//      fsFile := TFileStream.Create(FsFileName, fmOpenRead);
//      fsFile.Seek(0, soFromBeginning);
//      repeat
//        Form2.sDeltaPos := 'FiDeltaPos: ' + inttostr(FiDeltaPos^);
//        Form2.sReadArrayPos := 'Read iArrayPos: ' + inttostr(iArrayPos);
//        if FiDeltaPos^ >= High(TBuffer) then
//        begin
//          Form2.sReadSuspended := 'Read Suspended';
//          ResetEvent(FWriteEvent^);
//          iWaitResult := WaitForMultipleObjects(2, @HandleArray, false, INFINITE);
//          if iWaitResult = WAIT_OBJECT_0 + 1 then
//          begin
//            Break;
//          end;
//          //WaitForSingleObject(FWriteEvent^, INFINITE);
//          //                    While  FiDeltaPos^ >= High(TBuffer)  do
//          //          begin
//          //            Nop;
//          //          end;
//          Form2.sReadSuspended := 'Read Running';
//        end;
//        fsFile.Read(Buffer[iArrayPos].Buff[0], Buffer[iArrayPos].dwSize);
//        iPos := iPos + Buffer[iArrayPos].dwSize;
//        Inc(FiDeltaPos^);
//        Inc(iArrayPos);
//        if iArrayPos > High(TBuffer) then
//        begin
//          iArrayPos := 0;
//        end;
//        if iPos + Buffer[iArrayPos].dwSize > FiFileSize then
//        begin
//          Buffer[iArrayPos].dwSize := FiFileSize - iPos;
//          SetLength(Buffer[iArrayPos].Buff, Buffer[iArrayPos].dwSize);
//        end;
//        SetEvent(FReadEvent^);
//      until iPos >= FiFileSize;
//    except
//      on E : Exception do
//      begin
//        FsResult^ := E.Message;
//        //FiFileSize^ :=-1;
//        SetEvent(FTermEvent^);
//      end;
//    end;
//  finally
//    FreeAndNil(fsFile);
//    SetEvent(FReadEvent^);
//  end;
//end;
//
//{ TWrite }
//
//constructor TWrite.Create(const FileName : string; const iFileSize : Int64; var iResult : Integer;
//  sResult : string; var Buf : TBuffer; var iDeltaPos : Integer; var ReadEvent, WriteEvent, TermEvent
//  : THandle);
//begin
//  inherited Create(true);
//  FiResult := @iResult;
//  FsResult := @sResult;
//  FsFileName := FileName;
//  Buffer := @Buf;
//  FiFileSize := iFileSize;
//  FiDeltaPos := @iDeltaPos;
//  FReadEvent := @ReadEvent;
//  FWriteEvent := @WriteEvent;
//  FTermEvent := @TermEvent;
//end;
//
//procedure TWrite.DoTerminate;
//begin
//  inherited;
//  SetEvent(FTermEvent^)
//end;
//
//procedure TWrite.Execute;
//var
//  iArrayPos : Integer;
//  iPos : Int64;
//  fsFile : TFileStream;
//  HandleArray : array[0..1] of THandle;
//  iWaitResult : Integer;
//begin
//  iArrayPos := 0;
//  iPos := 0;
//  HandleArray[0] := FReadEvent^;
//  HandleArray[1] := FTermEvent^;
//  try
//    try
//      Form2.sWriteSuspended := 'Write Running';
//      if not FileExists(FsFileName) then
//      begin
//        fsFile := TFileStream.Create(FsFileName, fmCreate);
//        FreeAndNil(fsFile);
//      end;
//      fsFile := TFileStream.Create(FsFileName, fmOpenWrite);
//      fsFile.Seek(0, soFromBeginning);
//      repeat
//        Form2.sDeltaPos := 'FiDeltaPos: ' + inttostr(FiDeltaPos^);
//        Form2.sWriteArrayPos := 'Write iArrayPos: ' + inttostr(iArrayPos);
//        if FiDeltaPos^ <= 0 then
//        begin
//          Form2.sWriteSuspended := 'Write Suspended';
//          ResetEvent(FReadEvent^);
//          iWaitResult := WaitForMultipleObjects(2, @HandleArray, false, INFINITE);
//          if iWaitResult = WAIT_OBJECT_0 + 1 then
//          begin
//            Break;
//          end;
//          //WaitForSingleObject(FReadEvent^, INFINITE);
//         //          While  FiDeltaPos^ <= 0  do
//         //          begin
//         //            Nop;
//         //          end;
//          Form2.sWriteSuspended := 'Write Running';
//        end;
//        fsFile.Write(Buffer[iArrayPos].Buff[0], Buffer[iArrayPos].dwSize);
//        iPos := iPos + Buffer[iArrayPos].dwSize;
//        Dec(FiDeltaPos^);
//        Inc(iArrayPos);
//        if iArrayPos > High(TBuffer) then
//        begin
//          iArrayPos := 0;
//        end;
//        SetEvent(FWriteEvent^);
//        // ProgressForm.FileSizeDone := iPos;
//      until iPos >= FiFileSize;
//    except
//      on E : Exception do
//      begin
//        FsResult^ := E.Message;
//        SetEvent(FTermEvent^);
//        //FiFileSize^ := -1;
//      end;
//    end;
//  finally
//    FreeAndNil(fsFile);
//    SetEvent(FWriteEvent^);
//  end;
//end;
//
//constructor TFileCopier.Create(const InFileName, OutFileName : string);
//var
//  dwDummi, dwClusterSize : DWORD;
//  iDummi, iFreeSpace, iOutFileSize : int64;
//  i : integer;
//begin
//  inherited Create;
//  FiResult := 0;
//  FsResult := '';
//  FiFileSize := 0;
//  iDeltaPos := 0;
//  sInFileName := InFileName;
//  sOutFileName := OutFileName;
//  if (InFileName = OutFileName) then
//  begin
//    FiResult := 32;
//    exit;
//  end;
//  ReadEvent := CreateEvent(nil, False, False, PChar('ReadEvent'));
//  WriteEvent := CreateEvent(nil, False, False, PChar('WriteEvent'));
//  TermEvent := CreateEvent(nil, False, False, PChar('TermEvent'));
//  FiFileSize := GetFileSizeInt64(InFileName);
//  iOutFileSize := GetFileSizeInt64(OutFileName);
//  // ProgressForm.FileSize := FiFileSize;
//  if GetDiskFreeSpace(PChar(ExtractFileDir(OutFileName)), dwDummi, dwClusterSize, dwDummi,
//    dwDummi) then
//  begin
//    dwClusterSize := dwClusterSize * 400;
//  end
//  else
//  begin
//    dwClusterSize := 49152; {3 * 4 * 4096 48Kbytes gives me the best results }
//  end;
//  if dwClusterSize > FiFileSize then
//  begin
//    dwClusterSize := FiFileSize;
//  end;
//  for i := 0 to High(TBuffer) do
//  begin
//    SetLength(Buffer[i].Buff, dwClusterSize);
//    Buffer[i].dwSize := dwClusterSize;
//  end;
//  if GetDiskFreeSpaceEx(PChar(ExtractFileDir(OutFileName)), iFreeSpace, iDummi, @iDummi) then
//  begin
//    if FiFileSize > (iFreeSpace + iOutFileSize) then
//    begin
//      FiResult := 112;
//      Exit;
//    end;
//  end;
//  ReadThread := TRead.Create(InFileName, FiFileSize, FiResult, FsResult, Buffer, iDeltaPos,
//    ReadEvent, WriteEvent, TermEvent);
//  WriteThread := TWrite.Create(OutFileName, FiFileSize, FiResult, FsResult, Buffer, iDeltaPos,
//    ReadEvent, WriteEvent, TermEvent);
//  SetThreadAffinityMask(ReadThread.Handle, 1);
//  SetThreadAffinityMask(WriteThread.Handle, 2);
//  //  ReadThread.Resume;
//  //  WriteThread.Resume;
//  //  ReadThread.WaitFor;
//  //  WriteThread.WaitFor;
//  //  FileSetDate(OutFileName, FileAge(InFileName));
//  //  CloseHandle(ReadEvent);
//  //  CloseHandle(WriteEvent);
//  //  FreeAndNil(ReadThread);
//  //  FreeAndNil(WriteThread);
//end;
//
//function TFileCopier.GetResult : string;
//begin
//  if FiResult <> 0 then
//  begin
//    Result := SysErrorMessage(FiResult);
//  end;
//  if FiResult = 0 then
//  begin
//    Result := FsResult;
//  end;
//end;
//
//procedure TFileCopier.RunCopy;
//begin
//  if (ReadThread <> nil) and (WriteThread <> nil) then
//  begin
//    ReadThread.Resume;
//    WriteThread.Resume;
//    ReadThread.WaitFor;
//    Form2.sReadSuspended := 'Read Finished';
//    WriteThread.WaitFor;
//    Form2.sWriteSuspended := 'Write Finished';
//    FileSetDate(sOutFileName, FileAge(sInFileName));
//    CloseHandle(ReadEvent);
//    CloseHandle(WriteEvent);
//    CloseHandle(TermEvent);
//    FreeAndNil(ReadThread);
//    FreeAndNil(WriteThread);
//  end;
//end;
//
//procedure TFileCopier.SuspendRead;
//begin
//  if (ReadThread <> nil) then
//  begin
//    if bReadSuspended then
//    begin
//      ReadThread.Resume;
//      bReadSuspended := False;
//    end
//    else
//    begin
//      ReadThread.Suspend;
//      bReadSuspended := True;
//    end;
//  end;
//end;
//
//procedure TFileCopier.SuspendWrite;
//begin
//  if (WriteThread <> nil) then
//  begin
//    if bWriteSuspended then
//    begin
//      WriteThread.Resume;
//      bWriteSuspended := False;
//    end
//    else
//    begin
//      WriteThread.Suspend;
//      bWriteSuspended := True;
//    end;
//  end;
//end;
//
end.

