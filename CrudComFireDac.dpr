program CrudComFireDac;

uses
  Vcl.Forms,
  uFrmConsulta in 'uFrmConsulta.pas' {Form1},
  uLembrete in 'Model\uLembrete.pas' {Form3},
  uBaseDAO in 'DAO\uBaseDAO.pas',
  uDM in 'uDM.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
