unit SRDialog;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  VTreeHelper;

type
  TSRForm = class(TForm)
    eComp : TEdit;
    eReplace : TEdit;
    cbCaseSens : TCheckBox;
    cbQuitChanges : TCheckBox;
    lComp : TLabel;
    lReplace : TLabel;
    btOK : TButton;
    btCancel : TButton;
    cMode : TComboBox;
    lMode : TLabel;
    procedure FormShow(Sender : TObject);
  private
    function GetSearchData : TSearchData;
    { Private-Deklarationen }
  public
    property SearchData : TSearchData read GetSearchData;
  end;

var
  SRForm : TSRForm;

implementation

{$R *.dfm}

{ TSRForm }

procedure TSRForm.FormShow(Sender : TObject);
begin
  if cMode.Text = '' then
  begin
    cMode.Text := cMode.Items[0];
  end;
end;

function TSRForm.GetSearchData : TSearchData;
begin
  Result.sComp := eComp.Text;
  Result.sReplace := eReplace.Text;
  Result.bCaseSens := cbCaseSens.Checked;
  Result.bQuitChanges := cbQuitChanges.Checked;
  Result.Mode := TReplaceMode(cMode.Items.IndexOf(cMode.Text));
end;

end.

