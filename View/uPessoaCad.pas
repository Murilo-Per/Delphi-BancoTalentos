unit uPessoaCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uRepository,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uUtils, uPessoaController,
  uPessoaHistoricoController;

type
  TfrPessoaCad = class(TForm)
    edtID: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSobrenome: TLabeledEdit;
    edtCelular: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtLinkedIn: TLabeledEdit;
    edtGitHub: TLabeledEdit;
    Panel1: TPanel;
    btnSalvar: TButton;
    btnSair: TButton;
    GroupBox1: TGroupBox;
    dsHistorico: TDataSource;
    grdHistorico: TDBGrid;
    edtNomeEmpresa: TLabeledEdit;
    edtCargo: TLabeledEdit;
    dtEdtAdmissao: TDateTimePicker;
    Panel2: TPanel;
    btnSalvarHistorico: TButton;
    btnExcluirHistorico: TButton;
    lblDataAdmissao: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSalvarHistoricoClick(Sender: TObject);
    procedure btnExcluirHistoricoClick(Sender: TObject);
  private
    { Private declarations }
    FPessoaRepo: TRepository;
    FPessoaHistoricoRepo: TRepository;
    FPessoa: TPessoaController;
    FPessoaHistorico: TPessoaHistoricoController;

    procedure CriarObjetos(const pPessoaRepo: TRepository; const pPessoaHistoricoRepo: TRepository);
    procedure CarregarPessoa();
    procedure CarregarPessoaHistorico(pIDPessoa: Integer);

    procedure AtualizarDadosHistorico(pIDPessoa: Integer);
    procedure SalvarDados();
    procedure SalvarDadosPessoa();
    procedure SalvarDadosHistorico();

    procedure RemoverHistorico();
  public
    { Public declarations }
   enuFormState: TFormState;

   constructor Create(AOwner: TComponent;const pPessoaRepo: TRepository; const pPessoaHistoricoRepo: TRepository); overload;
  end;

var
  frPessoaCad: TfrPessoaCad;

implementation

{$R *.dfm}

procedure TfrPessoaCad.btnSalvarClick(Sender: TObject);
begin
  SalvarDados;
  Close;
end;

procedure TfrPessoaCad.btnSalvarHistoricoClick(Sender: TObject);
begin
  SalvarDadosHistorico();
end;

procedure TfrPessoaCad.btnExcluirHistoricoClick(Sender: TObject);
begin
  RemoverHistorico();
end;

procedure TfrPessoaCad.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrPessoaCad.CarregarPessoa();
begin
  edtID.Text := FPessoa.ID.ToString;
  edtNome.Text := FPessoa.Nome;
  edtSobrenome.Text := FPessoa.Sobrenome;
  edtEmail.Text := FPessoa.Email;
  edtCelular.Text := FPessoa.Celular;
  edtLinkedIn.Text := FPessoa.LinkedIn;
  edtGitHub.Text := FPessoa.GitHub;

  CarregarPessoaHistorico(StrToIntDef(FPessoa.ID.ToString, 0));
end;

procedure TfrPessoaCad.CarregarPessoaHistorico(pIDPessoa: Integer);
begin
  FPessoaHistoricoRepo.Filtered := False;
  FPessoaHistoricoRepo.Filter := 'IDPessoa = ' + IntToStr(pIDPessoa);
  FPessoaHistoricoRepo.Filtered := True;
end;

constructor TfrPessoaCad.Create(AOwner: TComponent; const pPessoaRepo: TRepository; const pPessoaHistoricoRepo: TRepository);
begin
  inherited Create(AOwner);
  CriarObjetos(pPessoaRepo, pPessoaHistoricoRepo);
end;

procedure TfrPessoaCad.CriarObjetos(const pPessoaRepo: TRepository; const pPessoaHistoricoRepo: TRepository);
begin
  FPessoaRepo := pPessoaRepo;
  FPessoa := TPessoaController.Create(FPessoaRepo);

  FPessoaHistoricoRepo := pPessoaHistoricoRepo;
  dsHistorico.DataSet := FPessoaHistoricoRepo;
  FPessoaHistorico := TPessoaHistoricoController.Create(FPessoaHistoricoRepo);
end;

procedure TfrPessoaCad.FormActivate(Sender: TObject);
begin
  if (enuFormState = stEditar) and (FPessoa.GetPessoaByID(FPessoaRepo.FieldByName('ID').AsInteger)) then
    CarregarPessoa()
  else
    CarregarPessoaHistorico(0);
end;

procedure TfrPessoaCad.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FPessoa);
end;

procedure TfrPessoaCad.FormShow(Sender: TObject);
begin
  if edtNome.CanFocus then
    edtNome.SetFocus;
end;

procedure TfrPessoaCad.RemoverHistorico;
begin
  if FPessoaHistoricoRepo.RecordCount > 0 then
  begin
    if MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation,
     [mbYes, mbNo], 0) = mrYes then
      FPessoaHistoricoRepo.Delete;
  end;
end;

procedure TfrPessoaCad.SalvarDados;
begin
  SalvarDadosPessoa();
end;

procedure TfrPessoaCad.SalvarDadosHistorico;
begin
  FPessoaHistorico.IDPessoa := FPessoa.ID;
  FPessoaHistorico.NomeEmpresa := edtNomeEmpresa.Text;
  FPessoaHistorico.Cargo := edtCargo.Text;
  FPessoaHistorico.DataAdmissao := dtEdtAdmissao.Date;

  FPessoaHistorico.Salvar;
end;

procedure TfrPessoaCad.SalvarDadosPessoa;
begin
  if enuFormState = stIncluir then
    FPessoa.ID := 0
  else
    FPessoa.ID := StrToInt(edtID.Text);

  FPessoa.Nome := edtNome.Text;
  FPessoa.Sobrenome := edtSobrenome.Text;
  FPessoa.Celular := edtCelular.Text;
  FPessoa.Email := edtEmail.Text;
  FPessoa.LinkedIn := edtLinkedIn.Text;
  FPessoa.GitHub := edtGitHub.Text;

  FPessoa.Salvar;

  AtualizarDadosHistorico(FPessoa.ID);
end;


procedure TfrPessoaCad.AtualizarDadosHistorico(pIDPessoa: Integer);
begin
  FPessoaHistoricoRepo.DisableControls;
  FPessoaHistoricoRepo.First;
  while not FPessoaHistoricoRepo.Eof do
  begin
    if FPessoaHistoricoRepo.Locate('IDPessoa', 0, []) then
    begin
      FPessoaHistoricoRepo.Edit;
      FPessoaHistoricoRepo.FieldByName('IDPessoa').AsInteger := pIDPessoa;
      FPessoaHistoricoRepo.Post;
    end;

    FPessoaHistoricoRepo.Next;
  end;
  FPessoaHistoricoRepo.EnableControls;
end;

end.
