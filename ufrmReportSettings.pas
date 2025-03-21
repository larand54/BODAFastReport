unit ufrmReportSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  uReport, uReportController, ufrmSubReportSettings, siComp, siLngLnk,
  Vcl.DBCtrls, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  ufrmDocType;

type
  TfrmReportSettings = class(TForm)
    lblTemplate_Name: TLabel;
    lblDocType: TLabel;
    lblSP_Name: TLabel;
    lblDS_Name: TLabel;
    edTemplate: TEdit;
    edDoctype: TEdit;
    edStoredProc: TEdit;
    edDataset: TEdit;
    lbxSubReports: TListBox;
    lblSubreports: TLabel;
    sbtnAddSR: TSpeedButton;
    sbtnRemoveSR: TSpeedButton;
    bbnApply: TBitBtn;
    bbnCancel: TBitBtn;
    edDescription: TEdit;
    lblDescription: TLabel;
    bbnCrtMain: TBitBtn;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    cboDocType: TComboBox;
    sbnAddDocType: TSpeedButton;
    procedure bbnCrtMainClick(Sender: TObject);
    procedure bbnUpdMainClick(Sender: TObject);
    procedure sbtnAddSRClick(Sender: TObject);
    procedure sbtnRemoveSRClick(Sender: TObject);
    procedure lbxSubReportsDblClick(Sender: TObject);
    procedure cboDocTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edStoredProcChange(Sender: TObject);
    procedure sbnAddDocTypeClick(Sender: TObject);
  private
    { Private declarations }
    FRepNo: integer;
    FReportData: TCMMReportData;
    FReportController: TCMReportController;
    procedure FillDocTypeData(aDocType: integer);
    procedure sortComboDT;
  public
    { Public declarations }
    property RepNo: integer read FRepNo;
    function Execute(TCMC: TCMReportController): TCMMReportData; OVERLOAD;
    function Execute(TCMC: TCMReportController; aRepData: TCMMReportData)
      : TCMMReportData; OVERLOAD;
  end;

var
  frmReportSettings: TfrmReportSettings;

implementation

{$R *.dfm}

uses udmFR;

{ TfrmReportSettings }

procedure TfrmReportSettings.bbnCrtMainClick(Sender: TObject);
begin
  if Copy(edStoredProc.Text,0,4) <> 'dbo.' then
    edStoredProc.Text := 'dbo.' + edStoredProc.Text;
  if Pos('.fr3',edTemplate.Text) = 0 then
    edTemplate.Text := edTemplate.Text + '.fr3';

  FreeAndNil(FReportData);
  FReportData := FReportController.CreateReport(edTemplate.Text, edDoctype.Text,
    edStoredProc.Text, edDataset.Text, edDescription.Text);
  if FReportData <> nil then
  begin
    bbnApply.Enabled := true;
    sbtnAddSR.Enabled := true;
    sbtnRemoveSR.Enabled := true;
  end;
end;

function TfrmReportSettings.Execute(TCMC: TCMReportController): TCMMReportData;
var
  srName: string;
  srl: TCMSReportsData;
  i: integer;
begin
  frmReportSettings.Caption := 'Report settings  -- Create New Report';
  bbnCrtMain.Caption :=  'Create Main';
  bbnCrtMain.OnClick := bbnCrtMainClick;
  FReportController := TCMC;
  bbnApply.Enabled := false;
  sbtnAddSR.Enabled := false;
  sbtnRemoveSR.Enabled := false;
  if (ShowModal = mrOK) then
  begin
    Result := FReportData;
    if lbxSubReports.Items.Count > 0 then
    begin
      srl := TCMSReportsData.Create;
      for i := 0 to lbxSubReports.Items.Count - 1 do
      begin
        srl.Add(TCMSReportData(lbxSubReports.Items.Objects[i]));
      end;
      FReportData.subReportsData := srl;
      lbxSubReports.Items.Clear;
    end;
  end
  else
    Result := nil;
end;

procedure TfrmReportSettings.bbnUpdMainClick(Sender: TObject);
var
  RepNo: integer;
begin
  RepNo := FReportData.ReportNo;
  if Copy(edStoredProc.Text,0,4) <> 'dbo.' then
    edStoredProc.Text := 'dbo.' + edStoredProc.Text;
  if Pos('.fr3',edTemplate.Text) = 0 then
    edTemplate.Text := edTemplate.Text + '.fr3';
  FReportController.UpdateReport(FReportData, edTemplate.Text, edDoctype.Text,
    edStoredProc.Text, edDataset.Text, edDescription.Text);
  if FReportData <> nil then
  begin
    bbnApply.Enabled := true;
    sbtnAddSR.Enabled := true;
    sbtnRemoveSR.Enabled := true;
  end;
end;

procedure TfrmReportSettings.cboDocTypeChange(Sender: TObject);
begin
  if cboDocType.ItemIndex = -1 then
    edDocType.Text := ''
  else
    edDoctype.Text := intToStr(integer(cboDocType.items.Objects[cboDocType.ItemIndex]));
end;

procedure TfrmReportSettings.edStoredProcChange(Sender: TObject);
begin
  if edDataset.Text = '' then
    edDataset.Text := 'DS_MAIN';
end;

function TfrmReportSettings.Execute(TCMC: TCMReportController;
  aRepData: TCMMReportData): TCMMReportData;
var
  srName: string;
  srl: TCMSReportsData;
  sr: TCMReportData;
  i: integer;
begin
  try
    FReportData := aRepData;
    bbnApply.Enabled := false;
    bbnCrtMain.Caption := 'Update Main' ;
    bbnCrtMain.OnClick := bbnUpdMainClick;
    frmReportSettings.Caption := 'Report settings  -- Update Report' ;
    FReportController := TCMC;
    frmDocType := TfrmDocType.Create(self);

    // Fill form with data
    FillDocTypeData(FReportData.docType);
    FRepNo := FReportData.ReportNo;
    edTemplate.Text := FReportData.Template;
    edDoctype.Text := intToStr(FReportData.docType);
    edStoredProc.Text := FReportData.storedProcName;
    edDataset.Text := FReportData.datasetUserName;
    edDescription.Text := FReportData.description;

    // Fill listbox with existing subReports
    srl := FReportData.subReportsData;
    if Assigned(srl) then
      for sr in srl do
      begin
        lbxSubReports.Items.AddObject(sr.name, sr);
      end;

    if (ShowModal = mrOK) then

    // Report now updated - add subreports and move on
    begin
      if lbxSubReports.Items.Count > 0 then
      begin
        srl := TCMSReportsData.Create;
        for i := 0 to lbxSubReports.Items.Count - 1 do
        begin
          srl.Add(TCMSReportData(lbxSubReports.Items.Objects[i]));
        end;
      end;
      FReportData.subReportsData.Free;
      FReportData.subReportsData := srl;
      Result := FReportData;
    end
    else
      Result := nil;
  finally
    lbxSubReports.Items.Clear;
  end;
end;

procedure TfrmReportSettings.FillDocTypeData(aDocType: integer);
var
  iDocType: integer;
  sDocType: string;
  docType: TCMDocType;
  sl: TStringList;
  i: integer;
begin
  docType := dmFR.DocType;
  sl := TStringLIst.Create;
  try
  for idocType in docType.keys do begin
    sDocType := docType[iDocType];
    sl.AddObject(sDocType, TObject(iDocType));
  end;
  sl.Sort;
  cboDocType.Clear;
  for i:=0 to sl.Count-1 do
  begin
    sDocType := sl[i];
    iDocType := Integer(sl.Objects[i]);
    cboDocType.Items.AddObject(sDocType, TObject(iDocType));
  end;
  if aDocType >= dmFR.DocType.Count then begin
    showMessage('Felaktig rapporttyp - R�tta till det!');
    aDocType := 0;  // Kontrakt F�r att passera n�sta test s� vi f�r upp dialogen och kan r�tta till felet.
  end;

  if aDocType > 0 then begin
    cboDocType.Text := dmFR.DocType.Items[aDocType];
    edDocType.Text := intToStr(aDocType);
  end;
  finally
    freeAndNil(sl);
  end;
end;

procedure TfrmReportSettings.FormCreate(Sender: TObject);
begin
  FillDocTypeData(-1);
end;

procedure TfrmReportSettings.lbxSubReportsDblClick(Sender: TObject);
var
  ix: integer;
  sr: TCMSReportData;
begin
 if (lbxSubReports.Items.Count > 0) then begin
   ix := lbxSubReports.ItemIndex;
   sr := TCMSReportData(lbxSubReports.Items.Objects[ix]);
   sr := frmSubReportSettings.Execute(FReportController, sr, FReportData.ReportNo);
 end;

end;

procedure TfrmReportSettings.sbnAddDocTypeClick(Sender: TObject);
var
  iDocType: integer;
begin
  iDocType := frmDocType.Execute;
  FillDocTypeData(iDocType);
end;

procedure TfrmReportSettings.sbtnAddSRClick(Sender: TObject);
var
  srd: TCMSReportData;
begin
  srd := frmSubReportSettings.Execute(FReportController, FReportData.ReportNo);
  if (frmSubReportSettings.ModalResult = mrOK) and (srd <> nil) then
    lbxSubReports.Items.AddObject(srd.name, srd);
end;

procedure TfrmReportSettings.sbtnRemoveSRClick(Sender: TObject);
begin
  lbxSubReports.Items.Delete(lbxSubReports.ItemIndex);
end;

procedure TfrmReportSettings.sortComboDT;
begin

end;

end.
