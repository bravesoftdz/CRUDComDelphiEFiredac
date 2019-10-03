unit uFrmConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uDM, uLembreteDAO, uLembrete, generics.defaults, generics.collections;

type
  TFrmConsulta = class(TForm)
    ListView1: TListView;
    Label1: TLabel;
    Label2: TLabel;
    edtBuscar: TEdit;
    btnBuscar: TButton;
    btnNovo: TButton;
    btnEditar: TButton;
    btnDeletar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    { Private declarations }
    LembreteDAO : TLembreteDAO;
    procedure PreencherListView(pListaLembrete: TList<TLembrete>);
    procedure CarregarColecao;
    procedure EditarLembrete;
  public
    { Public declarations }
  end;

var
  FrmConsulta: TFrmConsulta;

implementation

{$R *.dfm}

procedure TFrmConsulta.btnBuscarClick(Sender: TObject);
begin
  CarregarColecao;
end;

procedure TFrmConsulta.btnDeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja remover este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if ListView1.ItemIndex > -1 then
    begin
      if LembreteDAO.Deletar(TLembrete(ListView1.ItemFocused.Data)) then
        CarregarColecao;
    end;
  end;
end;

procedure TFrmConsulta.btnEditarClick(Sender: TObject);
begin
   EditarLembrete;
end;

procedure TFrmConsulta.btnNovoClick(Sender: TObject);
begin
  {try
    FrmLembreteInserir := TFrmLembreteInserir.Create(Self);
    FrmLembreteInserir.ShowModal;
    CarregarColecao;
  finally
    FreeAndNil(FrmLembreteInserir);
  end;}
end;

procedure TFrmConsulta.CarregarColecao;
begin
  try
    PreencherListView(LembreteDAO.ListarPorTitulo_Descricao(edtBuscar.Text));
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TFrmConsulta.EditarLembrete;
begin
  {try
    FrmLembreteEditar := TFrmLembreteEditar.Create(Self, TLembrete(ListView1.ItemFocused.Data));
    FrmLembreteEditar.ShowModal;
    CarregarColecao;
  finally
    FreeAndNil(FrmLembreteEditar);
  end;}
end;

procedure TFrmConsulta.FormCreate(Sender: TObject);
begin
  DM          := TDM.Create(Self);
  LembreteDAO := TLembreteDAO.Create;
end;

procedure TFrmConsulta.FormDestroy(Sender: TObject);
begin
   try
    if Assigned(LembreteDAO) then
      FreeAndNil(LembreteDAO);
    if Assigned(DM) then
      FreeAndNil(DM);
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TFrmConsulta.ListView1DblClick(Sender: TObject);
begin
  EditarLembrete;
end;

procedure TFrmConsulta.PreencherListView(pListaLembrete: TList<TLembrete>);
var
  I: Integer;
  tempItem: TListItem;
begin
  if Assigned(pListaLembrete) then
  begin
    ListView1.Clear;
    for I := 0 to pListaLembrete.Count -1 do
    begin
      tempItem := ListView1.Items.Add;
      tempItem.Caption := IntToStr(TLembrete(pListaLembrete[I]).IDLembrete);
      tempItem.SubItems.Add(TLembrete(pListaLembrete[I]).Titulo);
      tempItem.SubItems.Add(FormatDateTime('dd/mm/yyyy hh:mm', TLembrete(pListaLembrete[I]).DataHora));
      tempItem.Data := TLembrete(pListaLembrete[I]);
    end;
  end
  else
    ShowMessage('Nenhum lembrete encontrado.');

end;

end.
