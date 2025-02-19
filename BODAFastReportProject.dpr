program BODAFastReportProject;

uses
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uReport in '..\CMCommonSources\FastReport\uReport.pas',
  uReportController in '..\CMCommonSources\FastReport\uReportController.pas',
  udmFR in '..\CMCommonSources\FastReport\udmFR.pas' {dmFR: TDataModule},
  udmFRSystem in '..\CMCommonSources\FastReport\udmFRSystem.pas' {dmFRSystem: TDataModule},
  uFR_Log in '..\CMCommonSources\FastReport\uFR_Log.pas',
  uFRAccessories in '..\CMCommonSources\FastReport\uFRAccessories.pas',
  uFRConstants in '..\CMCommonSources\FastReport\uFRConstants.pas',
  uIdmFR in '..\CMCommonSources\FastReport\uIdmFR.pas',
  uIInterfacesFastReports in '..\CMCommonSources\FastReport\uIInterfacesFastReports.pas',
  uTwoReportInOne in '..\CMCommonSources\FastReport\uTwoReportInOne.pas',
  ufrmAddParams in 'ufrmAddParams.pas' {frmAddParams},
  ufrmCheckOrderNo in 'ufrmCheckOrderNo.pas' {frmCheckOrderNo},
  ufrmCopyTables in 'ufrmCopyTables.pas' {frmCopyTables},
  ufrmTranslations in 'ufrmTranslations.pas' {frmTranslations},
  uWS_UTILS in '..\CMCommonSources\uWS_UTILS.pas',
  VISConst in '..\CMCommonUnits\VISConst.pas',
  uVIS_UTILS in '..\CMCommonSources\uVIS_UTILS.pas',
  ufrmSubReportSettings in 'ufrmSubReportSettings.pas' {frmSubReportSettings},
  ufrmDocType in 'ufrmDocType.pas' {frmDocType},
  uUtilsInterfaces in 'uUtilsInterfaces.pas',
  ISendMailInterfaces in '..\CMCommonSources\sendMail\ISendMailInterfaces.pas',
  uCommonInterfaces in '..\CMCommonSources\uCommonInterfaces.pas',
  VidaType in '..\CMCommonUnits\VidaType.pas',
  uSQLServerName in '..\CMCommonUnits\uSQLServerName.pas',
  dmsDataConn in '..\CMCommonUnits\dmsDataConn.pas' {dmsConnector: TDataModule},
  ufrmReportSettings in 'ufrmReportSettings.pas' {frmReportSettings},
  uInitSynlog in '..\CMCommonUnits\uInitSynlog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmsConnector, dmsConnector);
  Application.CreateForm(TdmFR, dmFR);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSubReportSettings, frmSubReportSettings);
  Application.CreateForm(TfrmReportSettings, frmReportSettings);
  Application.CreateForm(TfrmAddParams, frmAddParams);
  Application.Run;
end.
