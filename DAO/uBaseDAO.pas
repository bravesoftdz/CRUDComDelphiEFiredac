unit uBaseDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, uDM, Data.DB, Vcl.Dialogs,
  System.Classes, System.Generics.Collections;

  type
    TBaseDAO = Class(TObject)
    private

    protected

    //Respons�vel por executar todas as manipula��es de aceso ao banco de dados;
    FQry: TFDQuery;
    constructor Create;
    destructor Destroy; override;
    function RetornarDataSet(pSQL: string): TFDQuery;
    function ExecutarComando(pSQL: string): integer;

    end;

implementation

{ TBaseDAO }

constructor TBaseDAO.Create;
begin
  inherited Create;
  FQry := TFDQuery.Create(nil);
  FQry.Connection := DM.FDConnection;
end;

destructor TBaseDAO.Destroy;
begin
  try
    //Se estiver instanciado destroi a vari�vel;
    if Assigned(FQry) then
       FreeAndNil(FQry);
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

function TBaseDAO.ExecutarComando(pSQL: string): integer;
begin
  try
    DM.FDConnection.StartTransaction;
    FQry.SQL.Text := pSQL;
    FQry.ExecSQL;
    Result := FQry.RowsAffected;
    DM.FDConnection.Commit;
  except
    DM.FDConnection.Rollback;
  end;
end;

function TBaseDAO.RetornarDataSet(pSQL: string): TFDQuery;
begin
  FQry.SQL.Text := pSQL;
  FQry.Active   := True;
  Result        := FQry;
end;

end.
