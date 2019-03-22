unit ShowErrors;

interface
{$Include Compilerswitches.inc}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Dialogs,
  Controls,
  StdCtrls,
  Buttons,
  ComCtrls;

type
  TTShowErrors = class(TForm)
    btClose : TButton;
    mErrors : TMemo;
    procedure btCloseClick(Sender : TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TShowErrors : TTShowErrors;

implementation
uses
  MainFrame;
{$R *.dfm}

procedure TTShowErrors.btCloseClick(Sender : TObject);
begin
  close;
end;

end.
