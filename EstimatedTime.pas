unit EstimatedTime;

interface

uses Classes,
  Windows,
  Dialogs;

type

  TTimeHist = record
    time : DWORD;
    Value : Int64;
  end;

  TEstimatedTime = class(TPersistent)
  private
    FValue : Int64;
    FMaxValue : Int64;
    FMinValue : Int64;
    FStepsPerSecond : Int64;
    FStarttime : DWORD;
    FSuspended : boolean;
    FTimeLeft : TTimeHist;
    FHistory : TTimeHist;
    FPauseTime : DWORD;

    procedure SetMaxValue(const Value : Int64);
    procedure SetMinValue(const Value : Int64);
    procedure SetValue(const Value : Int64);
    function GetElapsedTime : DWORD;
    function GetLeftTime : DWORD;
    function GetDoneRatio : Double;
    function GetDonePercent : Integer;
    function GetStepsPerSecond : int64;

  public
    constructor Create;

    procedure Start;
    procedure Suspend;
    procedure Resume;
    procedure Step(const x : Integer = 1);

    property MinValue : Int64 read FMinValue write SetMinValue;
    property MaxValue : Int64 read FMaxValue write SetMaxValue;
    property Value : Int64 read FValue write SetValue;
    property Paused : boolean read FSuspended;

    // geschätzte Restzeit (1 Tag = 1.0)
    property LeftTime : DWORD read GetLeftTime;

    // vergangene Zeit
    property ElapsedTime : DWORD read GetElapsedTime;

    // Anteil der Aufgabe, die schon erledigt ist (0.0 bis 1.0)
    property DoneRatio : Double read GetDoneRatio;
    // Erledigt n Prozent
    property DonePercent : Integer read GetDonePercent;
    property StepsPerSecond : Int64 read GetStepsPerSecond;

  end;

function UserFriendlyTime(t : DWORD) : string;



implementation

uses SysUtils;

{ TEstimatedTime }

constructor TEstimatedTime.Create;
begin
  inherited;
end;

function TEstimatedTime.GetDonePercent : Integer;
begin
  Result := Round(DoneRatio * 100.0);
end;

function TEstimatedTime.GetDoneRatio : Double;
begin
  if (MinValue < MaxValue) and (Value >= MinValue) and (Value <= MaxValue) then
    Result := (Value - MinValue) / (MaxValue - MinValue)
  else
    Result := 1;
end;

function TEstimatedTime.GetElapsedTime : DWORD;
begin
  if not FSuspended then
  begin
    Result := GetTickCount - FStarttime;
  end
  else
  begin
    Result := GetTickCount - FStarttime + (FPauseTime - GetTickCount);
  end;
end;

function TEstimatedTime.GetLeftTime : DWORD;
var
  Tick : DWORD;
begin
  //  dr := DoneRatio;
  //  if dr > 0 then
  //    Result := trunc((ElapsedTime / dr) - ElapsedTime)
  //  else
  //    Result := 0;
  Tick := GetTickCount;
  if Tick - FTimeLeft.Time >= 1000 then
  begin
    if (Value > 1) then
      //if StepsPerSecond <> 0then
    begin
      FTimeLeft.Time := Tick;
      FTimeLeft.Value := round((MaxValue - MinValue - Value) * ElapsedTime / Value);
      //FTimeLeft.Value := round((MaxValue - MinValue - Value) / StepsPerSecond) * 1000;
    end
    else
    begin
      FTimeLeft.Value := (MaxValue - MinValue - Value) * ElapsedTime;
    end;
  end;
  result := FTimeLeft.Value;
end;

function TEstimatedTime.GetStepsPerSecond : int64;
begin
  Result := FStepsPerSecond;
end;

procedure TEstimatedTime.SetMaxValue(const Value : Int64);
begin
  FMaxValue := Value;
end;

procedure TEstimatedTime.SetMinValue(const Value : Int64);
begin
  FMinValue := Value;
end;

procedure TEstimatedTime.SetValue(const Value : Int64);
var
  jetzt : DWORD;
  Buf1, Buf2 : int64;
begin
if not FSuspended then
begin
  jetzt := GetTickCount;
  Buf1 := Value - FHistory.Value;
  Buf2 := jetzt - FHistory.time;
  if Buf2 <> 0 then
  begin
    if Buf2 >= 500 then
    begin
      FStepsPerSecond := trunc(Buf1 / (Buf2 / 1000));
      FHistory.Value := Value;
      FHistory.time := jetzt;
    end;
  end
  else
  begin
    FStepsPerSecond := 0;
  end;
  FValue := Value;
end;
end;

procedure TEstimatedTime.Start;
begin
  FStarttime := GetTickCount;
  FStepsPerSecond := 0;
  FHistory.Value := FMinValue;
  FHistory.time := FStarttime;
end;

procedure TEstimatedTime.Suspend;
begin
  FSuspended := true;
  FPauseTime := GetTickCount;
end;

procedure TEstimatedTime.Resume;
begin
  FSuspended := false;
  FStarttime := FStarttime + (GetTickCount - FPauseTime);
  FHistory.time := FHistory.time + (GetTickCount - FPauseTime);
end;

procedure TEstimatedTime.Step(const x : Integer);
begin
  if FStarttime = 0.0 then
    Start;
  Value := Value + x;
end;

function UserFriendlyTime(t : DWORD) : string;
var
  days, hours, min, secs : DWord;
begin
  days := 0;
  hours := 0;
  min := 0;
  secs := 0;
  if t >= 86400000 then
  begin
    days := t div 86400000;
    t := t - days * 86400000;
  end;
  if t >= 3600000 then
  begin
    hours := t div 3600000;
    t := t - hours * 3600000;
  end;
  if t >= 60000 then
  begin
    min := t div 60000;
    t := t - min * 60000;
  end;
  if t >= 1000 then
  begin
    secs := t div 1000;
    //t := t - secs;
  end;
  //  if days > 2 then
  //    Result := Format('%dd', [days])
  //  else
  if days > 0 then
    Result := Format('%dd %dh %dmin %ds', [days, hours, min, secs])
  else
    //      if hours > 5 then
    //        Result := Format('%dh', [hours])
    //      else
    if hours > 0 then
      Result := Format('%dh %dmin %ds', [hours, min, secs])
    else
      //          if min > 5 then
      //            Result := Format('%dmin', [min])
      //          else
      if min > 0 then
        Result := Format('%dmin %ds', [min, secs])
      else
        Result := Format('%ds', [secs]);
end;

end.

