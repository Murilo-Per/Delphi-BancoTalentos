unit uPessoaHistoricoModel;

interface

type
  TPessoaHistorico = class
  private
    FIDPessoa: Integer;
    FNomeEmpresa: String;
    FCargo: String;
    FDataAdmissao: TDate;
  published
    property IDPessoa: Integer read FIDPessoa write FIDPessoa;
    property NomeEmpresa: String read FNomeEmpresa write FNomeEmpresa;
    property Cargo: String read FCargo write FCargo;
    property DataAdmissao: TDate read FDataAdmissao write FDataAdmissao;
 end;

implementation

end.
