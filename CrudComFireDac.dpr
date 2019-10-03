program CrudComFireDac;

uses
  Vcl.Forms,
  uFrmConsulta in 'uFrmConsulta.pas' {FrmConsulta},
  uBaseDAO in 'DAO\uBaseDAO.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uLembreteDAO in 'DAO\uLembreteDAO.pas',
  uLembrete in 'Model\uLembrete.pas',
  uFrmInserir in 'uFrmInserir.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmConsulta, FrmConsulta);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
