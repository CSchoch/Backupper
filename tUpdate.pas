unit tUpdate;
{ TODO : Logging!! }
interface
{$Include Compilerswitches.inc}

uses
  Classes,
  SysUtils,
  idHttp,
  csLogCls,
  csUtils;

type
  PTMemoryStream = ^TMemoryStream;
  PTFileStream = ^TFileStream;
  tTUpdate = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure Update;
    procedure Check;
  public
    bUpdate, bLoadLang : boolean;
    sFilePath : string;
    LogFile : PLogFile;
    data : PTMemoryStream;
  end;

implementation
uses
  MainFrame;
{ tDoUpdate }

procedure tTUpdate.Update;
var
  idGet : TidHttp;
  data2 : TMemoryStream;
begin
  idGet := Tidhttp.Create(nil);
  data2 := TMemoryStream.Create;
  try
    idGet.Get('http://cschoch.pytalhost.de/downloads/BackupperUpdate.exe', data2);
    data2.Seek(0, soFromBeginning);
    data2.SaveToFile(sFilePath + '\BackupperUpdate.exe');
    data2.Clear;
    if bLoadLang then
    begin
      idGet.Get('http://cschoch.pytalhost.de/downloads/English.xml', data2);
      data2.Seek(0, soFromBeginning);
      data2.SaveToFile(sFilePath + '\Language\English.xml');
      data2.Clear;
      idGet.Get('http://cschoch.pytalhost.de/downloads/German.xml', data2);
      data2.Seek(0, soFromBeginning);
      data2.SaveToFile(sFilePath + '\Language\German.xml');
    end;
  finally
    FreeandNil(idGet);
    FreeandNil(data2);
  end;
end;

procedure tTUpdate.Check;
var
  idGet : TidHttp;
begin
  idGet := Tidhttp.Create(nil);
  data^ := TMemoryStream.Create;
  try
    idGet.Get('http://cschoch.pytalhost.de/downloads/Version.xml', data^);
    data^.Seek(0, soFromBeginning);
  finally
    FreeandNil(idGet);
  end;
end;

procedure tTUpdate.Execute;
begin
  if bUpdate then
  begin
    Update;
  end
  else
  begin
    Check;
  end;
end;

end.

