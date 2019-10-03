unit uLembrete;

interface
  uses
    System.SysUtils;

  type
    TLembrete = class
    private
      FTitulo: string;
      FDataHora: TDateTime;
      FDescricao: string;
      FIDLembrete: integer;
      procedure SetDataHora(const Value: TDateTime);
      procedure SetDescricao(const Value: string);
      procedure SetIDLembrete(const Value: integer);
      procedure SetTitulo(const Value: string);

    protected

    public
      constructor Create;
      property IDLembrete: integer read FIDLembrete write SetIDLEmbrete;
      property Titulo: string read FTitulo write SetTitulo;
      property Descricao: string read FDescricao write SetDescricao;
      property DataHora: TDateTime read FDataHora write SetDataHora;
    published

    end;

implementation

{ TLembrete }

constructor TLembrete.Create;
begin
  FIDLembrete := 0;
  FTitulo := '';
  FDescricao := '';
  FDataHora := EncodeDate(1900,1,1);
end;

procedure TLembrete.SetDataHora(const Value: TDateTime);
begin
  FDataHora := Value;
end;

procedure TLembrete.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TLembrete.SetIDLembrete(const Value: integer);
begin
  FIDLEmbrete := Value;
end;

procedure TLembrete.SetTitulo(const Value: string);
begin
  FTitulo := Value;
end;

end.
