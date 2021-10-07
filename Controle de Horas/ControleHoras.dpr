program ControleHoras;

uses
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
  uDataModuleFormPrincipal in 'uDataModuleFormPrincipal.pas' {DataModuleFormPrincipal: TDataModule},
  uUtils in '..\Biblioteca\Utilit�rios\uUtils.pas',
  uHoraUtils in '..\Biblioteca\Utilit�rios\uHoraUtils.pas',
  uDAOBancoDadosBase in '..\Biblioteca\DAOs\uDAOBancoDadosBase.pas',
  uEntidade in '..\Biblioteca\Entidades\uEntidade.pas',
  uAtributosTabelas in '..\Biblioteca\Atributos\uAtributosTabelas.pas',
  uEntidadeTipo in 'Entidades\uEntidadeTipo.pas',
  uEntidadeObservacao in 'Entidades\uEntidadeObservacao.pas',
  uEntidadeMotivo in 'Entidades\uEntidadeMotivo.pas',
  uEntidadeLancamentoHora in 'Entidades\uEntidadeLancamentoHora.pas',
  uAcaoLancamentosHoras in 'A��es\uAcaoLancamentosHoras.pas',
  uAcaoTipos in 'A��es\uAcaoTipos.pas',
  uAcaoMotivos in 'A��es\uAcaoMotivos.pas',
  uAcaoSetores in 'A��es\uAcaoSetores.pas',
  uAcaoObservacoes in 'A��es\uAcaoObservacoes.pas',
  uEntidadeSetor in 'Entidades\uEntidadeSetor.pas',
  uDataSetHelper in '..\Biblioteca\Helpers\uDataSetHelper.pas',
  uDAOBancoDados in '..\Biblioteca\DAOs\uDAOBancoDados.pas',
  uConexao in '..\Biblioteca\Conexao\uConexao.pas',
  uRTTIUtils in '..\Biblioteca\Utilit�rios\uRTTIUtils.pas';

{$R *.res}

begin
  uConexao.InicializaConexao('ControleHoras.db');

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleFormPrincipal, DataModuleFormPrincipal);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
