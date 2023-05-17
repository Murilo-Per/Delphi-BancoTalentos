unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.WinXCtrls, Datasnap.DBClient, uPessoaRepo , uPessoaHistoricoRepo, Vcl.ExtCtrls, uUtils;

type
  TfrPrincipal = class(TForm)
    edtPesquisa: TSearchBox;
    DBGrid1: TDBGrid;
    dsGridPesquisa: TDataSource;
    Panel1: TPanel;
    btnSair: TButton;
    btnAddPessoa: TButton;
    DBGrid2: TDBGrid;
    dsGridHistorico: TDataSource;
    btnAlterarPessoa: TButton;
    btnRemoverPessoa: TButton;
    procedure FormActivate(Sender: TObject);
    procedure btnAddPessoaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnAlterarPessoaClick(Sender: TObject);
    procedure dsGridPesquisaDataChange(Sender: TObject; Field: TField);
    procedure btnRemoverPessoaClick(Sender: TObject);
  private
    { Private declarations }
    procedure CreateDataRepo();
    procedure FiltrarPessoa(pFiltro: String);
    procedure DefineCamposGridPessoa();
    procedure DefineCamposGridHistorico();
    procedure CriarForm(pTipoForm: TFormState);
    procedure RemoverPessoa();
  public
    { Public declarations }
    oPessoaRepo: TPessoaRepo;
    oPessoaHistoricoRepo: TPessoaHistoricoRepo;
  end;

var
  frPrincipal: TfrPrincipal;


implementation

{$R *.dfm}

uses uPessoaCad;

{ TfrPrincipal }

procedure TfrPrincipal.btnAddPessoaClick(Sender: TObject);
begin
  CriarForm(stIncluir);
end;

procedure TfrPrincipal.btnAlterarPessoaClick(Sender: TObject);
begin
  if dsGridPesquisa.DataSet.RecordCount > 0 then
  CriarForm(stEditar);
end;

procedure TfrPrincipal.btnRemoverPessoaClick(Sender: TObject);
begin
  RemoverPessoa();
end;

procedure TfrPrincipal.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrPrincipal.CreateDataRepo;
begin
  oPessoaRepo := TPessoaRepo.Create(Self);
  oPessoaRepo.CreateFieldsAddSeed();

  oPessoaHistoricoRepo := TPessoaHistoricoRepo.Create(Self);
  oPessoaHistoricoRepo.CreateFieldsAddSeed();
end;

procedure TfrPrincipal.CriarForm(pTipoForm: TFormState);
var
  FrPessoaCad: TfrPessoaCad;
begin
  dsGridPesquisa.Enabled := False;
  FrPessoaCad := TfrPessoaCad.Create(Self, oPessoaRepo, oPessoaHistoricoRepo);
  FrPessoaCad.enuFormState := pTipoForm;
  try

    FrPessoaCad.ShowModal;
  finally
    FreeAndNil(FrPessoaCad);
    dsGridPesquisa.Enabled := True;
    DefineCamposGridPessoa();
    DefineCamposGridHistorico();
  end;
end;

procedure TfrPrincipal.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ShowScrollBar(TDBGrid(Sender).Handle,SB_HORZ,False);
end;

procedure TfrPrincipal.DefineCamposGridPessoa;
const
  Nome = 1;
  Sobrenome = 2;
var
  iContador: Integer;
begin
  dsGridPesquisa.DataSet := oPessoaRepo;

  for iContador:= 0 to DBGrid1.Columns.Count -1 do
  begin
    if iContador in [Nome,Sobrenome] then
      Continue;

    DBGrid1.Columns.Items[iContador].Visible := False;
  end;
  dsGridPesquisa.DataSet.First;
end;

procedure TfrPrincipal.dsGridPesquisaDataChange(Sender: TObject; Field: TField);
begin
  if dsGridPesquisa.DataSet.RecordCount > 0 then
  begin
    dsGridHistorico.DataSet.Filtered := False;
    dsGridHistorico.DataSet.Filter :=
      StringReplace('IDPessoa = *s','*s',dsGridPesquisa.DataSet.FieldByName('ID').AsString,[rfReplaceAll]);
    dsGridHistorico.DataSet.Filtered := True;
  end;
end;

procedure TfrPrincipal.DefineCamposGridHistorico;
const
  IDPessoa = 0;
var
  iContador: Integer;
begin
   dsGridHistorico.DataSet := oPessoaHistoricoRepo;

   DBGrid2.Columns.Items[IDPessoa].Visible := False;
end;

procedure TfrPrincipal.edtPesquisaChange(Sender: TObject);
begin
  FiltrarPessoa(edtPesquisa.Text);
end;

procedure TfrPrincipal.FiltrarPessoa(pFiltro: String);
const
  FILTER = '(Upper(Nome) LIKE *s ) or (Upper(Sobrenome) LIKE *s ) or (Upper(Email) LIKE *s ) or (Upper(Celular) LIKE *s )';
var
  sFilter: String;
begin
  if Assigned(oPessoaRepo) then
  begin
    if Trim(pFiltro) = EmptyStr then
    begin
      oPessoaRepo.Filtered := False;
      oPessoaRepo.Filter := '';
    end
    else
    begin
      oPessoaRepo.Filtered := False;
      sFilter := StringReplace(FILTER,'*s', QuotedStr('%'+UpperCase(pFiltro)+'%'),[rfReplaceAll]);
      oPessoaRepo.Filter := sFilter;
      oPessoaRepo.Filtered := True;
    end;
  end;
end;

procedure TfrPrincipal.FormActivate(Sender: TObject);
begin
  CreateDataRepo();
  DefineCamposGridHistorico();
  DefineCamposGridPessoa();
end;

procedure TfrPrincipal.RemoverPessoa;
var
  sIDPessoa: String;
begin
 if oPessoaRepo.RecordCount <= 0 then
   exit;

 if MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin

     sIDPessoa := oPessoaRepo.FieldByName('ID').AsString;
     oPessoaHistoricoRepo.First;
     while not oPessoaHistoricoRepo.Eof do
     begin
       if oPessoaHistoricoRepo.Locate('IDPessoa', sIDPessoa, []) then
         oPessoaHistoricoRepo.Delete
       else
         Break;
     end;

     if oPessoaRepo.Locate('ID', sIDPessoa, []) then
       oPessoaRepo.Delete;

     oPessoaRepo.First;

     DefineCamposGridPessoa();
     DefineCamposGridHistorico();
  end;

end;

end.
