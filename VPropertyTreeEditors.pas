unit VPropertyTreeEditors;

// Utility unit for the advanced Virtual Treeview demo application which contains the implementation of edit link
// interfaces used in other samples of the demo.

interface
{$INCLUDE Compilerswitches.inc}

uses
  StdCtrls,
  Controls,
  VirtualTrees,
  Classes,
  Windows,
  Messages,
  JvSpin,
  JvToolEdit,
  VTreeHelper;

type
  TPropertyEditLink = class(TInterfacedObject, IVTEditLink)
  private
    FEdit : TWinControl;
    FTree : TVirtualStringTree;
    FNode : PVirtualNode;
    FColumn : Integer;
  protected
    procedure EditKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
  public
    destructor Destroy; override;

    function BeginEdit : Boolean; stdcall;
    function CancelEdit : Boolean; stdcall;
    function EndEdit : Boolean; stdcall;
    function GetBounds : TRect; stdcall;
    function PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex) :
      Boolean; stdcall;
    procedure ProcessMessage(var Message : TMessage); stdcall;
    procedure SetBounds(R : TRect); stdcall;
  end;

  //----------------------------------------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------------------------------------

implementation

uses
  Dialogs,
  MainFrame;

destructor TPropertyEditLink.Destroy;

begin
  FEdit.Free;
  inherited;
end;

procedure TPropertyEditLink.EditKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);

var
  CanAdvance : Boolean;

begin
  CanAdvance := true;

  case Key of
    VK_ESCAPE :
      if CanAdvance then
      begin
        FTree.CancelEditNode;
        Key := 0;
      end;
    VK_RETURN :
      if CanAdvance then
      begin
        FTree.EndEditNode;
        Key := 0;
      end;

    VK_UP,
      VK_DOWN :
      begin
        CanAdvance := Shift = [];
        if FEdit is TComboBox then
          CanAdvance := CanAdvance and not TComboBox(FEdit).DroppedDown;
        if FEdit is TJvFilenameEdit then
          CanAdvance := false;
        if FEdit is TJvSpinEdit then
          CanAdvance := false;
        if FEdit is TEdit then
          CanAdvance := false;
        if CanAdvance then
        begin
          PostMessage(FTree.Handle, WM_KEYDOWN, Key, 0);
          Key := 0;
        end;
      end;
  end;
end;

function TPropertyEditLink.BeginEdit : Boolean;

begin
  Result := True;
  FEdit.Show;
  FEdit.SetFocus;
end;

function TPropertyEditLink.CancelEdit : Boolean;

begin
  Result := True;
  FEdit.Hide;
end;

function TPropertyEditLink.EndEdit : Boolean;

var
  Data : PApplicationData;
begin
  Result := True;
  Data := FTree.GetNodeData(FNode);
  if FEdit is TJvFilenameEdit then
  begin
    Data^.sFileName := TJvFilenameEdit(FEdit).FileName;
    FTree.InvalidateNode(FNode);
  end;
  if FEdit is TEdit then
  begin
    Data^.sParam := TEdit(FEdit).Text;
    FTree.InvalidateNode(FNode);
  end;
  if FEdit is TComboBox then
  begin
    Data^.Action := TApplicationAction(TComboBox(FEdit).Items.IndexOf(TComboBox(FEdit).Text));
    FTree.InvalidateNode(FNode);
  end;
  if FEdit is TJvSpinEdit then
  begin
    Data^.iTimeout := TJvSpinEdit(FEdit).AsInteger * 1000;
    FTree.InvalidateNode(FNode);
  end;
  FEdit.Hide;
  FTree.SetFocus;
end;

function TPropertyEditLink.GetBounds : TRect;

begin
  Result := FEdit.BoundsRect;
end;

function TPropertyEditLink.PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column :
  TColumnIndex) : Boolean;

var
  Data : PApplicationData;
begin
  Result := True;
  FTree := Tree as TVirtualStringTree;
  FNode := Node;
  FColumn := Column;
  FEdit.Free;
  FEdit := nil;
  Data := FTree.GetNodeData(Node);
  case FColumn of
    0 :
      begin
        FEdit := TJvFilenameEdit.Create(nil);
        with FEdit as TJvFilenameEdit do
        begin
          Visible := false;
          Parent := Tree;
          DialogOptions := [ofHideReadOnly, ofFileMustExist];
          ButtonFlat := true;
          Text := Data^.sFileName;
          OnKeyDown := EditKeyDown;
          Filter := MainForm.JvTranslate.Translate('GUIStrings', 'eAppFilter');
          DialogTitle := MainForm.JvTranslate.Translate('GUIStrings', 'eAppTitle');

        end;
      end;
    1 :
      begin
        FEdit := TComboBox.Create(nil);
        with FEdit as TComboBox do
        begin
          Visible := False;
          Parent := Tree;
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'None'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'RunBevore'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'RunAfter'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'CloseBevore'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'CloseAfter'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'RunBevoreAndWait'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'RunAfterAndWait'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'CloseBevoreAndWait'));
          Items.Add(MainForm.JvTranslate.Translate('GUIStrings', 'CloseAfterAndWait'));
          Text := Items[integer(Data^.Action)];
          OnKeyDown := EditKeyDown;
        end;
      end;
    2 :
      begin
        FEdit := TJvSpinEdit.Create(nil);
        with FEdit as TJvSpinEdit do
        begin
          Visible := False;
          Parent := Tree;
          ButtonKind := bkStandard;
          MaxLength := 0;
          Decimal := 2;
          MinValue := 1;
          MaxValue := 0;
          CheckMaxValue := false;
          Value := Data^.iTimeout div 1000;
          OnKeyDown := EditKeyDown;
        end;
      end;
    3 :
      begin
        FEdit := TEdit.Create(nil);
        with FEdit as TEdit do
        begin
          Visible := false;
          Parent := Tree;
          ParentShowHint := false;
          ShowHint := True;
          Text := Data^.sParam;
          OnKeyDown := EditKeyDown;
        end;
      end
  else
    Result := False;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TPropertyEditLink.ProcessMessage(var Message : TMessage);

begin
  FEdit.WindowProc(Message);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TPropertyEditLink.SetBounds(R : TRect);

var
  Dummy : Integer;

begin
  // Since we don't want to activate grid extensions in the tree (this would influence how the selection is drawn)
  // we have to set the edit's width explicitly to the width of the column.
  FTree.Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
  FEdit.BoundsRect := R;
end;

end.

