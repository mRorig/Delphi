unit uAtributosTabelas;

interface

uses
  System.SysUtils;

type
  TOperadorSQL  = (osAND, osOR);
  TRelacaoSQL = (csInnerJoin, csLeftJoin);

  TConstantesSQL = class
  private
  public
    class function RetornaValorOperadorSQL(AOperador: TOperadorSQL): String;
    class function RetornaValorConjuncaoSQL(AConjuncao: TRelacaoSQL): String;
  end;

  TabelaAttribute = class(TCustomAttribute)
  private
    FNome: String;
  public
    constructor Create(ANome: String);

    property Nome: String read FNome;
  end;

  GeneratorAttribute = class(TCustomAttribute)
  private
    FNome: String;
  public
    constructor Create(ANome: String);

    property Nome: String read FNome;
  end;

  CampoAttribute = class(TCustomAttribute)
  private
    FNome: String;
  public
    constructor Create(ANome: String);

    property Nome: String read FNome;
  end;

  CampoChavePrimariaAttribute = class(CampoAttribute);
  CampoChaveEstrangeiraAttribute = class(CampoAttribute);

  CampoExternoAttribute = class(TCustomAttribute)
  private
    FNome: String;
    FTabela: String;
    FChaveFK: String;
    FChavePK: String;
    FRelacaoSQL: TRelacaoSQL;
    FCampo: string;
  public
    constructor Create(ANome, ATabela, AChavePK, AChaveFK, ACampoExibir: String; AConjuncao: TRelacaoSQL);

    property Nome: String read FNome;
    property Tabela: String read FTabela;
    property ChaveFK: String read FChaveFK;
    property ChavePK: String read FChavePK;
    property RelacaoSQL: TRelacaoSQL read FRelacaoSQL;
    property Campo: string read FCampo;
  end;

implementation

{ TabelaAttribute }

constructor TabelaAttribute.Create(ANome: String);
begin
  FNome := ANome;
end;

{ GeneratorAttribute }

constructor GeneratorAttribute.Create(ANome: String);
begin
  FNome := ANome;
end;

{ CampoAttribute }

constructor CampoAttribute.Create(ANome: String);
begin
  FNome := ANome;
end;

{ TConstantesOperador }

class function TConstantesSQL.RetornaValorOperadorSQL(AOperador: TOperadorSQL): String;
begin
  Result := EmptyStr;
  case AOperador of
    osAND: Result := ' AND ';
    osOR:  Result := ' OR ';
  end;
end;

class function TConstantesSQL.RetornaValorConjuncaoSQL(AConjuncao: TRelacaoSQL): String;
begin
  Result := EmptyStr;
  case AConjuncao of
    csInnerJoin: Result := ' INNER JOIN ';
    csLeftJoin:  Result := ' LEFT JOIN ';
  end;
end;

{ CampoExternoAttribute }

constructor CampoExternoAttribute.Create(ANome, ATabela, AChavePK, AChaveFK, ACampoExibir: String; AConjuncao: TRelacaoSQL);
begin
  FNome := ANome;
  FTabela := ATabela;
  FRelacaoSQL := AConjuncao;
  FChavePK := AChavePK;
  FChaveFK := AChaveFK;
  FCampo := ACampoExibir;
end;

end.
