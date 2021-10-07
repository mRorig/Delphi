unit uAcaoMotivos;

interface

uses
  uDaoBancoDados, uEntidadeMotivo, System.Generics.Collections, Data.DB, System.Classes;

type
  TAcaoMotivos = class
  private
    FDAO: TDAO<TEntidadeMotivo>;
  public
    function Abrir(const ADescricao: string): TEntidadeMotivo;
    function Consulta: TDataSet;
    function MotivoID(const ADescricao: string): Integer;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure CarregaCombo(AItems: TStrings);
    procedure Excluir(AID: Integer);
  end;

implementation

uses
  System.SysUtils, uDataSetHelper;

{ TAcaoTipos }

function TAcaoMotivos.Abrir(const ADescricao: string): TEntidadeMotivo;
var
  vCondicao: TStringList;
  vDataSet: TDataSet;
begin
  vCondicao := TStringList.Create;
  try
    vCondicao.Add('  DESCRICAO = ' + ADescricao.QuotedString);

    vDataSet := FDAO.Consulta(vCondicao, EmptyStr);
    try
      Result := vDataSet.ToEntidade<TEntidadeMotivo>;
    finally
      vDataSet.Free;
    end;
  finally
    vCondicao.Free;
  end;
end;

procedure TAcaoMotivos.AfterConstruction;
begin
  inherited;
  FDAO := TDAO<TEntidadeMotivo>.Create;
end;

procedure TAcaoMotivos.BeforeDestruction;
begin
  inherited;
  FDAO.Free;
end;

procedure TAcaoMotivos.CarregaCombo(AItems: TStrings);
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

function TAcaoMotivos.Consulta: TDataSet;
begin
  Result := FDAO.Consulta(nil, '');
end;

procedure TAcaoMotivos.Excluir(AID: Integer);
begin
  FDAO.Deletar(AID.ToString);
end;

function TAcaoMotivos.MotivoID(const ADescricao: string): Integer;
var
  vEntidade: TEntidadeMotivo;
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
        vEntidade := TEntidadeMotivo.Create;
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
