unit uDAOBancoDados;

interface

uses
  Data.DB, Data.SqlExpr, uEntidade, System.Generics.Collections, System.SysUtils,
  System.Classes, uDAOBancoDadosBase, Data.FMTBcd, System.Generics.Defaults,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Comp.Client,
  uAtributosTabelas, System.Rtti;

type
  TTabela = class
    Campos: TList<String>;
    Tabela: String;
    Generator: String;
    ChavePrimaria: String;
    propertyCampo: CampoChavePrimariaAttribute;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  TTabelaJoin = class(TTabela)
    RelacoesSQL: TRelacaoSQL;
    ChaveEstrangeira: String;
  end;

  TDAOBancoDados = class abstract(TDAOBancoDadosBase)
  strict private
    FTabela: TTabela;
    FTabelasExternas: TList<TTabelaJoin>;
  public
    constructor Create; override;

    function Abrir<T: TEntidade, constructor>(AID: Integer): T;
    function AbrirLista<T: TEntidade, constructor>(AWhere: String = ''; AOrdem: String = ''): TObjectList<T>;
    function Consulta<T: TEntidade>(AWhere: TStringList = nil; const AOrdenacao: string = ''): TDataSet;
    function Deletar<T: TEntidade>(AListaIDs: String): Boolean;
    function ObtemPropriedade<T: TEntidade>(ACampo: CampoAttribute): TRttiProperty;
    function RetornaEntidade<T: TEntidade, constructor>(ADataSet: TDataSet): T;
    function Salvar<T: TEntidade>(AEntidade: T): Boolean;

    procedure CarregarTabela<T: TEntidade>;
  end;

  TDAO<T: TEntidade, constructor> = class abstract(TDAOBancoDados)
  public
    constructor Create; override;

    function Abrir(AID: Integer): T; virtual;
    function AbrirLista(AWhere: String = ''; AOrdem: String = ''): TObjectList<T>; virtual;
    function Consulta(AWhere: TStringList; AOrdenacao: string): TDataSet; virtual;
    function Deletar(AListaIDs: String): Boolean; virtual;
    function Salvar(AEntidade: T): Boolean; virtual;
    function RetornaEntidade(ADataSet: TDataSet): T; virtual;
  end;

implementation

uses
  System.Types, uRTTIUtils;

function TDAOBancoDados.ObtemPropriedade<T>(ACampo: CampoAttribute):
    TRttiProperty;
var
  vContextoRTTI: TRttiContext;
  vClasseRTTI: TRttiType;
begin
  Result := nil;
  vContextoRTTI := TRttiContext.Create;
  try
    vClasseRTTI := vContextoRTTI.GetType(T.ClassInfo);

    Result := vClasseRTTI.ObtemProperty(ACampo);
  finally
    vContextoRTTI.Free;
  end;
end;

procedure TDAOBancoDados.CarregarTabela<T>;
var
  vPropriedade: TRttiProperty;
  vAtributo: TCustomAttribute;
  vClasse: TRttiType;
  vContexto: TRttiContext;
  vTabelaExterna: TTabelaJoin;
begin
  FTabela.Free;
  FTabela := TTabela.Create;

  FTabelasExternas.Clear;

  vContexto := TRttiContext.Create;
  try
    vClasse := vContexto.GetType(T.ClassInfo);
    for vAtributo in vClasse.GetAttributes do
    begin
      if vAtributo is TabelaAttribute then
      begin
        FTabela.Tabela := (vAtributo as TabelaAttribute).Nome;
      end;

      if vAtributo is GeneratorAttribute then
      begin
        FTabela.Generator := (vAtributo as GeneratorAttribute).Nome;
      end;
    end;

    for vPropriedade in vClasse.GetProperties do
    begin
      for vAtributo in vPropriedade.GetAttributes do
      begin
        if vAtributo is CampoChavePrimariaAttribute then
        begin
          FTabela.ChavePrimaria := (vAtributo as CampoChavePrimariaAttribute).Nome;
          FTabela.PropertyCampo :=  vAtributo as CampoChavePrimariaAttribute;
        end
        else if vAtributo is CampoAttribute then
        begin
          FTabela.Campos.Add((vAtributo as CampoAttribute).Nome);

        end
        else if vAtributo is CampoExternoAttribute then
        begin
          vTabelaExterna := TTabelaJoin.Create;
          vTabelaExterna.Campos.Add((vAtributo as CampoExternoAttribute).Campo + ' AS ' + (vAtributo as CampoExternoAttribute).Nome);
          vTabelaExterna.Tabela := (vAtributo as CampoExternoAttribute).Tabela;
          vTabelaExterna.ChavePrimaria := (vAtributo as CampoExternoAttribute).ChavePK;
          vTabelaExterna.ChaveEstrangeira := (vAtributo as CampoExternoAttribute).ChaveFK;
          vTabelaExterna.RelacoesSQL := (vAtributo as CampoExternoAttribute).RelacaoSQL;

          FTabelasExternas.Add(vTabelaExterna);
        end;
      end;
    end;
  finally
    vContexto.Free;
  end;
end;

function TDAOBancoDados.Abrir<T>(AID: Integer): T;
var
  vQuery: TFDQuery;
  vCampo: String;
const
  cVirgula = ',';
begin
  Result := nil;
  try
    vQuery := CriaQuery;
    vQuery.SQL.Add('SELECT FIRST 1');
    vQuery.SQL.Add(FTabela.ChavePrimaria + ',');

    for vCampo in FTabela.Campos do
    begin
      vQuery.SQL.Add(vCampo + cVirgula);
    end;

    vQuery.SQL.Add('0 AS DESCONSIDERAR');
    vQuery.SQL.Add('FROM');
    vQuery.SQL.Add('  "' + FTabela.Tabela + '"');
    vQuery.SQL.Add('WHERE');
    vQuery.SQL.Add('  ' + FTabela.ChavePrimaria + ' = ' + IntToStr(AID));
    vQuery.Open;

    if not vQuery.IsEmpty then
    begin
      Result := RetornaEntidade<T>(vQuery);
    end;
  finally
    vQuery.Free;
    FTabela.Free;
  end;
end;

function TDAOBancoDados.AbrirLista<T>(AWhere: String = ''; AOrdem: String = ''): TObjectList<T>;
var
  vQuery: TFDQuery;
  vCampo: String;
  vTabelaJoin: TTabelaJoin;
const
  cVirgula = ',';
begin
  Result := TObjectList<T>.Create(True);
  try
    vQuery := CriaQuery;
    vQuery.SQL.Add('SELECT');
    vQuery.SQL.Add(FTabela.ChavePrimaria + ',');

    for vCampo in FTabela.Campos do
    begin
      vQuery.SQL.Add(vCampo + cVirgula);
    end;

    for vTabelaJoin in FTabelasExternas do
    begin
      vQuery.SQL.Add('  '+vTabelaJoin.Tabela+cVirgula);
    end;

    vQuery.SQL.Add('0 AS DESCONSIDERAR');
    vQuery.SQL.Add('FROM');
    vQuery.SQL.Add('  "' + FTabela.Tabela + '"');

    for vTabelaJoin in FTabelasExternas do
    begin
      case vTabelaJoin.RelacoesSQL of
        csLeftJoin: vQuery.SQL.Add('LEFT JOIN');
        csInnerJoin: vQuery.SQL.Add('INNER JOIN');
      else
        raise Exception.Create('Tipo de Conjunção não implementada!');
      end;

      vQuery.SQL.Add('  '+vTabelaJoin.Tabela+' ON '+vTabelaJoin.Tabela+'.'+vTabelaJoin.ChaveEstrangeira+' = '+FTabela.Tabela+'.'+FTabela.ChavePrimaria);
    end;

    if not AWhere.IsEmpty then
    begin
      vQuery.SQL.Add('WHERE');
      vQuery.SQL.Add(AWhere);
    end;

    if not AOrdem.IsEmpty then
    begin
      vQuery.SQL.Add('ORDER BY');
      vQuery.SQL.Add(AOrdem);
    end;

    vQuery.Open;

    while not vQuery.Eof do
    begin
      Result.Add(RetornaEntidade<T>(vQuery));

      vQuery.Next;
    end;
  finally
    vQuery.Free;
  end;
end;

function TDAOBancoDados.Consulta<T>(AWhere: TStringList = nil;
    const AOrdenacao: string = ''): TDataSet;
var
  vQuery: TFDQuery;
  vCampo: String;
  vTabelaJoin: TTabelaJoin;
const
  cVirgula = ',';
begin
  Result := nil;
  try
    vQuery := CriaQuery;
    vQuery.SQL.Add('SELECT');

    if FTabela.Campos.Count > 0 then
    begin
      vQuery.SQL.Add('  '+FTabela.Tabela +'.'+ FTabela.ChavePrimaria + ',');
    end
    else
    begin
      vQuery.SQL.Add('  '+FTabela.Tabela +'.'+ FTabela.ChavePrimaria);
    end;

    for vCampo in FTabela.Campos do
    begin
      vQuery.SQL.Add('  '+FTabela.Tabela+'.'+vCampo+cVirgula);
    end;

    for vTabelaJoin in FTabelasExternas do
    begin
      vQuery.SQL.Add('  '+vTabelaJoin.Tabela+'.'+vTabelaJoin.Campos[0]+cVirgula);
    end;

    vQuery.SQL.Add('  NULL AS DESCONSIDERAR');
    vQuery.SQL.Add('FROM');
    vQuery.SQL.Add('  "' + FTabela.Tabela + '"');

    for vTabelaJoin in FTabelasExternas do
    begin
      case vTabelaJoin.RelacoesSQL of
        csLeftJoin: vQuery.SQL.Add('LEFT JOIN');
        csInnerJoin: vQuery.SQL.Add('INNER JOIN');
      else
        raise Exception.Create('Tipo de Conjunção não implementada!');
      end;

      vQuery.SQL.Add('  '+vTabelaJoin.Tabela+' ON '+vTabelaJoin.Tabela+'.'+vTabelaJoin.ChavePrimaria+' = '+FTabela.Tabela+'.'+vTabelaJoin.ChaveEstrangeira);
    end;

    if Assigned(AWhere) then
    begin
      vQuery.SQL.Add('WHERE');
      vQuery.SQL.AddStrings(AWhere);
    end;

    if not AOrdenacao.IsEmpty then
    begin
      vQuery.SQL.Add('ORDER BY');
      vQuery.SQL.Add('  '+AOrdenacao);
    end;

    vQuery.Open;

    Result := vQuery;
  except
    vQuery.DisposeOf;
  end;
end;

constructor TDAOBancoDados.Create;
begin
  inherited;
  FTabelasExternas := TList<TTabelaJoin>.Create;
end;

function TDAOBancoDados.Deletar<T>(AListaIDs: String): Boolean;
var
  vQuery: TFDQuery;
begin
  Result := False;
  try
    vQuery  := CriaQuery;
    try
      vQuery.SQL.Add('DELETE FROM ' + FTabela.Tabela + ' WHERE ' + FTabela.ChavePrimaria + ' IN (' + AListaIDs + ')');
      vQuery.ExecSQL();
      Result := True;
    except
      Result := False;
    end;
  finally
    vQuery.DisposeOf;
  end;
end;

function TDAOBancoDados.RetornaEntidade<T>(ADataSet: TDataSet): T;
var
  vObjeto: TObject;
  vValor: TValue;
  vClasse: TRttiType;
  vAtributo: TCustomAttribute;
  vContexto: TRttiContext;
  vPropriedade: TRttiProperty;
  vDataSetField: TField;
begin
  vObjeto := T.Create;
  vContexto := TRttiContext.Create;
  try
    vClasse := vContexto.GetType(T.ClassInfo);
    for vPropriedade in vClasse.GetProperties do
    begin
      vDataSetField := nil;

      for vAtributo in vPropriedade.GetAttributes do
      begin
        if vAtributo is CampoChavePrimariaAttribute then
        begin
          vDataSetField := ADataSet.FindField((vAtributo as CampoChavePrimariaAttribute).Nome);
          Break;
        end
        else if vAtributo is CampoAttribute then
        begin
          vDataSetField := ADataSet.FindField((vAtributo as CampoAttribute).Nome);
          Break;
        end;
      end;

      if Assigned(vDataSetField) then
      begin
        case vPropriedade.PropertyType.TypeKind of
          tkInteger:
          begin
            vValor := vDataSetField.AsInteger;
          end;

          tkInt64:
          begin
            vValor := vDataSetField.AsLargeInt;
          end;

          tkFloat:
          begin
            vValor := vDataSetField.AsFloat;
          end;

          tkString, tkUString, tkWChar, tkLString, tkWString, tkClass:
          begin
            vValor := vDataSetField.AsString;
          end;

          tkEnumeration:
          begin
            vValor := vDataSetField.AsBoolean;
          end;
        else
          Continue;
        end;        
        vPropriedade.SetValue(vObjeto, vValor);
      end;
    end;
  finally
    vContexto.Free;
  end;
  Result := T(vObjeto);
end;

function TDAOBancoDados.Salvar<T>(AEntidade: T): Boolean;
var
  vInd: Integer;
  vCampo, vValor: String;
  vQuery: TFDQuery;
  vSQLCampos, vSQLValores: TStringList;

  vClasse  : TRttiType;
  vProperty: TRttiProperty;
  vContexto: TRttiContext;
  vAtributo: TCustomAttribute;
  vChavePrimaria: TRttiProperty;
begin
  vQuery := CriaQuery;
  try
    vSQLCampos  := TStringList.Create;
    vSQLValores := TStringList.Create;

    vContexto := TRttiContext.Create;
    vClasse   := vContexto.GetType(T.ClassInfo);

    for vInd := 0 to Length(vClasse.GetProperties) - 1 do
    begin
      vCampo := EmptyStr;
      vValor := EmptyStr;

      vProperty := vClasse.GetProperties[vInd];
      for vAtributo in vProperty.GetAttributes do
      begin
        if vAtributo is CampoChavePrimariaAttribute then
        begin
          vCampo := (vAtributo as CampoChavePrimariaAttribute).Nome;
          vValor := AEntidade.RetornaValorSQL(vProperty);

          if (vValor = 'NULL') and not FTabela.Generator.IsEmpty then
          begin
            vValor := 'GEN_ID(' + FTabela.Generator + ', 1)';
          end;

          Break;
        end
        else if vAtributo is CampoChaveEstrangeiraAttribute then
        begin
          vCampo := (vAtributo as CampoAttribute).Nome;
          vValor := AEntidade.RetornaValorSQL(vProperty);
        end
        else if vAtributo is CampoAttribute then
        begin
          vCampo := (vAtributo as CampoAttribute).Nome;
          vValor := AEntidade.RetornaValorSQL(vProperty);
          Break;
        end;
      end;

      if not vCampo.IsEmpty and not vValor.IsEmpty and (vValor <> 'NULL') then
      begin
        if (Length(vClasse.GetProperties) - 1) > vInd then
        begin
          vCampo := vCampo + ',';
          vValor := vValor + ',';
        end;

        vSQLCampos.Add(vCampo);
        vSQLValores.Add(vValor);
      end;
    end;

    vChavePrimaria := ObtemPropriedade<T>(FTabela.propertyCampo);

    if (vSQLCampos.Count > -1) and (vSQLCampos.Count > -1) then
    begin
      vSQLCampos.Strings[vSQLCampos.Count-1] := StringReplace(vSQLCampos.Strings[vSQLCampos.Count-1], ',', EmptyStr, []);
      vSQLValores.Strings[vSQLValores.Count-1] := StringReplace(vSQLValores.Strings[vSQLValores.Count-1], ',', EmptyStr, []);

      if vChavePrimaria.GetValue(TEntidade(AEntidade)).AsInteger > 0  then
      begin
        vQuery.SQL.Add('UPDATE ' + FTabela.Tabela);
        vQuery.SQL.Add('SET');

        for vInd := 0 to Pred(vSQLCampos.Count) do
        begin
          if (StringReplace(vSQLCampos.Strings[vInd], ',', EmptyStr, []) <> FTabela.ChavePrimaria) then
          begin
            vQuery.SQL.Add(StringReplace(vSQLCampos.Strings[vInd], ',', EmptyStr, []) + ' = ' + vSQLValores.Strings[vInd]);
          end;
        end;

        vQuery.SQL.Add('WHERE');
        vQuery.SQL.Add('  '+FTabela.ChavePrimaria+' = '+IntToStr(vChavePrimaria.GetValue(TEntidade(AEntidade)).AsInteger));
      end
      else
      begin
        vQuery.SQL.Add('INSERT INTO ' + FTabela.Tabela);
        vQuery.SQL.Add('(');
        vQuery.SQL.AddStrings(vSQLCampos);
        vQuery.SQL.Add(')');
        vQuery.SQL.Add('VALUES');
        vQuery.SQL.Add('(');
        vQuery.SQL.AddStrings(vSQLValores);
        vQuery.SQL.Add(')');;
      end;
    end;
    vQuery.Execute();

    vQuery.SQL.Clear;
    vQuery.SQL.Add('SELECT '+FTabela.ChavePrimaria+' FROM '+FTabela.Tabela+' ORDER BY '+FTabela.ChavePrimaria+' DESC');
    vQuery.Open();

    if not vQuery.Eof and Assigned(vChavePrimaria) then
    begin
      vChavePrimaria.SetValue(TEntidade(AEntidade), vQuery.FieldByName(FTabela.ChavePrimaria).AsInteger);
    end;
    Result := True;
  finally
    vQuery.Free;
    vSQLCampos.Free;
    vSQLValores.Free;
  end;
end;

{ TTabela }

procedure TTabela.AfterConstruction;
begin
  inherited;
  Campos := TList<String>.Create;
  Tabela := EmptyStr;
  Generator := EmptyStr;
  ChavePrimaria := EmptyStr;
  propertyCampo := nil;
end;

procedure TTabela.BeforeDestruction;
begin
  inherited;
  Campos.Free;
end;

{ TDAO }

function TDAO<T>.Abrir(AID: Integer): T;
begin
  Result := inherited Abrir<T>(AID);
end;

function TDAO<T>.AbrirLista(AWhere, AOrdem: String): TObjectList<T>;
begin
  Result := inherited AbrirLista<T>(AWhere, AOrdem);
end;

function TDAO<T>.Consulta(AWhere: TStringList; AOrdenacao: string): TDataSet;
begin
  Result := inherited Consulta<T>(AWhere, AOrdenacao);
end;

constructor TDAO<T>.Create;
begin
  inherited;
  CarregarTabela<T>;
end;

function TDAO<T>.Deletar(AListaIDs: String): Boolean;
begin
  Result := inherited Deletar<T>(AListaIDs);
end;

function TDAO<T>.RetornaEntidade(ADataSet: TDataSet): T;
begin
  Result := inherited RetornaEntidade<T>(ADataSet);
end;

function TDAO<T>.Salvar(AEntidade: T): Boolean;
begin
  Result := inherited Salvar<T>(AEntidade);
end;

end.
