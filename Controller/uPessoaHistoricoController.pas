unit uPessoaHistoricoController;

interface

uses
  System.SysUtils, uPessoaHistoricoModel, uRepository;

type
  TPessoaHistoricoController = class(TPessoaHistorico)
    private
      FPessoaHistoricoRepo: TRepository;

      function ValidarCampos(): Boolean;
      function ValidarRepo(): Boolean;
    public
      constructor Create( const pPessoaHistoricoRepo: TRepository);
      function Salvar(): Boolean;
  end;

implementation

{ TPessoaHistoricoController }

uses uPessoaHistoricoRepo;

constructor TPessoaHistoricoController.Create(
  const pPessoaHistoricoRepo: TRepository);
begin
  inherited Create();
  FPessoaHistoricoRepo := pPessoaHistoricoRepo;
end;

function TPessoaHistoricoController.ValidarCampos: Boolean;
begin
  result := True;

  if (Trim(Self.NomeEmpresa) = EmptyStr) then
    raise Exception.Create('Campo "Nome da Empresa" não pode ser vazio!');

  if (Trim(Self.Cargo) = EmptyStr) then
    raise Exception.Create('Campo "Cargo" não pode ser vazio!');

 end;

function TPessoaHistoricoController.ValidarRepo: Boolean;
begin
  result := True;

  if not Assigned(FPessoaHistoricoRepo) then
    raise Exception.Create('Não foi possivel conectar a base de dados!');
end;

function TPessoaHistoricoController.Salvar: Boolean;
begin
  if (ValidarRepo()) and (ValidarCampos()) then
  begin
    result := True;

    if (ValidarCampos()) and (ValidarRepo()) then
      try
       TPessoaHistoricoRepo(FPessoaHistoricoRepo).Salvar(Self);
      Except on E:Exception do
        raise Exception.Create(E.Message);
      end;
  end;
end;

end.
