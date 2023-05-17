unit uPessoaRepo;

interface

uses
 System.SysUtils, System.Classes, DB, uPessoaModel, uRepository;

type
  TPessoaRepo = class(TRepository)
  private
    FLastID: Integer;
    procedure AddSeed();
    procedure CreateSeed(pID: Integer; pNome, pSobrenome, pCelular, pEmail, pLinkedin, pGitHub: String);
  published
    procedure CreateFieldsAddSeed();
    function GetId(): Integer;
    procedure Salvar(const pPessoa: TPessoa); overload;
    function GetPessoaByID(pID: Integer): Boolean;
  End;

implementation

{ TPessoaRepo }

procedure TPessoaRepo.CreateFieldsAddSeed();
begin
  Self.FieldDefs.Add('ID', ftInteger);
  Self.FieldDefs.Add('Nome', ftString, 20);
  Self.FieldDefs.Add('Sobrenome', ftString, 20);
  Self.FieldDefs.Add('Celular', ftString, 16);
  Self.FieldDefs.Add('Email', ftString, 20);
  Self.FieldDefs.Add('LinkedIn', ftString, 20);
  Self.FieldDefs.Add('GitHub', ftString, 20);
  Self.CreateDataSet;

  Self.LogChanges := False;

  AddSeed();
end;

function TPessoaRepo.GetId: Integer;
var
  sFilter: String;
  bmPosicao: TBookmark;
begin

  if Assigned(Self) and (FLastID <= 0) then
  begin
    bmPosicao := Self.GetBookmark;
    Self.DisableControls;

    if Self.Filtered then
    begin
      sFilter := Self.Filter;
      Self.Filtered := False;
    end;

    Self.Last;
    FLastID := Self.FieldByName('ID').AsInteger + 1;
    result := FLastID;

    if Trim(sFilter) <> EmptyStr then
    begin
      Self.Filtered := False;
      Self.Filter := sFilter;
      Self.Filtered := True;
    end;
    Self.GotoBookmark(bmPosicao);
    Self.EnableControls;
  end
  else
    result := FLastID+1;
end;

function TPessoaRepo.GetPessoaByID(pID: Integer): Boolean;
begin
  result := Self.Locate('ID', pID, []);
end;

procedure TPessoaRepo.CreateSeed(pID: Integer; pNome, pSobrenome, pCelular,
  pEmail, pLinkedin, pGitHub: String);
begin
  Self.Append;
  Self.FieldByName('ID').AsInteger := pID;
  Self.FieldByName('Nome').AsString := pNome;
  Self.FieldByName('Sobrenome').AsString := pSobrenome;
  Self.FieldByName('Celular').AsString := pCelular;
  Self.FieldByName('Email').AsString := pEmail;
  Self.FieldByName('LinkedIn').AsString := pLinkedin;
  Self.FieldByName('GitHub').AsString := pGitHub;
  Self.Post;
end;

procedure TPessoaRepo.AddSeed;
begin
  CreateSeed(1, 'Thomas', 'A. Anderson', '81 98888-8888', 'email@email.com', 'https://linkedin.com' ,'https://github.com');
  CreateSeed(2, 'Steve', 'Rogers', '81 98888-8888', 'email@email.com', 'https://linkedin.com' ,'https://github.com');
  CreateSeed(3, 'Luke', 'Skywalker', '81 98888-8888', 'email@email.com', 'https://linkedin.com' ,'https://github.com');
  CreateSeed(4, 'Dean', 'Winchester', '81 98888-8888', 'email@email.com', 'https://linkedin.com' ,'https://github.com');
end;

procedure TPessoaRepo.Salvar(const pPessoa: TPessoa);
var
  iID: integer;
begin
  if pPessoa.ID = 0 then
  begin
    iID := GetId;
    Self.Append;
    Self.FieldByName('ID').AsInteger := iID;
  end
  else
  begin
    if Self.Locate('ID', Self.FieldByName('ID').AsInteger,[]) then
      Self.Edit
    else
      raise Exception.Create('Registro:' + Self.FieldByName('ID').AsString +', não encontrado!');
  end;


  Self.FieldByName('Nome').AsString := pPessoa.Nome;
  Self.FieldByName('Sobrenome').AsString := pPessoa.Sobrenome;
  Self.FieldByName('Celular').AsString := pPessoa.Celular;
  Self.FieldByName('Email').AsString := pPessoa.Email;
  Self.FieldByName('LinkedIn').AsString := pPessoa.LinkedIn;
  Self.FieldByName('GitHub').AsString := pPessoa.GitHub;
  Self.Post;

  pPessoa.ID := iID;
end;
end.

