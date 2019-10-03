unit uLembreteDAO;

interface

uses
  uLembrete, classes, DB, SysUtils, generics.defaults,
  generics.collections, Dialogs, uDM, uBaseDAO, FireDAC.Comp.Client;

type
  TLembreteDAO = class(TBaseDAO)
  private
    FListaLembrete: TObjectList<TLembrete>;
    procedure PreencherColecao(DS: TFDQuery);
  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(pLembrete: TLembrete): boolean;
    function Deletar(pLembrete: TLembrete): boolean;
    function Alterar(pLembrete: TLembrete): boolean;
    function ListarPorTitulo_Descricao(pConteudo: string): TObjectList<TLembrete>;
  end;

implementation

{ TLembreteDAO }

constructor TLembreteDAO.Create;
begin
  inherited;
  FListaLembrete := TObjectList<TLembrete>.Create;
end;

destructor TLembreteDAO.Destroy;
begin
  try
    inherited;
    if Assigned(FListaLembrete) then
       FreeAndNil(FListaLembrete);
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

function TLembreteDAO.Inserir(pLembrete: TLembrete): boolean;
var
  sql: string;
begin
  sql := ' INSERT INTO LEMBRETE(TITULO, DESCRICAO, DATAHORA)' +
         ' VALUES( ' +
                     QuotedStr(pLembrete.Titulo)    + ',' +
                     QuotedStr(pLembrete.Descricao) + ',' +
                     QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm', pLembrete.DataHora)) +
                 ')';
  result := ExecutarCOmando(sql) > 0;
end;

function TLembreteDAO.Alterar(pLembrete: TLembrete): boolean;
var
  sql: string;
begin
  sql := ' UPDATE LEMBRETE     ' +
         ' SET TITULO       = ' + QuotedStr(pLembrete.Titulo)    + ',' +
         '     DESCRICAO    = ' + QuotedStr(pLembrete.Descricao) + ',' +
         '     DATAHORA     = ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm', pLembrete.DataHora)) +
         ' WHERE IDLEMBRETE = ' + IntToStr(pLembrete.IDLembrete);
end;

function TLembreteDAO.Deletar(pLembrete: TLembrete): boolean;
var
  sql: string;
begin
  sql := ' DELETE                   ' +
         ' FROM LEMBRETE            ' +
         ' WHERE IDLEMBRETE = ' + IntToStr(pLembrete.IDLembrete);
  result := ExecutarComando(sql) > 0;
end;

function TLembreteDAO.ListarPorTitulo_Descricao(pConteudo: string): TObjectList<TLembrete>;
var
  sql: string;
begin
  result := nil;
  sql := ' SELECT C.IDLEMBRETE, C.TITULO                   ' +
         ' C.DESCRICAO, C.DATAHORA                         ' +
         ' FROM LEMBRETE C                                 ' ;
  if pConteudo = '' then
  begin
    sql := sql + ' WHERE C.DataHora >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd', Now));
  end
  else
  begin
    sql := sql + '  WHERE C.TITULO LIKE ' + QuotedStr('%'+pConteudo+'%')+
                 '  OR C.DESCRICAO LIKE ' + QuotedStr('%'+pConteudo+'%');
  end;

  sql := sql + '  ORDER BY C.DATAHORA    ';
  FQry := RetornarDataSet(sql);

  if not(FQry.IsEmpty) then
  begin
    PreencherColecao(Fqry);
    result := FListaLembrete;
  end;
end;

procedure TLembreteDAO.PreencherColecao(DS: TFDQuery);
var
  I: Integer;
begin
  I := 0;
  FListaLembrete.Clear;
  while not Ds.eof do
  begin
    FListaLembrete.Add(TLembrete.Create);
    FListaLembrete[I].IDLembrete := Ds.FieldByName('IDLembrete').AsInteger;
    FListaLembrete[I].Titulo     := Ds.FieldByName('Titulo'    ).AsString;
    FListaLembrete[I].Descricao  := Ds.FieldByName('Descricao' ).AsString;
    FListaLembrete[I].DataHora   := Ds.FieldByName('DataHora'  ).AsDateTime;
    Ds.Next;
    I := I + 1;
  end;
end;

end.
