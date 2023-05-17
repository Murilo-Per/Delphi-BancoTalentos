unit uPessoaModel;

interface

type
  TPessoa = class
    private
    FID: Integer;
    FNome: String;
    FSobrenome: String;
    FEmail: String;
    FLinkedIn: string;
    FGitHub: string;
    FCelular: String;

    public
      property ID: Integer read FID write FID;
      property Nome: String read FNome write FNome;
      property Sobrenome: String read FSobrenome write FSobrenome;
      property Celular: String read FCelular write FCelular;
      property Email: String read FEmail write FEmail;
      property LinkedIn: string read FLinkedIn write FLinkedIn;
      property GitHub: string read FGitHub write FGitHub;
  End;

implementation

end.
