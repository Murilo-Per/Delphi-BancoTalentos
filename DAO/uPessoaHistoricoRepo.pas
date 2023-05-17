unit uPessoaHistoricoRepo;

interface

uses
 System.SysUtils, System.Classes, DB, uRepository, uPessoaHistoricoModel;

type
  TPessoaHistoricoRepo = class(TRepository)
  private
    procedure AddSeed();
    procedure CreateSeed(pID:Integer; pNomeEmpresa, pCargo, pDataAdimissao: String);
  published
    procedure CreateFieldsAddSeed();


    procedure Salvar(pPessoaHistorico: TPessoaHistorico); overload;
  End;
implementation

{ TPessoaHistoricoRepo }

procedure TPessoaHistoricoRepo.CreateFieldsAddSeed;
begin
  Self.FieldDefs.Add('IDPessoa', ftInteger);
  Self.FieldDefs.Add('NomeEmpresa', ftString, 30);
  Self.FieldDefs.Add('Cargo', ftString, 20);
  Self.FieldDefs.Add('DataAdmissao', ftDate);
  Self.CreateDataSet;

  Self.LogChanges := False;
  AddSeed();
end;

procedure TPessoaHistoricoRepo.CreateSeed(pID: Integer; pNomeEmpresa, pCargo,
  pDataAdimissao: String);
begin
  Self.Append;
  Self.FieldByName('IDPessoa').AsInteger := pID;
  Self.FieldByName('NomeEmpresa').AsString := pNomeEmpresa;
  Self.FieldByName('Cargo').AsString := pCargo;
  Self.FieldByName('DataAdmissao').AsDateTime := StrToDate(pDataAdimissao);
  Self.Post;
end;

procedure TPessoaHistoricoRepo.AddSeed;
begin
  //Thomas
  CreateSeed(1, 'A Resistencia', 'O Escolhido', '24/03/1999');
  CreateSeed(1, 'Revolução', 'O Escolhido', '21/12/2021');
  //Steve
  CreateSeed(2, 'S.H.I.E.L.D', 'Recruta', '29/07/2011');
  CreateSeed(2, 'Vingadores', 'Capitão', '04/05/2012');
  //Luke
  CreateSeed(3, 'Jedi', 'Padawan', '25/05/1977');
  CreateSeed(3, 'Jedi', 'Cavaleiro', '21/05/1980');
  CreateSeed(3, 'Jedi', 'Mestre', '25/05/1983');
  //Dean
  CreateSeed(4, 'Winchesters', 'Caçador', '13/09/2005');
end;

procedure TPessoaHistoricoRepo.Salvar(pPessoaHistorico: TPessoaHistorico);
begin
  Self.Append;
  Self.FieldByName('IDPessoa').AsInteger := pPessoaHistorico.IDPessoa;
  Self.FieldByName('NomeEmpresa').AsString := pPessoaHistorico.NomeEmpresa;
  Self.FieldByName('Cargo').AsString := pPessoaHistorico.Cargo;
  Self.FieldByName('DataAdmissao').AsDateTime := pPessoaHistorico.DataAdmissao;
  Self.Post;
end;

end.
