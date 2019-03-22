unit About;

interface
{$Include Compilerswitches.inc}

uses Forms,
  StdCtrls,
  Credits,
  Controls,
  Classes,
  csUtils;

type
  TAboutBox = class(TForm)
    btOk : TButton;
    Creatingsto : TScrollingCredits;
    procedure FormShow(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox : TAboutBox;

implementation

{$R *.DFM}
uses
  MainFrame;

procedure TAboutBox.FormShow(Sender : TObject);
begin
  Creatingsto.Credits.Clear;
  Creatingsto.Credits.Add(MainForm.JvTranslate.Translate('GUIStrings', 'Credits1') + GetVersion);
  Creatingsto.Credits.Add('Copyright © 2006 - 2016 C.Schoch');
  Creatingsto.Credits.Add('');
  Creatingsto.Credits.Add(MainForm.JvTranslate.Translate('GUIStrings', 'Credits3'));
  {$I Creatingsto.inc}
  Creatingsto.Credits.Add(MainForm.JvTranslate.Translate('GUIStrings', 'Credits4'));
  Creatingsto.Visible := true;
  Creatingsto.Animate := true;
end;

end.
