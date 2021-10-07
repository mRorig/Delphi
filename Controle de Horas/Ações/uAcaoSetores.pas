unit uAcaoSetores;

interface

uses
  uDaoBancoDados, uEntidadeSetor, System.Generics.Collections, Data.DB, System.Classes;

type
  TAcaoSetores = class
  private
    FDAO: TDAO<TEntidadeSetor>;
  public
    function Abrir(const ADescricao: string): TEntidadeSetor;
    function Consulta: TDataSet;
    function SetorID(const ADescricao: string): Integer;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure CarregaCombo(AItems: TStrings);
    procedure Excluir(AID: Integer);
  end;

implementation

uses
  System.SysUtils, uDataSetHelper;

{ TAcaoTipos }

function TAcaoSetores.Abrir(const ADescricao: string): TEntidadeSetor;
var
  vCondicao: TStringList;
  vDataSet: TDataSet;
begin
  vCondicao := TStringList.Create;
  try
    vCondicao.Add('  DESCRICAO = ' + ADescricao.QuotedString);

    vDataSet := FDAO.Consulta(vCondicao, EmptyStr);
    try
      Result := vDataSet.ToEntidade<TEntidadeSetor>;
    finally
      vDataSet.Free;
    end;
  finally
    vCondicao.Free;
  end;
end;

procedure TAcaoSetores.AfterConstruction;
begin
  inherited;
  FDAO := TDAO<TEntidadeSetor>.Create;
end;

procedure TAcaoSetores.BeforeDestruction;
begin
  inherited;
  FDAO.Free;
end;

procedure TAcaoSetores.CarregaCombo(AItems: TStrings);
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

function TAcaoSetores.Consulta: TDataSet;
begin
  Result := FDAO.Consulta(nil, '');
end;

procedure TAcaoSetores.Excluir(AID: Integer);
begin
  FDAO.Deletar(AID.ToString);
end;

function TAcaoSetores.SetorID(const ADescricao: string): Integer;
var
  vEntidade: TEntidadeSetor;
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
        vEntidade := TEntidadeSetor.Create;
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
