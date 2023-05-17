unit uRepository;

interface
uses Datasnap.DBClient, DB;

type
  TRepository = class(TClientDataSet)
  private
  strict protected
    procedure Salvar(); dynamic; abstract;
  end;

implementation

end.
