unit VTreeHelper;

interface

{$INCLUDE Compilerswitches.inc}

uses
  VirtualTrees,
  Classes,
  csProgressBarEx;

type
  TReplaceMode = (rmAll, rmInDrive, rmInFolder, rmDriveComplete, rmFolderComplete);
  TTriggerKind = (tkOneShot, tkEachMinute, tkEachHour, tkEachDay, tkEachMonth);
  TWatchMode = (wmNone, wmChange, wmChangeAndTimer, wmChangeOrTimer);
  TCompareMode = (cmHash, cmSizeTime, cmArchive);
  TApplicationAction = (aaNone, aaRunBefore, aaRunAfter, aaCloseBefore, aaCloseAfter, aaRunBeforeAndWait,
    aaRunAfterAndWait, aaCloseBeforeAndWait, aaCloseAfterAndWait);

  TSearchData = record
    sComp : string;
    sReplace : string;
    bCaseSens : Boolean;
    bQuitChanges : Boolean;
    Mode : TReplaceMode;
  end;

  TTimerData = record
    bEnabled : Boolean;
    bOnShutdown : Boolean;
    iMulti : integer;
    Time : TDateTime;
    Kind : TTriggerKind;
    WatchMode : TWatchMode;
  end;

  ATimerData = array [0 .. 4] of TTimerData;
  PApplicationData = ^TApplicationData;

  TApplicationData = record
    sFileName : string;
    sParam : string;
    iTimeout : integer;
    Action : TApplicationAction;
  end;

  AApplicationData = array [0 .. 19] of TApplicationData;
  PTreeData = ^TTreeData;

  TTreeData = record
    sName : string;
    sSource : string;
    sSourceC : string;
    sDest : string;
    sDestC : string;
    sFileMask : string;
    sSourceDriveLabel : string;
    sDestDriveLabel : string;
    sUsername : string;
    sPassword : string;
    bSubFolders : Boolean;
    bDeleteFiles : Boolean;
    bDoNotCopyFlags : Boolean;
    bProgress : Boolean;
    bChanged : Boolean;
    bCompress : Boolean;
    bEnableNetworkLogon : Boolean;
    iTimeDiff : integer;
    iImageIndex : integer;
    LastRun : TDateTime;
    JobErrors : TStringlist;
    SkipFolders : TStringlist;
    SkipFiles : TStringlist;
    Progress : TProgressBarEx;
    CompareMode : TCompareMode;
    Timer : ATimerData;
    Application : AApplicationData;
  end;

function VSTHAdd(AVST : TCustomVirtualStringTree; ARecord : TTreeData; Checked : Boolean; ANode : PVirtualNode = nil)
  : PVirtualNode;
function VSTHChange(AVST : TVirtualStringTree; ARecord : TTreeData; Checked : Boolean; ANode : PVirtualNode)
  : PVirtualNode;
function VSTHChecked(AVST : TCustomVirtualStringTree; ANode : PVirtualNode) : Boolean;
procedure VSTHCreate(AVST : TVirtualStringTree);
procedure VSTHDel(AVST : TVirtualStringTree; ANode : PVirtualNode);

implementation

function VSTHAdd(AVST : TCustomVirtualStringTree; ARecord : TTreeData; Checked : Boolean; ANode : PVirtualNode = nil)
  : PVirtualNode;
type
  TStringArray = array [0 .. 1] of string;

  function Seperate(s : string) : TStringArray;
  var
    i : integer;
  begin
    result[0] := s;
    result[1] := '';
    for i := 0 to length(s) do
    begin
      if s[i] = ' ' then
      begin
        result[0] := copy(s, 0, i - 1);
        result[1] := copy(s, i + 1, length(s));
        break;
      end;
    end;
  end;

var
  SubData, RootData : PTreeData;
  Strings : TStringArray;
  Nodes : PVirtualNode;
  i : integer;
begin
  Strings := Seperate(ARecord.sName);
  if (ANode = nil) and (Strings[1] <> '') and (AVST.GetFirst <> nil) then
  // Neuer Node?
  begin
    Nodes := AVST.GetFirst;
    repeat
      SubData := AVST.GetNodeData(Nodes);
      if (Strings[0] = Seperate(SubData^.sName)[0]) and
        ((Seperate(SubData.sName)[1] <> '') and (AVST.GetNodeLevel(Nodes) = 0) or (Nodes.ChildCount >= 1)) then
      // Name schon vorhanden?
      begin
        if Nodes.ChildCount <= 1 then // schon gruppiert?
        begin
          result := AVST.AddChild(Nodes); // neuer SubNode
          AVST.ValidateNode(result, false);
          SubData := AVST.GetNodeData(result); // hole Daten des SubNode
          RootData := AVST.GetNodeData(Nodes); // hole Daten des RootNode
          SubData^ := RootData^; // setze Daten des RootNode auf den SubNode
          SubData^.sName := Seperate(RootData^.sName)[1];
          // Name des neuen SubNode
          RootData := AVST.GetNodeData(Nodes); // hole Daten des RootNode
          RootData^.sName := Strings[0]; // setze Gruppenname auf RootNode
          RootData^.sSource := ''; // lösche Daten des RootNode
          RootData^.sSourceC := '';
          RootData^.sDest := '';
          RootData^.sDestC := '';
          RootData^.sFileMask := '';
          RootData^.sSourceDriveLabel := '';
          RootData^.sDestDriveLabel := '';
          RootData^.sUsername := '';
          RootData^.sPassword := '';
          RootData^.bSubFolders := false;
          RootData^.bDeleteFiles := false;
          RootData^.bDoNotCopyFlags := false;
          RootData^.bProgress := false;
          RootData^.bEnableNetworkLogon := false;
          RootData^.iTimeDiff := 0;
          RootData^.LastRun := 0;
          RootData^.Progress.Free;
          RootData^.Progress := nil;
          RootData^.JobErrors := nil;
          RootData^.SkipFolders := nil;
          RootData^.SkipFiles := nil;
          RootData^.CompareMode := cmHash;
          for i := 0 to High(ATimerData) do
          begin
            RootData^.Timer[i].bEnabled := false;
            RootData^.Timer[i].bOnShutdown := false;
            RootData^.Timer[i].Time := 0;
            RootData^.Timer[i].Kind := tkOneShot;
            RootData^.Timer[i].WatchMode := wmNone;
            RootData^.Timer[i].iMulti := 1;
          end;
          for i := 0 to High(AApplicationData) do
          begin
            RootData^.Application[i].sFileName := '';
            RootData^.Application[i].sParam := '';
            RootData^.Application[i].iTimeout := 0;
            RootData^.Application[i].Action := aaNone;
          end;
          AVST.CheckState[result] := AVST.CheckState[Nodes];
          AVST.CheckState[Nodes] := csMixedNormal;
        end;
        result := AVST.AddChild(Nodes); // füge neuen SubNode hinzu
        AVST.ValidateNode(result, false);
        SubData := AVST.GetNodeData(result); // hole Daten des neuen SubNode
        SubData^ := ARecord; // setze Daten des neuen SubNode
        SubData^.sName := Strings[1]; // setze Name des neuen SubNode
        if result <> nil then
        begin
          AVST.CheckState[result] := csCheckedNormal;
          if not Checked then
          begin
            AVST.CheckState[result] := csUncheckedNormal;
          end;
        end;
        exit;
      end;
      Nodes := AVST.GetNext(Nodes);
    until Nodes = nil;
    result := AVST.AddChild(ANode);
    // Name nicht vorhanden -> füge neuen Node hinzu
    SubData := AVST.GetNodeData(result); // Daten holen
    AVST.ValidateNode(result, false);
    SubData^ := ARecord; // Daten setzen
  end
  else
  begin
    result := AVST.AddChild(ANode);
    SubData := AVST.GetNodeData(result);
    AVST.ValidateNode(result, false);
    SubData^ := ARecord;
  end;
  if result <> nil then
  begin
    AVST.CheckState[result] := csCheckedNormal;
    if not Checked then
    begin
      AVST.CheckState[result] := csUncheckedNormal;
    end;
  end;
end;

function VSTHChange(AVST : TVirtualStringTree; ARecord : TTreeData; Checked : Boolean; ANode : PVirtualNode)
  : PVirtualNode;
var
  NodeData : PTreeData;
  sName : string;
  slSkipFolders, slSkipFiles : TStringlist;
begin
  sName := '';
  if AVST.GetNodeLevel(ANode) = 1 then
  begin
    NodeData := AVST.GetNodeData(ANode.Parent);
    sName := NodeData^.sName + ' ';
  end;
  NodeData := AVST.GetNodeData(ANode);
  if ARecord.sName = sName + NodeData^.sName then
  begin
    result := ANode;
    ARecord.sName := NodeData^.sName;
    NodeData^ := ARecord;
    AVST.CheckState[result] := csCheckedNormal;
    if not Checked then
    begin
      AVST.CheckState[result] := csUncheckedNormal;
    end;
  end
  else
  begin
    slSkipFolders := TStringlist.Create;
    slSkipFolders.Sorted := true;
    slSkipFolders.Duplicates := dupIgnore;
    slSkipFolders.Assign(ARecord.SkipFolders);
    ARecord.SkipFolders := slSkipFolders;
    slSkipFiles := TStringlist.Create;
    slSkipFiles.Sorted := true;
    slSkipFiles.Duplicates := dupIgnore;
    slSkipFiles.Assign(ARecord.SkipFiles);
    ARecord.SkipFiles := slSkipFiles;
    result := VSTHAdd(AVST, ARecord, Checked);
    if result.Parent = ANode then
    begin
      ANode := AVST.GetFirstChild(ANode);
    end;
    VSTHDel(AVST, ANode);
  end;
end;

function VSTHChecked(AVST : TCustomVirtualStringTree; ANode : PVirtualNode) : Boolean;
var
  CheckState : TCheckState;
begin
  result := false;
  if ANode <> nil then
  begin
    CheckState := AVST.CheckState[ANode];
    result := CheckState = csCheckedNormal;
  end;
end;

procedure VSTHCreate(AVST : TVirtualStringTree);
begin
  AVST.NodeDataSize := SizeOf(TTreeData);
end;

procedure VSTHDel(AVST : TVirtualStringTree; ANode : PVirtualNode);
var
  RootNode, SubNode : PVirtualNode;
  RootData, SubData : PTreeData;
  s : string;
begin
  if Assigned(ANode) then
  begin
    if AVST.GetNodeLevel(ANode) = 1 then
    begin
      RootNode := ANode.Parent;
      AVST.DeleteNode(ANode);
      if AVST.ChildCount[RootNode] = 1 then
      begin
        SubNode := AVST.GetFirstChild(RootNode);
        RootData := AVST.GetNodeData(RootNode);
        SubData := AVST.GetNodeData(SubNode);
        s := RootData^.sName + ' ' + SubData^.sName;
        RootData^ := SubData^;
        RootData^.SkipFolders := TStringlist.Create;
        RootData^.SkipFolders.Sorted := true;
        RootData^.SkipFolders.Duplicates := dupIgnore;
        RootData^.SkipFolders.Assign(SubData^.SkipFolders);
        RootData^.SkipFiles := TStringlist.Create;
        RootData^.SkipFiles.Sorted := true;
        RootData^.SkipFiles.Duplicates := dupIgnore;
        RootData^.SkipFiles.Assign(SubData^.SkipFiles);
        RootData^.sName := s;
        AVST.CheckState[RootNode] := AVST.CheckState[SubNode];
        AVST.DeleteNode(SubNode);
      end;
    end
    else
    begin
      AVST.DeleteNode(ANode);
    end;
  end;
end;

end.
