unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, frxDesgn, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ComCtrls, frxClass, frxExportRTF,
  frxRich, Vcl.ImgList, Vcl.Buttons, frxDBSet,
  uReport, Vcl.ButtonGroup, Vcl.ExtCtrls,
  uReportController, System.Actions, Vcl.ActnList, Vcl.Menus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinWhiteprint, dxSkinVS2010,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData,
  System.ImageList, frxSmartMemo, frCoreClasses;

type
  TErrorCode = class
  private
    FErrorCode: integer;
  public
    property ec: integer read FErrorCode;
    constructor create(aErrorCode: integer);
  end;
  ICMFastReport = Interface
    ['{A0CA085E-2986-4ACE-BCD4-9F81DD70E274}']

  End;

  TfrmMain = class(TForm)
    Label1: TLabel;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    frxDesigner1: TfrxDesigner;
    ImageList1: TImageList;
    Panel1: TPanel;
    ReportTree: TTreeView;
    Panel2: TPanel;
    Memo1: TMemo;
    bbnClose: TBitBtn;
    GroupBox1: TGroupBox;
    btnRemoveReport: TButton;
    btnPreview: TButton;
    btnDesignReport: TButton;
    btnNewReport: TButton;
    btnProperties: TButton;
    Label2: TLabel;
    btnPrint: TButton;
    btnFile: TButton;
    ActionList1: TActionList;
    acnNew: TAction;
    acnClose: TAction;
    acnEdit: TAction;
    acnDesign: TAction;
    acnPreview: TAction;
    acnPrint: TAction;
    acnPDF: TAction;
    acnRemove: TAction;
    acnChgLanguage: TAction;
    pmnuReport: TPopupMenu;
    Copy1: TMenuItem;
    New1: TMenuItem;
    Edit1: TMenuItem;
    N1: TMenuItem;
    PreView1: TMenuItem;
    Print1: TMenuItem;
    PDF1: TMenuItem;
    Remove1: TMenuItem;
    acnCopy: TAction;
    acnRefresh: TAction;
    acnRefresh1: TMenuItem;
    acnNewDocType: TAction;
    frxReport1: TfrxReport;
    grbDatabase: TGroupBox;
    btnChangeDB: TButton;
    rbWSWoodsupport: TRadioButton;
    rbCMFaster: TRadioButton;
    rbCM: TRadioButton;
    acnChangeDatabase: TAction;
    acnCopyTables: TAction;
    CopyDBTables1: TMenuItem;
    acnTranslations: TAction;
    ranslations1: TMenuItem;
    lblDBStatus: TLabel;
    grpTranslation: TGroupBox;
    btnTranslation: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ReportTreeClick(Sender: TObject);
    procedure ReportTreeHint(Sender: TObject; const Node: TTreeNode;
      var Hint: string);
    procedure acnCloseExecute(Sender: TObject);
    procedure acnRemoveExecute(Sender: TObject);
    procedure acnPDFExecute(Sender: TObject);
    procedure acnPrintExecute(Sender: TObject);
    procedure acnPreviewExecute(Sender: TObject);
    procedure acnDesignExecute(Sender: TObject);
    procedure acnEditExecute(Sender: TObject);
    procedure acnNewExecute(Sender: TObject);
    procedure acnCopyExecute(Sender: TObject);
    procedure acnRefreshExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure acnDBSelectExecute(Sender: TObject);
    procedure acnChangeDatabaseExecute(Sender: TObject);
    procedure acnCopyTablesExecute(Sender: TObject);
    procedure btnTranslationsClick(Sender: TObject);

  private
    { Private declarations }
    TreeView1HintText: UnicodeString;
    TheHint: string;

    FReportPath: string;
    FfrxDataSet: TfrxDBDataset;
    FfdStoredProc: TFDStoredProc;
    FReportController: TCMReportController;

    FspList: TList<TFDStoredProc>;
    FfrxDSList: TList<TfrxDBDataset>;
    FReportData: TCMMReportData;
    FReportsData: TCMMReportsData;
    FSReportData: TCMSReportData;
    FParams: TCMParams;
    FErrors: TStringList;
    FValidKeyCombo: Boolean; //Used for detecting key sequences
    DefReportTreeWndProc: TWndMethod;

    procedure ReportTreeWndProc(var Message: TMessage);
    function TreeItemSearch(TV: TTreeView; SearchItem: string): TTreeNode;

    procedure BuildTree;
    procedure updateTree;
    procedure getParameters(aReportData: TCMMReportData);
    function prepareForOutput: integer;
    function validateReportData(aReportData: TCMMReportData;
      errors: TStringList): boolean;
    procedure setCaption;
    procedure setUpDBSelect;

  public
    { Public declarations }
    Property report: TCMMReportData read FReportData write FReportData;
    Property frxDataset: TfrxDBDataset read FfrxDataSet write FfrxDataSet;
    Property fdStoredProc: TFDStoredProc read FfdStoredProc write FfdStoredProc;
    Property frxDSList: TList<TfrxDBDataset> read FfrxDSList write FfrxDSList;
    Property spList: TList<TFDStoredProc> read FspList write FspList;
    Property reportController: TCMReportController read FReportController;
  end;

var
  frmMain: TfrmMain;

implementation

uses udmFR, ufrmAddParams, ufrmReportSettings, printers, CommCtrl
  , ufrmCheckOrderNo
  , uWS_Utils
  , ufrmCopyTables, ufrmTranslations
  , dmsDataConn
  ;
{$R *.dfm}

const
  TTS_ALWAYSTIP = $01;
  TTS_NOPREFIX = $02;
  { For IE >= 0x0500 }
  TTS_NOANIMATE = $10;
  TTS_NOFADE = $20;
  TTS_BALLOON = $40;
  TTS_CLOSE = $80;
  { For Windows >= Vista }
  TTS_USEVISUALSTYLE = $100; // Use themed hyperlinks

  TTF_IDISHWND = $0001;
  TTF_CENTERTIP = $0002;
  TTF_RTLREADING = $0004;
  TTF_SUBCLASS = $0010;
  TTF_TRACK = $0020;
  TTF_ABSOLUTE = $0080;
  TTF_TRANSPARENT = $0100;
  TTF_PARSELINKS = $1000; // For IE >= 0x0501
  TTF_DI_SETITEM = $8000; // valid only on the TTN_NEEDTEXT callback

  TTDT_AUTOMATIC = 0;
  TTDT_RESHOW = 1;
  TTDT_AUTOPOP = 2;
  TTDT_INITIAL = 3;

  // ToolTip Icons (Set with TTM_SETTITLE)
  TTI_NONE = 0;
  TTI_INFO = 1;
  TTI_WARNING = 2;
  TTI_ERROR = 3;
  { For Windows >= Vista }
  TTI_INFO_LARGE = 4;
  TTI_WARNING_LARGE = 5;
  TTI_ERROR_LARGE = 6;

  // Tool Tip Messages
  TTM_ACTIVATE = WM_USER + 1;
  TTM_SETDELAYTIME = WM_USER + 3;
  TTM_ADDTOOLA = WM_USER + 4;
  TTM_DELTOOLA = WM_USER + 5;
  TTM_NEWTOOLRECTA = WM_USER + 6;
  TTM_GETTOOLINFOA = WM_USER + 8;
  TTM_SETTOOLINFOA = WM_USER + 9;
  TTM_HITTESTA = WM_USER + 10;
  TTM_GETTEXTA = WM_USER + 11;
  TTM_UPDATETIPTEXTA = WM_USER + 12;
  TTM_ENUMTOOLSA = WM_USER + 14;
  TTM_GETCURRENTTOOLA = WM_USER + 15;
  TTM_ADDTOOLW = WM_USER + 50;
  TTM_DELTOOLW = WM_USER + 51;
  TTM_NEWTOOLRECTW = WM_USER + 52;
  TTM_GETTOOLINFOW = WM_USER + 53;
  TTM_SETTOOLINFOW = WM_USER + 54;
  TTM_HITTESTW = WM_USER + 55;
  TTM_GETTEXTW = WM_USER + 56;
  TTM_UPDATETIPTEXTW = WM_USER + 57;
  TTM_ENUMTOOLSW = WM_USER + 58;
  TTM_GETCURRENTTOOLW = WM_USER + 59;
  TTM_WINDOWFROMPOINT = WM_USER + 16;
  TTM_TRACKACTIVATE = WM_USER + 17;
  TTM_TRACKPOSITION = WM_USER + 18;
  TTM_SETTIPBKCOLOR = WM_USER + 19;
  TTM_SETTIPTEXTCOLOR = WM_USER + 20;
  TTM_GETDELAYTIME = WM_USER + 21;
  TTM_GETTIPBKCOLOR = WM_USER + 22;
  TTM_GETTIPTEXTCOLOR = WM_USER + 23;
  TTM_SETMAXTIPWIDTH = WM_USER + 24;
  TTM_GETMAXTIPWIDTH = WM_USER + 25;
  TTM_SETMARGIN = WM_USER + 26;
  TTM_GETMARGIN = WM_USER + 27;
  TTM_POP = WM_USER + 28;
  TTM_UPDATE = WM_USER + 29;
  { For IE >= 0X0500 }
  TTM_GETBUBBLESIZE = WM_USER + 30;
  TTM_ADJUSTRECT = WM_USER + 31;
  TTM_SETTITLEA = WM_USER + 32;
  TTM_SETTITLEW = WM_USER + 33;
  { For Windows >= XP }
  TTM_POPUP = WM_USER + 34;
  TTM_GETTITLE = WM_USER + 35;

  TTM_ADDTOOL = {$IFDEF UNICODE}TTM_ADDTOOLW{$ELSE}TTM_ADDTOOLA{$ENDIF};
  TTM_DELTOOL = {$IFDEF UNICODE}TTM_DELTOOLW{$ELSE}TTM_DELTOOLA{$ENDIF};
  TTM_NEWTOOLRECT =
{$IFDEF UNICODE}TTM_NEWTOOLRECTW{$ELSE}TTM_NEWTOOLRECTA{$ENDIF};
  TTM_GETTOOLINFO =
{$IFDEF UNICODE}TTM_GETTOOLINFOW{$ELSE}TTM_GETTOOLINFOA{$ENDIF};
  TTM_SETTOOLINFO =
{$IFDEF UNICODE}TTM_SETTOOLINFOW{$ELSE}TTM_SETTOOLINFOA{$ENDIF};
  TTM_HITTEST = {$IFDEF UNICODE}TTM_HITTESTW{$ELSE}TTM_HITTESTA{$ENDIF};
  TTM_GETTEXT = {$IFDEF UNICODE}TTM_GETTEXTW{$ELSE}TTM_GETTEXTA{$ENDIF};
  TTM_UPDATETIPTEXT =
{$IFDEF UNICODE}TTM_UPDATETIPTEXTW{$ELSE}TTM_UPDATETIPTEXTA{$ENDIF};
  TTM_ENUMTOOLS = {$IFDEF UNICODE}TTM_ENUMTOOLSW{$ELSE}TTM_ENUMTOOLSA{$ENDIF};
  TTM_GETCURRENTTOOL =
{$IFDEF UNICODE}TTM_GETCURRENTTOOLW{$ELSE}TTM_GETCURRENTTOOLA{$ENDIF};
  { For IE >= 0X0500 }
  TTM_SETTITLE = TTM_SETTITLEW;
  { For Windows >= XP }
  // TTM_SETWINDOWTHEME = CCM_SETWINDOWTHEME;
  TTM_RELAYEVENT = WM_USER + 7;
  TTM_GETTOOLCOUNT = WM_USER + 13;

  TTN_FIRST = 0 - 520;
  TTN_LAST = 0 - 549;

  TTN_NEEDTEXTA = TTN_FIRST - 0;
  TTN_NEEDTEXTW = TTN_FIRST - 10;
  TTN_NEEDTEXT = {$IFDEF UNICODE}TTN_NEEDTEXTW{$ELSE}TTN_NEEDTEXTA{$ENDIF};
  TTN_SHOW = TTN_FIRST - 1;
  TTN_POP = TTN_FIRST - 2;
  TTN_LINKCLICK = TTN_FIRST - 3;

procedure TfrmMain.ReportTreeWndProc(var Message: TMessage);
var
  MaxWidth: integer;
begin
  if Message.Msg = WM_NOTIFY then
  begin
    with TWMNotify(Message).Nmhdr^ do
    begin
      if code = TTN_NEEDTEXTW then
      begin
        MaxWidth := SendMessage(hwndFrom, TTM_GETMAXTIPWIDTH, 0, 0);
        if MaxWidth = -1 then
          SendMessage(hwndFrom, TTM_SETMAXTIPWIDTH, 400, 0);
      end;
    end;
  end;
{
var
  Pt: TPoint;
  Node: TTreeNode;
  LItemRect: TRect;
  LMaxWidth,i: Integer;
  s: string;
begin
  if Message.Msg = WM_NOTIFY then
  begin
    with TWMNotify(Message) do
    begin
      if NMHdr^.code = TTN_NEEDTEXTW then
      begin
        if (PToolTipTextW(NMHdr)^.uFlags and TTF_IDISHWND) <> 0 then
        begin
          GetCursorPos(Pt);
          Pt := ReportTree.ScreenToClient(Pt);
          Node := ReportTree.GetNodeAt(Pt.X, Pt.Y);
          if Node <> nil then
          begin
            TreeView1HintText := theHint;
            if TreeView1HintText <> '' then begin

            with PToolTipTextW(NMHdr)^ do
            begin
              lpszText := PWideChar(TreeView1HintText);
              i := SizeOf(szText);
              s := szText;
              ZeroMemory(lpszText, SizeOf(szText));
              hInst := 0;
            end;

            LItemRect := Node.DisplayRect(True);
            if LItemRect.Left < 0 then
              LItemRect.Left := 0;
            LItemRect.TopLeft := ReportTree.ClientToScreen(LItemRect.TopLeft);

            LMaxWidth := SendMessage(Nmhdr^.hwndFrom, TTM_GETMAXTIPWIDTH, 0, 0);
            if LMaxWidth = -1 then
            begin
              LMaxWidth := 400; // use whatever you need...
              SendMessage(Nmhdr^.hwndFrom, TTM_SETMAXTIPWIDTH, LMaxWidth, 0);
            end;

            SendMessage(Nmhdr^.hwndFrom, TTM_ADJUSTRECT, WPARAM(True), LPARAM(@LItemRect));
            SetWindowPos(Nmhdr^.hwndFrom, HWND_TOP, LItemRect.Left, LItemRect.Top, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOOWNERZORDER);

            Message.Result := 1;
            end;
          end;
        end;
      end;

      Exit;
    end;
  end;
}

  DefReportTreeWndProc(Message);
end;


procedure TfrmMain.setCaption;
begin
  Caption := 'FastReport' + '  Server: ' + dmFR.DBConnection.Params.Values['Server']+' TemplatePath: '+ FReportPath;
end;

procedure TfrmMain.setUpDBSelect;
var
  server: string;
begin
(*
    server := dmFR.DBConnection.Params.Values['Server'];
    if server = 'AML-NET-RDS-011\WOODSUPPORT' then begin
      grbDatabase.Tag := rbWSWoodSupport.Tag;
      rbWSWoodSupport.Checked := true
    end
    else if UpperCase(server) = getDBServerName then begin
      grbDatabase.Tag := rbCMFaster.Tag;
      rbCMFaster.Checked := true
    end
    else if UpperCase(server) = getDBServerName then begin
      grbDatabase.Tag := rbCM.Tag;
      rbCM.Checked := true
    end
    else begin
      ShowMessage('DB-Connection not setup ERROR!!');
    end;

*)end;

procedure TfrmMain.updateTree ;
var
  Node: TTreeNode;
  subItem: TTreeNode;
  qry: TFDQuery;
  sp_name: string;
  DsU_name: string;
  RepNo: integer;
  errMsg: String;
  Descr: string;
  Template: string;
  docType, LastDocType: integer;
  subItmIndx: integer;
  Reportsdata: TCMMReportsdata;
  Reportdata: TCMMReportData;
  docTypeName: string;

begin
  ReportTree.Items.Clear;
  Node := ReportTree.Items.Add(nil, 'Available Reports...');
  Node.ImageIndex := 0;
  try
    dmFR.RefreshDocType;
    reportsData := FReportsData;
    ReportTree.Selected := Node; // Make the first node the root of the tree
    LastDocType := -1; // To identify First record in the loop
    for Reportdata in Reportsdata do
    begin

      docType := Reportdata.docType;
      docTypeName := dmFR.getDocTypeName(docType);
      Template := Reportdata.Template;
      if LastDocType <> docType then
      begin
        Node := TreeItemSearch(ReportTree,docTypeName);
        if not assigned(Node) then
          Node := ReportTree.Items.AddChildObject(ReportTree.Selected,
                  docTypeName, nil);
      // intToStr(docType), nil);
        LastDocType := docType;
      end;
      subItem := ReportTree.Items.AddChildObject(Node, Template, Reportdata);

      FErrors.Clear;
      if validateReportData(Reportdata, FErrors) then
      begin
        subItmIndx := 2;
      end else
      subItmIndx := 1;
      subItem.ImageIndex := subItmIndx;
      subItem.SelectedIndex := subItmIndx;
    end;
    ReportTree.items[0].expand(false);
  finally
    FReportsData := ReportsData;
  end;
end;

procedure TfrmMain.acnChangeDatabaseExecute(Sender: TObject);
var
  server: string;
  iTag: integer;
  SaveCursor: TCursor;
begin
  server := '';
  iTag := 0;
  SaveCursor := Screen.Cursor;
  try
    Screen.Cursor := crSQLWait;
    if rbWSWoodsupport.Checked then begin
      iTag := rbWSWoodsupport.Tag;
      server := dmsConnector.localServer;
    end
    else if rbCMFaster.Checked then begin
      iTag := rbCMFaster.Tag;
//      server := getDBServerName;
    end
    else if rbCM.Checked then begin
      iTag := rbCM.Tag;
//      server := getDBServerName;;
    end;

    if dmFR.ReconnectDB(server) then begin
      lblDBStatus.Caption := '';
      grbDatabase.Tag := iTag;
      setCaption;
      BuildTree;
    end
    else
      ShowMessage('Kunde inte koppla upp mot vald databas!');
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TfrmMain.acnCloseExecute(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.acnCopyExecute(Sender: TObject);
var
  reportCopy, org: TCMMReportData;
  srcopy, srOrg: TCMSReportData;
  node: TTreeNode;
  nodeIndex: integer;
  index: integer;
begin
  try
    Node := ReportTree.Selected;
    NodeIndex := Node.Index;
    org := Node.Data;
    index := FReportsData.IndexOf(org);
    reportCopy := FReportController.CreateReport('COPY' + org.Template,
      intToStr(org.docType), org.storedProcName, org.datasetUserName,
      org.description);
    if reportCopy <> nil then
    begin
      srOrg := nil;
      srCopy := nil;
      if org.subReportsData <> nil then
        for srOrg in org.subReportsData do
        begin
          srcopy := FReportController.CreateSubReport(reportCopy.ReportNo,
            srOrg.name, srOrg.storedProcName, srOrg.datasetUserName);
          if srcopy <> nil then
          begin
            if reportCopy.subReportsData = nil then
              reportCopy.subReportsData := TCMSReportsData.create;
            reportCopy.subReportsData.Add(srcopy);
          end;
        end;
      if dmFR.addReport(reportCopy.ReportNo, reportCopy) then
      begin
        FReportsData.Insert(index,reportCopy);
        UpdateTree;
        ReportTree.Refresh;
        Node := TreeItemSearch(ReportTree, dmFR.getDocTypeName(org.docType));
        Node.Selected := true;
        Node.Expanded := true;
//        ReportTree.Selected := ReportTree.Items.Item[index];
      end;
    end;
//    CopyFile(PChar(dmFR.getTemplatePath+org.Template), PChar(dmFR.getTemplatePath+reportCopy.Template), true);
  finally
  end;
end;

procedure TfrmMain.acnCopyTablesExecute(Sender: TObject);
begin
  frmCopyTables.ShowModal;
end;

procedure TfrmMain.acnDBSelectExecute(Sender: TObject);
var
  server: string;
begin
  lblDBStatus.Font.Color := clWindowText;
  lblDBStatus.Caption := '';
  btnChangeDB.Enabled := false;
  if TRadioButton(Sender).Tag <> grbDatabase.Tag then begin
    if computerName = 'JME-SSD' then
     server := 'JME-SSD\SQLEXPRESS01'

    else if TRadioButton(Sender).Tag = 1 then begin
     server := dmsConnector.localServer;
      // server := 'carmak-speed\sqlexpress'
    end
    else if TRadioButton(Sender).Tag = 2 then begin
      server := 'AML-NET-RDS-011\WOODSUPPORT'
    end
    else if TRadioButton(Sender).Tag = 3 then begin
      server := 'AML-NET-RDS-011\WOODSUPPORT'
    end;
    if dmFR.CheckServer(server) then begin
      lblDBStatus.Caption := AnsiUpperCase(server) +
        ' vald och OK - Tryck p� "RECONNECT" f�r att byta databas.';
      btnChangeDB.Enabled := true;
    end
    else begin
      lblDBStatus.Font.Color := clRed;
      lblDBStatus.Caption := AnsiUpperCase(server) + ' Kan ej anv�ndas f�r n�rvarande';
    end;
  end;
end;

procedure TfrmMain.acnDesignExecute(Sender: TObject);
var
  report: TCMMReportData;
  Node: TTreeNode;
  templateFile: string;
begin
  report := ReportTree.Selected.Data;
  if report <> nil then begin
    reportController.DesignReport(prepareForOutput, FParams);
  end
  else begin
    // Create new template without any report connected
    if MessageDlg
      ('You are going to create a new template without any specified report',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      frxReport1.DataSet := nil;
      frxReport1.DesignReport;
    end;
  end;
end;

procedure TfrmMain.acnEditExecute(Sender: TObject);
var
  Node: TTreeNode;
  subItem: TTreeNode;
begin
  if not Assigned(FReportData) then
  begin
    MessageDlg('Please select a report!' , mtInformation, [mbOK], 0);
    exit;
  end;

  FReportData := frmReportSettings.execute(reportController, FReportData);
  if FReportData <> nil then
  begin
    if dmFR.upDateReport(FReportData.ReportNo, FReportData) then
    begin
      UpdateTree;
      ReportTree.Refresh;
      Node := TreeItemSearch(ReportTree, dmFR.getDocTypeName(FReportData.docType));
      Node.Selected := true;
      Node.Expanded := true;
    end;
  end;
end;

procedure TfrmMain.acnNewExecute(Sender: TObject);
var
  Node: TTreeNode;
  subItem: TTreeNode;
begin
  FReportData := frmReportSettings.execute(reportController);
  if FReportData <> nil then
  begin
    if dmFR.addReport(FReportData.ReportNo, FReportData) then
    begin
      FReportsData.Add(FReportData);
      UpdateTree;
      ReportTree.Refresh;
      Node := TreeItemSearch(ReportTree, dmFR.getDocTypeName(FReportData.docType));
      Node.Selected := true;
      Node.Expanded := true;
    end;
  end;
end;

procedure TfrmMain.acnPDFExecute(Sender: TObject);
begin
  reportController.setExportFile('PDFReport.PDF');
  reportController.RunReport(prepareForOutput, FParams, frFile, 0);
end;

procedure TfrmMain.acnPreviewExecute(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frPreview, 0);
end;

procedure TfrmMain.acnPrintExecute(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frPrint, 0);
end;

procedure TfrmMain.acnRefreshExecute(Sender: TObject);
begin
  BuildTree;
end;

procedure TfrmMain.acnRemoveExecute(Sender: TObject);
var
  report: TCMMReportData;
  Node: TTreeNode;
  templateFile: string;
begin
  report := ReportTree.Selected.Data;
  if report <> nil then
  begin
    if MessageDlg('You are going to remove the report: '  + report.Template,
      mtWarning, [mbOK, mbCancel], 0) = mrOK then
    begin
      if reportController.DeleteReport(report.ReportNo) then
        ReportTree.Selected.Delete;
      ReportTree.Refresh;
    end;
  end;
end;

procedure TfrmMain.btnTranslationsClick(Sender: TObject);
begin
  if frmTranslations = nil then
    frmTranslations := TfrmTranslations.createWithDBConnection(self, dmsConnector.ADConnection1);
  if frmTranslations <> nil then begin
    frmTranslations.ShowModal;
    freeAndNil(frmTranslations);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Make treeview enable multiple lined hint
  DefReportTreeWndProc := ReportTree.WindowProc;
  ReportTree.WindowProc := ReportTreeWndProc;

  // Initialization
  Memo1.Clear;
  FReportData := nil;
  FReportsData := nil;
  FErrors := TStringList.create;
  dmFR.SetUpConnection(dmsConnector.ADConnection1);
  try
    FReportController := TCMReportController.create;
    FReportPath := FReportController.TemplatePath;
    BuildTree;
  finally
    setUpDBSelect;
    setCaption;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    If (GetKeyState(Ord('L'))<0) and (GetKeyState(Ord('G'))<0) and (GetKeyState(VK_CONTROL)<0) then begin
      // FReportController.SetTemplatePath('D:\git\delphi\FastReportProject\fr3\');
      FReportController.SetTemplatePath('C:\Program Files (x86)\WS\FReports\');

      FReportPath := FReportController.TemplatePath;
      setCaption
    end;
    If (GetKeyState(Ord('L'))<0) and (GetKeyState(Ord('A'))<0) and (GetKeyState(VK_CONTROL)<0) then begin
      FReportController.RestoreTemplatePath;
      FReportPath := FReportController.TemplatePath;
      setCaption;
    end;
    If (GetKeyState(Ord('K'))<0) and (GetKeyState(Ord('L'))<0) and (GetKeyState(VK_CONTROL)<0) then begin
      frmCheckOrderNo := TfrmCheckOrderNo.Create(nil);
      frmCheckOrderNo.Show;
    end;
end;



procedure TfrmMain.getParameters(aReportData: TCMMReportData);
begin
  FParams := frmAddParams.execute(aReportData);
end;

function TfrmMain.prepareForOutput: integer;
var
  Node: TTreeNode;
  RepNo: integer;
begin
  Node := ReportTree.Selected;
  if (Node.Data <> nil) then
  begin
    report := Node.Data;
    RepNo := report.ReportNo;
    if RepNo > 0 then
    begin
      getParameters(report);
      if Assigned(FParams) then
        Result := RepNo
      else
        Result := -1;
      { FParams := TCMParams.create;
        FParams.Add('@INVOICENO', 29366); }
    end;
  end;
end;

procedure TfrmMain.ReportTreeClick(Sender: TObject);
var
  Node: TTreeNode;
  Descr: string;
begin
  Node := ReportTree.Selected;
  if (Node.Data <> nil) then
  begin
    report := Node.Data;
    Memo1.Clear;
    Descr := TCMMReportData(Node.Data).description;
    if Descr <> '' then
      Memo1.Lines.Add(Descr);
  end;
end;

procedure TfrmMain.ReportTreeHint(Sender: TObject; const Node: TTreeNode;
  var Hint: string);
var
  rd: TCMMReportData;
  errMsg: string;
  params: TCMParamsInfo;
  param: TCMParamInfo;
begin
  Hint := '';
  rd := TCMMReportData(Node.Data);
  if Assigned(rd) then
  begin
    Hint := 'ReportNo: ' + intToStr(rd.ReportNo);
    FErrors.Clear;
    validateReportData(rd, FErrors);
    for errMsg in FErrors do
      Hint := Hint + sLineBreak + errMsg;

    Hint := Hint + sLineBreak + 'DocType: ' + intToStr(rd.docType);
    params := rd.getAllParameters;
//    Hint := Hint + sLineBreak + 'Parameters:';
    for param in Params do
      Hint := Hint + sLineBreak + param.Key+': '+param.Value;
    TheHint := Hint;

  end;
end;

function TfrmMain.validateReportData(aReportData: TCMMReportData;
  errors: TStringList): boolean;
begin
  if aReportData.datasetUserName = '' then
    errors.AddObject('Dataset is missing' , TErrorCode.create(1));
  if aReportData.storedProcName = '' then
    errors.AddObject('Stored procedure is missing' , TErrorCode.create(2));
  Result := (errors.Count > 0);
end;

procedure TfrmMain.BuildTree;
var
  Node: TTreeNode;
  subItem: TTreeNode;
  qry: TFDQuery;
  sp_name: string;
  DsU_name: string;
  RepNo: integer;
  errMsg: String;
  Descr: string;
  Template: string;
  docType, LastDocType: integer;
  subItmIndx: integer;
  Reportsdata: TCMMReportsdata;
  Reportdata: TCMMReportData;
  docTypeName: string;

begin
  ReportTree.Items.Clear;
  Node := ReportTree.Items.Add(nil, 'Available Reports...');
  Node.ImageIndex := 0;
  try
    dmFR.RefreshDocType;
    dmFR.qryFastReports.Active;
    FReportsdata := reportController.AllReports;
    updateTree;
    ReportTree.items[0].expand(false);
  finally
    dmFR.qryFastReports.close;
  end;
end;

function TfrmMain.TreeItemSearch(TV: TTreeView; SearchItem: string): TTreeNode;
var
  i: Integer;
  iItem: string;
begin
  if (TV = nil) or (SearchItem = '') then Exit;
  for i := 0 to TV.Items.Count - 1 do
  begin
    iItem := TV.Items[i].Text;
    if SearchItem = iItem then
    begin
      Result := TV.Items[i];
      Exit;
    end
    else
    begin
      Result := nil;
    end;
  end;
end;



constructor TErrorCode.create(aErrorCode: integer);
begin
  FErrorCode := aErrorCode;
end;

end.
