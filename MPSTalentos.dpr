program MPSTalentos;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frPrincipal},
  uPessoaModel in 'Model\uPessoaModel.pas',
  uPessoaCad in 'View\uPessoaCad.pas' {frPessoaCad},
  uPessoaRepo in 'DAO\uPessoaRepo.pas',
  uPessoaController in 'Controller\uPessoaController.pas',
  uRepository in 'Model\uRepository.pas',
  uPessoaHistoricoModel in 'Model\uPessoaHistoricoModel.pas',
  uPessoaHistoricoRepo in 'DAO\uPessoaHistoricoRepo.pas',
  uUtils in 'uUtils.pas',
  uPessoaHistoricoController in 'Controller\uPessoaHistoricoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
