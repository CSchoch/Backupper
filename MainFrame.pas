(* *****************************************************************************
  _\\|//_
  (` * * ')
  ______________________________ooO_(_)_Ooo_____________________________________
  ******************************************************************************
  ******************************************************************************
  ***                                                                        ***
  ***               Copyright (c) 2006 - 20011 by C.Schoch                    ***
  ***                                                                        ***
  ***   File:       MainFrame.pas                                            ***
  ***   Version:    1.0                                                      ***
  ***                                                                        ***
  ***   Autor:      C.Schoch                                                 ***
  ***               C.Schoch@web.de                                          ***
  ***               ICQ: 335208821                                           ***
  ***                                                                        ***
  ***   Function:  GUI Functions for Backupper                               ***
  ***                                                                        ***
  ***   Version  Date        Description                                     ***
  ***   -------  ----------  ----------------------------------------------- ***
  ***   1.0      2006-08-25  First release                                   ***
  ***                                                                        ***
  ******************************************************************************
  ******************************************************************************
  .oooO     Oooo.
  ____________________________(   )_____(   )___________________________________
  \ (       ) /
  \_)     (_/

  ***************************************************************************** *)

unit MainFrame;
{ DONE : Files auslesen -> job für job }
{ DONE : Optionenspeicherung implementieren (XML) Pfad : / Userprofile/Appdata/Backupper/Settings.xml }
{ DONE : Exception beim Beenden debuggen und entfernen }
{ DONE : Anwendungen schließen }
{ DONE : File Operation Thread benötigt }
{ DONE 1 : Schalter für automatisches Backup }
{ DONE 1 : Verschobene Files erkennen }
{ DONE 1 : Shutdown nach dem Backup }
{ DONE : die meisten Texte nur mit  bVerbose in Log schreiben }
{ DONE : Verbose Bit benötigt }
{ DONE 1 : Files vergleichen }
{ DONE : Statusanzeige hinzufügen }
{ DONE : Verwendung von THashedStringList in tSearchFiles prüfen bringt nichts }
{ DONE : CreateDirectory durch CreateDirectorySpecial austauschen }
{ DONE : Files aktualisieren }
{ DONE : Pfad für Logfile einstellbar machen }
{ DONE : Einstelldialog bauen }
{ DONE : ListView in EditChange einbauen für spezielle Optionen }
{ DONE : subFolders in SearchFiles einstellbar machen (im lv) }
{ DONE : Thread Prioritäten einstellbar machen }
{ DONE : Hashs vorberechnen zu unsicher }
{ DONE : Versionierung der Settings.xml }
{ DONE : Lokalisierung mit XML }
{ DONE : Umbenannte Files erkennen }
{ DONE : Fortschrittsbalken }
{ DONE : Update Thread schreiben }
{ DONE : Online Update mit Hilfe von XML File: Inhalt: Version, bNeednewLang, (Changelog) }
{ DONE : Anhalten/Fortsetzen Button }
{ DONE : Kontextmenu nur deaktivieren statt ausblenden }
{ DONE : Main Menü Eintrag "Jobs" }
{ DONE : kleinere Schrift im Hinzufügen/Ändern Dialog }
{ DONE : Buttons für Opendialoge }
{ DONE : Pfade für Opendialoge auf aktuellen setzen }
{ DONE : Parameter -Forum einbauen }
{ DONE : Beim setzen des Protokollordners wird immer "Backupper\"  hinzugefügt }
{ DONE : Über Dialog ab der mitte Scrollen }
{ DONE : Wenn Quellordner nicht verfügbar wird das gesammte Backup gelöscht! }
{ DONE : Option Anwendung neu starten nach Ende des Jobs }
{ DONE : Neuer Hinzufügen / Ändern Dialog }
{ DONE : Wenn auf Quelldatei kein Zugriff besteht sind die Daten der Zieldatei weg }
{ DONE : Log bei Fehler für jeden Job anzeigen }
{ DONE : State Image auch im Root anzeigen }
{ DONE : Namen für Jobs }
{ DONE : Einstellbare Zeitabweichung }
{ DONE : Minimize to Tray }
{ DONE 1 : Zeitmanager }
{ DONE : Jobgruppen mit Treeview }
{ DONE : Multi-Prozessor support }
{ DONE : Verschiedene Sortiertiermethoden: Filetime & Filesize, Hash }
{ DONE : bVerbose bei Fehlern entfernen }
{ DONE : bVerbose gegen Loglevel System austauschen }
{ DONE : Button zum Löschen der automatisch angelegten Dateien }
{ DONE : Funktion Rücksicherung }
{ DONE : Skiplist -- TStringlist -- Sorted }
{ DONE : Timer Option Alle x Minuten / Stunden / Tage / Monate }
{ DONE : Abfrage ob Herunterfahren oder Neustart }
{ DONE : Werden bei Anwendung beenden " " " mit in den Pfad eigefügt kann die Anwedung nicht beendet werden }
{ DONE : Mitloggen von wo nach wo verschoben wurde }
{ DONE : Progress im ListView anzeigen }
{ DONE : Spalten des ListView variabel gestalten }
{ DONE : Letzte Durchführung anzeigen im ListView }
{ DONE : Log Klasse einführen }
{ DONE : Sprachdatei in GUI Strings und Display Strings Logging Strings aufteilen }
{ DONE : Auch beim sortieren Loggen, von wo nach wo welches soll gelöscht werden usw. }
{ DONE : Progress in extra Fenster mit Fehleranzeige, Gesamtfortschritt, Einzelfortschritt usw. }
{ DONE : Timer Option --> bei Änderung und/oder Timer }
{ DONE : Fortschritt im Hint des TNA-Icons }
{ DONE : Exception beim aufruf des Einstelldialogs beseitigen }
{ DONE: Exception beim sortieren beseitigen }
{ DONE : Bestimmung der leeren Ordner optimieren }
{ DONE : Suche Ersetzen im Pfad (ersetzen im Laufwerk, ersetzen in den Ordnern, Laufwerk komplett, Ordner komplett)
  Stringreplace, Regex }
{ DONE: Drag & Drop support }
{ DONE : Zeit beim Sortieren }
{ DONE : Dateien pro/s anzeigen beim Suchen }
{ DONE : Verschobene Dateien Fortschritt }
{ DONE : Anwendung vor und nach dem Backup ausführen }
{ DONE : Anwendung vor und nach dem Backup schließen }
{ DONE : Mehrere Anwendungen definieren }
{ DONE : Datenträgernamen abfragen }
{ DONE : iCompareMode nach TCompareMode }
{ DONE : Imageindex speichern }
{ DONE : Username und Passwort für Jobs (Anmeldung bei Netzlaufwerken usw.) }

{ TODO : Files nicht komplett kopieren }
{ TODO : Hardlinks zu doppelten Files innerhalb der jobs }
{ TODO : verzögertes löschen der DestFiles }
{ TODO : Statistik (normalerweise zu kopieren, wirklich kopiert, verschoben) }
{ TODO : Infos zu den einzelenen Jobs (Freier Plattenplatz usw.) }
{ TODO : Auch bei btBackup.Click DoEvent verwenden }
{ TODO : Zeichnen des Progress im TNA }
{ TODO : Dateien komprimieren }
{ TODO : Tagesspezifische Ordner für Backups (mit Hardlinks zu alten Dateien) }
{ TODO : Warnimage hinzufügen }
{ TODO : Multi Thread Sort }
{ TODO : Multi Thread Copy }

{ TODO : Suchen Ersetzen fixen }

interface

{$INCLUDE Compilerswitches.inc}

uses
  Windows,
  Messages,
  SysUtils,
  StrUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  ShlObj,
  ActiveX,
  ExtCtrls,
  Math,
  XPMan,
  ShellApi,
  Menus,
  ImgList,
  StdCtrls,
  ActnList,
  JvSimpleXml,
  JvTranslator,
  JvComponentBase,
  ShutDown,
  DECCipher,
  DECHash,
  DECUtil,
  DECFmt,
  VirtualTrees,
  VTHeaderPopup,
  VTreeHelper,
  EditChange,
  About,
  SettingsDialog,
  ShowErrors,
  ShutdownRestart,
  ProgressDialog,
  SRDialog,
  tSearchFiles,
  tSortFiles,
  tFileOperation,
  tDirWatch,
  tUpdate,
  csExplode,
  csProgressBarEx,
  csLogCls,
  csUtils,
  JvTrayIcon,
  Generics.Collections,
  IniFiles,
  AppEvnts
  {, FileCopier};

type
  TMainForm = class(TForm)
    XPManifest : TXPManifest;
    btBackup : TButton;
    btCancel : TButton;
    pmListView : TPopupMenu;
    pmAdd : TMenuItem;
    pmDel : TMenuItem;
    pmChange : TMenuItem;
    imlPopupMenu : TImageList;
    sbMainForm : TStatusBar;
    pmCopy : TMenuItem;
    btTest : TButton;
    mmMainForm : TMainMenu;
    mmFile : TMenuItem;
    mmBackup : TMenuItem;
    mmCancel : TMenuItem;
    mmOptions : TMenuItem;
    mmSettings : TMenuItem;
    mmEnd : TMenuItem;
    mmAbout : TMenuItem;
    sxmlMainForm : TJvSimpleXML;
    mmKill : TMenuItem;
    tAutoBackup : TTimer;
    ShutDown : TShutDown;
    JvTranslate : TJvTranslator;
    mmLanguage : TMenuItem;
    mmLangGerman : TMenuItem;
    mmLangEnglish : TMenuItem;
    mmLangSpecial : TMenuItem;
    mUpdates : TMenuItem;
    mmUpdateNow : TMenuItem;
    mmCheckUpdateNow : TMenuItem;
    mmCheckUpdateAuto : TMenuItem;
    mmLoadUpdateAuto : TMenuItem;
    mmVersionDisplay : TMenuItem;
    tAutoUpdate : TTimer;
    btSuspend : TButton;
    mmJobs : TMenuItem;
    mmAdd : TMenuItem;
    mmCopy : TMenuItem;
    mmChange : TMenuItem;
    mmDel : TMenuItem;
    pmShowErrors : TMenuItem;
    mmShowErrors : TMenuItem;
    tvSourceDestination : TVirtualStringTree;
    imlTreeView : TImageList;
    tAlarms : TTimer;
    pmTrayIcon : TPopupMenu;
    imlTrayIcon : TImageList;
    pmtShow : TMenuItem;
    pmtHide : TMenuItem;
    pmtClose : TMenuItem;
    tHide : TTimer;
    pmtEnableTimer : TMenuItem;
    pmtCancel : TMenuItem;
    pmtSuspend : TMenuItem;
    mmSpecial : TMenuItem;
    mmUninstall : TMenuItem;
    mmRestore : TMenuItem;
    pmTVHeader : TVTHeaderPopupMenu;
    mmShowExtendedProgress : TMenuItem;
    alMainForm : TActionList;
    acStart : TAction;
    acCancel : TAction;
    acSuspend : TAction;
    acAdd : TAction;
    acCopy : TAction;
    acChange : TAction;
    acDel : TAction;
    acShowErrors : TAction;
    acSearchReplace : TAction;
    mmSearch : TMenuItem;
    meSearchReplace : TMenuItem;
    ctiBackupper : TJvTrayIcon;
    procedure pmtEnableTimerClick(Sender : TObject);
    procedure pmtShowClick(Sender : TObject);
    procedure tHideTimer(Sender : TObject);
    procedure pmtHideClick(Sender : TObject);
    procedure tAlarmsTimer(Sender : TObject);
    procedure tvSourceDestinationGetImageIndex(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind;
      Column : TColumnIndex; var Ghosted : Boolean; var ImageIndex : Integer);
    procedure tvSourceDestinationDblClick(Sender : TObject);
    procedure tvSourceDestinationClick(Sender : TObject);
    procedure tvSourceDestinationMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
    procedure tvSourceDestinationInitNode(Sender : TBaseVirtualTree; ParentNode, Node : PVirtualNode;
      var InitialStates : TVirtualNodeInitStates);
    procedure tvSourceDestinationGetText(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
      TextType : TVSTTextType; var CellText : String);
    procedure acSuspendExecute(Sender : TObject);
    procedure tAutoUpdateTimer(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure mmSettingsClick(Sender : TObject);
    procedure mmUpdateNowClick(Sender : TObject);
    procedure mmCheckUpdateNowClick(Sender : TObject);
    procedure mmLoadUpdateAutoClick(Sender : TObject);
    procedure mmCheckUpdateAutoClick(Sender : TObject);
    procedure mmLangSpecialClick(Sender : TObject);
    procedure mmLangEnglishClick(Sender : TObject);
    procedure mmLangGermanClick(Sender : TObject);
    procedure mmSpecialClick(Sender : TObject);
    procedure mmRestoreClick(Sender : TObject);
    procedure mmUninstallClick(Sender : TObject);
    procedure tAutoBackupTimer(Sender : TObject);
    procedure FormResize(Sender : TObject);
    procedure mmKillClick(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure mmAboutClick(Sender : TObject);
    procedure mmEndClick(Sender : TObject);
    procedure FormCloseQuery(Sender : TObject; var CanClose : Boolean);
    procedure acCancelExecute(Sender : TObject);
    procedure btTestClick(Sender : TObject);
    procedure acBackupExecute(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure SaveSettings;
    procedure LoadSettingsV10;
    procedure LoadSettingsV11;
    procedure LoadSettingsV12;
    procedure LoadSettingsV13;
    procedure LoadSettingsV14;
    procedure LoadSettingsV15;
    procedure LoadSettingsV16;
    function EncryptPW(const AText : string; const APassword : string) : string;
    function DecryptPW(const AText : string; const APassword : string) : string;
    procedure StatusbarUpdate(sJobName : string; Data : PTreeData);
    procedure WMQUERYENDSESSION(var msg : TMessage); message WM_QUERYENDSESSION;
    procedure WMENDSESSION(var msg : TMessage); message WM_ENDSESSION;
    procedure acShowErrorsExecute(Sender : TObject);
    procedure acCopyExecute(Sender : TObject);
    procedure acChangeExecute(Sender : TObject);
    procedure acDelExecute(Sender : TObject);
    procedure acAddExecute(Sender : TObject);
    procedure DoEvent(TreeData, RootData : PTreeData; Node : PVirtualNode; iMode : Integer; sRootName : string);
    procedure ctiBackupperDblClick(Sender : TObject);
    procedure pmTVHeaderAddHeaderPopupItem(const Sender : TBaseVirtualTree; const Column : TColumnIndex;
      var Cmd : TAddPopupItemType);
    procedure tvSourceDestinationFreeNode(Sender : TBaseVirtualTree; Node : PVirtualNode);
    procedure OnThreadTerminate(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure mmShowExtendedProgressClick(Sender : TObject);
    procedure acSearchReplaceExecute(Sender : TObject);
  private
    SourceFileList : tSearchFiles.TFoundFilesList; // 0: Filename 1: Hash
    DestFileList : tSearchFiles.TFoundFilesList; // 0: Filename 1: Hash
    SourceFolderList : THashedStringList; // 0. Path to Folder
    DestFolderList : THashedStringList; // 0. Path to Folder
    CopyFilesList : tSortFiles.TSortedFilesList;
    // 0: Source 1: Destination 2: Hash
    MoveFilesList : tSortFiles.TSortedFilesList;
    // 0: Source 1: Destination 2: Hash
    DeleteFilesList : tSortFiles.TSortedFilesList;
    // 0: Source 1: Destination 2: Hash
    DeleteDirList : TStringList;
    ThreadArray : array [0 .. 3] of THandle;
    bCanceled, bShutdown, bParamShutdown, bForce, bLog, bUseDescription : Boolean;
    bEndBackupbevoreShutdown, bConfirmShutdown, bConfirmDelete, bClose : Boolean;
    bParamClose, bSuspended, bAddCanceled, bUpdateDone, bWrongSettings : Boolean;
    bStartInTray, bLoaded, bDoSdEvent, bLogoff, bExtProgress, bError : Boolean;
    sLogPath, sSettingsPath, sLangPath, sStatusbarText, sStatusbarTextOld : string;
    iWaitTimeout, iLang, iShutdownMode : Integer;
    iThreadPriority : TThreadPriority;
    SearchData : TSearchData;
    Data : TMemoryStream;
    UpdateThread : tTUpdate;
    WatchThread : TtDirWatch;
    FLast : TTimeStamp;
    LogLevel : TLogLevel;
    ThreadIdList : TStringList;
    // pbStatusBar : TProgressBarEx;
    ActNode : PVirtualNode;
    procedure DoTranslation;
    procedure ConnectDrives(d : TStringDivider; TreeData : PTreeData; sRootName : string);
    procedure IterateSearchReplace(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; var Abort : Boolean);
    procedure CropForm;
  public
    LogFile : TLogFile;
    DestThread : TtSearchFiles;
    SourceThread : TtSearchFiles;
    SortThread : TtSortFiles;
    OperationThread : TtFileOperation;
  end;

var
  MainForm : TMainForm;
  MinimizeToTray : Boolean;
  // const
  // iActLang = 11;

implementation

{$R *.dfm}

procedure TMainForm.FormShow(Sender : TObject);

  procedure SetStandartvalues;
  var
    SaveVisibilities : TTrayVisibilities;
  begin
    // nichts zum Laden: Default Werte setzen
    sLogPath := GetShellFolder(CSIDL_PERSONAL) + 'Backupper\';
    MainForm.Height := 468;
    MainForm.Left := 0;
    MainForm.Top := 0;
    MainForm.Width := 575;
    iWaitTimeout := 3000;
    iThreadPriority := tpNormal;
    tvSourceDestination.Header.Columns[0].Width := 100;
    tvSourceDestination.Header.Columns[1].Width := 100;
    tvSourceDestination.Header.Columns[2].Width := 100;
    tvSourceDestination.Header.Columns[3].Width := 150;
    bShutdown := false;
    bLog := true;
    bUseDescription := true;
    LogLevel := llError;
    bForce := false;
    WindowState := wsNormal;
    bEndBackupbevoreShutdown := false;
    bConfirmShutdown := false;
    bConfirmDelete := true;
    bClose := false;
    bStartInTray := false;
    SaveVisibilities := ctiBackupper.Visibility;
    exclude(SaveVisibilities, tvAutoHide);
    ctiBackupper.Visibility := SaveVisibilities;
    bUseDescription := true;
    // Hole Standart Sprache des Systems
    if (GetUserDefaultLangID and LANG_GERMAN) = LANG_GERMAN then
    begin
      // benutze Deutsche Sprache
      mmLangGerman.Click;
    end
    else
    begin
      // benutze Englisch als Standard
      mmLangEnglish.Click;
    end;
  end;

var
  // r : TRect;
  i : Integer;
  bHide : Boolean;
begin
  if not bLoaded then
  begin
{$IFDEF Debug}
    mmKill.Visible := true;
    mmKill.Enabled := true;
    btTest.Visible := true;
    btTest.Enabled := true;
{$ENDIF}
    // Größe des 1. Panels ermitteln
    // 0 = erstes Panel der Statusbar; 1 = zweites Panel usw.
    // Das Panel muss auf Style := psOwnerDraw stehen
    // pbStatusBar := TProgressBarEx.Create(Self);
    // with pbStatusBar do
    // begin
    // Name := 'pbStatusBar';
    // Top := 448;
    // Anchors := [akRight, akBottom];
    // Step := 1;
    // TabOrder := 6;
    // Parent := sbMainForm;
    // end;
    // sbMainForm.Perform(SB_Bottom, 1, integer(@R));
    // pbStatusBar.Parent := sbMainForm;
    // pbStatusBar.BoundsRect := r;
    // pbStatusbar.Left := MainForm.Width - 100;
    // pbStatusBar.Width := sbMainform.Panels[1].Width;
    // pbStatusBar.Height := sbMainForm.Height;
    // sbMainForm.DoubleBuffered := true;
    // pbStatusBar.DoubleBuffered := true;
    bHide := false;
    VSTHCreate(tvSourceDestination);
    // Laden der Infos aus der Form in Dateien
    // JvTranslate.XML.LoadFromString(JvTranslate.ComponentToXML(self,true));
    // JvTranslate.XML.SaveToFile(ExtractFileDir(Application.ExeName)+ '\Deutschr.xml');
    // JvTranslate.XML.LoadFromString(JvTranslate.ComponentToXML(AboutBox,true));
    // JvTranslate.XML.SaveToFile(ExtractFileDir(Application.ExeName)+ '\Deutsch1r.xml');
    // JvTranslate.XML.LoadFromString(JvTranslate.ComponentToXML(TEditChange,true));
    // JvTranslate.XML.SaveToFile(ExtractFileDir(Application.ExeName)+ '\Deutsch2r.xml');
    // JvTranslate.XML.LoadFromString(JvTranslate.ComponentToXML(SettingsForm,true));
    // JvTranslate.XML.SaveToFile(ExtractFileDir(Application.ExeName)+ '\Deutsch3r.xml');
    // JvTranslate.XML.LoadFromString(JvTranslate.ComponentToXML(TShowErrors,true));
    // JvTranslate.XML.SaveToFile(ExtractFileDir(Application.ExeName)+ '\Deutsch4r.xml');
    // JvTranslate.XML.LoadFromString(JvTranslate.ComponentToXML(ShutdownRestart,true));
    // JvTranslate.XML.SaveToFile(ExtractFileDir(Application.ExeName)+ '\Deutsch5r.xml');
    { Optionen laden }
    sSettingsPath := GetShellFolder(CSIDL_APPDATA) + 'Backupper\';
    sLangPath := ExtractFileDir(Application.ExeName) + '\Language\';
    sxmlMainForm.Root.Name := 'Backupper';
    // Parameter an Programm übergeben
    for i := 1 to ParamCount do
    begin
      MainForm.Caption := MainForm.Caption + ' ' + ParamStr(i);
      case CaseStringIOf(ParamStr(i), ['-shutdown', '-auto', '-close', '-forum', '-autostart']) of
        0 :
          bParamShutdown := true;
        1 :
          tAutoBackup.Enabled := true;
        2 :
          bParamClose := true;
        3 :
          sSettingsPath := ExtractFileDir(Application.ExeName) + '\';
        4 :
          bHide := true;
      end;
    end;
    if FileExists(sSettingsPath + 'Settings.xml') then
    begin
      // laden der gespeicherten Werte
      sxmlMainForm.LoadFromFile(sSettingsPath + 'Settings.xml');
      case sxmlMainForm.Root.Items.itemNamed['FileVersion'].IntValue of
        10 :
          LoadSettingsV10;
        11 :
          LoadSettingsV11;
        12 :
          LoadSettingsV12;
        13 :
          LoadSettingsV13;
        14 :
          LoadSettingsV14;
        15 :
          LoadSettingsV15;
        16 :
          LoadSettingsV16;
      else
        SetStandartvalues;
        MessageDlg(format(JvTranslate.Translate('GUIStrings', 'UnknownSettings'), [#10#13]), mtInformation, [mbOK], 0);
        bWrongSettings := true;
      end;
    end
    else
    begin
      SetStandartvalues;
      // Settings Dialog laden nach Abfrage
      if (MessageDlg(format(JvTranslate.Translate('GUIStrings', 'StandW'), [#10#13]), mtConfirmation, mbYesNo, 0)
        = mrYes) then
      begin
        mmSettings.Click;
      end;
    end;
    CropForm;
    LogFile := TLogFile.Create(sLogPath, 'Backupper - .log', 'yyyy.mm.dd', '', false, bLog);
    with LogFile do
    begin
      Enabled := bLog;
      UseDescription := bUseDescription;
      DestroyLang := false;
      Translator := JvTranslate;
      LogLevel := MainForm.LogLevel;
    end;
    LogFile.Write('LogStrings', 'Loaded');
    SetStatusbarText(sbMainForm, JvTranslate.Translate('GUIStrings', 'Loaded'));
    mmVersionDisplay.Caption := format(JvTranslate.Translate('GUIStrings', 'Version'),
      [JvTranslate.Translate('GUIStrings', 'Unknown')]);
    tAutoUpdate.Enabled := mmCheckUpdateAuto.Checked;
    FLast := DateTimeToTimeStamp(Now);
{$IFNDEF TIMERTEST}
    Inc(FLast.Time, 60 * 2000);
{$ENDIF}
    ctiBackupper.Animated := false;
    ctiBackupper.CurrentIcon := Application.Icon;
    tHide.Enabled := bHide and bStartInTray;
    iShutdownMode := - 1; // -1 = Undefiniert, 1 = Shutdown, 2 = Restart
    bLoaded := true;
    if IsWinVistaOrHigher then
    begin
      tvSourceDestination.Width := tvSourceDestination.Width + 9;
      // tvSourceDestination.Height := tvSourceDestination.Height - 35;
      pmtShow.Visible := false;
      pmtHide.Default := false;
    end;
  end;
end;

procedure TMainForm.IterateSearchReplace(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer;
  var Abort : Boolean);

  function Dialog(sFrom, sTo : string) : Boolean;
  var
    s : string;
  begin
    Result := false;
    if Abort then
    begin
      exit;
    end;
    s := format(JvTranslate.Translate('GUIStrings', 'RealyReplace'), [sFrom, sTo]);
    case MessageDlg(s, mtConfirmation, [mbYes, mbNo, mbNoToAll, mbYesToAll], 0) of
      mrYes :
        Result := true;
      mrNo :
        Result := false;
      mrYesToAll :
        begin
          Result := true;
          TSearchData(Data^).bQuitChanges := false;
          SearchData.bQuitChanges := false;
        end;
      mrNoToAll :
        begin
          Result := false;
          Abort := true;
        end;
    end;
  end;

var
  NodeData : PTreeData;
  sOldSource : string;
  sOldDest : string;
  SearchData : TSearchData;
  iPos, iLengthS, iLengthR : Integer;
  s, sNew : string;
begin
  if Node.ChildCount <= 0 then
  begin
    NodeData := Sender.GetNodeData(Node);
    sOldSource := NodeData.sSource;
    sOldDest := NodeData.sDest;
    SearchData := TSearchData(Data^);
    if not SearchData.bCaseSens then
    begin
      SearchData.sComp := UpperCase(SearchData.sComp);
      sOldSource := UpperCase(sOldSource);
      sOldDest := UpperCase(sOldDest);
    end;
    case SearchData.Mode of
      rmAll :
        begin
          iPos := 1;
          iLengthS := Length(SearchData.sComp);
          iLengthR := Length(SearchData.sReplace);
          repeat
            iPos := PosEx(SearchData.sComp, sOldSource, iPos);
            if iPos <> 0 then
            begin
              sNew := NodeData.sSource;
              Delete(sNew, iPos, iLengthS);
              Insert(SearchData.sReplace, sNew, iPos);
              if not SearchData.bQuitChanges or Dialog(NodeData.sSource, sNew) then
              begin
                NodeData.sSource := sNew;
                Delete(sOldSource, iPos, iLengthS);
                Insert(SearchData.sReplace, sOldSource, iPos);
                Inc(iPos, iLengthR);
              end
              else
              begin
                Inc(iPos, iLengthS);
              end;
            end;
          until iPos = 0;
          iPos := 1;
          repeat
            iPos := PosEx(SearchData.sComp, sOldDest, iPos);
            if iPos <> 0 then
            begin
              sNew := NodeData.sDest;
              Delete(sNew, iPos, iLengthS);
              Insert(SearchData.sReplace, sNew, iPos);
              if not SearchData.bQuitChanges or Dialog(NodeData.sDest, sNew) then
              begin
                NodeData.sDest := sNew;
                Delete(sOldDest, iPos, iLengthS);
                Insert(SearchData.sReplace, sOldDest, iPos);
                Inc(iPos, iLengthR);
              end
              else
              begin
                Inc(iPos, iLengthS);
              end;
            end;
          until iPos = 0;
        end;
      rmInDrive :
        begin
          iPos := 1;
          iLengthS := Length(SearchData.sComp);
          iLengthR := Length(SearchData.sReplace);
          s := ExtractFileDrive(sOldSource);
          repeat
            iPos := PosEx(SearchData.sComp, s, iPos);
            if iPos <> 0 then
            begin
              sNew := s;
              Delete(sNew, iPos, iLengthS);
              Insert(SearchData.sReplace, sNew, iPos);
              sNew := sNew + CutStartDir(NodeData.sSource, ExtractFileDrive(sOldSource));
              if not SearchData.bQuitChanges or Dialog(NodeData.sSource, sNew) then
              begin
                NodeData.sSource := sNew;
                Delete(s, iPos, iLengthS);
                Insert(SearchData.sReplace, s, iPos);
                Inc(iPos, iLengthR);
              end
              else
              begin
                Inc(iPos, iLengthS);
              end;
            end;
          until iPos = 0;
          iPos := 1;
          s := ExtractFileDrive(sOldDest);
          repeat
            iPos := PosEx(SearchData.sComp, s, iPos);
            if iPos <> 0 then
            begin
              sNew := s;
              Delete(sNew, iPos, iLengthS);
              Insert(SearchData.sReplace, sNew, iPos);
              sNew := sNew + CutStartDir(NodeData.sDest, ExtractFileDrive(sOldDest));
              if not SearchData.bQuitChanges or Dialog(NodeData.sDest, sNew) then
              begin
                NodeData.sDest := sNew;
                Delete(s, iPos, iLengthS);
                Insert(SearchData.sReplace, s, iPos);
                Inc(iPos, iLengthR);
              end
              else
              begin
                Inc(iPos, iLengthS);
              end;
            end;
          until iPos = 0;
        end;
      rmInFolder :
        begin
          iPos := 1;
          iLengthS := Length(SearchData.sComp);
          iLengthR := Length(SearchData.sReplace);
          s := CutStartDir(sOldSource, ExtractFileDrive(sOldSource));
          repeat
            iPos := PosEx(SearchData.sComp, s, iPos);
            if iPos <> 0 then
            begin
              sNew := CutStartDir(NodeData.sSource, ExtractFileDrive(NodeData.sSource));
              Delete(sNew, iPos, iLengthS);
              Insert(SearchData.sReplace, sNew, iPos);
              sNew := ExtractFileDrive(NodeData.sSource) + sNew;
              if not SearchData.bQuitChanges or Dialog(NodeData.sSource, sNew) then
              begin
                NodeData.sSource := sNew;
                Delete(s, iPos, iLengthS);
                Insert(SearchData.sReplace, s, iPos);
                Inc(iPos, iLengthR);
              end
              else
              begin
                Inc(iPos, iLengthS);
              end;
            end;
          until iPos = 0;
          iPos := 1;
          s := CutStartDir(sOldDest, ExtractFileDrive(sOldDest));
          repeat
            iPos := PosEx(SearchData.sComp, s, iPos);
            if iPos <> 0 then
            begin
              sNew := CutStartDir(NodeData.sDest, ExtractFileDrive(NodeData.sDest));
              Delete(sNew, iPos, iLengthS);
              Insert(SearchData.sReplace, sNew, iPos);
              sNew := ExtractFileDrive(NodeData.sDest) + sNew;
              if not SearchData.bQuitChanges or Dialog(NodeData.sDest, sNew) then
              begin
                NodeData.sDest := sNew;
                Delete(s, iPos, iLengthS);
                Insert(SearchData.sReplace, s, iPos);
                Inc(iPos, iLengthR);
              end
              else
              begin
                Inc(iPos, iLengthS);
              end;
            end;
          until iPos = 0;
        end;
      rmDriveComplete :
        begin
          s := ExtractFileDrive(sOldSource);
          if Pos(SearchData.sComp, s) <> 0 then
          begin
            sNew := SearchData.sReplace + CutStartDir(NodeData.sSource, s);
            if not SearchData.bQuitChanges or Dialog(NodeData.sSource, sNew) then
            begin
              NodeData.sSource := sNew;
            end;
          end;
          s := ExtractFileDrive(sOldDest);
          if Pos(SearchData.sComp, s) <> 0 then
          begin
            sNew := SearchData.sReplace + CutStartDir(NodeData.sDest, s);
            if not SearchData.bQuitChanges or Dialog(NodeData.sDest, sNew) then
            begin
              NodeData.sDest := sNew;
            end;
          end;
        end;
      rmFolderComplete :
        begin
          s := CutStartDir(sOldSource, ExtractFileDrive(sOldSource));
          if Pos(SearchData.sComp, s) <> 0 then
          begin
            sNew := ExtractFileDrive(NodeData.sSource) + SearchData.sReplace;
            if not SearchData.bQuitChanges or Dialog(NodeData.sSource, sNew) then
            begin
              NodeData.sSource := sNew;
            end;
          end;
          s := CutStartDir(sOldDest, ExtractFileDrive(sOldDest));
          if Pos(SearchData.sComp, s) <> 0 then
          begin
            sNew := ExtractFileDrive(NodeData.sDest) + SearchData.sReplace;
            if not SearchData.bQuitChanges or Dialog(NodeData.sDest, sNew) then
            begin
              NodeData.sDest := sNew;
            end;
          end;
        end;
    end;
  end;
end;

procedure TMainForm.CropForm;
var
  i : Integer;
begin

  with Screen do
  begin
    for i := 0 to FormCount - 1 do
    begin
      if Forms[i].Top < 0 then
      begin
        Forms[i].Top := 0;
      end;
      if Forms[i].Left < 0 then
      begin
        Forms[i].Left := 0;
      end;
      if Forms[i].Left + Forms[i].Width > DesktopWidth then
      begin
        Forms[i].Left := Forms[i].Left - ((Forms[i].Left + Forms[i].Width) - DesktopWidth);
        if Forms[i].Left < 0 then
        begin
          Forms[i].Width := Forms[i].Width + Forms[i].Left;
          Forms[i].Left := 0;
        end;
      end;
      if Forms[i].Top + Forms[i].Height > DesktopHeight then
      begin
        Forms[i].Top := Forms[i].Top - ((Forms[i].Top + Forms[i].Height) - DesktopHeight);
        if Forms[i].Top < 0 then
        begin
          Forms[i].Height := Forms[i].Width + Forms[i].Top;
          Forms[i].Top := 0;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.btTestClick(Sender : TObject); // zum Test
{$IFDEF DEBUG}
var
  tick : Integer;

  function FastFileCopy1(const InFileName, OutFileName : string; out iResult : Integer; out sResult : string) : Boolean;
  var
    dwClusterSize, dwDummi : DWORD;
    InFile, OutFile : TFileStream;
    InBuffer, OutBuffer : array of Byte;
    iSizeDone, iSize, iSizeFile, iOutFileSize, iDummi, iFreeSpace : int64;
  begin
    iSizeDone := 0;
    iSize := 0;
    Result := true;
    iResult := 0;
    sResult := '';
    InFile := nil;
    OutFile := nil;
    if (InFileName = OutFileName) then
    begin
      Result := false;
      iResult := 32;
      exit;
    end;
    try
      try
        InFile := TFileStream.Create(InFileName, fmOpenRead);
        if not FileExists(OutFileName) then
        begin
          OutFile := TFileStream.Create(OutFileName, fmCreate);
          FreeAndNil(OutFile);
        end;
        OutFile := TFileStream.Create(OutFileName, fmOpenReadWrite);
        iSizeFile := InFile.Size;
        iOutFileSize := OutFile.Size;
        if GetDiskFreeSpace(PChar(ExtractFileDir(OutFileName)), dwDummi, dwClusterSize, dwDummi, dwDummi) then
        begin
          dwClusterSize := dwClusterSize * 400;
        end
        else
        begin
          dwClusterSize := 49152;
          { 3 * 4 * 4096 48Kbytes gives me the best results }
        end;
        if dwClusterSize > iSizeFile then
        begin
          dwClusterSize := iSizeFile;
        end;
        SetLength(InBuffer, dwClusterSize);
        SetLength(OutBuffer, dwClusterSize);
        if GetDiskFreeSpaceEx(PChar(ExtractFileDir(OutFileName)), iFreeSpace, iDummi, @iDummi) then
        begin
          if iSizeFile > (iFreeSpace + iOutFileSize) then
          begin
            Result := false;
            iResult := 112;
          end;
        end;
        ProgressForm.State := bsOpCopy;
        if (iResult <> 112) then
        begin
          InFile.Seek(0, soFromBeginning);
          OutFile.Seek(0, soFromBeginning);
          repeat
            InFile.Read(InBuffer[0], dwClusterSize);
            OutFile.Read(OutBuffer[0], dwClusterSize);
            if not CompareMem(InBuffer, OutBuffer, dwClusterSize) then
            begin
              OutFile.Position := iSizeDone;
              OutFile.Write(InBuffer[0], dwClusterSize);
            end;
            iSizeDone := iSizeDone + dwClusterSize;
            if iSizeDone + dwClusterSize > iSizeFile then
            begin
              dwClusterSize := iSizeFile - iSizeDone;
              SetLength(InBuffer, dwClusterSize);
              SetLength(OutBuffer, dwClusterSize);
            end;
            ProgressForm.FileSize := iSizeFile;
            ProgressForm.FileSizeDone := iSizeDone;
          until iSizeDone >= iSizeFile;
          FileSetDate(OutFile.Handle, FileGetDate(InFile.Handle));
          iResult := iSizeFile - iSizeDone;
          if iResult <> 0 then
          begin
            Result := false;
            iResult := 5;
          end;
        end;
      except
        on E : Exception do
        begin
          sResult := E.Message;
          Result := false;
        end;
      end;
    finally
      FreeAndNil(InFile);
      FreeAndNil(OutFile);
    end;
  end;

  procedure FastFileCopyCallBack(Position, Size : int64);
  begin
    ProgressForm.FileSize := Size;
    ProgressForm.FileSizeDone := Position;
    Application.ProcessMessages;
  end;

  procedure CloseCallBack();
  begin
    Application.ProcessMessages;
  end;

{$ENDIF}
{$IFDEF DEBUG}

var
  i, j, k, l, m : Integer;
  dwPAffinity, dwDummy, AHWND : DWORD;
  test : TStringDynArray;
  fname, s : string;
  OutFile : file;
  SkipFiles : TStringList;
  msg : TMessage;
  LogFile : TLogFile;
  // Thread1, Thread2, Thread3, Thread4 : TRead;
  // Copier : TFileCopier;
  MyList : TDictionary<string, Integer>;
  MyHashedList : THashedStringList;
  Test1 : TList<TSortedFileValues>;
  NewValue : TSortedFileValues;
{$ENDIF}
begin
{$IFDEF DEBUG}
  Test1 := TList<TSortedFileValues>.Create(TSortedFileValuesComparer.Create);
  for i := 20 downto 0 do
  begin
    NewValue.sHash := IntToStr(i);
    Test1.Add(NewValue);
  end;
  NewValue.sHash := '19';
  NewValue.sSourceFileName := 'sfjkvhfkgvdbfk';
  ShowMessageFmt('%d', [Test1.IndexOf(NewValue)]);
  Test1.Sort;
  ShowMessageFmt('%d', [Test1.IndexOf(NewValue)]);
  Test1.TrimExcess;
  FreeAndNil(Test1);
  // CropForm;
  // MyList := TDictionary<string, Integer>.Create(10000000);
  // tick := GetTickCount;
  // for i := 0 to 10000000 do
  // begin
  // MyList.Add('Test' + IntToStr(i), i);
  // end;
  // tick := GetTickCount - tick;
  // ShowMessage(IntToStr(tick));
  // tick := GetTickCount;
  // for i := 0 to 10000000 do
  // begin
  // MyList.TryGetValue('Test' + IntToStr(i), j);
  // end;
  // tick := GetTickCount - tick;
  // ShowMessage(IntToStr(tick));
  // FreeAndNil(MyList);
  //
  // MyHashedList := THashedStringList.Create;
  // MyHashedList.Capacity := 10000000;
  // tick := GetTickCount;
  // for i := 0 to 10000000 do
  // begin
  // MyHashedList.Add('Test' + IntToStr(i));
  // end;
  // tick := GetTickCount - tick;
  // ShowMessage(IntToStr(tick));
  // tick := GetTickCount;
  // for i := 0 to 10000000 do
  // begin
  // MyHashedList.IndexOf('Test' + IntToStr(i));
  // end;
  // tick := GetTickCount - tick;
  // ShowMessage(IntToStr(tick));
  // FreeAndNil(MyHashedList);
  // s := 'Test';
  // Delete(s, 2, 2);
  // Insert('HAllo', s, 2);
  // ShowMessage(s);
  // ProgressForm.Show;
  // ProgressForm.State := bsOpCopy;
  // Copier := TFileCopier.Create('H:\Test\Lexware.Quicken.2006.Deluxe.v13.0.GERMAN.iso','H:\Test\Lexware.iso');
  // IsNetworkPath('\\');
  // dwDummy := ConnectToNetworkDriveW(GetFreeDriveLetter + ':', '\\Laptopchristian\Windows', '', '');
  // case dwDummy of
  // ERROR_ACCESS_DENIED : s := 'ERROR_ACCESS_DENIED';
  // ERROR_ALREADY_ASSIGNED : s := 'ERROR_ALREADY_ASSIGNED';
  // ERROR_BAD_DEV_TYPE : s := 'ERROR_BAD_DEV_TYPE';
  // ERROR_BAD_DEVICE : s := 'ERROR_BAD_DEVICE';
  // ERROR_BAD_NET_NAME : s := 'ERROR_BAD_NET_NAME';
  // ERROR_BAD_PROFILE : s := 'ERROR_BAD_PROFILE';
  // ERROR_BAD_PROVIDER : s := 'ERROR_BAD_PROVIDER';
  // ERROR_BUSY : s := 'ERROR_BUSY';
  // ERROR_CANCELLED : s := 'ERROR_CANCELLED';
  // ERROR_CANNOT_OPEN_PROFILE : s := 'ERROR_CANNOT_OPEN_PROFILE';
  // ERROR_DEVICE_ALREADY_REMEMBERED : s := 'ERROR_DEVICE_ALREADY_REMEMBERED';
  // ERROR_EXTENDED_ERROR : s := 'ERROR_EXTENDED_ERROR';
  // ERROR_INVALID_PASSWORD : s := 'ERROR_INVALID_PASSWORD';
  // ERROR_NO_NET_OR_BAD_PATH : s := 'ERROR_NO_NET_OR_BAD_PATH';
  // ERROR_NO_NETWORK : s := 'ERROR_NO_NETWORK ';
  // end;
  // ShowMessage(s);
  // S := GetFreeDriveLetter();
  // Thread1 := TRead.Create(true);
  // Thread2 := TRead.Create(true);
  // Thread3 := TRead.Create(true);
  // Thread4 := TRead.Create(true);
  // SetThreadAffinityMask(Thread1.Handle,1);
  // SetThreadAffinityMask(Thread2.Handle, 2);
  // SetThreadAffinityMask(Thread3.Handle,4);
  // SetThreadAffinityMask(Thread4.Handle,8);
  // Thread1.Resume;
  // Thread2.Resume;
  // Thread3.Resume;
  // Thread4.Resume;
  // ProgressForm.Show;
  // tick := GetTickCount;
  // ProgressForm.State := bsOpCopy;
  // FastFileCopy('M:\Vista32\Vista 32 Hard Disk.vhd', 'D:\Test\Vista 32 Hard Disk.vhd', @FastFileCopyCallBack);
  // tick := GetTickCount - tick;
  // ShowMessage(inttostr(Tick));
  // tick := GetTickCount;
  //
  // csUtils.FastFileCopy('C:\Test.txt', 'C:\Test2.txt');
  // tick := GetTickCount - tick;
  // ShowMessage(inttostr(Tick));
  // ShowMessage(SysErrorMessage(i));
  // ShowMessage(s);
  // S := 'Test';
  // s := EnCryptPW(s, 'cs');
  // ShowMessage(DecryptPw(s, 'cs'));
  // RunApplicationAndWait('C:\Dokumente und Einstellungen\Chef\Eigene Dateien\Borland Studio-Projekte\Winamp_Reanimate\getDLL.cmd', 5000);
  // ShowMessage('Fertig');
  // ProgressForm.Show;
  // WatchThread := TtDirWatch.Create(true);
  // WatchThread.AddWatchNode(tvSourceDestination.GetNodeData(tvSourceDestination.GetFirstChecked(csCheckedNormal)));
  // WatchThread.AddWatchNode(tvSourceDestination.GetNodeData(tvSourceDestination.GetNextChecked(tvSourceDestination.GetFirstChecked(csCheckedNormal))));
  // WatchThread.Resume;
  // pbStatusbar.Position := 52.853;
  // Delay(1000);
  // pbStatusbar.Position := 0;
  // Delay(1000);
  // pbStatusbar.Position := 90;
  // Delay(1000);
  // skipFiles := TStringlist.Create;
  // LogFile := TLogFile.Create(sLogPath, 'Backupper.log', 'yyyy.mm.dd', '', false, true);
  // LogFile.Translator := JvTranslate;
  // LogFile.DestroyLang := false;
  // //ShowMessage(LogFile.Translator.Translate('Strings', 'Loaded'));
  // LogFile.LogLevel := llDebug;
  // //s := LogFile.Write('0Test1');
  // //showmessage(s);
  // LogFile.Write('1Test2');
  // LogFile.Write('2Test1');
  // LogFile.Write('3Test2');
  // //ShowMessage(LogFile.ReadLine(1));
  // ShowMessage(LogFile.Write('Strings', 'Loaded', llDebug));
  // FreeandNil(LogFile);
  // nop;
  // ShowMessage(LogFile.FileName);
  // ShowMessage(inttostr(LogFile.FileSize));
  // ShowMessage(inttostr(LogFile.MaxSize));
  // ShowMessage(inttostr(LogFile.MaxSizeKB));
  // ShowMessage(inttostr(LogFile.MaxSizeMB));
  // SkipFiles := TStringList.Create;
  // SkipFiles.Sorted := true;
  // SkipFiles.Duplicates := dupIgnore;
  // SkipFiles.Add('.txt');
  // SkipFiles.Add('test');
  // SkipFiles.Add('test.bmp');
  // SkipFiles.Add('C:\Test1\Neuer Ordner\Neuer Ordner5\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neu Textdokument.txt');
  // fName :=
  // 'C:\Test1\Neuer Ordner\Neuer Ordner5\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neuer Ordner (2)\Neu Textdokument1.txt';
  // l := -1;
  // for i := 0 to SkipFiles.Count - 1 do
  // begin
  // s := SkipFiles.Strings[i];
  // if (s = extractfileext(fNAme)) or (s = CutExtension(extractFileName(fNAme))) or (s = extractfilename(fNAme)) or (s = fNAme) then
  // begin
  // l := 1;
  // break;
  // end;
  // end;
  // if l <> -1 then
  // ShowMessage('gefunden');
  // ShowMessage(inttostr(GetClustersize('C:\')));
  // tAlarms.Enabled := true;
  // Showmessage(JvTranslate.Translate('Strings', 'NoNewVersionAvailable'));
  // Showmessage(JvTranslate.Translate('Strings', 'UpdatingEndInfo'));
  // System.Assign(outfile, 'C:\Test1\test.txt');
  // Reset(outfile, 1);
  // FileSetDate(TFileRec(outfile).Handle, 859548856);
  // CloseFile(outfile)
  // ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'Update.cmd'), '', nil,
  // SW_Show);
  // showmessage(syserrormessage(FastFileCopy('H:\FightClub.iso', 'H:\FightClub2.iso',
  // @FastFileCopyCallBack)));
  // ShowMessage(IntToStr(GetCPUCount));
  { AHWND := OpenProcess(PROCESS_QUERY_INFORMATION, true, GetCurrentProcessId
    {GetPidFromProcessName(extractfilename(Application.ExeName)));

    if GetProcessAffinityMask(AHWND, dwPAffinity, dwDummy) then
    begin
    showmessage(inttostr(dwPAffinity));
    end
    else
    begin
    showmessage(Syserrormessage(GetLAstError))
    end;
    {Log.SaveToFile('C:\test1\Log.txt');
    Log.Clear;
    Log.Free;
    for i := low(SourceFileList) to high(SourceFileList) do
    begin
    SourceFileList[i].SaveToFile('C:\test1\SourceFolder' + inttostr(i) + '.txt');
    SourceFileList[i].Clear;
    SourceFileList[i].Free;
    end;
    for j := 0 to high(DestFileList) do
    begin
    DestFileList[j].SaveToFile('C:\test1\DestFolder' + inttostr(j) + '.txt');
    DestFileList[j].Clear;
    DestFileList[j].Free;
    end;
    for k := 0 to high(CopyFilesList) do
    begin
    CopyFilesList[k].SaveToFile('C:\test1\CopyFiles' + inttostr(k) + '.txt');
    CopyFilesList[k].Clear;
    CopyFilesList[k].Free;
    end;
    for l := 0 to high(MoveFilesList) do
    begin
    MoveFilesList[l].SaveToFile('C:\test1\MoveFiles' + inttostr(l) + '.txt');
    MoveFilesList[l].Clear;
    MoveFilesList[l].Free;
    end;
    for m := 0 to high(MoveFilesList) do
    begin
    DeleteFilesList[m].SaveToFile('C:\test1\DeleteFiles' + inttostr(m) + '.txt');
    DeleteFilesList[m].Clear;
    FreeandNil(DeleteFilesList[m])
    end;
    DeleteDirList.SaveToFile('C:\test1\DeleteDir.txt');
    DeleteDirList.Clear;
    DeleteDirList.Free; }
{$ENDIF}
end;

procedure TMainForm.ctiBackupperDblClick(Sender : TObject);
begin
  if IsWinVistaOrHigher then
  begin
    if MainForm.Visible then
    begin
      pmtHideClick(Sender);
    end
    else
    begin
      pmtShowClick(Sender);
    end;
  end;
end;

procedure TMainForm.acCancelExecute(Sender : TObject);
// Abbrechen
begin
  SetStatusbarText(sbMainForm, JvTranslate.Translate('GUIStrings', 'Canceling'));
  if bSuspended then // Job angehalten?
  begin
    btSuspend.Click;
  end;
  acSuspend.Visible := false;
  bCanceled := true;
  DestThread.Terminate;
  SourceThread.Terminate;
  SortThread.Terminate;
  OperationThread.Terminate;
end;

procedure TMainForm.WMQUERYENDSESSION(var msg : TMessage);
// Aktionen beim Herunterfahren
var
  WaitResult : DWORD;
  bShutdownNo : Boolean;
  TreeData : PTreeData;
  Node : PVirtualNode;
  s : string;
begin
  msg.Result := Integer(true);
  if msg.LParam = Integer(ENDSESSION_FORCEFULSHUTDOWN) then
  begin
    close;
  end
  else
  begin
    bLogoff := (msg.LParam = Integer(ENDSESSION_LOGOFF));
    if bConfirmShutdown and acCancel.Enabled and not pmtEnableTimer.Checked and
    // Herunterfahren abbrechen?
      (MessageDlg(JvTranslate.Translate('GUIStrings', 'EndBackup'), mtConfirmation, mbYesNo, 0) = mrYes) then
    begin
      bShutdownNo := true;
    end
    else
    begin
      bShutdownNo := false
    end;
    if (bEndBackupbevoreShutdown or bShutdownNo) and acCancel.Enabled then
    begin
      if iShutdownMode <= 0 then
      begin
        if (ShutdownRestartDialog.ShowModal <> mrYes) then
        begin
          iShutdownMode := 1;
        end
        else
        begin
          iShutdownMode := 2;
        end;
      end;
      msg.Result := Integer(false);
      ShutdownBlockReasonSet(MainForm.Handle, JvTranslate.Translate('GUIStrings', 'ShutdownBlock'));
    end
    else
    begin
      if acCancel.Enabled and not bCanceled then // Laufende Jobs beenden
      begin
        bCanceled := true;
        if (DestThread <> nil) and (SourceThread <> nil) and (SortThread <> nil) then
        begin
          if bSuspended then
          begin
            btSuspend.Click;
          end;
          DestThread.Terminate;
          SourceThread.Terminate;
          SortThread.Terminate;
          OperationThread.Terminate;
          repeat
            WaitResult := WaitforMultipleObjects(Length(ThreadArray), @ThreadArray, true, 1000);
            if WaitResult <> WAIT_OBJECT_0 then
            begin
              Application.ProcessMessages;
            end;
          until WaitResult = WAIT_OBJECT_0;
        end;
      end;
      if not bDoSdEvent then
      begin
        Node := tvSourceDestination.GetFirst;
        repeat
          if Node = nil then // Abfrage auf vorhandene Jobs
          begin
            break;
          end;
          if Assigned(Node) then
          begin
            if Node.ChildCount >= 1 then
            begin
              Node := tvSourceDestination.GetNext(Node);
            end;
            TreeData := tvSourceDestination.GetNodeData(Node);
            if TreeData^.Timer[0].bOnShutdown then
            begin
              bDoSdEvent := true;
              if iShutdownMode <= 0 then
              begin
                if (ShutdownRestartDialog.ShowModal <> mrYes) then
                begin
                  iShutdownMode := 1;
                end
                else
                begin
                  iShutdownMode := 2;
                end;
              end;
              msg.Result := Integer(false);
              ShutdownBlockReasonSet(MainForm.Handle, JvTranslate.Translate('GUIStrings', 'ShutdownBlock'));
              FLast := DateTimeToTimeStamp(Now);
              Dec(FLast.Time, 1000);
              if not pmtEnableTimer.Checked then
              begin
                pmtEnableTimerClick(pmtEnableTimer);
              end;
              s := LogFile.Write('LogStrings', 'ShutdownCanceled');
              SetStatusbarText(sbMainForm, s);
              break;
            end;
          end;
          Node := tvSourceDestination.GetNext(Node);
        until (Node = nil) or bCanceled;
      end;
    end;
    if msg.Result <> 0 then
    begin
      ShutdownBlockReasonDelete(MainForm.Handle);
      close;
    end;
  end;
end;

procedure TMainForm.WMENDSESSION(var msg : TMessage);
begin
  close;
end;

procedure TMainForm.SaveSettings;
// Einstellungen speichern
var
  i, j, k : Integer;
  TreeData : PTreeData;
  Node : PVirtualNode;
  sName : string;
  bIsExpanded : Boolean;

begin
  sxmlMainForm.Root.Items.Clear;
  sxmlMainForm.Root.Items.Add('FileVersion', 16);
  with sxmlMainForm.Root.Items.Add('tvSourceDestination') do
  begin
    Node := tvSourceDestination.GetFirst;
    if Node <> nil then
    begin
      i := 0;
      repeat
        if Node.ChildCount >= 1 then
        begin
          Node := tvSourceDestination.GetFirstChild(Node);
        end;
        sName := '';
        bIsExpanded := false;
        with Items.Add('Job' + IntToStr(i)) do
        begin
          if tvSourceDestination.GetNodeLevel(Node) = 1 then
          begin
            bIsExpanded := tvSourceDestination.Expanded[Node.Parent];
            TreeData := tvSourceDestination.GetNodeData(Node.Parent);
            sName := TreeData^.sName + ' ';
          end;
          TreeData := tvSourceDestination.GetNodeData(Node);
          Items.Add('bCheckedItem', VSTHChecked(tvSourceDestination, Node));
          Items.Add('sName', sName + TreeData^.sName);
          Items.Add('sSource', TreeData^.sSource);
          Items.Add('sDest', TreeData^.sDest);
          Items.Add('sFileMask', TreeData^.sFileMask);
          Items.Add('sSourceDriveLabel', TreeData^.sSourceDriveLabel);
          Items.Add('sDestDriveLabel', TreeData^.sDestDriveLabel);
          Items.Add('sUsername', TreeData^.sUsername);
          Items.Add('sPassword', TreeData^.sPassword);
          Items.Add('bSubFolders', TreeData^.bSubFolders);
          Items.Add('bDeleteFiles', TreeData^.bDeleteFiles);
          Items.Add('bDoNotCopyFlags', TreeData^.bDoNotCopyFlags);
          Items.Add('bCompress', TreeData^.bCompress);
          Items.Add('bEnableNetworkLogon', TreeData^.bEnableNetworkLogon);
          Items.Add('CompareMode', Integer(TreeData^.CompareMode));
          Items.Add('iTimeDiff', TreeData^.iTimeDiff);
          if TreeData^.iImageIndex = 0 then
            TreeData^.iImageIndex := 2;
          Items.Add('iImageIndex', TreeData^.iImageIndex);
          Items.Add('LastRun', DateTimeToStr(TreeData^.LastRun));
          Items.Add('bIsExpanded', bIsExpanded);
          with Items.Add('Skiplists') do
          begin
            with Items.Add('SkipFolders') do
            begin
              if TreeData^.SkipFolders <> nil then
              begin
                for j := 0 to TreeData^.SkipFolders.Count - 1 do
                begin
                  Items.Add('SkipFolder' + IntToStr(j), TreeData^.SkipFolders.Strings[j]);
                end;
              end;
            end;
            with Items.Add('SkipFiles') do
            begin
              if TreeData^.SkipFiles <> nil then
              begin
                for j := 0 to TreeData^.SkipFiles.Count - 1 do
                begin
                  Items.Add('SkipFile' + IntToStr(j), TreeData^.SkipFiles.Strings[j]);
                end;
              end;
            end;
          end;
          with Items.Add('Timer') do
          begin
            for j := 0 to high(ATimerData) do
            begin
              Items.Add('bEnabled' + IntToStr(j), TreeData^.Timer[j].bEnabled);
              Items.Add('bOnShutdown' + IntToStr(j), TreeData^.Timer[j].bOnShutdown);
              Items.Add('Time' + IntToStr(j), DateTimeToStr(TreeData^.Timer[j].Time));
              Items.Add('Kind' + IntToStr(j), Integer(TreeData^.Timer[j].Kind));
              Items.Add('WatchMode' + IntToStr(j), Integer(TreeData^.Timer[j].WatchMode));
              Items.Add('iMulti' + IntToStr(j), TreeData^.Timer[j].iMulti);
            end;
          end;
          with Items.Add('Application') do
          begin
            k := 0;
            for j := 0 to high(AApplicationData) do
            begin
              if TreeData^.Application[j].sFileName <> '' then
              begin
                Items.Add('sFileName' + IntToStr(k), TreeData^.Application[j].sFileName);
                Items.Add('sParam' + IntToStr(k), TreeData^.Application[j].sParam);
                Items.Add('iTimeout' + IntToStr(k), TreeData^.Application[j].iTimeout);
                Items.Add('Action' + IntToStr(k), Integer(TreeData^.Application[j].Action));
                Inc(k);
              end;
            end;
            Items.Add('iApplicationCount', k);
          end;
        end;
        Node := tvSourceDestination.GetNext(Node);
        Inc(i);
      until Node = nil;
    end;
  end;
  with sxmlMainForm.Root.Items.Add('Settings') do
  begin
    with Items.Add('Logging') do
    begin
      Items.Add('sLogPath', sLogPath);
      Items.Add('bLog', bLog);
      Items.Add('bUseDescription', bUseDescription);
      Items.Add('iLogLevel', Integer(LogLevel));
    end;
    with Items.Add('Programm') do
    begin
      Items.Add('iWaitTimeout', iWaitTimeout);
      Items.Add('iLang', iLang);
      Items.Add('iThreadPriority', Integer(iThreadPriority));
      if WindowState = wsNormal then
      begin
        Items.Add('iHeight', MainForm.Height);
        Items.Add('iLeft', MainForm.Left);
        Items.Add('iTop', MainForm.Top);
        Items.Add('iWidth', MainForm.Width);
      end
      else
      begin
        WindowState := wsNormal;
        Hide;
        Items.Add('iHeight', MainForm.Height);
        Items.Add('iLeft', MainForm.Left);
        Items.Add('iTop', MainForm.Top);
        Items.Add('iWidth', MainForm.Width);
        WindowState := wsMaximized;
      end;
      Items.Add('iColumnCount', tvSourceDestination.Header.Columns.Count);
      for j := 0 to tvSourceDestination.Header.Columns.Count - 1 do
      begin
        Items.Add('iColumnWidth' + IntToStr(j), tvSourceDestination.Header.Columns[j].Width);
        Items.Add('iColumnPos' + IntToStr(j), tvSourceDestination.Header.Columns[j].Position);
        Items.Add('bColumnVisible' + IntToStr(j), coVisible in tvSourceDestination.Header.Columns[j].Options);
      end;
      Items.Add('iAppColumnCount', TEditChange.vstApplications.Header.Columns.Count);
      for j := 0 to TEditChange.vstApplications.Header.Columns.Count - 1 do
      begin
        Items.Add('iAppColumnWidth' + IntToStr(j), TEditChange.vstApplications.Header.Columns[j].Width);
        Items.Add('iAppColumnPos' + IntToStr(j), TEditChange.vstApplications.Header.Columns[j].Position);
        Items.Add('bAppColumnVisible' + IntToStr(j), coVisible in TEditChange.vstApplications.Header.Columns[j]
          .Options);
      end;
      Items.Add('bShutdown', bShutdown);
      Items.Add('bForce', bForce);
      Items.Add('bWindowState', WindowState = wsMaximized);
      Items.Add('bEndBackupbevoreShutdown', bEndBackupbevoreShutdown);
      Items.Add('bConfirmShutdown', bConfirmShutdown);
      Items.Add('bConfirmDelete', bConfirmDelete);
      Items.Add('bClose', bClose);
      Items.Add('bCheckUpdateAuto', mmCheckUpdateAuto.Checked);
      Items.Add('bUpdateAuto', mmLoadUpdateAuto.Checked);
      Items.Add('bStartInTray', bStartInTray);
      Items.Add('bMinimizeToTray', tvAutoHide in ctiBackupper.Visibility);
      Items.Add('bExtProgress', bExtProgress);
    end;
  end;
  try
    CreateDirectoryRecurse('', sSettingsPath, nil);
    sxmlMainForm.SaveToFile(sSettingsPath + 'Settings.xml');
  except
    { TODO : Medung Settings konnten nicht gespeichert werden mit Fehleranzeige }
  end;
end;

procedure TMainForm.FormCloseQuery(Sender : TObject; var CanClose : Boolean);
// Aktionen vorm schliesen
var
  WaitResult : DWORD;
begin
  CanClose := false;
  if acCancel.Enabled and not bCanceled then
  begin
    if (MessageDlg(JvTranslate.Translate('GUIStrings', 'RealyCancel'), mtConfirmation, mbYesNo, 0) = mrYes) then
    // wirklich schließen?
    begin
      bCanceled := true;
      tAlarms.Enabled := false;
      MainForm.Caption := JvTranslate.Translate('GUIStrings', 'Closing');
      SetStatusbarText(sbMainForm, JvTranslate.Translate('GUIStrings', 'Closing'));
      LogFile.Write('LogStrings', 'Closing');
      if (DestThread <> nil) and (SourceThread <> nil) and (SortThread <> nil) then
      begin
        if bSuspended then
        begin
          btSuspend.Click
        end;
        DestThread.Terminate;
        SourceThread.Terminate;
        SortThread.Terminate;
        OperationThread.Terminate;
        repeat
          WaitResult := WaitforMultipleObjects(Length(ThreadArray), @ThreadArray, true, 1000);
          if WaitResult = WAIT_TIMEOUT then
          begin
            Application.ProcessMessages;
          end;
        until WaitResult <> WAIT_TIMEOUT;
      end;
      if UpdateThread <> nil then
      begin
        UpdateThread.Terminate;
        repeat
          WaitResult := WaitforSingleObject(UpdateThread.Handle, 1000);
          if WaitResult = WAIT_TIMEOUT then
          begin
            Application.ProcessMessages;
          end;
        until WaitResult <> WAIT_TIMEOUT;
      end;
      FreeAndNil(UpdateThread);
      if WatchThread <> nil then
      begin
        if WatchThread.Suspended then
        begin
          WatchThread.Resume;
        end;
        WatchThread.Terminate;
        repeat
          WaitResult := WaitforSingleObject(WatchThread.Handle, 1000);
          if WaitResult = WAIT_TIMEOUT then
          begin
            Application.ProcessMessages;
          end;
        until WaitResult <> WAIT_TIMEOUT;
      end;
      FreeAndNil(WatchThread);
      FreeAndNil(ThreadIdList);
      CanClose := true;
    end;
  end
  else
  begin
    MainForm.Caption := JvTranslate.Translate('GUIStrings', 'Closing');
    SetStatusbarText(sbMainForm, JvTranslate.Translate('GUIStrings', 'Closing'));
    LogFile.Write('LogStrings', 'Closing');
    if UpdateThread <> nil then
    begin
      UpdateThread.Terminate;
      repeat
        WaitResult := WaitforSingleObject(UpdateThread.Handle, 1000);
        if WaitResult = WAIT_TIMEOUT then
        begin
          Application.ProcessMessages;
        end;
      until WaitResult <> WAIT_TIMEOUT;
    end;
    FreeAndNil(UpdateThread);
    if WatchThread <> nil then
    begin
      if WatchThread.Suspended then
      begin
        WatchThread.Resume;
      end;
      WatchThread.Terminate;
      repeat
        WaitResult := WaitforSingleObject(WatchThread.Handle, 1000);
        if WaitResult = WAIT_TIMEOUT then
        begin
          Application.ProcessMessages;
        end;
      until WaitResult <> WAIT_TIMEOUT;
    end;
    FreeAndNil(WatchThread);
    FreeAndNil(ThreadIdList);
    tAlarms.Enabled := false;
    CanClose := true;
  end;
end;

procedure TMainForm.FormCreate(Sender : TObject);
begin
  ThreadIdList := TStringList.Create;
  ThreadIdList.NameValueSeparator := ';';
end;

procedure TMainForm.mmEndClick(Sender : TObject);
// schliesen
begin
  close;
end;

procedure TMainForm.mmAboutClick(Sender : TObject);
// Aboutbox anzeigen
begin
  AboutBox.ShowModal
end;

procedure TMainForm.FormClose(Sender : TObject; var Action : TCloseAction);
// Aktionen beim schliesen
begin
  ctiBackupper.Animated := true;
  if LogFile <> nil then // Log speichern
  begin
    if bCanceled then // abgebrochen?
    begin
      LogFile.Write('LogStrings', 'Canceled');
    end;
    LogFile.Write('LogStrings', 'Closed');
    FreeAndNil(LogFile);
  end;
  if not bWrongSettings then
  begin
    SaveSettings; // Optionen speichern
  end;
end;

procedure TMainForm.mmKillClick(Sender : TObject);
// Anwendung killen
begin
  halt;
end;

procedure TMainForm.FormResize(Sender : TObject);
// Positionen der Statusbar setzen
begin
  // sbMainform.Panels[0].Width := MainForm.Width - 108;
  // pbStatusBar.Left := MainForm.Width - 108;
end;

procedure TMainForm.tAutoBackupTimer(Sender : TObject);
// Automatisches Backup
begin
  tAutoBackup.Enabled := false;
  if acStart.Enabled then
  begin
    btBackup.Click;
  end;
end;

procedure TMainForm.LoadSettingsV10;
// Einstellungen Version 1.0 laden
var
  i, j : Integer;
  TreeData : TTreeData;
begin
  with sxmlMainForm.Root.Items.itemNamed['lvSourceDestination'] do
  begin
    tvSourceDestination.BeginUpdate;
    for i := 0 to Items.itemNamed['iItemsCount'].IntValue - 1 do
    begin
      TreeData.sName := IntToStr(i);
      TreeData.sSource := Items.itemNamed['sSourceItem' + IntToStr(i)].Value;
      TreeData.sDest := Items.itemNamed['sDestItem' + IntToStr(i)].Value;
      TreeData.sFileMask := Items.itemNamed['sFileMask' + IntToStr(i)].Value;
      TreeData.sSourceDriveLabel := '';
      TreeData.sDestDriveLabel := '';
      TreeData.sUsername := '';
      TreeData.sPassword := '';
      TreeData.bSubFolders := Items.itemNamed['bSubItems' + IntToStr(i)].BoolValue;
      TreeData.bDeleteFiles := false;
      TreeData.bDoNotCopyFlags := false;
      TreeData.bCompress := false;
      TreeData.CompareMode := cmHash;
      TreeData.iTimeDiff := 0;
      TreeData.SkipFolders := TStringList.Create;
      TreeData.SkipFiles := TStringList.Create;
      TreeData.SkipFolders.Sorted := true;
      TreeData.SkipFiles.Sorted := true;
      TreeData.SkipFolders.Duplicates := dupIgnore;
      TreeData.SkipFiles.Duplicates := dupIgnore;
      for j := 0 to high(ATimerData) do
      begin
        TreeData.Timer[j].bEnabled := false;
        TreeData.Timer[j].bOnShutdown := false;
        TreeData.Timer[j].Time := 0;
        TreeData.Timer[j].Kind := tkOneShot;
        TreeData.Timer[j].WatchMode := wmNone;
        TreeData.Timer[j].iMulti := 1;
      end;
      TreeData.Application[0].sFileName := Items.itemNamed['sApplication' + IntToStr(i)].Value;
      TreeData.Application[0].sParam := '';
      TreeData.Application[0].iTimeout := Items.itemNamed['Programm'].Items.itemNamed['iWaitTimeout'].IntValue;
      TreeData.Application[0].Action := aaCloseBeforeAndWait;
      TreeData.iImageIndex := - 1;
      VSTHAdd(tvSourceDestination, TreeData, Items.itemNamed['bCheckedItem' + IntToStr(i)].BoolValue);
    end;
    tvSourceDestination.EndUpdate;
  end;
  with sxmlMainForm.Root.Items.itemNamed['Settings'] do
  begin
    with Items.itemNamed['Logging'] do
    begin
      sLogPath := Items.itemNamed['sLogPath'].Value;
      bLog := Items.itemNamed['bLog'].BoolValue;
      bUseDescription := true;
      LogLevel := llError;
    end;
    with Items.itemNamed['Programm'] do
    begin
      MainForm.Height := Items.itemNamed['iHeight'].IntValue;
      MainForm.Left := Items.itemNamed['iLeft'].IntValue;
      MainForm.Top := Items.itemNamed['iTop'].IntValue;
      MainForm.Width := Items.itemNamed['iWidth'].IntValue;
      iWaitTimeout := Items.itemNamed['iWaitTimeout'].IntValue;
      iLang := Items.itemNamed['iLang'].IntValue;
      iThreadPriority := TThreadPriority(Items.itemNamed['iThreadPriority'].IntValue);
      tvSourceDestination.Header.Columns[1].Width := Items.itemNamed['iColumWidth1'].IntValue;
      tvSourceDestination.Header.Columns[2].Width := Items.itemNamed['iColumWidth2'].IntValue;
      bShutdown := Items.itemNamed['bShutdown'].BoolValue;
      bForce := Items.itemNamed['bForce'].BoolValue;
      if Items.itemNamed['bWindowState'].BoolValue then
      begin
        WindowState := wsMaximized;
      end
      else
      begin
        WindowState := wsNormal;
      end;
      bEndBackupbevoreShutdown := Items.itemNamed['bEndBackupbevoreShutdown'].BoolValue;
      bConfirmShutdown := Items.itemNamed['bConfirmShutdown'].BoolValue;
      bConfirmDelete := Items.itemNamed['bConfirmDelete'].BoolValue;
      bClose := Items.itemNamed['bClose'].BoolValue;
      case iLang of
        0 :
          mmLangGerman.Click;
        1 :
          mmLangEnglish.Click;
        2 :
          mmLangSpecial.Click;
      end;
      mmCheckUpdateAuto.Checked := false;
      mmLoadUpdateAuto.Checked := false;
    end;
  end;
end;

procedure TMainForm.LoadSettingsV11;
// Einstellungen Version 1.1 laden
var
  i, j : Integer;
  TreeData : TTreeData;
begin
  with sxmlMainForm.Root.Items.itemNamed['lvSourceDestination'] do
  begin
    tvSourceDestination.BeginUpdate;
    for i := 0 to Items.itemNamed['iItemsCount'].IntValue - 1 do
    begin
      TreeData.sName := IntToStr(i);
      TreeData.sSource := Items.itemNamed['sSourceItem' + IntToStr(i)].Value;
      TreeData.sDest := Items.itemNamed['sDestItem' + IntToStr(i)].Value;
      TreeData.sFileMask := Items.itemNamed['sFileMask' + IntToStr(i)].Value;
      TreeData.sSourceDriveLabel := '';
      TreeData.sDestDriveLabel := '';
      TreeData.sUsername := '';
      TreeData.sPassword := '';
      TreeData.bSubFolders := Items.itemNamed['bSubItems' + IntToStr(i)].BoolValue;
      TreeData.bDeleteFiles := Items.itemNamed['bDeleteFiles' + IntToStr(i)].BoolValue;
      TreeData.bDoNotCopyFlags := false;
      TreeData.bCompress := false;
      TreeData.CompareMode := TCompareMode(Items.itemNamed['iCompareMethod' + IntToStr(i)].IntValue);
      TreeData.iTimeDiff := 0;
      TreeData.SkipFolders := TStringList.Create;
      TreeData.SkipFiles := TStringList.Create;
      TreeData.SkipFolders.Sorted := true;
      TreeData.SkipFiles.Sorted := true;
      TreeData.SkipFolders.Duplicates := dupIgnore;
      TreeData.SkipFiles.Duplicates := dupIgnore;
      for j := 0 to high(ATimerData) do
      begin
        TreeData.Timer[j].bEnabled := false;
        TreeData.Timer[j].bOnShutdown := false;
        TreeData.Timer[j].Time := 0;
        TreeData.Timer[j].Kind := tkOneShot;
        TreeData.Timer[j].WatchMode := wmNone;
        TreeData.Timer[j].iMulti := 1;
      end;
      for j := 0 to high(AApplicationData) do
      begin
        TreeData.Application[j].sFileName := '';
        TreeData.Application[j].sParam := '';
        TreeData.Application[j].iTimeout := 0;
        TreeData.Application[j].Action := aaNone;
      end;
      if Items.itemNamed['bCloseApplication'].BoolValue then
      begin
        TreeData.Application[0].sFileName := Items.itemNamed['sApplication' + IntToStr(i)].Value;
        TreeData.Application[0].sParam := '';
        TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
          .Items.itemNamed['iWaitTimeout'].IntValue;
        TreeData.Application[0].Action := aaCloseBeforeAndWait;
      end;
      if Items.itemNamed['bCloseApplication'].BoolValue and Items.itemNamed['bRestartApplication'].BoolValue then
      begin
        TreeData.Application[1].sFileName := Items.itemNamed['sApplication' + IntToStr(i)].Value;
        TreeData.Application[0].sParam := '';
        TreeData.Application[1].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
          .Items.itemNamed['iWaitTimeout'].IntValue;
        TreeData.Application[1].Action := aaRunAfter;
      end;
      if Items.itemNamed['bRestartApplication'].BoolValue then
      begin
        TreeData.Application[0].sFileName := Items.itemNamed['sApplication' + IntToStr(i)].Value;
        TreeData.Application[0].sParam := '';
        TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
          .Items.itemNamed['iWaitTimeout'].IntValue;
        TreeData.Application[0].Action := aaRunAfter;
      end;
      TreeData.iImageIndex := - 1;
      VSTHAdd(tvSourceDestination, TreeData, Items.itemNamed['bCheckedItem' + IntToStr(i)].BoolValue);
    end;
    tvSourceDestination.EndUpdate;
  end;
  with sxmlMainForm.Root.Items.itemNamed['Settings'] do
  begin
    with Items.itemNamed['Logging'] do
    begin
      sLogPath := Items.itemNamed['sLogPath'].Value;
      bLog := Items.itemNamed['bLog'].BoolValue;
      bUseDescription := true;
      LogLevel := TLogLevel(Items.itemNamed['iLogLevel'].IntValue);
    end;
    with Items.itemNamed['Programm'] do
    begin
      MainForm.Height := Items.itemNamed['iHeight'].IntValue;
      MainForm.Left := Items.itemNamed['iLeft'].IntValue;
      MainForm.Top := Items.itemNamed['iTop'].IntValue;
      MainForm.Width := Items.itemNamed['iWidth'].IntValue;
      iWaitTimeout := Items.itemNamed['iWaitTimeout'].IntValue;
      iLang := Items.itemNamed['iLang'].IntValue;
      iThreadPriority := TThreadPriority(Items.itemNamed['iThreadPriority'].IntValue);
      tvSourceDestination.Header.Columns[1].Width := Items.itemNamed['iColumWidth1'].IntValue;
      tvSourceDestination.Header.Columns[2].Width := Items.itemNamed['iColumWidth2'].IntValue;
      bShutdown := Items.itemNamed['bShutdown'].BoolValue;
      bForce := Items.itemNamed['bForce'].BoolValue;
      if Items.itemNamed['bWindowState'].BoolValue then
      begin
        WindowState := wsMaximized;
      end
      else
      begin
        WindowState := wsNormal;
      end;
      bEndBackupbevoreShutdown := Items.itemNamed['bEndBackupbevoreShutdown'].BoolValue;
      bConfirmShutdown := Items.itemNamed['bConfirmShutdown'].BoolValue;
      bConfirmDelete := Items.itemNamed['bConfirmDelete'].BoolValue;
      bClose := Items.itemNamed['bClose'].BoolValue;
      case iLang of
        0 :
          mmLangGerman.Click;
        1 :
          mmLangEnglish.Click;
        2 :
          mmLangSpecial.Click;
      end;
      mmCheckUpdateAuto.Checked := Items.itemNamed['bCheckUpdateAuto'].BoolValue;
      mmLoadUpdateAuto.Checked := Items.itemNamed['bUpdateAuto'].BoolValue;
    end;
  end;
end;

procedure TMainForm.LoadSettingsV12;
// Einstellungen Version 1.2 laden
var
  i, j : Integer;
  Node : PVirtualNode;
  TreeData : TTreeData;
begin
  with sxmlMainForm.Root.Items.itemNamed['tvSourceDestination'] do
  begin
    tvSourceDestination.BeginUpdate;
    for i := 0 to (Items.Count div 13) - 1 do
    // 13 = Anzahl der gespeicherten Optionen
    begin
      TreeData.sName := Items.itemNamed['sName' + IntToStr(i)].Value;
      TreeData.sSource := Items.itemNamed['sSourceItem' + IntToStr(i)].Value;
      TreeData.sDest := Items.itemNamed['sDestItem' + IntToStr(i)].Value;
      TreeData.sFileMask := Items.itemNamed['sFileMask' + IntToStr(i)].Value;
      TreeData.sSourceDriveLabel := '';
      TreeData.sDestDriveLabel := '';
      TreeData.sUsername := '';
      TreeData.sPassword := '';
      TreeData.bSubFolders := Items.itemNamed['bSubFolders' + IntToStr(i)].BoolValue;
      TreeData.bDeleteFiles := Items.itemNamed['bDeleteFiles' + IntToStr(i)].BoolValue;
      TreeData.bDoNotCopyFlags := false;
      TreeData.bCompress := false;
      TreeData.CompareMode := TCompareMode(Items.itemNamed['iCompareMethod' + IntToStr(i)].IntValue);
      TreeData.iTimeDiff := Items.itemNamed['iTimeDiff' + IntToStr(i)].IntValue;
      TreeData.SkipFolders := TStringList.Create;
      TreeData.SkipFiles := TStringList.Create;
      TreeData.SkipFolders.Sorted := true;
      TreeData.SkipFiles.Sorted := true;
      TreeData.SkipFolders.Duplicates := dupIgnore;
      TreeData.SkipFiles.Duplicates := dupIgnore;
      for j := 0 to high(ATimerData) do
      begin
        TreeData.Timer[j].bEnabled := false;
        TreeData.Timer[j].bOnShutdown := false;
        TreeData.Timer[j].Time := 0;
        TreeData.Timer[j].Kind := tkOneShot;
        TreeData.Timer[j].WatchMode := wmNone;
        TreeData.Timer[j].iMulti := 1;
      end;
      for j := 0 to high(AApplicationData) do
      begin
        TreeData.Application[j].sFileName := '';
        TreeData.Application[j].sParam := '';
        TreeData.Application[j].iTimeout := 0;
        TreeData.Application[j].Action := aaNone;
      end;
      if Items.itemNamed['bCloseApplication'].BoolValue then
      begin
        TreeData.Application[0].sFileName := Items.itemNamed['sApplication' + IntToStr(i)].Value;
        TreeData.Application[0].sParam := '';
        TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
          .Items.itemNamed['iWaitTimeout'].IntValue;
        TreeData.Application[0].Action := aaCloseBeforeAndWait;
      end;
      if Items.itemNamed['bCloseApplication'].BoolValue and Items.itemNamed['bRestartApplication'].BoolValue then
      begin
        TreeData.Application[1].sFileName := Items.itemNamed['sApplication' + IntToStr(i)].Value;
        TreeData.Application[1].sParam := '';
        TreeData.Application[1].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
          .Items.itemNamed['iWaitTimeout'].IntValue;
        TreeData.Application[1].Action := aaRunAfter;
      end;
      if Items.itemNamed['bRestartApplication'].BoolValue then
      begin
        TreeData.Application[0].sFileName := Items.itemNamed['sApplication' + IntToStr(i)].Value;
        TreeData.Application[0].sParam := '';
        TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
          .Items.itemNamed['iWaitTimeout'].IntValue;
        TreeData.Application[0].Action := aaRunAfter;
      end;
      TreeData.iImageIndex := - 1;
      Node := VSTHAdd(tvSourceDestination, TreeData, Items.itemNamed['bCheckedItem' + IntToStr(i)].BoolValue);
      tvSourceDestination.Expanded[Node.Parent] := Items.itemNamed['bIsExpanded' + IntToStr(i)].BoolValue
    end;
    tvSourceDestination.EndUpdate;
  end;
  with sxmlMainForm.Root.Items.itemNamed['Settings'] do
  begin
    with Items.itemNamed['Logging'] do
    begin
      sLogPath := Items.itemNamed['sLogPath'].Value;
      bLog := Items.itemNamed['bLog'].BoolValue;
      bUseDescription := true;
      LogLevel := TLogLevel(Items.itemNamed['iLogLevel'].IntValue);
    end;
    with Items.itemNamed['Programm'] do
    begin
      MainForm.Height := Items.itemNamed['iHeight'].IntValue;
      MainForm.Left := Items.itemNamed['iLeft'].IntValue;
      MainForm.Top := Items.itemNamed['iTop'].IntValue;
      MainForm.Width := Items.itemNamed['iWidth'].IntValue;
      iWaitTimeout := Items.itemNamed['iWaitTimeout'].IntValue;
      iLang := Items.itemNamed['iLang'].IntValue;
      iThreadPriority := TThreadPriority(Items.itemNamed['iThreadPriority'].IntValue);
      tvSourceDestination.Header.Columns[0].Width := Items.itemNamed['iColumWidth0'].IntValue;
      tvSourceDestination.Header.Columns[1].Width := Items.itemNamed['iColumWidth1'].IntValue;
      tvSourceDestination.Header.Columns[2].Width := Items.itemNamed['iColumWidth2'].IntValue;
      bShutdown := Items.itemNamed['bShutdown'].BoolValue;
      bForce := Items.itemNamed['bForce'].BoolValue;
      if Items.itemNamed['bWindowState'].BoolValue then
      begin
        WindowState := wsMaximized;
      end
      else
      begin
        WindowState := wsNormal;
      end;
      bEndBackupbevoreShutdown := Items.itemNamed['bEndBackupbevoreShutdown'].BoolValue;
      bConfirmShutdown := Items.itemNamed['bConfirmShutdown'].BoolValue;
      bConfirmDelete := Items.itemNamed['bConfirmDelete'].BoolValue;
      bClose := Items.itemNamed['bClose'].BoolValue;
      case iLang of
        0 :
          mmLangGerman.Click;
        1 :
          mmLangEnglish.Click;
        2 :
          mmLangSpecial.Click;
      end;
      mmCheckUpdateAuto.Checked := Items.itemNamed['bCheckUpdateAuto'].BoolValue;
      mmLoadUpdateAuto.Checked := Items.itemNamed['bUpdateAuto'].BoolValue;
    end;
  end;
end;

procedure TMainForm.LoadSettingsV13;
// Einstellungen Version 1.3 laden
var
  i, j : Integer;
  Node : PVirtualNode;
  TreeData : TTreeData;
  SaveVisibilities : TTrayVisibilities;
begin
  with sxmlMainForm.Root.Items.itemNamed['tvSourceDestination'] do
  begin
    tvSourceDestination.BeginUpdate;
    for i := 0 to Items.Count - 1 do
    begin
      with Items.itemNamed['Job' + IntToStr(i)] do
      // vermeidet das Zählen der Job Optionen
      begin
        TreeData.sName := Items.itemNamed['sName'].Value;
        TreeData.sSource := Items.itemNamed['sSourceItem'].Value;
        TreeData.sDest := Items.itemNamed['sDestItem'].Value;
        TreeData.sFileMask := Items.itemNamed['sFileMask'].Value;
        TreeData.sSourceDriveLabel := '';
        TreeData.sDestDriveLabel := '';
        TreeData.sUsername := '';
        TreeData.sPassword := '';
        TreeData.bSubFolders := Items.itemNamed['bSubFolders'].BoolValue;
        TreeData.bDeleteFiles := Items.itemNamed['bDeleteFiles'].BoolValue;
        TreeData.bDoNotCopyFlags := false;
        TreeData.bCompress := false;
        TreeData.iTimeDiff := Items.itemNamed['iTimeDiff'].IntValue;
        TreeData.CompareMode := TCompareMode(Items.itemNamed['iCompareMethod'].IntValue);
        TreeData.SkipFolders := TStringList.Create;
        TreeData.SkipFiles := TStringList.Create;
        TreeData.SkipFolders.Sorted := true;
        TreeData.SkipFiles.Sorted := true;
        TreeData.SkipFolders.Duplicates := dupIgnore;
        TreeData.SkipFiles.Duplicates := dupIgnore;
        with Items.itemNamed['Skiplists'] do
        begin
          with Items.itemNamed['SkipFolders'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFolders.Add(Items.itemNamed['SkipFolder' + IntToStr(j)].Value);
            end;
          end;
          with Items.itemNamed['SkipFiles'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFiles.Add(Items.itemNamed['SkipFile' + IntToStr(j)].Value);
            end;
          end;
        end;
        with Items.itemNamed['Timer'] do
        begin
          for j := 0 to (Items.Count div 5) - 1 do
          begin
            TreeData.Timer[j].bEnabled := Items.itemNamed['bEnabled' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].bOnShutdown := Items.itemNamed['bOnShutdown' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].Time := StrtoDateTime(Items.itemNamed['rTime' + IntToStr(j)].Value);
            TreeData.Timer[j].Kind := TTriggerKind(Items.itemNamed['iKind' + IntToStr(j)].IntValue);
            TreeData.Timer[j].WatchMode := wmNone;
            TreeData.Timer[j].iMulti := Items.itemNamed['iMulti' + IntToStr(j)].IntValue;
          end;
        end;
        for j := 0 to high(AApplicationData) do
        begin
          TreeData.Application[j].sFileName := '';
          TreeData.Application[j].sParam := '';
          TreeData.Application[j].iTimeout := 0;
          TreeData.Application[j].Action := aaNone;
        end;
        if Items.itemNamed['bCloseApplication'].BoolValue then
        begin
          TreeData.Application[0].sFileName := Items.itemNamed['sApplication'].Value;
          TreeData.Application[0].sParam := '';
          TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
            .Items.itemNamed['iWaitTimeout'].IntValue;
          TreeData.Application[0].Action := aaCloseBeforeAndWait;
        end;
        if Items.itemNamed['bCloseApplication'].BoolValue and Items.itemNamed['bRestartApplication'].BoolValue then
        begin
          TreeData.Application[1].sFileName := Items.itemNamed['sApplication'].Value;
          TreeData.Application[1].sParam := '';
          TreeData.Application[1].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
            .Items.itemNamed['iWaitTimeout'].IntValue;
          TreeData.Application[1].Action := aaRunAfter;
        end;
        if Items.itemNamed['bRestartApplication'].BoolValue then
        begin
          TreeData.Application[0].sFileName := Items.itemNamed['sApplication'].Value;
          TreeData.Application[0].sParam := '';
          TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
            .Items.itemNamed['iWaitTimeout'].IntValue;
          TreeData.Application[0].Action := aaRunAfter;
        end;
        TreeData.iImageIndex := - 1;
        Node := VSTHAdd(tvSourceDestination, TreeData, Items.itemNamed['bCheckedItem'].BoolValue);
        tvSourceDestination.Expanded[Node.Parent] := Items.itemNamed['bIsExpanded'].BoolValue
      end;
    end;
    tvSourceDestination.EndUpdate;
  end;
  with sxmlMainForm.Root.Items.itemNamed['Settings'] do
  begin
    with Items.itemNamed['Logging'] do
    begin
      sLogPath := Items.itemNamed['sLogPath'].Value;
      bLog := Items.itemNamed['bLog'].BoolValue;
      bUseDescription := true;
      LogLevel := TLogLevel(Items.itemNamed['iLogLevel'].IntValue);
    end;
    with Items.itemNamed['Programm'] do
    begin
      MainForm.Height := Items.itemNamed['iHeight'].IntValue;
      MainForm.Left := Items.itemNamed['iLeft'].IntValue;
      MainForm.Top := Items.itemNamed['iTop'].IntValue;
      MainForm.Width := Items.itemNamed['iWidth'].IntValue;
      iWaitTimeout := Items.itemNamed['iWaitTimeout'].IntValue;
      iLang := Items.itemNamed['iLang'].IntValue;
      iThreadPriority := TThreadPriority(Items.itemNamed['iThreadPriority'].IntValue);
      tvSourceDestination.Header.Columns[0].Width := Items.itemNamed['iColumWidth0'].IntValue;
      tvSourceDestination.Header.Columns[1].Width := Items.itemNamed['iColumWidth1'].IntValue;
      tvSourceDestination.Header.Columns[2].Width := Items.itemNamed['iColumWidth2'].IntValue;
      bShutdown := Items.itemNamed['bShutdown'].BoolValue;
      bForce := Items.itemNamed['bForce'].BoolValue;
      if Items.itemNamed['bWindowState'].BoolValue then
      begin
        WindowState := wsMaximized;
      end
      else
      begin
        WindowState := wsNormal;
      end;
      bEndBackupbevoreShutdown := Items.itemNamed['bEndBackupbevoreShutdown'].BoolValue;
      bConfirmShutdown := Items.itemNamed['bConfirmShutdown'].BoolValue;
      bConfirmDelete := Items.itemNamed['bConfirmDelete'].BoolValue;
      bClose := Items.itemNamed['bClose'].BoolValue;
      case iLang of
        0 :
          mmLangGerman.Click;
        1 :
          mmLangEnglish.Click;
        2 :
          mmLangSpecial.Click;
      end;
      mmCheckUpdateAuto.Checked := Items.itemNamed['bCheckUpdateAuto'].BoolValue;
      mmLoadUpdateAuto.Checked := Items.itemNamed['bUpdateAuto'].BoolValue;
      bStartInTray := Items.itemNamed['bStartInTray'].BoolValue;
      SaveVisibilities := ctiBackupper.Visibility;
      if Items.itemNamed['bMinimizeToTray'].BoolValue then
      begin
        include(SaveVisibilities, tvAutoHide);
      end
      else
      begin
        exclude(SaveVisibilities, tvAutoHide);
      end;
      ctiBackupper.Visibility := SaveVisibilities;
    end;
  end;
end;

procedure TMainForm.LoadSettingsV14;
// Einstellungen Version 1.4 laden
var
  i, j, k : Integer;
  Node : PVirtualNode;
  TreeData : TTreeData;
  SaveVisibilities : TTrayVisibilities;
begin
  with sxmlMainForm.Root.Items.itemNamed['tvSourceDestination'] do
  begin
    tvSourceDestination.BeginUpdate;
    for i := 0 to Items.Count - 1 do
    begin
      with Items.itemNamed['Job' + IntToStr(i)] do
      // vermeidet das Zählen der Job Optionen
      begin
        TreeData.sName := Items.itemNamed['sName'].Value;
        TreeData.sSource := Items.itemNamed['sSourceItem'].Value;
        TreeData.sDest := Items.itemNamed['sDestItem'].Value;
        TreeData.sFileMask := Items.itemNamed['sFileMask'].Value;
        TreeData.bSubFolders := Items.itemNamed['bSubFolders'].BoolValue;
        TreeData.bDeleteFiles := Items.itemNamed['bDeleteFiles'].BoolValue;
        TreeData.bDoNotCopyFlags := false;
        TreeData.iTimeDiff := Items.itemNamed['iTimeDiff'].IntValue;
        TreeData.LastRun := StrtoDateTime(Items.itemNamed['rLastRun'].Value);
        TreeData.CompareMode := TCompareMode(Items.itemNamed['iCompareMethod'].IntValue);
        TreeData.bProgress := false;
        TreeData.SkipFolders := TStringList.Create;
        TreeData.SkipFiles := TStringList.Create;
        TreeData.SkipFolders.Sorted := true;
        TreeData.SkipFiles.Sorted := true;
        TreeData.SkipFolders.Duplicates := dupIgnore;
        TreeData.SkipFiles.Duplicates := dupIgnore;
        with Items.itemNamed['Skiplists'] do
        begin
          with Items.itemNamed['SkipFolders'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFolders.Add(Items.itemNamed['SkipFolder' + IntToStr(j)].Value);
            end;
          end;
          with Items.itemNamed['SkipFiles'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFiles.Add(Items.itemNamed['SkipFile' + IntToStr(j)].Value);
            end;
          end;
        end;
        with Items.itemNamed['Timer'] do
        begin
          for j := 0 to (Items.Count div 6) - 1 do
          begin
            TreeData.Timer[j].bEnabled := Items.itemNamed['bEnabled' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].bOnShutdown := Items.itemNamed['bOnShutdown' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].Time := StrtoDateTime(Items.itemNamed['rTime' + IntToStr(j)].Value);
            TreeData.Timer[j].Kind := TTriggerKind(Items.itemNamed['iKind' + IntToStr(j)].IntValue);
            TreeData.Timer[j].WatchMode := TWatchMode(Items.itemNamed['iWatchMode' + IntToStr(j)].IntValue);
            TreeData.Timer[j].iMulti := Items.itemNamed['iMulti' + IntToStr(j)].IntValue;
          end;
        end;
        for j := 0 to high(AApplicationData) do
        begin
          TreeData.Application[j].sFileName := '';
          TreeData.Application[j].sParam := '';
          TreeData.Application[j].iTimeout := 0;
          TreeData.Application[j].Action := aaNone;
        end;
        if Items.itemNamed['bCloseApplication'].BoolValue then
        begin
          TreeData.Application[0].sFileName := Items.itemNamed['sApplication'].Value;
          TreeData.Application[0].sParam := '';
          TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
            .Items.itemNamed['iWaitTimeout'].IntValue;
          TreeData.Application[0].Action := aaCloseBeforeAndWait;
        end;
        if Items.itemNamed['bCloseApplication'].BoolValue and Items.itemNamed['bRestartApplication'].BoolValue then
        begin
          TreeData.Application[1].sFileName := Items.itemNamed['sApplication'].Value;
          TreeData.Application[1].sParam := '';
          TreeData.Application[1].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
            .Items.itemNamed['iWaitTimeout'].IntValue;
          TreeData.Application[1].Action := aaRunAfter;
        end;
        if Items.itemNamed['bRestartApplication'].BoolValue then
        begin
          TreeData.Application[0].sFileName := Items.itemNamed['sApplication'].Value;
          TreeData.Application[0].sParam := '';
          TreeData.Application[0].iTimeout := sxmlMainForm.Root.Items.itemNamed['Settings'].Items.itemNamed['Programm']
            .Items.itemNamed['iWaitTimeout'].IntValue;
          TreeData.Application[0].Action := aaRunAfter;
        end;
        TreeData.iImageIndex := - 1;
        Node := VSTHAdd(tvSourceDestination, TreeData, Items.itemNamed['bCheckedItem'].BoolValue);
        tvSourceDestination.Expanded[Node.Parent] := Items.itemNamed['bIsExpanded'].BoolValue
      end;
    end;
    tvSourceDestination.EndUpdate;
  end;
  with sxmlMainForm.Root.Items.itemNamed['Settings'] do
  begin
    with Items.itemNamed['Logging'] do
    begin
      sLogPath := Items.itemNamed['sLogPath'].Value;
      bLog := Items.itemNamed['bLog'].BoolValue;
      bUseDescription := Items.itemNamed['bUseDescription'].BoolValue;
      LogLevel := TLogLevel(Items.itemNamed['iLogLevel'].IntValue);
    end;
    with Items.itemNamed['Programm'] do
    begin
      MainForm.Height := Items.itemNamed['iHeight'].IntValue;
      MainForm.Left := Items.itemNamed['iLeft'].IntValue;
      MainForm.Top := Items.itemNamed['iTop'].IntValue;
      MainForm.Width := Items.itemNamed['iWidth'].IntValue;
      iWaitTimeout := Items.itemNamed['iWaitTimeout'].IntValue;
      iLang := Items.itemNamed['iLang'].IntValue;
      iThreadPriority := TThreadPriority(Items.itemNamed['iThreadPriority'].IntValue);
      k := tvSourceDestination.Header.Columns.Count - 1;
      k := EnsureRange(k, 0, 4);
      for j := 0 to k do
      begin
        with tvSourceDestination.Header.Columns[j] do
        begin
          Width := Items.itemNamed['iColumWidth' + IntToStr(j)].IntValue;
          Position := Items.itemNamed['iColumPos' + IntToStr(j)].IntValue;
          if not Items.itemNamed['iColumVisible' + IntToStr(j)].BoolValue then
          begin
            Options := Options - [coVisible];
          end;
        end;
      end;
      bShutdown := Items.itemNamed['bShutdown'].BoolValue;
      bForce := Items.itemNamed['bForce'].BoolValue;
      if Items.itemNamed['bWindowState'].BoolValue then
      begin
        WindowState := wsMaximized;
      end
      else
      begin
        WindowState := wsNormal;
      end;
      bEndBackupbevoreShutdown := Items.itemNamed['bEndBackupbevoreShutdown'].BoolValue;
      bConfirmShutdown := Items.itemNamed['bConfirmShutdown'].BoolValue;
      bConfirmDelete := Items.itemNamed['bConfirmDelete'].BoolValue;
      bClose := Items.itemNamed['bClose'].BoolValue;
      case iLang of
        0 :
          mmLangGerman.Click;
        1 :
          mmLangEnglish.Click;
        2 :
          mmLangSpecial.Click;
      end;
      mmCheckUpdateAuto.Checked := Items.itemNamed['bCheckUpdateAuto'].BoolValue;
      mmLoadUpdateAuto.Checked := Items.itemNamed['bUpdateAuto'].BoolValue;
      bStartInTray := Items.itemNamed['bStartInTray'].BoolValue;
      SaveVisibilities := ctiBackupper.Visibility;
      if Items.itemNamed['bMinimizeToTray'].BoolValue then
      begin
        include(SaveVisibilities, tvAutoHide);
      end
      else
      begin
        exclude(SaveVisibilities, tvAutoHide);
      end;
      ctiBackupper.Visibility := SaveVisibilities;
      bExtProgress := Items.itemNamed['bExtProgress'].BoolValue;
    end;
  end;
end;

procedure TMainForm.LoadSettingsV15;
// Einstellungen Version 1.5 laden
var
  i, j, k : Integer;
  Node : PVirtualNode;
  TreeData : TTreeData;
  SaveVisibilities : TTrayVisibilities;
begin
  with sxmlMainForm.Root.Items.itemNamed['tvSourceDestination'] do
  begin
    tvSourceDestination.BeginUpdate;
    for i := 0 to Items.Count - 1 do
    begin
      with Items.itemNamed['Job' + IntToStr(i)] do
      // vermeidet das Zählen der Job Optionen
      begin
        TreeData.sName := Items.itemNamed['sName'].Value;
        TreeData.sSource := Items.itemNamed['sSource'].Value;
        TreeData.sDest := Items.itemNamed['sDest'].Value;
        TreeData.sFileMask := Items.itemNamed['sFileMask'].Value;
        TreeData.sSourceDriveLabel := Items.itemNamed['sSourceDriveLabel'].Value;
        TreeData.sDestDriveLabel := Items.itemNamed['sDestDriveLabel'].Value;
        TreeData.sUsername := Items.itemNamed['sUsername'].Value;
        TreeData.sPassword := Items.itemNamed['sPassword'].Value;
        TreeData.bSubFolders := Items.itemNamed['bSubFolders'].BoolValue;
        TreeData.bDeleteFiles := Items.itemNamed['bDeleteFiles'].BoolValue;
        TreeData.bDoNotCopyFlags := false;
        TreeData.bCompress := Items.itemNamed['bCompress'].BoolValue;
        TreeData.bEnableNetworkLogon := Items.itemNamed['bEnableNetworkLogon'].BoolValue;
        TreeData.bProgress := false;
        TreeData.bChanged := false;
        TreeData.iTimeDiff := Items.itemNamed['iTimeDiff'].IntValue;
        TreeData.iImageIndex := Items.itemNamed['iImageIndex'].IntValue;
        TreeData.LastRun := StrtoDateTime(Items.itemNamed['LastRun'].Value);
        TreeData.CompareMode := TCompareMode(Items.itemNamed['CompareMode'].IntValue);
        TreeData.SkipFolders := TStringList.Create;
        TreeData.SkipFiles := TStringList.Create;
        TreeData.SkipFolders.Sorted := true;
        TreeData.SkipFiles.Sorted := true;
        TreeData.SkipFolders.Duplicates := dupIgnore;
        TreeData.SkipFiles.Duplicates := dupIgnore;
        with Items.itemNamed['Skiplists'] do
        begin
          with Items.itemNamed['SkipFolders'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFolders.Add(Items.itemNamed['SkipFolder' + IntToStr(j)].Value);
            end;
          end;
          with Items.itemNamed['SkipFiles'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFiles.Add(Items.itemNamed['SkipFile' + IntToStr(j)].Value);
            end;
          end;
        end;
        with Items.itemNamed['Timer'] do
        begin
          for j := 0 to (Items.Count div 6) - 1 do
          begin
            TreeData.Timer[j].bEnabled := Items.itemNamed['bEnabled' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].bOnShutdown := Items.itemNamed['bOnShutdown' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].Time := StrtoDateTime(Items.itemNamed['Time' + IntToStr(j)].Value);
            TreeData.Timer[j].Kind := TTriggerKind(Items.itemNamed['Kind' + IntToStr(j)].IntValue);
            TreeData.Timer[j].WatchMode := TWatchMode(Items.itemNamed['WatchMode' + IntToStr(j)].IntValue);
            TreeData.Timer[j].iMulti := Items.itemNamed['iMulti' + IntToStr(j)].IntValue;
          end;
        end;
        for j := 0 to high(AApplicationData) do
        begin
          TreeData.Application[j].sFileName := '';
          TreeData.Application[j].sParam := '';
          TreeData.Application[j].iTimeout := 0;
          TreeData.Application[j].Action := aaNone;
        end;
        with Items.itemNamed['Application'] do
        begin
          k := Items.itemNamed['iApplicationCount'].IntValue - 1;
          for j := 0 to k do
          begin
            TreeData.Application[j].sFileName := Items.itemNamed['sFileName' + IntToStr(j)].Value;
            TreeData.Application[j].sParam := Items.itemNamed['sParam' + IntToStr(j)].Value;
            TreeData.Application[j].iTimeout := Items.itemNamed['iTimeout' + IntToStr(j)].IntValue;
            TreeData.Application[j].Action := TApplicationAction(Items.itemNamed['Action' + IntToStr(j)].IntValue);
          end;
        end;
        Node := VSTHAdd(tvSourceDestination, TreeData, Items.itemNamed['bCheckedItem'].BoolValue);
        tvSourceDestination.Expanded[Node.Parent] := Items.itemNamed['bIsExpanded'].BoolValue
      end;
    end;
    tvSourceDestination.EndUpdate;
  end;
  with sxmlMainForm.Root.Items.itemNamed['Settings'] do
  begin
    with Items.itemNamed['Logging'] do
    begin
      sLogPath := Items.itemNamed['sLogPath'].Value;
      bLog := Items.itemNamed['bLog'].BoolValue;
      bUseDescription := Items.itemNamed['bUseDescription'].BoolValue;
      LogLevel := TLogLevel(Items.itemNamed['iLogLevel'].IntValue);
    end;
    with Items.itemNamed['Programm'] do
    begin
      MainForm.Height := Items.itemNamed['iHeight'].IntValue;
      MainForm.Left := Items.itemNamed['iLeft'].IntValue;
      MainForm.Top := Items.itemNamed['iTop'].IntValue;
      MainForm.Width := Items.itemNamed['iWidth'].IntValue;
      iWaitTimeout := Items.itemNamed['iWaitTimeout'].IntValue;
      iLang := Items.itemNamed['iLang'].IntValue;
      iThreadPriority := TThreadPriority(Items.itemNamed['iThreadPriority'].IntValue);
      k := Items.itemNamed['iColumnCount'].IntValue - 1;
      k := EnsureRange(k, 0, tvSourceDestination.Header.Columns.Count - 1);
      for j := 0 to k do
      begin
        with tvSourceDestination.Header.Columns[j] do
        begin
          Width := Items.itemNamed['iColumnWidth' + IntToStr(j)].IntValue;
          Position := Items.itemNamed['iColumnPos' + IntToStr(j)].IntValue;
          if not Items.itemNamed['bColumnVisible' + IntToStr(j)].BoolValue then
          begin
            Options := Options - [coVisible];
          end;
        end;
      end;
      k := Items.itemNamed['iAppColumnCount'].IntValue - 1;
      k := EnsureRange(k, 0, TEditChange.vstApplications.Header.Columns.Count - 1);
      for j := 0 to k do
      begin
        with TEditChange.vstApplications.Header.Columns[j] do
        begin
          Width := Items.itemNamed['iAppColumnWidth' + IntToStr(j)].IntValue;
          Position := Items.itemNamed['iAppColumnPos' + IntToStr(j)].IntValue;
          if not Items.itemNamed['bAppColumnVisible' + IntToStr(j)].BoolValue then
          begin
            Options := Options - [coVisible];
          end;
        end;
      end;
      bShutdown := Items.itemNamed['bShutdown'].BoolValue;
      bForce := Items.itemNamed['bForce'].BoolValue;
      if Items.itemNamed['bWindowState'].BoolValue then
      begin
        WindowState := wsMaximized;
      end
      else
      begin
        WindowState := wsNormal;
      end;
      bEndBackupbevoreShutdown := Items.itemNamed['bEndBackupbevoreShutdown'].BoolValue;
      bConfirmShutdown := Items.itemNamed['bConfirmShutdown'].BoolValue;
      bConfirmDelete := Items.itemNamed['bConfirmDelete'].BoolValue;
      bClose := Items.itemNamed['bClose'].BoolValue;
      case iLang of
        0 :
          mmLangGerman.Click;
        1 :
          mmLangEnglish.Click;
        2 :
          mmLangSpecial.Click;
      end;
      mmCheckUpdateAuto.Checked := Items.itemNamed['bCheckUpdateAuto'].BoolValue;
      mmLoadUpdateAuto.Checked := Items.itemNamed['bUpdateAuto'].BoolValue;
      bStartInTray := Items.itemNamed['bStartInTray'].BoolValue;
      SaveVisibilities := ctiBackupper.Visibility;
      if Items.itemNamed['bMinimizeToTray'].BoolValue then
      begin
        include(SaveVisibilities, tvAutoHide);
      end
      else
      begin
        exclude(SaveVisibilities, tvAutoHide);
      end;
      ctiBackupper.Visibility := SaveVisibilities;
      bExtProgress := Items.itemNamed['bExtProgress'].BoolValue;
    end;
  end;
end;

procedure TMainForm.LoadSettingsV16;
// Einstellungen Version 1.6 laden
var
  i, j, k : Integer;
  Node : PVirtualNode;
  TreeData : TTreeData;
  SaveVisibilities : TTrayVisibilities;
begin
  with sxmlMainForm.Root.Items.itemNamed['tvSourceDestination'] do
  begin
    tvSourceDestination.BeginUpdate;
    for i := 0 to Items.Count - 1 do
    begin
      with Items.itemNamed['Job' + IntToStr(i)] do
      // vermeidet das Zählen der Job Optionen
      begin
        TreeData.sName := Items.itemNamed['sName'].Value;
        TreeData.sSource := Items.itemNamed['sSource'].Value;
        TreeData.sDest := Items.itemNamed['sDest'].Value;
        TreeData.sFileMask := Items.itemNamed['sFileMask'].Value;
        TreeData.sSourceDriveLabel := Items.itemNamed['sSourceDriveLabel'].Value;
        TreeData.sDestDriveLabel := Items.itemNamed['sDestDriveLabel'].Value;
        TreeData.sUsername := Items.itemNamed['sUsername'].Value;
        TreeData.sPassword := Items.itemNamed['sPassword'].Value;
        TreeData.bSubFolders := Items.itemNamed['bSubFolders'].BoolValue;
        TreeData.bDeleteFiles := Items.itemNamed['bDeleteFiles'].BoolValue;
        TreeData.bDoNotCopyFlags := Items.itemNamed['bDoNotCopyFlags'].BoolValue;
        TreeData.bCompress := Items.itemNamed['bCompress'].BoolValue;
        TreeData.bEnableNetworkLogon := Items.itemNamed['bEnableNetworkLogon'].BoolValue;
        TreeData.bProgress := false;
        TreeData.bChanged := false;
        TreeData.iTimeDiff := Items.itemNamed['iTimeDiff'].IntValue;
        TreeData.iImageIndex := Items.itemNamed['iImageIndex'].IntValue;
        TreeData.LastRun := StrtoDateTime(Items.itemNamed['LastRun'].Value);
        TreeData.CompareMode := TCompareMode(Items.itemNamed['CompareMode'].IntValue);
        TreeData.SkipFolders := TStringList.Create;
        TreeData.SkipFiles := TStringList.Create;
        TreeData.SkipFolders.Sorted := true;
        TreeData.SkipFiles.Sorted := true;
        TreeData.SkipFolders.Duplicates := dupIgnore;
        TreeData.SkipFiles.Duplicates := dupIgnore;
        with Items.itemNamed['Skiplists'] do
        begin
          with Items.itemNamed['SkipFolders'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFolders.Add(Items.itemNamed['SkipFolder' + IntToStr(j)].Value);
            end;
          end;
          with Items.itemNamed['SkipFiles'] do
          begin
            for j := 0 to Items.Count - 1 do
            begin
              TreeData.SkipFiles.Add(Items.itemNamed['SkipFile' + IntToStr(j)].Value);
            end;
          end;
        end;
        with Items.itemNamed['Timer'] do
        begin
          for j := 0 to (Items.Count div 6) - 1 do
          begin
            TreeData.Timer[j].bEnabled := Items.itemNamed['bEnabled' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].bOnShutdown := Items.itemNamed['bOnShutdown' + IntToStr(j)].BoolValue;
            TreeData.Timer[j].Time := StrtoDateTime(Items.itemNamed['Time' + IntToStr(j)].Value);
            TreeData.Timer[j].Kind := TTriggerKind(Items.itemNamed['Kind' + IntToStr(j)].IntValue);
            TreeData.Timer[j].WatchMode := TWatchMode(Items.itemNamed['WatchMode' + IntToStr(j)].IntValue);
            TreeData.Timer[j].iMulti := Items.itemNamed['iMulti' + IntToStr(j)].IntValue;
          end;
        end;
        for j := 0 to high(AApplicationData) do
        begin
          TreeData.Application[j].sFileName := '';
          TreeData.Application[j].sParam := '';
          TreeData.Application[j].iTimeout := 0;
          TreeData.Application[j].Action := aaNone;
        end;
        with Items.itemNamed['Application'] do
        begin
          k := Items.itemNamed['iApplicationCount'].IntValue - 1;
          for j := 0 to k do
          begin
            TreeData.Application[j].sFileName := Items.itemNamed['sFileName' + IntToStr(j)].Value;
            TreeData.Application[j].sParam := Items.itemNamed['sParam' + IntToStr(j)].Value;
            TreeData.Application[j].iTimeout := Items.itemNamed['iTimeout' + IntToStr(j)].IntValue;
            TreeData.Application[j].Action := TApplicationAction(Items.itemNamed['Action' + IntToStr(j)].IntValue);
          end;
        end;
        Node := VSTHAdd(tvSourceDestination, TreeData, Items.itemNamed['bCheckedItem'].BoolValue);
        tvSourceDestination.Expanded[Node.Parent] := Items.itemNamed['bIsExpanded'].BoolValue
      end;
    end;
    tvSourceDestination.EndUpdate;
  end;
  with sxmlMainForm.Root.Items.itemNamed['Settings'] do
  begin
    with Items.itemNamed['Logging'] do
    begin
      sLogPath := Items.itemNamed['sLogPath'].Value;
      bLog := Items.itemNamed['bLog'].BoolValue;
      bUseDescription := Items.itemNamed['bUseDescription'].BoolValue;
      LogLevel := TLogLevel(Items.itemNamed['iLogLevel'].IntValue);
    end;
    with Items.itemNamed['Programm'] do
    begin
      MainForm.Height := Items.itemNamed['iHeight'].IntValue;
      MainForm.Left := Items.itemNamed['iLeft'].IntValue;
      MainForm.Top := Items.itemNamed['iTop'].IntValue;
      MainForm.Width := Items.itemNamed['iWidth'].IntValue;
      iWaitTimeout := Items.itemNamed['iWaitTimeout'].IntValue;
      iLang := Items.itemNamed['iLang'].IntValue;
      iThreadPriority := TThreadPriority(Items.itemNamed['iThreadPriority'].IntValue);
      k := Items.itemNamed['iColumnCount'].IntValue - 1;
      k := EnsureRange(k, 0, tvSourceDestination.Header.Columns.Count - 1);
      for j := 0 to k do
      begin
        with tvSourceDestination.Header.Columns[j] do
        begin
          Width := Items.itemNamed['iColumnWidth' + IntToStr(j)].IntValue;
          Position := Items.itemNamed['iColumnPos' + IntToStr(j)].IntValue;
          if not Items.itemNamed['bColumnVisible' + IntToStr(j)].BoolValue then
          begin
            Options := Options - [coVisible];
          end;
        end;
      end;
      k := Items.itemNamed['iAppColumnCount'].IntValue - 1;
      k := EnsureRange(k, 0, TEditChange.vstApplications.Header.Columns.Count - 1);
      for j := 0 to k do
      begin
        with TEditChange.vstApplications.Header.Columns[j] do
        begin
          Width := Items.itemNamed['iAppColumnWidth' + IntToStr(j)].IntValue;
          Position := Items.itemNamed['iAppColumnPos' + IntToStr(j)].IntValue;
          if not Items.itemNamed['bAppColumnVisible' + IntToStr(j)].BoolValue then
          begin
            Options := Options - [coVisible];
          end;
        end;
      end;
      bShutdown := Items.itemNamed['bShutdown'].BoolValue;
      bForce := Items.itemNamed['bForce'].BoolValue;
      if Items.itemNamed['bWindowState'].BoolValue then
      begin
        WindowState := wsMaximized;
      end
      else
      begin
        WindowState := wsNormal;
      end;
      bEndBackupbevoreShutdown := Items.itemNamed['bEndBackupbevoreShutdown'].BoolValue;
      bConfirmShutdown := Items.itemNamed['bConfirmShutdown'].BoolValue;
      bConfirmDelete := Items.itemNamed['bConfirmDelete'].BoolValue;
      bClose := Items.itemNamed['bClose'].BoolValue;
      case iLang of
        0 :
          mmLangGerman.Click;
        1 :
          mmLangEnglish.Click;
        2 :
          mmLangSpecial.Click;
      end;
      mmCheckUpdateAuto.Checked := Items.itemNamed['bCheckUpdateAuto'].BoolValue;
      mmLoadUpdateAuto.Checked := Items.itemNamed['bUpdateAuto'].BoolValue;
      bStartInTray := Items.itemNamed['bStartInTray'].BoolValue;
      SaveVisibilities := ctiBackupper.Visibility;
      if Items.itemNamed['bMinimizeToTray'].BoolValue then
      begin
        include(SaveVisibilities, tvAutoHide);
      end
      else
      begin
        exclude(SaveVisibilities, tvAutoHide);
      end;
      ctiBackupper.Visibility := SaveVisibilities;
      bExtProgress := Items.itemNamed['bExtProgress'].BoolValue;
    end;
  end;
end;

function TMainForm.EncryptPW(const AText : string; const APassword : string) : string;
var
  ASalt : Binary;
  AData : Binary;
  APass : Binary;
  Cipher : TDECCipher;
begin
  Cipher := ValidCipher(TCipher_Rijndael).Create;
  with Cipher, Context do
    try
      ASalt := RandomBinary(16);
      APass := ValidHash(THash_SHA1).KDFx(APassword, ASalt, KeySize, TFormat_Copy, 1);
      Mode := cmCBCx;
      Init(APass);
      AData := ASalt + EncodeBinary(AText) + CalcMAC;
      Result := ValidFormat(TFormat_MIME64).Encode(AData);
    finally
      Free;
      ProtectBinary(ASalt);
      ProtectBinary(AData);
      ProtectBinary(APass);
    end;
end;

function TMainForm.DecryptPW(const AText : string; const APassword : string) : string;
var
  ASalt : Binary;
  AData : Binary;
  APass : Binary;
  ALen : Integer;
  Cipher : TDECCipher;
begin
  Cipher := ValidCipher(TCipher_Rijndael).Create;
  with Cipher, Context do
    try
      ASalt := ValidFormat(TFormat_MIME64).Decode(AText);
      ALen := Length(ASalt) - 16 - BufferSize;
      AData := System.Copy(ASalt, 17, ALen);
      SetLength(ASalt, 16);
      APass := ValidHash(THash_SHA1).KDFx(APassword, ASalt, KeySize, TFormat_Copy, 1);
      Mode := cmCBCx;
      Init(APass);
      Result := DecodeBinary(AData);
    finally
      Free;
      ProtectBinary(ASalt);
      ProtectBinary(AData);
      ProtectBinary(APass);
    end;
end;

procedure TMainForm.mmSettingsClick(Sender : TObject);
var
  sDir : string;
  s : string;
  bMinimizeToTray : Boolean;
  SaveVisibilities : TTrayVisibilities;
  // Optionen Form laden
begin
  bMinimizeToTray := tvAutoHide in ctiBackupper.Visibility;
  with SettingsForm do // Daten in die Form laden
  begin
    piThreadPriority := @MainForm.iThreadPriority;
    pLogLevel := @MainForm.LogLevel;
    piWaitTimeout := @iWaitTimeout;
    psLogPath := @sLogPath;
    pbShutdown := @bShutdown;
    pbForce := @bForce;
    pbLog := @bLog;
    pbUseDescription := @bUseDescription;
    pbEndBackupbevoreShutdown := @bEndBackupbevoreShutdown;
    pbConfirmShutdown := @bConfirmShutdown;
    pbConfirmDelete := @bConfirmDelete;
    pbClose := @bClose;
    pbStartInTray := @bStartInTray;
    pbMinimizetoTray := @bMinimizeToTray;
    pbExtProgress := @bExtProgress;
    iThreadPriority := MainForm.iThreadPriority;
    LogLevel := MainForm.LogLevel;
    seWaitTimeout.Value := trunc(iWaitTimeout / 1000);
    eLogPath.Text := sLogPath;
    cbShutdown.Checked := bShutdown;
    cbForce.Checked := bForce;
    cbLogEnabled.Checked := bLog;
    cbDescription.Checked := bUseDescription;
    cbEndBackupbevoreShutdown.Checked := bEndBackupbevoreShutdown;
    cbConfirmShutdown.Checked := bConfirmShutdown;
    cbConfirmDelete.Checked := bConfirmDelete;
    cbClose.Checked := bClose;
    cbStartInTray.Checked := bStartInTray;
    cbMinimizeToTray.Checked := tvAutoHide in ctiBackupper.Visibility;
    cbExtProgress.Checked := bExtProgress;
    ShowModal;
    if ModalResult = mrOk then // Optionen ändern
    begin
      MainForm.iThreadPriority := iThreadPriority;
      MainForm.LogLevel := LogLevel;
      iWaitTimeout := trunc(seWaitTimeout.Value * 1000);
      sLogPath := eLogPath.Text;
      bShutdown := cbShutdown.Checked;
      bForce := cbForce.Checked;
      bLog := cbLogEnabled.Checked;
      bUseDescription := cbDescription.Checked;
      bEndBackupbevoreShutdown := cbEndBackupbevoreShutdown.Checked;
      bConfirmShutdown := cbConfirmShutdown.Checked;
      bConfirmDelete := cbConfirmDelete.Checked;
      bClose := cbClose.Checked;
      bStartInTray := cbStartInTray.Checked;
      bMinimizeToTray := cbMinimizeToTray.Checked;
      bExtProgress := cbExtProgress.Checked;
      sDir := GetShellFolder(CSIDL_STARTUP);
      if cbAutostart.Checked then
      begin
        CreateDirectoryRecurse('', sDir, nil);
        CreateLink(Application.ExeName, ' -Autostart', sDir + 'Backupper.lnk', '');
      end
      else
      begin
        DeleteFile(sDir + 'Backupper.lnk');
      end;
      s := LogFile.Write('LogStrings', 'SettingsChanged');
      SetStatusbarText(sbMainForm, s);
    end
  end;
  SaveVisibilities := ctiBackupper.Visibility;
  if bMinimizeToTray then
  begin
    include(SaveVisibilities, tvAutoHide);
  end
  else
  begin
    exclude(SaveVisibilities, tvAutoHide);
  end;
  ctiBackupper.Visibility := SaveVisibilities;
  if LogFile <> nil then
  begin
    LogFile.Enabled := bLog;
    LogFile.UseDescription := bUseDescription;
    LogFile.LogLevel := MainForm.LogLevel;
  end;
end;

procedure TMainForm.mmShowExtendedProgressClick(Sender : TObject);
begin
  ProgressForm.show;
  ProgressForm.DoNotClose := ProgressForm.DoNotClose or (Sender = mmShowExtendedProgress);
  MainForm.Enabled := false;
end;

procedure TMainForm.mmSpecialClick(Sender : TObject);
begin
  mmRestore.Enabled := (tvSourceDestination.FocusedNode <> nil)
end;

procedure TMainForm.DoTranslation();
begin
  JvTranslate.Translate(Self);
  // nicht automatisch ladbare Teile setzen
  with tvSourceDestination.Header do
  begin
    Columns[0].Text := JvTranslate.Translate('GUIStrings', 'tvName');
    Columns[1].Text := JvTranslate.Translate('GUIStrings', 'tvSource');
    Columns[2].Text := JvTranslate.Translate('GUIStrings', 'tvDest');
    Columns[3].Text := JvTranslate.Translate('GUIStrings', 'tvLastRun');
  end;
  with TEditChange.vstApplications.Header do
  begin
    Columns[0].Text := JvTranslate.Translate('GUIStrings', 'vstPath');
    Columns[1].Text := JvTranslate.Translate('GUIStrings', 'vstAction');
    Columns[2].Text := JvTranslate.Translate('GUIStrings', 'vstTimeout');
    Columns[3].Text := JvTranslate.Translate('GUIStrings', 'vstParam');
  end;
  tvSourceDestination.Repaint;
  with SRForm.cMode.Items do
  begin
    SRForm.cMode.Text := '';
    Clear;
    Add(JvTranslate.Translate('GUIStrings', 'SRMComlete'));
    Add(JvTranslate.Translate('GUIStrings', 'SRMDrivePart'));
    Add(JvTranslate.Translate('GUIStrings', 'SRMFolderPart'));
    Add(JvTranslate.Translate('GUIStrings', 'SRMDrive'));
    Add(JvTranslate.Translate('GUIStrings', 'SRMFolder'));
  end;
  mmVersionDisplay.Caption := format(JvTranslate.Translate('GUIStrings', 'Version'),
    [JvTranslate.Translate('GUIStrings', 'Unknown')]);
  if bSuspended then
  begin
    acSuspend.Caption := JvTranslate.Translate('GUIStrings', 'Continue');
  end
  else
  begin
    acSuspend.Caption := JvTranslate.Translate('GUIStrings', 'Suspend');
  end;
  ProgressForm.ToggleShow := false;
  JvTranslate.Translate(AboutBox);
  JvTranslate.Translate(TEditChange);
  JvTranslate.Translate(SettingsForm);
  JvTranslate.Translate(TShowErrors);
  JvTranslate.Translate(ShutdownRestartDialog);
  JvTranslate.Translate(ProgressForm);
  JvTranslate.Translate(SRForm);
end;

procedure TMainForm.ConnectDrives(d : TStringDivider; TreeData : PTreeData; sRootName : string);
var
  sNetworkPath : csExplode.TStringDynArray;
begin
  if IsNetworkPath(TreeData^.sSource) then
  // beim Quellnetzlaufwerk anmelden
  begin
    d.Explode(TreeData^.sSourceC, sNetworkPath);
    TreeData^.sSourceC := GetFreeDriveLetter + ':\';
    sNetworkPath[0] := ExcludeTrailingPathDelimiter(sNetworkPath[0]);
    if d.Count > 1 then
    begin
      if sNetworkPath[1][1] = '\' then
      begin
        TreeData^.sSourceC := ExcludeTrailingPathDelimiter(TreeData^.sSourceC);
      end;
      TreeData^.sSourceC := TreeData^.sSourceC + sNetworkPath[1];
    end;
    if TreeData^.bEnableNetworkLogon then
    begin
      if ConnectToNetworkDriveW(ExtractFileDrive(TreeData^.sSourceC), sNetworkPath[0], TreeData^.sUsername,
        DecryptPW(TreeData^.sPassword, sRootName + TreeData^.sName)) <> NO_ERROR then
      begin
        TreeData^.sSourceC := TreeData^.sSource;
      end;
    end
    else
    begin
      if ConnectToNetworkDriveW(ExtractFileDrive(TreeData^.sSourceC), sNetworkPath[0]) <> NO_ERROR then
      begin
        TreeData^.sSourceC := TreeData^.sSource;
      end;
    end;
  end;
  if IsNetworkPath(TreeData^.sDest) then
  // beim Zielnetzlaufwerk anmelden
  begin
    d.Explode(TreeData^.sDestC, sNetworkPath);
    TreeData^.sDestC := GetFreeDriveLetter + ':\';
    sNetworkPath[0] := ExcludeTrailingPathDelimiter(sNetworkPath[0]);
    if d.Count > 1 then
    begin
      if sNetworkPath[1][1] = '\' then
      begin
        TreeData^.sDestC := ExcludeTrailingPathDelimiter(TreeData^.sDestC);
      end;
      TreeData^.sDestC := TreeData^.sDestC + sNetworkPath[1];
    end;
    if TreeData^.bEnableNetworkLogon then
    begin
      if ConnectToNetworkDriveW(ExtractFileDrive(TreeData^.sDestC), sNetworkPath[0], TreeData^.sUsername,
        DecryptPW(TreeData^.sPassword, sRootName + TreeData^.sName)) <> NO_ERROR then
      begin
        TreeData^.sDestC := TreeData^.sDest;
      end;
    end
    else
    begin
      if ConnectToNetworkDriveW(ExtractFileDrive(TreeData^.sDestC), sNetworkPath[0]) <> NO_ERROR then
      begin
        TreeData^.sDestC := TreeData^.sDest;
      end;
    end;
  end;
end;

procedure TMainForm.mmLangGermanClick(Sender : TObject);
// Deutsche Sprache setzen
var
  sLangFile : string;
begin
  mmLangGerman.Checked := true;
  mmLangEnglish.Checked := false;
  mmLangSpecial.Checked := false;
  iLang := 0;
  sLangFile := sLangPath + 'German.xml';
  { Übersetzen }
  // Laden der Infos aus dem File in die Form
  if FileExists(sLangFile) then
  begin
    JvTranslate.XML.LoadFromFile(sLangFile);
    DoTranslation;
  end
  else
  begin
    MessageDlg('Sprachdatei nicht gefunden!' + #10#13 + 'Übersetzung nicht möglich!', mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.mmLangEnglishClick(Sender : TObject);
// Englische Sprache setzen
var
  sLangFile : string;
begin
  mmLangGerman.Checked := false;
  mmLangEnglish.Checked := true;
  mmLangSpecial.Checked := false;
  iLang := 1;
  sLangFile := sLangPath + 'English.xml';
  { Übersetzen }
  // Laden der Infos aus dem File in die Form
  if FileExists(sLangFile) then
  begin
    JvTranslate.XML.LoadFromFile(sLangFile);
    DoTranslation;
  end
  else
  begin
    MessageDlg('Language file not found!' + #10#13 + 'Translation not possible!', mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.mmLangSpecialClick(Sender : TObject);
// var
// sLangFile : string;
begin
  // mmLangGerman.Checked := false;
  // mmLangEnglish.Checked := false;
  // mmLangSpecial.Checked := true;
  // iLang := 2;
  // sLangFile := sLangPath + 'Schwäbisch.xml';
  // {Übersetzen}
  // // Laden der Infos aus dem File in die Form
  // if FileExists(sLangFile) then
  // begin
  // JvTranslate.XML.LoadFromFile(sLangFile);
  // DoTranslation;
  // end
  // else
  // begin
  // MessageDlg('Language file not found!' + #10#13 + 'Translation not possible!', mtInformation,
  // [mbOK], 0);
  // end;
end;

procedure TMainForm.StatusbarUpdate(sJobName : string; Data : PTreeData);
// Statusbar updaten
var
  eProgressCalc : extended;
  sProgressString : string;
begin
  if (sStatusbarText <> '') and (sStatusbarText <> sStatusbarTextOld) then
  // Text geändert?
  begin
    sStatusbarTextOld := sStatusbarText;
    SetStatusbarText(sbMainForm, sStatusbarText);
  end;
  eProgressCalc := ProgressForm.Progress;
  sProgressString := '';
  if Data <> nil then
  begin
    if Data^.Progress <> nil then
    begin
      Data^.Progress.Position := eProgressCalc;
      sProgressString := Data^.Progress.DisplayPos;
    end;
  end;
  if sJobName <> '' then // Hint des Tray Icons
  begin
    ctiBackupper.Hint := 'Backupper' + #10#13 + sJobName;
    if sStatusbarText <> '' then
    begin
      ctiBackupper.Hint := ctiBackupper.Hint + #10#13 + ExtractFileName(sStatusbarText) + ' ' + sProgressString;
    end;
  end
  else
  begin
    ctiBackupper.Hint := 'Backupper';
  end;

end;

procedure TMainForm.mmCheckUpdateAutoClick(Sender : TObject);
// automatisches suchen nach Updates
begin
  mmCheckUpdateAuto.Checked := not mmCheckUpdateAuto.Checked;
end;

procedure TMainForm.mmLoadUpdateAutoClick(Sender : TObject);
// automatisches laden von Updates
begin
  mmLoadUpdateAuto.Checked := not mmLoadUpdateAuto.Checked;
end;

procedure TMainForm.mmRestoreClick(Sender : TObject);
var
  Node : PVirtualNode;
  TreeData, RootData : PTreeData;
  Data : TTreeData;
  sRootName : string;
begin
  if (MessageDlg(format(JvTranslate.Translate('GUIStrings', 'Restore'), [#10#13]), mtConfirmation, [mbYes, mbNo], 0)
    = mrYes) then
  begin
    sRootName := '';
    RootData := nil;
    Node := tvSourceDestination.FocusedNode;
    if Node <> nil then
    begin
      if tvSourceDestination.GetNodeLevel(Node) = 1 then
      begin
        RootData := tvSourceDestination.GetNodeData(Node.Parent);
        sRootName := RootData^.sName + ' ';
      end;
      TreeData := tvSourceDestination.GetNodeData(Node);
      Data := TreeData^;
      Data.sSource := TreeData^.sDest;
      Data.sDest := TreeData^.sSource;
      Data.sSourceDriveLabel := TreeData^.sDestDriveLabel;
      Data.sDestDriveLabel := TreeData^.sSourceDriveLabel;
      Data.CompareMode := cmHash;
      Data.bDeleteFiles := false;
      Data.bDoNotCopyFlags := TreeData^.bDoNotCopyFlags;
      DoEvent(@Data, RootData, Node, 2, sRootName);
      TreeData^.iImageIndex := Data.iImageIndex;
      TreeData^.JobErrors := Data.JobErrors;
      tvSourceDestination.RepaintNode(Node);
    end;
    if tvSourceDestination.FocusedNode <> nil then
    begin
      acDel.Enabled := true;
      acCopy.Enabled := true;
      acChange.Enabled := true;
    end;
  end;
end;

procedure TMainForm.mmCheckUpdateNowClick(Sender : TObject);
// Suchen nach Updates
var
  VersionFile : TJvSimpleXML;
  RemoteVersion : TVersion;
  dwWaitResult : DWORD;
  s : string;
begin
  ctiBackupper.Animated := true;
  s := LogFile.Write('LogStrings', 'CheckingUpdate');
  SetStatusbarText(sbMainForm, s);
  UpdateThread := tTUpdate.Create(true); // Update Thread starten
  ThreadIdList.Add(IntToStr(UpdateThread.ThreadId) + ';0Exception in Check Update Thread');
  UpdateThread.OnTerminate := OnThreadTerminate;
  UpdateThread.bUpdate := false;
  UpdateThread.LogFile := @LogFile;
  UpdateThread.Data := @Data;
  mmCheckUpdateNow.Enabled := false; // kollisionen vermeiden
  UpdateThread.Resume;
  repeat
    dwWaitResult := WaitforSingleObject(UpdateThread.Handle, 200);
    // Auf Update Thread warten
    if dwWaitResult <> WAIT_OBJECT_0 then
    begin
      Application.ProcessMessages;
    end;
  until dwWaitResult = WAIT_OBJECT_0;
  if Data.Memory <> nil then // Verarbeiten der Infos aus der Version.xml
  begin
    VersionFile := TJvSimpleXML.Create(Self);
    VersionFile.LoadFromStream(Data);
    VersionFile.Root.Name := 'Version';
    mmVersionDisplay.Caption := format(MainForm.JvTranslate.Translate('GUIStrings', 'Version'),
      [VersionFile.Root.Items.itemNamed['sVersion'].Value]);
    RemoteVersion.iMajor := VersionFile.Root.Items.itemNamed['iMajor'].IntValue;
    RemoteVersion.iMinor := VersionFile.Root.Items.itemNamed['iMinor'].IntValue;
    RemoteVersion.iRevision := VersionFile.Root.Items.itemNamed['iRevision'].IntValue;
    RemoteVersion.iBuild := VersionFile.Root.Items.itemNamed['iBuild'].IntValue;
    if CompareVersion(GetVersionExt, RemoteVersion) > 0 then
    begin
      mmUpdateNow.Enabled := true;
      s := LogFile.Write('LogStrings', 'NewVersionAvailable');
      SetStatusbarText(sbMainForm, s);
      if mmLoadUpdateAuto.Checked then // Update automatisch laden?
      begin
        ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(UpdateThread.ThreadId)));
        // ID leeren
        FreeAndNil(UpdateThread);
        s := LogFile.Write('LogStrings', 'CheckingUpdateEnd');
        SetStatusbarText(sbMainForm, s);
        mmUpdateNow.Click;
      end
      else
      begin
        if (MessageDlg(format(JvTranslate.Translate('GUIStrings', 'NewVersionAvailableLoad'), [#10#13]), mtConfirmation,
          mbYesNo, 0) = mrYes) then
        begin
          ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(UpdateThread.ThreadId)));
          // ID leeren
          FreeAndNil(UpdateThread);
          s := LogFile.Write('LogStrings', 'CheckingUpdateEnd');
          SetStatusbarText(sbMainForm, s);
          mmUpdateNow.Click;
        end;
      end;
    end
    else
    begin
      ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(UpdateThread.ThreadId)));
      // ID leeren
      s := LogFile.Write('LogStrings', 'CheckingUpdateEnd');
      SetStatusbarText(sbMainForm, s);
      if not mmCheckUpdateAuto.Checked then
      begin
        MessageDlg(JvTranslate.Translate('GUIStrings', 'NoNewVersionAvailable'), mtInformation, [mbOK], 0)
      end;
    end;
    FreeAndNil(VersionFile);
    FreeAndNil(Data);
  end
  else
  begin
    s := LogFile.Write('LogStrings', 'ErrorCheckingUpdate');
    SetStatusbarText(sbMainForm, s);
  end;
  FreeAndNil(UpdateThread);
  ctiBackupper.Animated := false;
  ctiBackupper.CurrentIcon := Application.Icon;
  mmCheckUpdateNow.Enabled := true; // kollisionen vermeiden
end;

procedure TMainForm.mmUpdateNowClick(Sender : TObject);
// lade Update
var
  // Version : TJvSimpleXML;
  dwWaitResult : DWORD;
  s : string;
begin
  ctiBackupper.Animated := true;
  // if data.Memory <> nil then
  // begin
  // data.Position := 0;
  s := LogFile.Write('LogStrings', 'Updating');
  SetStatusbarText(sbMainForm, s);
  // Version := TJvSimpleXML.Create(self);
  // Version.LoadFromStream(data);
  // Version.Root.Name := 'Version';
  UpdateThread := tTUpdate.Create(true); // Update Thread starten
  ThreadIdList.Add(IntToStr(UpdateThread.ThreadId) + ';0Exception in Load Update Thread');
  UpdateThread.OnTerminate := OnThreadTerminate;
  UpdateThread.bUpdate := true;
  // UpdateThread.bLoadLang := (Version.Root.Items.itemNamed['iLangVersion'].IntValue > iActLang);
  UpdateThread.LogFile := @LogFile;
  UpdateThread.Data := @Data;
  UpdateThread.sFilePath := ExtractFilePath(Application.ExeName);
  mmUpdateNow.Enabled := false;
  UpdateThread.Resume;
  repeat
    dwWaitResult := WaitforSingleObject(UpdateThread.Handle, 200);
    if dwWaitResult <> WAIT_OBJECT_0 then
    begin
      Application.ProcessMessages;
    end;
  until dwWaitResult = WAIT_OBJECT_0;
  ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(UpdateThread.ThreadId))); // ID leeren
  FreeAndNil(UpdateThread);
  FreeAndNil(Data);
  // FreeandNil(Version);
  if FileExists(ExtractFilePath(Application.ExeName) + 'BackupperUpdate.exe') then
  begin
    bUpdateDone := true;
    MessageDlg(format(JvTranslate.Translate('GUIStrings', 'UpdatingEndInfo'), [#10#13]), mtInformation, [mbOK], 0);
    s := LogFile.Write('LogStrings', 'UpdatingEnd');
    SetStatusbarText(sbMainForm, s);
  end
  else
  begin
    s := LogFile.Write('LogStrings', 'ErrorUpdating');
    SetStatusbarText(sbMainForm, s);
  end;
  // end
  // else
  // begin
  // Log(JvTranslate.Translate('Strings', 'ErrorUpdating'), LogList, bVerbose);
  // SetStatusbarText(sbMainForm, JvTranslate.Translate('Strings', 'ErrorUpdating'), bVerbose);
  // end;
  if not mmLoadUpdateAuto.Checked then
  begin
    ctiBackupper.Animated := false;
    ctiBackupper.CurrentIcon := Application.Icon;
  end;
end;

procedure TMainForm.FormDestroy(Sender : TObject);
// Update abschliesen
begin
  FreeAndNil(ThreadIdList);
  if FileExists(ExtractFilePath(Application.ExeName) + 'BackupperUpdate.exe') and bUpdateDone then
  begin
    ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'BackupperUpdate.exe'), '', nil, SW_Hide);
  end;
end;

procedure TMainForm.tAutoUpdateTimer(Sender : TObject);
// Automatisch auf Updates prüfen
begin
  tAutoUpdate.Enabled := false;
  mmCheckUpdateNow.Click;
end;

procedure TMainForm.acSuspendExecute(Sender : TObject);
// Job anhalten/starten
begin
  if bSuspended then
  begin
    try
      DestThread.Resume;
    except
    end;
    try
      SourceThread.Resume;
    except
    end;
    try
      SortThread.Resume;
    except
    end;
    try
      OperationThread.Resume;
    except
    end;
    acSuspend.Caption := JvTranslate.Translate('GUIStrings', 'Suspend');
    ProgressForm.Resume;
  end
  else
  begin
    try
      DestThread.Suspend;
    except
    end;
    try
      SourceThread.Suspend;
    except
    end;
    try
      SortThread.Suspend;
    except
    end;
    try
      OperationThread.Suspend;
    except
    end;
    acSuspend.Caption := JvTranslate.Translate('GUIStrings', 'Continue');
    ProgressForm.Suspend;
  end;
  ctiBackupper.Animated := bSuspended;
  bSuspended := not bSuspended;
end;

procedure TMainForm.acBackupExecute(Sender : TObject);
// Jobs abarbeiten
var
  i, j, k, l, m, n, o, p : Integer;
  dwWaitResult, dwPAffinity, dwDummy, dwPHandle : DWORD;
  bErrors, bNoMoreNode : Boolean;
  Node, RootNode, ChildNode : PVirtualNode;
  TreeData, RootData : PTreeData;
  sRootName, sLog : string;
  d : TStringDivider;
begin
  acStart.Enabled := false; // Kolisionen vermeiden
  acAdd.Enabled := false;
  acChange.Enabled := false;
  acDel.Enabled := false;
  acCopy.Enabled := false;
  acShowErrors.Enabled := false;
  acCancel.Enabled := true;
  acSuspend.Visible := true;
  bError := false;
  bErrors := false;
  bCanceled := false;
  ctiBackupper.Animated := true;
  ProgressForm.ClearErrors;
  d := TStringDivider.Create;
  d.Pattern := '|';
  if tvSourceDestination.GetFirst = nil then // Abfrage auf vorhandene Jobs
  begin
    if (MessageDlg(format(JvTranslate.Translate('GUIStrings', 'NoJob'), [#10#13]), mtConfirmation, mbYesNo, 0)
      = mrYes) then
    begin
      acAddExecute(Sender);
    end
    else
    begin
      bAddCanceled := true;
    end;
  end;
  sLog := LogFile.Write('LogStrings', 'Started');
  SetStatusbarText(sbMainForm, sLog);
  if bExtProgress then
  begin
    ProgressForm.State := bsInit;
    mmShowExtendedProgressClick(Sender);
  end;
  Node := tvSourceDestination.GetFirstChecked(csCheckedNormal);
  bNoMoreNode := false;
  repeat // Jobs durchführen
    if bCanceled then // Abbrechen
    begin
      break;
    end;
    if Assigned(Node) then
    begin
      sRootName := '';
      if tvSourceDestination.GetNodeLevel(Node) = 1 then
      begin
        RootNode := Node.Parent;
        RootData := tvSourceDestination.GetNodeData(RootNode);
        sRootName := RootData^.sName + ' ';
        RootData^.iImageIndex := 0;
        tvSourceDestination.RepaintNode(RootNode);
      end
      else
      begin
        if Node.ChildCount >= 1 then
        begin
          Node := tvSourceDestination.GetNextChecked(Node, csCheckedNormal);
          RootNode := Node.Parent;
          RootData := tvSourceDestination.GetNodeData(RootNode);
          sRootName := RootData^.sName + ' ';
          RootData^.iImageIndex := 0;
          tvSourceDestination.RepaintNode(RootNode);
        end;
      end;
      ActNode := Node;
      TreeData := tvSourceDestination.GetNodeData(Node);
      TreeData^.sSourceC := TreeData^.sSource;
      TreeData^.sDestC := TreeData^.sDest;
      ConnectDrives(d, TreeData, sRootName);
      if TreeData^.JobErrors = nil then // Fehlerliste vorhanden?
      begin
        TreeData^.JobErrors := TStringList.Create;
      end;
      TreeData^.JobErrors.Clear;
      ProgressForm.State := bsInit;
      ProgressForm.SourceDir := TreeData^.sSourceC;
      ProgressForm.DestDir := TreeData^.sDestC;
      ProgressForm.JobName := sRootName + TreeData^.sName;
      ProgressForm.Error := @TreeData^.JobErrors;
      if (TreeData^.sSourceDriveLabel = '') or
        (TreeData^.sSourceDriveLabel = GetVolumeLabel(ExtractFileDrive(TreeData^.sSourceC))) then
      // Quelllaufwerksname korrekt?
      begin
        if (TreeData^.sDestDriveLabel = '') or
          (TreeData^.sDestDriveLabel = GetVolumeLabel(ExtractFileDrive(TreeData^.sDestC))) then
        // Ziellaufwerksname korrekt?
        begin
          if DirectoryExists(TreeData^.sSourceC) then
          // Quellordner vorhanden?
          begin
            for i := 0 to High(AApplicationData) do
            begin
              if TreeData^.Application[i].sFileName <> '' then
              begin
                ProgressForm.ApplicationName := TreeData^.Application[i].sFileName;
                case TreeData^.Application[i].Action of
                  aaRunBefore :
                    begin
                      ProgressForm.State := bsStartApp;
                      RunApplication(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam);
                    end;
                  aaRunBeforeAndWait :
                    begin
                      ProgressForm.State := bsStartApp;
                      RunApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam,
                        TreeData^.Application[i].iTimeout);
                    end;
                  aaCloseBefore :
                    begin
                      ProgressForm.State := bsCloseApp;
                      CloseApplication(TreeData^.Application[i].sFileName);
                    end;
                  aaCloseBeforeAndWait :
                    begin
                      ProgressForm.State := bsCloseApp;
                      CloseApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].iTimeout);
                    end;
                end;
              end;
            end;
            ProgressForm.State := bsInit;
            ProgressForm.SourceDir := TreeData^.sSourceC;
            ProgressForm.DestDir := TreeData^.sDestC;
            ProgressForm.JobName := sRootName + TreeData^.sName;
            ProgressForm.Error := @TreeData^.JobErrors;
            sLog := LogFile.Write('LogStrings', 'JobStarted', [sRootName + TreeData^.sName]);
            SetStatusbarText(sbMainForm, sLog);
            bError := false;
            TreeData^.iImageIndex := 0;
            tvSourceDestination.RepaintNode(Node);
            SourceThread := TtSearchFiles.Create(true);
            // Thread zum durchsuchen der Quellordner
            ThreadIdList.Add(IntToStr(SourceThread.ThreadId) + ';0Exception in Search Source Thread');
            SourceThread.OnTerminate := OnThreadTerminate;
            DestThread := TtSearchFiles.Create(true);
            // Thread zum durchsuchen der Zielordner
            ThreadIdList.Add(IntToStr(DestThread.ThreadId) + ';0Exception in Search Dest Thread');
            DestThread.OnTerminate := OnThreadTerminate;
            SortThread := TtSortFiles.Create(true);
            // Thread um Dateien den einzelnen Aktionen zuzuordnen
            ThreadIdList.Add(IntToStr(SortThread.ThreadId) + ';0Exception in Sort Files Thread');
            SortThread.OnTerminate := OnThreadTerminate;
            OperationThread := TtFileOperation.Create(true);
            // Thread um Dateien zu kopieren, verschieben, usw.
            ThreadIdList.Add(IntToStr(OperationThread.ThreadId) + ';0Exception in Operate Files Thread');
            OperationThread.OnTerminate := OnThreadTerminate;
            SourceThread.sDir := TreeData^.sSourceC; // Werteübergabe
            SourceThread.LogFile := @LogFile;
            SourceThread.TreeData := TreeData;
            SourceThread.FileList := @SourceFileList;
            SourceThread.FolderList := @SourceFolderList;
            SourceThread.bError := @bError;
            SourceThread.sStatusbarText := @sStatusbarText;
            SourceThread.Priority := iThreadPriority;
            SourceThread.iSearchMode := smSource;
            SourceThread.PF := ProgressForm;
            DestThread.sDir := TreeData^.sDestC;
            DestThread.LogFile := @LogFile;
            DestThread.TreeData := TreeData;
            DestThread.FileList := @DestFileList;
            DestThread.FolderList := @DestFolderList;
            DestThread.bError := @bError;
            DestThread.sStatusbarText := @sStatusbarText;
            DestThread.Priority := iThreadPriority;
            DestThread.iSearchMode := smDestination;
            DestThread.PF := ProgressForm;
            SortThread.SourceFiles := @SourceFileList;
            SortThread.DestFiles := @DestFileList;
            SortThread.SourceFolders := @SourceFolderList;
            SortThread.DestFolders := @DestFolderList;
            SortThread.CopyFiles := @CopyFilesList;
            SortThread.MoveFiles := @MoveFilesList;
            SortThread.DeleteFiles := @DeleteFilesList;
            SortThread.DeleteDirs := @DeleteDirList;
            SortThread.LogFile := @LogFile;
            SortThread.TreeData := TreeData;
            SortThread.bError := @bError;
            SortThread.sStatusbarText := @sStatusbarText;
            SortThread.Priority := iThreadPriority;
            SortThread.PF := ProgressForm;
            OperationThread.CopyFiles := @CopyFilesList;
            OperationThread.MoveFiles := @MoveFilesList;
            OperationThread.DeleteFiles := @DeleteFilesList;
            OperationThread.DeleteDirs := @DeleteDirList;
            OperationThread.LogFile := @LogFile;
            OperationThread.TreeData := TreeData;
            OperationThread.ErrorsList := @TreeData^.JobErrors;
            OperationThread.bError := @bError;
            OperationThread.sStatusbarText := @sStatusbarText;
            OperationThread.bDeleteFiles := TreeData^.bDeleteFiles;
            OperationThread.bDoNotCopyFlags := TreeData^.bDoNotCopyFlags;
            OperationThread.Priority := iThreadPriority;
            OperationThread.PF := ProgressForm;
            ThreadArray[0] := DestThread.Handle;
            // Handle Array um auf Threads zu warten
            ThreadArray[1] := SourceThread.Handle;
            ThreadArray[2] := SortThread.Handle;
            ThreadArray[3] := OperationThread.Handle;
            dwPHandle := OpenProcess(PROCESS_QUERY_INFORMATION, true, GetCurrentProcessId);
            // Prozesshandle holen
            if GetProcessAffinityMask(dwPHandle, dwPAffinity, dwDummy) then
            // Zugewiesene Prozessoren holen
            begin
              if dwPAffinity > 1 then
              begin
                for o := 0 to 31 do
                // dwPAffinity ausmaskieren und Prozessoren den Threads zuweisen
                begin
                  if (dwPAffinity shr o and 1) = 1 then
                  begin
                    if SetThreadAffinityMask(ThreadArray[0], 1 shl o) = 0 then
                    begin
                      LogFile.Write('LogStrings', 'ErrorSetAffinity',
                        ['"Search Source"', SysErrorMessage(GetLastError)]);
                    end;
                    if SetThreadAffinityMask(ThreadArray[2], 1 shl o) = 0 then
                    begin
                      LogFile.Write('LogStrings', 'ErrorSetAffinity', ['"Sort"', SysErrorMessage(GetLastError)]);
                    end;
                    if SetThreadAffinityMask(ThreadArray[3], 1 shl o) = 0 then
                    begin
                      LogFile.Write('LogStrings', 'ErrorSetAffinity',
                        ['"Operate Files"', SysErrorMessage(GetLastError)]);
                    end;
                    break;
                  end;
                end;
                if SetThreadAffinityMask(ThreadArray[1], 1 shl o) = 0 then
                begin
                  LogFile.Write('LogStrings', 'ErrorSetAffinity',
                    ['"Search Destination"', SysErrorMessage(GetLastError)]);
                end;
                for p := o + 1 to 31 do
                begin
                  if (dwPAffinity shr p and 1) = 1 then
                  begin
                    if SetThreadAffinityMask(ThreadArray[1], 1 shl p) = 0 then
                    begin
                      LogFile.Write('LogStrings', 'ErrorSetAffinity',
                        ['"Search Destination"', SysErrorMessage(GetLastError)]);
                    end;
                    break;
                  end;
                end;
              end;
            end;
            CloseHandle(dwPHandle); // Prozesshandle freigeben
            DestThread.Resume; // Threads starten
            SourceThread.Resume;
            SortThread.Resume;
            OperationThread.Resume;
            TreeData^.bProgress := true;
            repeat
              // Auf Threads warten
              dwWaitResult := WaitforMultipleObjects(Length(ThreadArray), @ThreadArray, true, 100);
              if dwWaitResult <> WAIT_OBJECT_0 then
              begin
                StatusbarUpdate(sRootName + TreeData^.sName, TreeData);
                // Statusbar updaten / Progress berechnen
                tvSourceDestination.RepaintNode(Node);
                acShowErrors.Enabled := bError and (tvSourceDestination.FocusedNode <> nil);
                Application.ProcessMessages; // GUI aktualisieren
              end;
            until dwWaitResult = WAIT_OBJECT_0;
            // keinen Threads mehr zum warten
            TreeData^.bProgress := false;
            tvSourceDestination.RepaintNode(Node);
            if TreeData^.sSource <> TreeData^.sSourceC then
            // Bei Quellnetzlaufwerk abmelden
            begin
              DisconnectNetworkDriveW(ExtractFileDrive(TreeData^.sSourceC));
            end;
            if TreeData^.sDest <> TreeData^.sDestC then
            // Bei Zielnetzlaufwerk abmelden
            begin
              DisconnectNetworkDriveW(ExtractFileDrive(TreeData^.sDestC));
            end;
            if not bCanceled then
            begin
              TreeData^.LastRun := Now;
            end
            else
            begin
              TreeData^.LastRun := - 1;
            end;
            if not bCanceled then // Backup nicht abgebrochen?
            begin
              if bError then // Fehler?
              begin
                sLog := LogFile.Write('LogStrings', 'ErrorJob', [sRootName + TreeData^.sName]);
                SetStatusbarText(sbMainForm, sLog);
              end
              else
              begin
                sLog := LogFile.Write('LogStrings', 'SuccessJob', [sRootName + TreeData^.sName]);
                SetStatusbarText(sbMainForm, sLog);
              end;
            end
            else
            begin
              sLog := LogFile.Write('LogStrings', 'CanceledJob', [sRootName + TreeData^.sName]);
              SetStatusbarText(sbMainForm, sLog);
            end;
            if bError or bCanceled then // Fehler im Job aufgetreten?
            begin
              bErrors := bError; // Fehlerbit für Meldung setzen
              TreeData^.iImageIndex := 2;
              tvSourceDestination.RepaintNode(Node);
            end
            else
            begin
              TreeData^.iImageIndex := 1;
              tvSourceDestination.RepaintNode(Node);
            end;
            for i := 0 to High(AApplicationData) do
            begin
              if TreeData^.Application[i].sFileName <> '' then
              begin
                ProgressForm.ApplicationName := TreeData^.Application[i].sFileName;
                case TreeData^.Application[i].Action of
                  aaRunAfter :
                    begin
                      ProgressForm.State := bsStartApp;
                      RunApplication(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam);
                    end;
                  aaRunAfterAndWait :
                    begin
                      ProgressForm.State := bsStartApp;
                      RunApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam,
                        TreeData^.Application[i].iTimeout);
                    end;
                  aaCloseAfter :
                    begin
                      ProgressForm.State := bsCloseApp;
                      CloseApplication(TreeData^.Application[i].sFileName);
                    end;
                  aaCloseAfterAndWait :
                    begin
                      ProgressForm.State := bsCloseApp;
                      CloseApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].iTimeout);
                    end;
                end;
              end;
            end;
            // Speicher freigeben
            if SourceFileList <> nil then
            begin
              SourceFileList.Clear;
              FreeAndNil(SourceFileList);
            end;
            if DestFileList <> nil then
            begin
              DestFileList.Clear;
              FreeAndNil(DestFileList);
            end;
            if CopyFilesList <> nil then
            begin
              CopyFilesList.Clear;
              FreeAndNil(CopyFilesList);
            end;
            if MoveFilesList <> nil then
            begin
              MoveFilesList.Clear;
              FreeAndNil(MoveFilesList);
            end;
            if DeleteFilesList <> nil then
            begin
              DeleteFilesList.Clear;
              FreeAndNil(DeleteFilesList);
            end;
            if SourceFolderList <> nil then
            begin
              SourceFolderList.Clear;
              FreeAndNil(SourceFolderList);
            end;
            if DestFolderList <> nil then
            begin
              DestFolderList.Clear;
              FreeAndNil(DestFolderList);
            end;
            if DeleteDirList <> nil then
            begin
              DeleteDirList.Clear;
              FreeAndNil(DeleteDirList);
            end;
            ActNode := nil;
            if ThreadIdList <> nil then
            begin
              ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(SourceThread.ThreadId)));
              // IDs leeren
              ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(DestThread.ThreadId)));
              ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(SortThread.ThreadId)));
              ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(OperationThread.ThreadId)));
            end;
            FreeAndNil(SourceThread); // Threads freigeben
            FreeAndNil(DestThread);
            FreeAndNil(SortThread);
            FreeAndNil(OperationThread);
            StatusbarUpdate('', nil);
            // Statusbar updaten / Progress berechnen
          end
          else
          begin // Job abbrechen, kein Quellordner
            bErrors := true;
            TreeData^.iImageIndex := 2;
            tvSourceDestination.RepaintNode(Node);
            sLog := LogFile.Write('LogStrings', 'NoSourceFolder', [sRootName + TreeData^.sName]);
            Log(sLog, TreeData^.JobErrors);
            SetStatusbarText(sbMainForm, sLog);
          end;
        end
        else
        begin // Job abbrechen, Ziellaufwerksname falsch
          bErrors := true;
          TreeData^.iImageIndex := 2;
          tvSourceDestination.RepaintNode(Node);
          sLog := LogFile.Write('LogStrings', 'DestLwNameWrong', [sRootName + TreeData^.sName]);
          Log(sLog, TreeData^.JobErrors);
          SetStatusbarText(sbMainForm, sLog);
        end;
      end
      else
      begin // Job abbrechen, Quelllaufwerksname falsch
        bErrors := true;
        TreeData^.iImageIndex := 2;
        tvSourceDestination.RepaintNode(Node);
        sLog := LogFile.Write('LogStrings', 'SourceLwNameWrong', [sRootName + TreeData^.sName]);
        Log(sLog, TreeData^.JobErrors);
        SetStatusbarText(sbMainForm, sLog);
      end;
      if bCanceled then
      begin
        sLog := JvTranslate.Translate('GUIStrings', 'Canceled');
        Log(sLog, TreeData^.JobErrors);
        SetStatusbarText(sbMainForm, sLog);
      end;
      if tvSourceDestination.GetNodeLevel(Node) = 1 then // Jobgruppe?
      begin
        RootNode := Node.Parent;
        ChildNode := tvSourceDestination.GetLastChild(RootNode);
        while not VSTHChecked(tvSourceDestination, ChildNode) do
        // letzten Checked Node der Gruppe suchen
        begin
          ChildNode := tvSourceDestination.GetPrevious(ChildNode);
          if ChildNode = nil then
          // Jobgruppe während der Bearbeitung abgewählt?
          begin
            ChildNode := Node;
            break;
          end;
        end;
        if (ChildNode = Node) or bCanceled then
        // Aktueller Node = letzter Checked Node?
        begin
          ChildNode := tvSourceDestination.GetFirstChild(RootNode);
          RootData := tvSourceDestination.GetNodeData(RootNode);
          RootData^.iImageIndex := 1;
          repeat // gehe durch alle Child Nodes der Jobgruppe und suchen ob einer der ausgewählten nicht ok
            TreeData := tvSourceDestination.GetNodeData(ChildNode);
            if ((TreeData^.iImageIndex = 2) and VSTHChecked(tvSourceDestination, ChildNode)) or bCanceled then
            // Fehler im gefundenen und angewählten Node oder Abgebrochen?
            begin
              RootData^.iImageIndex := 2;
              break;
            end;
            ChildNode := tvSourceDestination.GetNextSibling(ChildNode);
          until ChildNode = nil;
          tvSourceDestination.RepaintNode(RootNode);
        end;
      end;
      if not bCanceled then // Abgebrochen?
      begin
        if tvSourceDestination.GetNextChecked(Node, csCheckedNormal) <> nil then
        // Nächsten Node zum bearbeiten holen
        begin
          Node := tvSourceDestination.GetNextChecked(Node, csCheckedNormal);
        end
        else
        begin
          bNoMoreNode := true; // Kein Node mehr zum bearbeiten
        end;
      end;
    end
    else
    begin
      bNoMoreNode := true;
    end;
  until bNoMoreNode or bCanceled;
  acStart.Enabled := true; // Kolisionen vermeiden
  acAdd.Enabled := true;
  if tvSourceDestination.FocusedNode <> nil then
  begin
    acDel.Enabled := true;
    acCopy.Enabled := true;
    acChange.Enabled := true;
  end;
  acCancel.Enabled := false;
  acSuspend.Visible := false;
  if not bCanceled and not bAddCanceled then // Backup nicht abgebrochen?
  begin
    if bErrors then // Fehler?
    begin
      sLog := LogFile.Write('LogStrings', 'Error'); // Meldung Fehler
      SetStatusbarText(sbMainForm, sLog);
    end
    else
    begin
      sLog := LogFile.Write('LogStrings', 'Success'); // Meldung Erfolg
      SetStatusbarText(sbMainForm, sLog);
    end;
    if bLogoff then // Abgebrochene ENDSESSION wieder einleiten
    begin
      ShutDown.Logoff(bForce);
    end
    else
    begin
      case iShutdownMode of
        1 :
          ShutDown.ShutDown(true, bForce);
        2 :
          ShutDown.Restart(bForce);
      end;
    end;
    if bShutdown or bParamShutdown then
    // Automatisches Herunterfahren nach dem Backup
    begin
      ShutDown.ShutDown(true, bForce);
    end;
    if bClose or bParamClose then // Automatisches schließen nach dem Backup
    begin
      close;
    end;
  end
  else
  begin
    sLog := LogFile.Write('LogStrings', 'Canceled');
    // Meldung Backup abgebrochen
    SetStatusbarText(sbMainForm, sLog);
  end;
  if not ProgressForm.DoNotClose then
  begin
    ProgressForm.close;
  end;
  ProgressForm.Error := nil;
  ProgressForm.State := bsFinished;
  FreeAndNil(d);
  ctiBackupper.Animated := false;
  ctiBackupper.CurrentIcon := Application.Icon;
  bCanceled := false;
end;

procedure TMainForm.acSearchReplaceExecute(Sender : TObject);
var
  SearchData : TSearchData;
begin
  if SRForm.ShowModal = mrOk then
  begin
    SearchData := SRForm.SearchData;
    tvSourceDestination.IterateSubtree(nil, IterateSearchReplace, @SearchData, [], false);
  end;
end;

procedure TMainForm.acShowErrorsExecute(Sender : TObject);
// zeige Fehlerliste
var
  TreeData : PTreeData;
begin
  TreeData := tvSourceDestination.GetNodeData(tvSourceDestination.FocusedNode);
  if Assigned(TreeData) and (TreeData^.JobErrors <> nil) and (TreeData^.JobErrors is TStringList) then
  begin
    TShowErrors.mErrors.Lines.Assign(TreeData^.JobErrors);
    TShowErrors.show;
  end;
end;

procedure TMainForm.acAddExecute(Sender : TObject);
// Job hinzufügen
var
  TreeData : TTreeData;
  i : Integer;
begin
  with TEditChange do
  begin
    eName.Text := '';
    eSourcePath.Text := '';
    eDestinationPath.Text := '';
    eFileMask.Text := '*.*';
    eSourceDriveLabel.Text := '';
    eDestDriveLabel.Text := '';
    eUserName.Text := '';
    ePassword.Text := '';
    cbEnabled.Checked := false;
    cbSubFolders.Checked := true;
    cbDeleteFiles.Checked := true;
    cbDoNotCopyFlags.Checked := false;
    cbEnableNetworkLogon.Checked := false;
    iTimeout := iWaitTimeout;
    CompareMode := cmHash;
    seTimeDiff.Value := 0;
    SkipFolders := nil;
    SkipFiles := nil;
    for i := 0 to high(ATimerData) do
    begin
      Timer[i].bEnabled := false;
      Timer[i].bOnShutdown := false;
      Timer[i].Time := 0;
      Timer[i].Kind := tkOneShot;
      Timer[i].iMulti := 1;
    end;
    for i := 0 to high(AApplicationData) do
    begin
      Application[i].sFileName := '';
      Application[i].sParam := '';
      Application[i].iTimeout := iWaitTimeout;
      Application[i].Action := aaNone;
    end;
    Caption := JvTranslate.Translate('GUIStrings', 'AddJob');
    ShowModal;
    if (eSourcePath.Text <> '') and (eDestinationPath.Text <> '') and (ModalResult = mrOk) then
    begin
      LogFile.Write('LogStrings', 'JobAdded', [eName.Text]);
      if eName.Text = '' then
      begin
        eName.Text := ' ';
      end;
      TreeData.sName := eName.Text;
      TreeData.sSource := eSourcePath.Text;
      TreeData.sDest := eDestinationPath.Text;
      TreeData.sFileMask := eFileMask.Text;
      TreeData.sSourceDriveLabel := eSourceDriveLabel.Text;
      TreeData.sDestDriveLabel := eDestDriveLabel.Text;
      TreeData.sUsername := eUserName.Text;
      TreeData.sPassword := EncryptPW(ePassword.Text, TreeData.sName);
      TreeData.bSubFolders := cbSubFolders.Checked;
      TreeData.bDeleteFiles := cbDeleteFiles.Checked;
      TreeData.bDoNotCopyFlags := cbDoNotCopyFlags.Checked;
      TreeData.bEnableNetworkLogon := cbEnableNetworkLogon.Checked;
      TreeData.CompareMode := CompareMode;
      TreeData.iTimeDiff := trunc(seTimeDiff.Value);
      if TreeData.SkipFolders = nil then
      begin
        TreeData.SkipFolders := TStringList.Create;
        TreeData.SkipFolders.Sorted := true;
        TreeData.SkipFolders.Duplicates := dupIgnore;
      end;
      TreeData.SkipFolders.Clear;
      for i := 0 to lvSkipFolders.Items.Count - 1 do
      begin
        TreeData.SkipFolders.Add(lvSkipFolders.Items[i].Caption);
      end;
      if TreeData.SkipFiles = nil then
      begin
        TreeData.SkipFiles := TStringList.Create;
        TreeData.SkipFiles.Sorted := true;
        TreeData.SkipFiles.Duplicates := dupIgnore;
      end;
      TreeData.SkipFiles.Clear;
      for i := 0 to lvSkipFiles.Items.Count - 1 do
      begin
        TreeData.SkipFiles.Add(lvSkipFiles.Items[i].Caption);
      end;
      TreeData.Timer := Timer;
      TreeData.Application := Application;
      TreeData.iImageIndex := - 1;
      VSTHAdd(tvSourceDestination, TreeData, cbEnabled.Checked);
      bAddCanceled := false;
    end
    else
    begin
      bAddCanceled := true;
    end;
  end;
end;

procedure TMainForm.acDelExecute(Sender : TObject);
// Job löschen
var
  TreeData : PTreeData;
  sFullName : string;
begin
  TreeData := tvSourceDestination.GetNodeData(tvSourceDestination.FocusedNode);
  sFullName := TreeData^.sName;
  if tvSourceDestination.GetNodeLevel(tvSourceDestination.FocusedNode) = 1 then
  begin
    TreeData := tvSourceDestination.GetNodeData(tvSourceDestination.FocusedNode.Parent);
    sFullName := TreeData^.sName + ' ' + sFullName;
  end;
  if bConfirmDelete then
  begin
    if (MessageDlg(format(JvTranslate.Translate('GUIStrings', 'RealyDeleteJob'), [sFullName]), mtConfirmation, mbYesNo,
      0) = mrYes) then
    begin
      LogFile.Write('LogStrings', 'JobDeleted', [sFullName]);
      VSTHDel(tvSourceDestination, tvSourceDestination.FocusedNode);
    end;
  end
  else
  begin
    LogFile.Write('LogStrings', 'JobDeleted', [sFullName]);
    VSTHDel(tvSourceDestination, tvSourceDestination.FocusedNode);
  end;
end;

procedure TMainForm.acChangeExecute(Sender : TObject);
// Job ändern
var
  Node : PVirtualNode;
  TreeData, RootData : PTreeData;
  Data : TTreeData;
  i : Integer;
begin
  Node := tvSourceDestination.FocusedNode;
  TreeData := tvSourceDestination.GetNodeData(Node);
  with TEditChange do
  begin
    eName.Text := '';
    if tvSourceDestination.GetNodeLevel(Node) = 1 then
    begin
      RootData := tvSourceDestination.GetNodeData(Node.Parent);
      eName.Text := RootData^.sName + ' ';
    end;
    eName.Text := eName.Text + TreeData^.sName;
    eSourcePath.Text := TreeData^.sSource;
    eDestinationPath.Text := TreeData^.sDest;
    cbEnabled.Checked := VSTHChecked(tvSourceDestination, Node);
    eFileMask.Text := TreeData^.sFileMask;
    eSourceDriveLabel.Text := '';
    eDestDriveLabel.Text := '';
    eSourceDriveLabel.Text := TreeData^.sSourceDriveLabel;
    eDestDriveLabel.Text := TreeData^.sDestDriveLabel;
    eUserName.Text := TreeData^.sUsername;
    ePassword.Text := DecryptPW(TreeData^.sPassword, eName.Text);
    cbSubFolders.Checked := TreeData^.bSubFolders;
    cbDeleteFiles.Checked := TreeData^.bDeleteFiles;
    cbDoNotCopyFlags.Checked := TreeData^.bDoNotCopyFlags;
    cbEnableNetworkLogon.Checked := TreeData^.bEnableNetworkLogon;
    iTimeout := iWaitTimeout;
    CompareMode := TreeData^.CompareMode;
    SkipFolders := TreeData^.SkipFolders;
    SkipFiles := TreeData^.SkipFiles;
    seTimeDiff.Value := TreeData^.iTimeDiff;
    Timer := TreeData^.Timer;
    for i := 0 to high(AApplicationData) do
    begin
      if TreeData^.Application[i].sFileName = '' then
      begin
        TreeData^.Application[i].iTimeout := iWaitTimeout;
      end;
    end;
    Application := TreeData^.Application;
    Caption := JvTranslate.Translate('GUIStrings', 'ChangeJob');
    ShowModal;
    if (eSourcePath.Text <> '') and (eDestinationPath.Text <> '') and (ModalResult = mrOk) then
    begin
      LogFile.Write('LogStrings', 'JobChanged', [eName.Text]);
      if eName.Text = '' then
      begin
        eName.Text := ' ';
      end;
      Data.sName := eName.Text;
      Data.sSource := eSourcePath.Text;
      Data.sDest := eDestinationPath.Text;
      Data.sFileMask := eFileMask.Text;
      Data.sSourceDriveLabel := eSourceDriveLabel.Text;
      Data.sDestDriveLabel := eDestDriveLabel.Text;
      Data.sUsername := eUserName.Text;
      Data.sPassword := EncryptPW(ePassword.Text, Data.sName);
      Data.bSubFolders := cbSubFolders.Checked;
      Data.bDeleteFiles := cbDeleteFiles.Checked;
      Data.bDoNotCopyFlags := cbDoNotCopyFlags.Checked;
      Data.bEnableNetworkLogon := cbEnableNetworkLogon.Checked;
      Data.CompareMode := CompareMode;
      Data.iTimeDiff := trunc(seTimeDiff.Value);
      Data.SkipFolders := TreeData^.SkipFolders;
      if Data.SkipFolders = nil then
      begin
        Data.SkipFolders := TStringList.Create;
        Data.SkipFolders.Sorted := true;
        Data.SkipFolders.Duplicates := dupIgnore;
      end;
      Data.SkipFolders.Clear;
      for i := 0 to lvSkipFolders.Items.Count - 1 do
      begin
        Data.SkipFolders.Add(lvSkipFolders.Items[i].Caption);
      end;
      Data.SkipFiles := TreeData^.SkipFiles;
      if Data.SkipFiles = nil then
      begin
        Data.SkipFiles := TStringList.Create;
        Data.SkipFiles.Sorted := true;
        Data.SkipFiles.Duplicates := dupIgnore;
      end;
      Data.SkipFiles.Clear;
      for i := 0 to lvSkipFiles.Items.Count - 1 do
      begin
        Data.SkipFiles.Add(lvSkipFiles.Items[i].Caption);
      end;
      Data.Timer := Timer;
      Data.Application := Application;
      Data.iImageIndex := - 1;
      VSTHChange(tvSourceDestination, Data, cbEnabled.Checked, Node);
    end;
  end;
end;

procedure TMainForm.acCopyExecute(Sender : TObject);
// Job kopieren
var
  Checked : Boolean;
  Node : PVirtualNode;
  NewTreeData : TTreeData;
  TreeData, RootData : PTreeData;
begin
  Node := tvSourceDestination.FocusedNode;
  TreeData := tvSourceDestination.GetNodeData(Node);
  NewTreeData := TreeData^;
  NewTreeData.LastRun := 0;
  NewTreeData.SkipFolders := TStringList.Create;
  NewTreeData.SkipFolders.Sorted := true;
  NewTreeData.SkipFolders.Duplicates := dupIgnore;
  NewTreeData.SkipFolders.Assign(TreeData^.SkipFolders);
  NewTreeData.SkipFiles := TStringList.Create;
  NewTreeData.SkipFiles.Sorted := true;
  NewTreeData.SkipFiles.Duplicates := dupIgnore;
  NewTreeData.SkipFiles.Assign(TreeData^.SkipFiles);
  Checked := tvSourceDestination.CheckState[Node] = csCheckedNormal;
  NewTreeData.Progress := nil;
  if tvSourceDestination.GetNodeLevel(Node) = 1 then
  begin
    RootData := tvSourceDestination.GetNodeData(Node.Parent);
    NewTreeData.sName := RootData^.sName + ' ' + NewTreeData.sName;
  end;
  VSTHAdd(tvSourceDestination, NewTreeData, Checked);
  LogFile.Write('LogStrings', 'JobCopied', [NewTreeData.sName]);
end;

procedure TMainForm.tvSourceDestinationClick(Sender : TObject);
// lesen
var
  Node : PVirtualNode;
begin
  Node := tvSourceDestination.FocusedNode;
  if Assigned(Node) then
  begin
    if tvSourceDestination.ChildCount[Node] >= 1 then
    begin
      if tvSourceDestination.Expanded[Node] then
      begin
        tvSourceDestination.Selected[tvSourceDestination.GetFirstChild(Node)] := true;
      end
      else
      begin
        tvSourceDestination.Selected[Node] := false;
      end;
    end;
  end;
end;

procedure TMainForm.tvSourceDestinationGetText(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex;
  TextType : TVSTTextType; var CellText : string);
var
  Data : PTreeData;
  iLevel : Integer;
  r : TRect;
begin
  Data := tvSourceDestination.GetNodeData(Node);
  if Assigned(Data) then
  begin
    iLevel := Sender.GetNodeLevel(Node);
    if tvSourceDestination.ChildCount[Node] <= 1 then
    begin
      iLevel := 1;
    end;
    case iLevel of
      0 :
        case Column of
          0 :
            CellText := Data^.sName;
        else
          CellText := '';
        end;
      1 :
        case Column of
          0 :
            CellText := Data^.sName;
          1 :
            CellText := Data^.sSource;
          2 :
            CellText := Data^.sDest;
          3 :
            if not Data^.bProgress then
            begin
              case trunc(Data^.LastRun) of
                0 :
                  CellText := JvTranslate.Translate('GUIStrings', 'Never');
                - 1 :
                  CellText := JvTranslate.Translate('GUIStrings', 'Canceled');
              else
                CellText := DateTimeToStr(Data^.LastRun);
              end;
              if Data^.Progress <> nil then
              begin
                Data^.Progress.Visible := false;
              end;
            end
            else
            begin
              if Data^.Progress = nil then
              begin
                Data^.Progress := TProgressbarEx.Create(tvSourceDestination);
                Data^.Progress.Parent := tvSourceDestination;
                Data^.Progress.DoubleBuffered := true;
              end;
              r := tvSourceDestination.GetDisplayRect(Node, 3, false);
              Data^.Progress.BoundsRect := r;
              Data^.Progress.Left := r.Left;
              Data^.Progress.Width := r.Right - r.Left;
              Data^.Progress.Height := r.Bottom - r.Top;
              Data^.Progress.Visible := true;
            end;
          4 :
            case Data^.CompareMode of
              cmHash :
                CellText := JvTranslate.Translate('GUIStrings', 'ModeHash');
              cmSizeTime :
                CellText := JvTranslate.Translate('GUIStrings', 'ModeFile');
              cmArchive :
                CellText := JvTranslate.Translate('GUIStrings', 'ModeArchive');
            end;
          5 :
            CellText := Data^.sSourceDriveLabel;
          6 :
            CellText := Data^.sDestDriveLabel;
        end;
    end;
  end;
end;

procedure TMainForm.tvSourceDestinationInitNode(Sender : TBaseVirtualTree; ParentNode, Node : PVirtualNode;
  var InitialStates : TVirtualNodeInitStates);
begin
  Node.CheckType := ctTriStateCheckBox; // we will have checkboxes throughout
  if ParentNode = nil then // top-level node is being initialised
    InitialStates := InitialStates + [ivsHasChildren];
  // <- important line here
end;

procedure TMainForm.tvSourceDestinationMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  Node : PVirtualNode;
  Data : PTreeData;
begin
  if Assigned(tvSourceDestination.GetNodeAt(X, Y)) then
  begin
    // tvSourceDestination.Selected[tvSourceDestination.GetNodeAt(x, y)] := true;
    // tvSourceDestination.FocusedNode := tvSourceDestination.GetNodeAt(x, y);
  end
  else
  begin
    tvSourceDestination.Selected[tvSourceDestination.GetFirstSelected] := false;
  end;
  Node := tvSourceDestination.FocusedNode;
  if Assigned(Node) then
  begin
    if tvSourceDestination.ChildCount[Node] >= 1 then
    begin
      if tvSourceDestination.Expanded[Node] then
      begin
        tvSourceDestination.Selected[tvSourceDestination.GetFirstChild(Node)] := true;
        tvSourceDestination.FocusedNode := tvSourceDestination.GetFirstChild(Node);
      end
      else
      begin
        tvSourceDestination.Selected[Node] := false;
      end;
    end;
  end;
  if tvSourceDestination.SelectedCount >= 1 then
  begin
    Data := tvSourceDestination.GetNodeData(tvSourceDestination.FocusedNode);
    acAdd.Enabled := acStart.Enabled;
    acChange.Enabled := acStart.Enabled;
    acDel.Enabled := acStart.Enabled;
    acCopy.Enabled := acStart.Enabled;
    acShowErrors.Enabled := (((Data^.JobErrors <> nil) and (Data^.JobErrors.Count >= 1)) or
      (acCancel.Enabled and acShowErrors.Enabled));
  end
  else
  begin
    acAdd.Enabled := acStart.Enabled;
    acChange.Enabled := false;
    acDel.Enabled := false;
    acCopy.Enabled := false;
    acShowErrors.Enabled := false;
  end;
  if Button = mbRight then
  begin
    pmListView.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;
end;

procedure TMainForm.pmTVHeaderAddHeaderPopupItem(const Sender : TBaseVirtualTree; const Column : TColumnIndex;
  var Cmd : TAddPopupItemType);
begin
  if Column = 0 then
  begin
    Cmd := apHidden;
  end;
end;

procedure TMainForm.tvSourceDestinationDblClick(Sender : TObject);
begin
  if acChange.Enabled then
  begin
    pmChange.Click;
  end
  else
  begin
    pmAdd.Click;
  end;
end;

procedure TMainForm.tvSourceDestinationFreeNode(Sender : TBaseVirtualTree; Node : PVirtualNode);
var
  Data : PTreeData;
  i : Integer;
begin
  Data := tvSourceDestination.GetNodeData(Node);
  if Assigned(Data) then
  begin
    Data^.sName := '';
    Data^.sSource := '';
    Data^.sSourceC := '';
    Data^.sDest := '';
    Data^.sDestC := '';
    Data^.sFileMask := '';
    Data^.sSourceDriveLabel := '';
    Data^.sDestDriveLabel := '';
    Data^.sUsername := '';
    Data^.sPassword := '';
    Data^.bSubFolders := false;
    Data^.bDeleteFiles := false;
    Data^.bDoNotCopyFlags := false;
    Data^.bProgress := false;
    Data^.bEnableNetworkLogon := false;
    Data^.iTimeDiff := 0;
    Data^.iImageIndex := - 1;
    Data^.LastRun := 0;
    Data^.CompareMode := cmHash;
    FreeAndNil(Data^.JobErrors);
    FreeAndNil(Data^.Progress);
    FreeAndNil(Data^.SkipFolders);
    FreeAndNil(Data^.SkipFiles);
    Data^.CompareMode := cmHash;
    for i := 0 to High(ATimerData) do
    begin
      Data^.Timer[i].bEnabled := false;
      Data^.Timer[i].bOnShutdown := false;
      Data^.Timer[i].Time := 0;
      Data^.Timer[i].Kind := tkOneShot;
      Data^.Timer[i].WatchMode := wmNone;
      Data^.Timer[i].iMulti := 1;
    end;
    for i := 0 to High(AApplicationData) do
    begin
      Data^.Application[i].sFileName := '';
      Data^.Application[i].sParam := '';
      Data^.Application[i].iTimeout := 0;
      Data^.Application[i].Action := aaNone;
    end;
  end;
end;

procedure TMainForm.tvSourceDestinationGetImageIndex(Sender : TBaseVirtualTree; Node : PVirtualNode;
  Kind : TVTImageKind; Column : TColumnIndex; var Ghosted : Boolean; var ImageIndex : Integer);
var
  Data : PTreeData;
begin
  if (Column = 0) and ((Kind = ikNormal) or (Kind = ikSelected)) then
  begin
    Data := Sender.GetNodeData(Node);
    ImageIndex := Data^.iImageIndex;
  end;
end;

procedure TMainForm.DoEvent(TreeData, RootData : PTreeData; Node : PVirtualNode; iMode : Integer; sRootName : string);
var
  i, j, k, l, m, n, o, p : Integer;
  bErrors : Boolean;
  dwWaitResult, dwPAffinity, dwDummy, dwPHandle : DWORD;
  RootNode, ChildNode : PVirtualNode;
  sLog : string;
  d : TStringDivider;
begin
  acStart.Enabled := false; // Kolisionen vermeiden
  acAdd.Enabled := false;
  acChange.Enabled := false;
  acDel.Enabled := false;
  acCopy.Enabled := false;
  acShowErrors.Enabled := false;
  acCancel.Enabled := true;
  acSuspend.Visible := true;
  bError := false;
  bErrors := false;
  RootNode := nil;
  d := TStringDivider.Create;
  d.Pattern := '|';
  ProgressForm.ClearErrors;
  ctiBackupper.Animated := true;
  // if WatchThread <> nil then
  // begin
  // WatchThread.Suspend;
  // end;
  if not bCanceled then // Abbrechen
  begin
    TreeData^.sSourceC := TreeData^.sSource;
    TreeData^.sDestC := TreeData^.sDest;
    ConnectDrives(d, TreeData, sRootName);
    if TreeData^.JobErrors = nil then // Fehlerliste vorhanden?
    begin
      TreeData^.JobErrors := TStringList.Create;
    end;
    TreeData^.JobErrors.Clear;
    ProgressForm.State := bsInit;
    ProgressForm.SourceDir := TreeData^.sSourceC;
    ProgressForm.DestDir := TreeData^.sDestC;
    ProgressForm.JobName := sRootName + TreeData^.sName;
    ProgressForm.Error := @TreeData^.JobErrors;
    if tvSourceDestination.GetNodeLevel(Node) = 1 then
    begin
      RootNode := Node.Parent;
      RootData := tvSourceDestination.GetNodeData(RootNode);
      RootData^.iImageIndex := 0;
      tvSourceDestination.RepaintNode(Node.Parent);
    end;
    ActNode := Node;
    if (TreeData^.sSourceDriveLabel = '') or
      (TreeData^.sSourceDriveLabel = GetVolumeLabel(ExtractFileDrive(TreeData^.sSourceC))) then
    // Quelllaufwerksname korrekt?
    begin
      if (TreeData^.sDestDriveLabel = '') or
        (TreeData^.sDestDriveLabel = GetVolumeLabel(ExtractFileDrive(TreeData^.sDestC))) then
      // Ziellaufwerksname korrekt?
      begin
        if DirectoryExists(TreeData^.sSourceC) then // Quellordner vorhanden?
        begin
          for i := 0 to High(AApplicationData) do
          begin
            if TreeData^.Application[i].sFileName <> '' then
            begin
              case TreeData^.Application[i].Action of
                aaRunBefore :
                  RunApplication(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam);
                aaRunBeforeAndWait :
                  RunApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam,
                    TreeData^.Application[i].iTimeout);
                aaCloseBefore :
                  CloseApplication(TreeData^.Application[i].sFileName);
                aaCloseBeforeAndWait :
                  CloseApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].iTimeout);
              end;
            end;
          end;
          case iMode of
            0 :
              sLog := LogFile.Write('LogStrings', 'JobStarted', [sRootName + TreeData^.sName]);
            1 :
              sLog := LogFile.Write('LogStrings', 'JobStartedTimed', [sRootName + TreeData^.sName]);
            2 :
              sLog := LogFile.Write('LogStrings', 'JobStartedBack', [sRootName + TreeData^.sName]);
          end;
          SetStatusbarText(sbMainForm, sLog);
          bError := false;
          TreeData^.iImageIndex := 0;
          tvSourceDestination.RepaintNode(Node);
          SourceThread := TtSearchFiles.Create(true);
          // Thread zum durchsuchen der Quellordner
          ThreadIdList.Add(IntToStr(SourceThread.ThreadId) + ';0Exception in Search Source Thread');
          SourceThread.OnTerminate := OnThreadTerminate;
          DestThread := TtSearchFiles.Create(true);
          // Thread zum durchsuchen der Zielordner
          ThreadIdList.Add(IntToStr(DestThread.ThreadId) + ';0Exception in Search Dest Thread');
          DestThread.OnTerminate := OnThreadTerminate;
          SortThread := TtSortFiles.Create(true);
          // Thread um Dateien den einzelnen Aktionen zuzuordnen
          ThreadIdList.Add(IntToStr(SortThread.ThreadId) + ';0Exception in Sort Files Thread');
          SortThread.OnTerminate := OnThreadTerminate;
          OperationThread := TtFileOperation.Create(true);
          // Thread um Dateien zu kopieren, verschieben, usw.
          ThreadIdList.Add(IntToStr(OperationThread.ThreadId) + ';0Exception in Operate Files Thread');
          OperationThread.OnTerminate := OnThreadTerminate;
          SourceThread.sDir := TreeData^.sSourceC; // Werteübergabe
          SourceThread.LogFile := @LogFile;
          SourceThread.TreeData := TreeData;
          SourceThread.FileList := @SourceFileList;
          SourceThread.FolderList := @SourceFolderList;
          SourceThread.bError := @bError;
          SourceThread.sStatusbarText := @sStatusbarText;
          SourceThread.iSearchMode := smSource;
          SourceThread.Priority := iThreadPriority;
          SourceThread.PF := ProgressForm;
          DestThread.sDir := TreeData^.sDestC;
          DestThread.LogFile := @LogFile;
          DestThread.TreeData := TreeData;
          DestThread.FileList := @DestFileList;
          DestThread.FolderList := @DestFolderList;
          DestThread.bError := @bError;
          DestThread.sStatusbarText := @sStatusbarText;
          DestThread.iSearchMode := smDestination;
          DestThread.Priority := iThreadPriority;
          DestThread.PF := ProgressForm;
          SortThread.SourceFiles := @SourceFileList;
          SortThread.DestFiles := @DestFileList;
          SortThread.SourceFolders := @SourceFolderList;
          SortThread.DestFolders := @DestFolderList;
          SortThread.CopyFiles := @CopyFilesList;
          SortThread.MoveFiles := @MoveFilesList;
          SortThread.DeleteFiles := @DeleteFilesList;
          SortThread.DeleteDirs := @DeleteDirList;
          SortThread.LogFile := @LogFile;
          SortThread.TreeData := TreeData;
          SortThread.bError := @bError;
          SortThread.sStatusbarText := @sStatusbarText;
          SortThread.Priority := iThreadPriority;
          SortThread.PF := ProgressForm;
          OperationThread.CopyFiles := @CopyFilesList;
          OperationThread.MoveFiles := @MoveFilesList;
          OperationThread.DeleteFiles := @DeleteFilesList;
          OperationThread.DeleteDirs := @DeleteDirList;
          OperationThread.LogFile := @LogFile;
          OperationThread.TreeData := TreeData;
          OperationThread.ErrorsList := @TreeData^.JobErrors;
          OperationThread.bError := @bError;
          OperationThread.sStatusbarText := @sStatusbarText;
          OperationThread.bDeleteFiles := TreeData^.bDeleteFiles;
          OperationThread.bDoNotCopyFlags := TreeData^.bDoNotCopyFlags;
          OperationThread.Priority := iThreadPriority;
          OperationThread.PF := ProgressForm;
          ThreadArray[0] := DestThread.Handle;
          // Handle Array um auf Threads zu warten
          ThreadArray[1] := SourceThread.Handle;
          ThreadArray[2] := SortThread.Handle;
          ThreadArray[3] := OperationThread.Handle;
          dwPHandle := OpenProcess(PROCESS_QUERY_INFORMATION, true, GetCurrentProcessId);
          // Prozesshandle holen
          if GetProcessAffinityMask(dwPHandle, dwPAffinity, dwDummy) then
          // Zugewiesene Prozessoren holen
          begin
            if dwPAffinity > 1 then
            begin
              for o := 0 to 31 do
              // dwPAffinity ausmaskieren und Prozessoren den Threads zuweisen
              begin
                if (dwPAffinity shr o and 1) = 1 then
                begin
                  if SetThreadAffinityMask(ThreadArray[0], 1 shl o) = 0 then
                  begin
                    LogFile.Write('LogStrings', 'ErrorSetAffinity', ['"Search Source"', SysErrorMessage(GetLastError)]);
                  end;
                  if SetThreadAffinityMask(ThreadArray[2], 1 shl o) = 0 then
                  begin
                    LogFile.Write('LogStrings', 'ErrorSetAffinity', ['"Sort"', SysErrorMessage(GetLastError)]);
                  end;
                  if SetThreadAffinityMask(ThreadArray[3], 1 shl o) = 0 then
                  begin
                    LogFile.Write('LogStrings', 'ErrorSetAffinity', ['"Operate Files"', SysErrorMessage(GetLastError)]);
                  end;
                  break;
                end;
              end;
              if SetThreadAffinityMask(ThreadArray[1], 1 shl o) = 0 then
              begin
                LogFile.Write('LogStrings', 'ErrorSetAffinity',
                  ['"Search Destination"', SysErrorMessage(GetLastError)]);
              end;
              for p := o + 1 to 31 do
              begin
                if (dwPAffinity shr p and 1) = 1 then
                begin
                  if SetThreadAffinityMask(ThreadArray[1], 1 shl p) = 0 then
                  begin
                    LogFile.Write('LogStrings', 'ErrorSetAffinity',
                      ['"Search Destination"', SysErrorMessage(GetLastError)]);
                  end;
                  break;
                end;
              end;
            end;
          end;
          CloseHandle(dwPHandle); // Prozesshandle freigeben
          DestThread.Resume; // Threads starten
          SourceThread.Resume;
          SortThread.Resume;
          OperationThread.Resume;
          TreeData^.bProgress := true;
          repeat
            // Auf Threads warten
            dwWaitResult := WaitforMultipleObjects(Length(ThreadArray), @ThreadArray, true, 100);
            if dwWaitResult <> WAIT_OBJECT_0 then
            begin
              StatusbarUpdate(sRootName + TreeData^.sName, TreeData);
              // Statusbar updaten / Progress berechnen
              tvSourceDestination.RepaintNode(Node);
              acShowErrors.Enabled := bError and (tvSourceDestination.FocusedNode <> nil);
              Application.ProcessMessages; // GUI aktualisieren
            end;
          until dwWaitResult = WAIT_OBJECT_0;
          // keinen Threads mehr zum warten
          // if WatchThread <> nil then
          // begin
          // WatchThread.Resume;
          // end;
          if TreeData^.sSource <> TreeData^.sSourceC then
          // Bei Quellnetzlaufwerk abmelden
          begin
            DisconnectNetworkDriveW(ExtractFileDrive(TreeData^.sSourceC));
          end;
          if TreeData^.sDest <> TreeData^.sDestC then
          // Bei Zielnetzlaufwerk abmelden
          begin
            DisconnectNetworkDriveW(ExtractFileDrive(TreeData^.sDestC));
          end;
          TreeData^.bProgress := false;
          if not bCanceled then
          begin
            TreeData^.LastRun := Now;
          end
          else
          begin
            TreeData^.LastRun := - 1;
          end;
          if bError or bCanceled then // Fehler im Job aufgetreten?
          begin
            bErrors := bError; // Fehlerbit für Meldung setzen
            TreeData^.iImageIndex := 2;
            tvSourceDestination.RepaintNode(Node);
          end
          else
          begin
            TreeData^.iImageIndex := 1;
            tvSourceDestination.RepaintNode(Node);
          end;
          for i := 0 to High(AApplicationData) do
          begin
            if TreeData^.Application[i].sFileName <> '' then
            begin
              case TreeData^.Application[i].Action of
                aaRunAfter :
                  RunApplication(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam);
                aaRunAfterAndWait :
                  RunApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].sParam,
                    TreeData^.Application[i].iTimeout);
                aaCloseAfter :
                  CloseApplication(TreeData^.Application[i].sFileName);
                aaCloseAfterAndWait :
                  CloseApplicationandWait(TreeData^.Application[i].sFileName, TreeData^.Application[i].iTimeout);
              end;
            end;
          end;
          // Speicher freigeben
          if SourceFileList <> nil then
          begin
            SourceFileList.Clear;
            FreeAndNil(SourceFileList);
          end;
          if DestFileList <> nil then
          begin
            DestFileList.Clear;
            FreeAndNil(DestFileList);
          end;
          if CopyFilesList <> nil then
          begin
            CopyFilesList.Clear;
            FreeAndNil(CopyFilesList);
          end;
          if MoveFilesList <> nil then
          begin
            MoveFilesList.Clear;
            FreeAndNil(MoveFilesList);
          end;
          if DeleteFilesList <> nil then
          begin
            DeleteFilesList.Clear;
            FreeAndNil(DeleteFilesList);
          end;
          if SourceFolderList <> nil then
          begin
            SourceFolderList.Clear;
            FreeAndNil(SourceFolderList);
          end;
          if DestFolderList <> nil then
          begin
            DestFolderList.Clear;
            FreeAndNil(DestFolderList);
          end;
          if DeleteDirList <> nil then
          begin
            DeleteDirList.Clear;
            FreeAndNil(DeleteDirList);
          end;
          ActNode := nil;
          ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(SourceThread.ThreadId)));
          // IDs leeren
          ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(DestThread.ThreadId)));
          ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(SortThread.ThreadId)));
          ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(OperationThread.ThreadId)));
          FreeAndNil(SourceThread); // Threads freigeben
          FreeAndNil(DestThread);
          FreeAndNil(SortThread);
          FreeAndNil(OperationThread);
          StatusbarUpdate('', nil); // Statusbar updaten / Progress berechnen
        end
        else
        begin // Job abbrechen, kein Quellordner
          bErrors := true;
          TreeData^.iImageIndex := 2;
          tvSourceDestination.RepaintNode(Node);
          sLog := LogFile.Write('LogStrings', 'NoSourceFolder', [sRootName + TreeData^.sName]);
          Log(sLog, TreeData^.JobErrors);
          SetStatusbarText(sbMainForm, sLog);
        end;
      end
      else
      begin // Job abbrechen, Ziellaufwerksname falsch
        bErrors := true;
        TreeData^.iImageIndex := 2;
        tvSourceDestination.RepaintNode(Node);
        sLog := LogFile.Write('LogStrings', 'DestLwNameWrong', [sRootName + TreeData^.sName]);
        Log(sLog, TreeData^.JobErrors);
        SetStatusbarText(sbMainForm, sLog);
      end;
    end
    else
    begin // Job abbrechen, Quelllaufwerksname falsch
      bErrors := true;
      TreeData^.iImageIndex := 2;
      tvSourceDestination.RepaintNode(Node);
      sLog := LogFile.Write('LogStrings', 'SourceLwNameWrong', [sRootName + TreeData^.sName]);
      Log(sLog, TreeData^.JobErrors);
      SetStatusbarText(sbMainForm, sLog);
    end;
  end;
  if bCanceled then
  begin
    case iMode of
      0 :
        Log(format(JvTranslate.Translate('GUIStrings', 'Canceled'), [sRootName + TreeData^.sName]),
          TreeData^.JobErrors);
      1 :
        Log(format(JvTranslate.Translate('GUIStrings', 'CanceledTimed'), [sRootName + TreeData^.sName]),
          TreeData^.JobErrors);
      2 :
        Log(format(JvTranslate.Translate('GUIStrings', 'CanceledBack'), [sRootName + TreeData^.sName]),
          TreeData^.JobErrors);
    end;
  end;
  if tvSourceDestination.GetNodeLevel(Node) = 1 then
  begin
    ChildNode := tvSourceDestination.GetFirstChild(RootNode);
    RootData^.iImageIndex := 1;
    repeat
      TreeData := tvSourceDestination.GetNodeData(ChildNode);
      if (TreeData^.iImageIndex = 2) or bCanceled then
      begin
        RootData^.iImageIndex := 2;
        break;
      end;
      ChildNode := tvSourceDestination.GetNextSibling(ChildNode);
    until ChildNode = nil;
    tvSourceDestination.RepaintNode(RootNode);
  end;
  TreeData := tvSourceDestination.GetNodeData(Node);
  acStart.Enabled := not pmtEnableTimer.Checked; // Kolisionen vermeiden
  ctiBackupper.Animated := false;
  ctiBackupper.CurrentIcon := Application.Icon;
  acCancel.Enabled := false;
  acSuspend.Visible := false;
  if not bCanceled then // Backup nicht abgebrochen?
  begin
    if bErrors then // Fehler?
    begin
      case iMode of
        0 :
          sLog := LogFile.Write('LogStrings', 'Error', [sRootName + TreeData^.sName]);
        1 :
          sLog := LogFile.Write('LogStrings', 'ErrorTimed', [sRootName + TreeData^.sName]);
        2 :
          sLog := LogFile.Write('LogStrings', 'ErrorBack', [sRootName + TreeData^.sName]);
      end;
      SetStatusbarText(sbMainForm, sLog);
    end
    else
    begin
      case iMode of
        0 :
          sLog := LogFile.Write('LogStrings', 'Success', [sRootName + TreeData^.sName]);
        1 :
          sLog := LogFile.Write('LogStrings', 'SuccessTimed', [sRootName + TreeData^.sName]);
        2 :
          sLog := LogFile.Write('LogStrings', 'SuccessBack', [sRootName + TreeData^.sName]);
      end;
      SetStatusbarText(sbMainForm, sLog);
    end;
  end
  else
  begin
    case iMode of
      0 :
        sLog := LogFile.Write('LogStrings', 'Canceled', [sRootName + TreeData^.sName]);
      1 :
        sLog := LogFile.Write('LogStrings', 'CanceledTimed', [sRootName + TreeData^.sName]);
      2 :
        sLog := LogFile.Write('LogStrings', 'CanceledBack', [sRootName + TreeData^.sName]);
    end;
    SetStatusbarText(sbMainForm, sLog);
  end;
  ProgressForm.Error := nil;
  ProgressForm.State := bsFinished;
  FreeAndNil(d);
end;

procedure TMainForm.tAlarmsTimer(Sender : TObject);
var
  Current : TDateTime;
  Stamp : TTimeStamp;
  // Year, Month, Day : Word;
  i : Integer;
  bNoMoreNode, bEventSignaled : Boolean;
  Node, RootNode : PVirtualNode;
  TreeData, RootData : PTreeData;
  sRootName : string;
begin
  tAlarms.Enabled := false;
  Current := Now;
  Stamp := DateTimeToTimeStamp(Current);
  if ((((Stamp.Time - FLast.Time) >= 1000) or (Stamp.Date > FLast.Date)) and not acCancel.Enabled) then
  begin
    FLast := Stamp;
    bNoMoreNode := false;
    bEventSignaled := false;
    bCanceled := false;
    RootData := nil;
    Node := tvSourceDestination.GetFirst;
    repeat
      if Node = nil then // Abfrage auf vorhandene Jobs
      begin
        break;
      end;
      if Assigned(Node) then
      begin
        sRootName := '';
        if tvSourceDestination.GetNodeLevel(Node) = 1 then
        begin
          RootNode := Node.Parent;
          RootData := tvSourceDestination.GetNodeData(RootNode);
          sRootName := RootData^.sName + ' ';
        end
        else
        begin
          if Node.ChildCount >= 1 then
          begin
            Node := tvSourceDestination.GetNext(Node);
            RootNode := Node.Parent;
            RootData := tvSourceDestination.GetNodeData(RootNode);
            sRootName := RootData^.sName + ' ';
          end;
        end;
        TreeData := tvSourceDestination.GetNodeData(Node);
        if bDoSdEvent then
        begin
          if TreeData^.Timer[0].bOnShutdown then
          begin
            DoEvent(TreeData, RootData, Node, 1, sRootName); // Timer Event
            TreeData^.bChanged := false;
          end;
        end
        else
        begin
          for i := 0 to high(ATimerData) do
          begin
            if TreeData^.Timer[i].bEnabled then
            begin
              case TreeData^.Timer[i].WatchMode of
                wmNone :
                  begin
                    bEventSignaled := (Current >= TreeData^.Timer[i].Time);
                  end;
                wmChange :
                  begin
                    bEventSignaled := TreeData^.bChanged;
                  end;
                wmChangeAndTimer :
                  begin
                    bEventSignaled := (TreeData^.bChanged) and (Current >= TreeData^.Timer[i].Time);
                  end;
                wmChangeOrTimer :
                  begin
                    bEventSignaled := (TreeData^.bChanged) or (Current >= TreeData^.Timer[i].Time);
                  end;
              end;
              if bEventSignaled then
              begin
                bEventSignaled := false;
                DoEvent(TreeData, RootData, Node, 1, sRootName);
                // Timer Event
                TreeData := tvSourceDestination.GetNodeData(Node);
                TreeData^.bChanged := false;
                Current := Now;
                Stamp := DateTimeToTimeStamp(TreeData^.Timer[i].Time);
                if (Current >= TreeData^.Timer[i].Time) then
                begin
                  repeat
                    case TreeData^.Timer[i].Kind of
                      tkOneShot :
                        ;
                      tkEachMinute :
                        Inc(Stamp.Time, 60 * 1000 * TreeData^.Timer[i].iMulti);
                      tkEachHour :
                        Inc(Stamp.Time, 60 * 60 * 1000 * TreeData^.Timer[i].iMulti);
                      tkEachDay :
                        Inc(Stamp.Date);
                      tkEachMonth :
                        Stamp := DateTimeToTimeStamp(IncMonth(TreeData^.Timer[i].Time, TreeData^.Timer[i].iMulti));
                      // tkEachYear :
                      // begin
                      // DecodeDate(Current, Year, Month, Day);
                      // // (rom) a showoff with boolean expressions :-)
                      // Inc(Stamp.Date, 365 + Ord(IsLeapYear(Year)));
                      // end;
                    end;
                    if Stamp.Time > 24 * 60 * 60 * 1000 then
                    begin
                      Inc(Stamp.Date);
                      Dec(Stamp.Time, 24 * 60 * 60 * 1000);
                    end;
                    if TreeData^.Timer[i].Kind <> tkOneShot then
                      TreeData^.Timer[i].Time := TimeStampToDateTime(Stamp)
                    else
                      TreeData^.Timer[i].bEnabled := (TreeData^.Timer[i].WatchMode = wmChange) or
                        (TreeData^.Timer[i].WatchMode = wmChangeOrTimer);
                  until (TimeStampToDateTime(Stamp) >= Current) or (TreeData^.Timer[i].Kind = tkOneShot);
                end;
              end;
            end;
          end;
        end;
      end;
      if not bCanceled then
      begin
        Node := tvSourceDestination.GetNext(Node);
        if Node = nil then
        begin
          bNoMoreNode := true;
        end;
      end;
    until bNoMoreNode or bCanceled;
    if bDoSdEvent then // Abgebrochene ENDSESSION wieder einleiten
    begin
      if bLogoff then
      begin
        ShutDown.Logoff(bForce);
      end
      else
      begin
        case iShutdownMode of
          1 :
            ShutDown.ShutDown(true, bForce);
          2 :
            ShutDown.Restart(bForce);
        end;
      end;
    end;
    bCanceled := false;
  end;
  tAlarms.Enabled := pmtEnableTimer.Checked;
end;

procedure TMainForm.pmtHideClick(Sender : TObject);
begin
  ctiBackupper.HideApplication;
  if not pmtEnableTimer.Checked then
  begin
    pmtEnableTimerClick(Sender);
  end;
  if not IsWinVistaOrHigher then
  begin
    pmtShow.Default := true;
    pmtHide.Default := false;
  end
  else
  begin
    pmtShow.Visible := true;
    pmtHide.Visible := false;
  end;
end;

procedure TMainForm.tHideTimer(Sender : TObject);
begin
  tHide.Enabled := false;
  pmtHide.Click;
end;

procedure TMainForm.pmtShowClick(Sender : TObject);
begin
  ctiBackupper.ShowApplication;
  if pmtEnableTimer.Checked then
  begin
    pmtEnableTimerClick(Sender);
  end;
  if not IsWinVistaOrHigher then
  begin
    pmtShow.Default := false;
    pmtHide.Default := true;
  end
  else
  begin
    pmtShow.Visible := false;
    pmtHide.Visible := true;
  end;
end;

procedure TMainForm.pmtEnableTimerClick(Sender : TObject);
var
  i : Integer;
  sRootName : string;
  dwWaitResult : DWORD;
  Node : PVirtualNode;
  TreeData : PTreeData;
begin
  pmtEnableTimer.Checked := not pmtEnableTimer.Checked;
  if pmtEnableTimer.Checked then
  begin
    tAlarms.Enabled := true;
    acStart.Enabled := false; // Kolisionen vermeiden
    acAdd.Enabled := false;
    acChange.Enabled := false;
    acDel.Enabled := false;
    acCopy.Enabled := false;
    WatchThread := TtDirWatch.Create(true);
    WatchThread.Priority := tpLowest;
    ThreadIdList.Add(IntToStr(WatchThread.ThreadId) + ';0Exception in Watch Directory Thread');
    WatchThread.OnTerminate := OnThreadTerminate;
    Node := tvSourceDestination.GetFirst;
    while Node <> nil do
    begin
      sRootName := '';
      if Node.ChildCount >= 1 then
      begin
        TreeData := tvSourceDestination.GetNodeData(Node);
        sRootName := TreeData^.sName + ' ';
        Node := tvSourceDestination.GetNext(Node);
      end;
      TreeData := tvSourceDestination.GetNodeData(Node);
      for i := 0 to High(ATimerData) do
      begin
        if TreeData^.Timer[i].WatchMode <> wmNone then
        begin
          WatchThread.AddWatchNode(tvSourceDestination.GetNodeData(Node), sRootName);
        end;
      end;
      Node := tvSourceDestination.GetNext(Node);
    end;
    WatchThread.Resume;
  end
  else
  begin
    tAlarms.Enabled := false;
    acStart.Enabled := not acCancel.Enabled; // Kolisionen vermeiden
    acAdd.Enabled := not acCancel.Enabled;
    if (tvSourceDestination.FocusedNode <> nil) and not acCancel.Enabled then
    begin
      acChange.Enabled := true;
      acDel.Enabled := true;
      acCopy.Enabled := true;
    end;
    if WatchThread <> nil then
    begin
      if WatchThread.Suspended then
      begin
        WatchThread.Resume;
      end;
      WatchThread.Terminate;
      repeat
        dwWaitResult := WaitforSingleObject(WatchThread.Handle, 250);
        if dwWaitResult = WAIT_TIMEOUT then
        begin
          Application.ProcessMessages;
        end;
      until dwWaitResult <> WAIT_TIMEOUT;
      ThreadIdList.Delete(ThreadIdList.IndexOfName(IntToStr(WatchThread.ThreadId)));
      FreeAndNil(WatchThread);
    end;
  end;
end;

procedure TMainForm.mmUninstallClick(Sender : TObject);
var
  bSuccess : Boolean;
begin
  if (MessageDlg(JvTranslate.Translate('GUIStrings', 'Uninstall'), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    FreeAndNil(LogFile);
    bSuccess := false;
    if DirectoryExists(sSettingsPath) and DeleteFileEx(sSettingsPath) then
    begin
      bSuccess := true;
    end;
    if DirectoryExists(sLogPath) and DeleteFileEx(sLogPath) or not bLog then
    begin
      bSuccess := bSuccess
    end
    else
    begin
      bSuccess := false;
    end;
    if bSuccess then
    begin
      MessageDlg(format(JvTranslate.Translate('GUIStrings', 'UninstallSucces'), [#10#13]), mtInformation, [mbOK], 0);
      bWrongSettings := true;
    end;
  end;
end;

procedure TMainForm.OnThreadTerminate(Sender : TObject);
var
  s : string;
  Data : PTreeData;
begin
  if TThread(Sender).FatalException is Exception then
  begin
    bError := true;
    s := ThreadIdList.Values[IntToStr(TThread(Sender).ThreadId)];
    s := s + ' --> Message text:"';
    s := s + (TThread(Sender).FatalException as Exception).Message;
    s := s + '"';
    s := LogFile.Write(s);
    if ActNode <> nil then
    begin
      Data := tvSourceDestination.GetNodeData(ActNode);
      if Assigned(Data) then
      begin
        Log(s, Data^.JobErrors);
      end;
    end;
    SetStatusbarText(sbMainForm, s);
  end;
end;

end.
