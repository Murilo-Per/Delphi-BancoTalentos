unit uPessoaController;

interface

uses System.SysUtils, uPessoaModel, uRepository;


type
  TPessoaController = class(TPessoa)
    private
      FPessoaRepo: TRepository;

      function ValidarCampos(): Boolean;
      function ValidarRepo(): Boolean;
    public
      constructor Create( const pPessoaRepo: TRepository);
      function Salvar(): Boolean;
      function GetPessoaByID(pID: Integer): Boolean;
  end;

implementation

{ TPessoaController }

uses uPessoaRepo;

constructor TPessoaController.Create(const pPessoaRepo: TRepository);
begin
  inherited Create;
  FPessoaRepo := pPessoaRepo;
end;

function TPessoaController.GetPessoaByID(pID: Integer): Boolean;
begin
  result := True;
  if ValidarRepo() then
  begin
    if TPessoaRepo(FPessoaRepo).GetPessoaByID(pID) then
    begin
      Self.ID := TPessoaRepo(FPessoaRepo).FieldByName('ID').AsInteger;
      Self.Nome := TPessoaRepo(FPessoaRepo).FieldByName('Nome').AsString;
      Self.Sobrenome := TPessoaRepo(FPessoaRepo).FieldByName('Sobrenome').AsString;
      Self.Email := TPessoaRepo(FPessoaRepo).FieldByName('Email').AsString;
      Self.Celular := TPessoaRepo(FPessoaRepo).FieldByName('Celular').AsString;
      Self.LinkedIn := TPessoaRepo(FPessoaRepo).FieldByName('LinkedIn').AsString;
      Self.GitHub := TPessoaRepo(FPessoaRepo).FieldByName('GitHub').AsString;
    end
    else
      raise Exception.Create('Registro não encontrado!');
  end;
end;

function TPessoaController.Salvar(): Boolean;
begin
  result := True;

  if (ValidarCampos()) and (ValidarRepo()) then
    try
     TPessoaRepo(FPessoaRepo).Salvar(Self);
    Except on E:Exception do
      raise Exception.Create(E.Message);
    end;
end;

function TPessoaController.ValidarCampos: Boolean;
begin
  result := True;

  if (Trim(Self.Nome) = EmptyStr) then
    raise Exception.Create('Campo "Nome" não pode ser vazio!');

  if (Trim(Self.Sobrenome) = EmptyStr) then
    raise Exception.Create('Campo "Sobrenome" não pode ser vazio!');

  if (Trim(Self.Celular) = EmptyStr) then
    raise Exception.Create('Campo "Celular" não pode ser vazio!');

  if (Trim(Self.Email) = EmptyStr) then
    raise Exception.Create('Campo "Email" não pode ser vazio!');

  if (Trim(Self.LinkedIn) = EmptyStr) then
    raise Exception.Create('Campo "LinkedIn" não pode ser vazio!');

  if (Trim(Self.GitHub) = EmptyStr) then
    raise Exception.Create('Campo "GitHub" não pode ser vazio!');
 end;

function TPessoaController.ValidarRepo: Boolean;
begin
  result := True;

  if not Assigned(FPessoaRepo) then
    raise Exception.Create('Não foi possivel conectar a base de dados!');
end;

end.
