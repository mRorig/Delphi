unit uAcaoTipos;

interface

uses
  uDaoBancoDados, uEntidadeTipo, System.Generics.Collections, Data.DB, system.classes;

type
  TAcaoTipos = class
  private
    FDAO: TDAO<TEntidadeTipo>;
  public
    function Abrir(const ADescricao: string): TEntidadeTipo;
    function Consulta: TDataSet;
    function TipoID(const ADescricao: string): Integer;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure CarregaCombo(AItems: TStrings);
    procedure Excluir(AID: Integer);
  end;

implementation

uses
  System.SysUtils, uDataSetHelper;

{ TAcaoTipos }

function TAcaoTipos.Abrir(const ADescricao: string): TEntidadeTipo;
var
  vCondicao: TStringList;
  vDataSet: TDataSet;
begin
  vCondicao := TStringList.Create;
  try
    vCondicao.Add('  DESCRICAO = ' + ADescricao.QuotedString);

    vDataSet := FDAO.Consulta(vCondicao, EmptyStr);
    try
      Result := vDataSet.ToEntidade<TEntidadeTipo>;
    finally
      vDataSet.Free;
    end;
  finally
    vCondicao.Free;
  end;
end;

procedure TAcaoTipos.AfterConstruction;
begin
  inherited;
  FDAO := TDAO<TEntidadeTipo>.Create;
end;

procedure TAcaoTipos.BeforeDestruction;
begin
  inherited;
  FDAO.Free;
end;

procedure TAcaoTipos.CarregaCombo(AItems: TStrings);
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

function TAcaoTipos.Consulta: TDataSet;
begin
  Result := FDAO.Consulta(nil, '');
end;

procedure TAcaoTipos.Excluir(AID: Integer);
begin
  FDAO.Deletar(AID.ToString);
end;

function TAcaoTipos.TipoID(const ADescricao: string): Integer;
var
  vEntidade: TEntidadeTipo;
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
        vEntidade := TEntidadeTipo.Create;
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
