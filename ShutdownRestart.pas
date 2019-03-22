unit ShutdownRestart;

interface
{$Include Compilerswitches.inc}

uses Windows,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Controls,
  StdCtrls,
  Buttons,
  ExtCtrls,
  ImgList,
  JvExStdCtrls,
  JvButton,
  JvCtrls;

type
  TShutdownRestartDialog = class(TForm)
    tTimeout : TTimer;
    btShutdown : TJvImgBtn;
    btRestart : TJvImgBtn;
    lWhattoDo : TLabel;
    lTimeout : TLabel;
    imlShutdownRestart : TImageList;
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure FormShow(Sender : TObject);
    procedure tTimeoutTimer(Sender : TObject);
  private
    i : integer;
  public
    { Public-Deklarationen }
  end;

var
  ShutdownRestartDialog : TShutdownRestartDialog;

implementation
uses
  MainFrame;
{$R *.dfm}

procedure TShutdownRestartDialog.tTimeoutTimer(Sender : TObject);
begin
  if i <= 0 then
  begin
    close;
    ModalResult := mrNo;
  end;
  dec(i);
  lTimeout.Caption := format(MainForm.JvTranslate.Translate('GUIStrings', 'Timeout'), [i]);
end;

procedure TShutdownRestartDialog.FormShow(Sender : TObject);
begin
  i := 10;
  tTimeout.Enabled := true;
  lTimeout.Caption := format(MainForm.JvTranslate.Translate('GUIStrings', 'Timeout'), [i]);
end;

procedure TShutdownRestartDialog.FormClose(Sender : TObject;
  var Action : TCloseAction);
begin
  tTimeout.Enabled := false;
end;

end.

