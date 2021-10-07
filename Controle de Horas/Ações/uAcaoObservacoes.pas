unit uAcaoObservacoes;

interface

uses
  uDaoBancoDados, uEntidadeObservacao, System.Generics.Collections, Data.DB, System.Classes;

type
  TAcaoObservacoes = class
  private
    FDAO: TDAO<TEntidadeObservacao>;
  public
    function Abrir(const ADescricao: string): TEntidadeObservacao;
    function Consulta: TDataSet;
    function ObservacaoID(const ADescricao: string): Integer;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure CarregaCombo(AItems: TStrings);
    procedure Excluir(AID: Integer);
  end;

implementation

uses
  System.SysUtils, uDataSetHelper;

{ TAcaoTipos }

function TAcaoObservacoes.Abrir(const ADescricao: string): TEntidadeObservacao;
var
  vCondicao: TStringList;
  vDataSet: TDataSet;
begin
  vCondicao := TStringList.Create;
  try
    vCondicao.Add('  DESCRICAO = ' + ADescricao.QuotedString);

    vDataSet := FDAO.Consulta(vCondicao, EmptyStr);
    try
      Result := vDataSet.ToEntidade<TEntidadeObservacao>;
    finally
      vDataSet.Free;
    end;
  finally
    vCondicao.Free;
  end;
end;

procedure TAcaoObservacoes.AfterConstruction;
begin
  inherited;
  FDAO := TDAO<TEntidadeObservacao>.Create;
end;

procedure TAcaoObservacoes.BeforeDestruction;
begin
  inherited;
  FDAO.Free;
end;

procedure TAcaoObservacoes.CarregaCombo(AItems: TStrings);
var
  vDataSet: TDataSet;
begin
  AItems.Clear;

  vDataSet := FDAO.Consulta(nil, 'DATA_INCLUSAO DESC, DATA_ALTERACAO');
  try
    while not vDataSet.Eof do
    begin
      AItems.Add(vDataSet.FieldByName('DESCRICAO').AsString);

      vDataSet.Next;
    end;
  finally
    vDataSet.Free;
  end;
end;

function TAcaoObservacoes.Consulta: TDataSet;
begin
  Result := FDAO.Consulta(nil, '');
end;

procedure TAcaoObservacoes.Excluir(AID: Integer);
begin
  FDAO.Deletar(AID.ToString);
end;

function TAcaoObservacoes.ObservacaoID(const ADescricao: string): Integer;
var
  vEntidade: TEntidadeObservacao;
begin
  Result := 0;
  if not ADescricao.IsEmpty then
  begin
    vEntidade := Abrir(ADescricao);
    try
      if Assigned(vEntidade) then
      begin
        Result := vEntidade.ID;
      end
      else
      begin
        vEntidade := TEntidadeObservacao.Create;
        vEntidade.Descricao := ADescricao;

        if FDAO.Salvar(vEntidade) then
        begin
          Result := vEntidade.ID;
        end;
      end;
    finally
      vEntidade.Free;
    end;
  end;
end;

end.
