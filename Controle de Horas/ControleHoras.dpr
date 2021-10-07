program ControleHoras;

uses
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
  uDataModuleFormPrincipal in 'uDataModuleFormPrincipal.pas' {DataModuleFormPrincipal: TDataModule},
  uUtils in '..\Biblioteca\Utilitários\uUtils.pas',
  uHoraUtils in '..\Biblioteca\Utilitários\uHoraUtils.pas',
  uDAOBancoDadosBase in '..\Biblioteca\DAOs\uDAOBancoDadosBase.pas',
  uEntidade in '..\Biblioteca\Entidades\uEntidade.pas',
  uAtributosTabelas in '..\Biblioteca\Atributos\uAtributosTabelas.pas',
  uEntidadeTipo in 'Entidades\uEntidadeTipo.pas',
  uEntidadeObservacao in 'Entidades\uEntidadeObservacao.pas',
  uEntidadeMotivo in 'Entidades\uEntidadeMotivo.pas',
  uEntidadeLancamentoHora in 'Entidades\uEntidadeLancamentoHora.pas',
  uAcaoLancamentosHoras in 'Ações\uAcaoLancamentosHoras.pas',
  uAcaoTipos in 'Ações\uAcaoTipos.pas',
  uAcaoMotivos in 'Ações\uAcaoMotivos.pas',
  uAcaoSetores in 'Ações\uAcaoSetores.pas',
  uAcaoObservacoes in 'Ações\uAcaoObservacoes.pas',
  uEntidadeSetor in 'Entidades\uEntidadeSetor.pas',
  uDataSetHelper in '..\Biblioteca\Helpers\uDataSetHelper.pas',
  uDAOBancoDados in '..\Biblioteca\DAOs\uDAOBancoDados.pas',
  uConexao in '..\Biblioteca\Conexao\uConexao.pas',
  uRTTIUtils in '..\Biblioteca\Utilitários\uRTTIUtils.pas';

{$R *.res}

begin
  uConexao.InicializaConexao('ControleHoras.db');

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleFormPrincipal, DataModuleFormPrincipal);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
