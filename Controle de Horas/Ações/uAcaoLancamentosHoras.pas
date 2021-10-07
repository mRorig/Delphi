unit uAcaoLancamentosHoras;

interface

uses
  uDaoBancoDados, uEntidadeLancamentoHora, System.Generics.Collections, Data.DB, system.sysutils;

type
  TAcaoLancamentosHoras = class
  private
    FDAO: TDAO<TEntidadeLancamentoHora>;
  public
    function AbrirLista(AWhere: String = ''; AOrdem: String = ''): TObjectList<TEntidadeLancamentoHora>;
    function Consulta: TDataSet;
    function Salvar(AEntidade: TEntidadeLancamentoHora): Boolean;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure Excluir(AID: Integer);
  end;

implementation

{ TAcaoCartao }

function TAcaoLancamentosHoras.AbrirLista(AWhere: String = ''; AOrdem: String = ''): TObjectList<TEntidadeLancamentoHora>;
begin
  Result := FDAO.AbrirLista(AWhere, AOrdem);
end;

procedure TAcaoLancamentosHoras.AfterConstruction;
begin
  inherited;
  FDAO := TDAO<TEntidadeLancamentoHora>.Create;
end;

procedure TAcaoLancamentosHoras.BeforeDestruction;
begin
  inherited;
  FDAO.DisposeOf;
end;

function TAcaoLancamentosHoras.Consulta: TDataSet;
begin
  Result := FDAO.Consulta(nil, 'DATA DESC, HORA_INICIO DESC');
end;

procedure TAcaoLancamentosHoras.Excluir(AID: Integer);
begin
  FDAO.Deletar(AID.ToString);
end;

function TAcaoLancamentosHoras.Salvar(AEntidade: TEntidadeLancamentoHora): Boolean;
begin
  Result := FDAO.Salvar(AEntidade);
end;

end.
