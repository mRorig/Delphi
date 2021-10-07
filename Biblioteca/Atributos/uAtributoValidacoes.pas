unit uAtributoValidacoes;

interface

uses
  System.Classes, System.Generics.Collections, System.Rtti, System.SysUtils, System.TypInfo;

type
  TValidacaoSeveridade = (vsAlerta, vsErro);
  TValidacoesAttribute = class abstract(TCustomAttribute);

  ValidacaoAttribute = class abstract(TValidacoesAttribute)
  private
    FMensagem: String;
    FSeveridade: TValidacaoSeveridade;
  public
    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; virtual; abstract;

    property Severidade: TValidacaoSeveridade read FSeveridade;
    property Mensagem: String read FMensagem;
  end;

  ValidaNaoVazioAttribute = class(ValidacaoAttribute)
  public
    constructor Create; overload;
    constructor Create(ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;

    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;
  end;

  ValidaSomenteNumerosAttribute = class(ValidacaoAttribute)
  public
    constructor Create; overload;
    constructor Create(ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;

    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;
  end;

  ValidaSomenteLetrasAttribute = class(ValidacaoAttribute)
  public
    constructor Create; overload;
    constructor Create(ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;

    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;
  end;

  ValidaSomenteAlfanumericoAttribute = class(ValidacaoAttribute)
  public
    constructor Create; overload;
    constructor Create(ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;
    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;
  end;

  ValidaTamanhoMinimoAttribute = class(ValidacaoAttribute)
  private
    FTamanhoMinimo: Integer;
  public
    constructor Create(ATamanhoMinimo: Integer); overload;
    constructor Create(ATamanhoMinimo: Integer; ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;
    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;
    property TamanhoMinimo: Integer read FTamanhoMinimo;
  end;

  ValidaTamanhoMaximoAttribute = class(ValidacaoAttribute)
  private
    FTamanhoMaximo: Integer;
  public
    constructor Create(ATamanhoMaximo: Integer); overload;
    constructor Create(ATamanhoMaximo: Integer; ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;

    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;

    property TamanhoMaximo: Integer read FTamanhoMaximo;
  end;

  ValidaValorMinimoAttribute = class(ValidacaoAttribute)
  private
    FMinimo: Double;
  public
    constructor Create(AMinimo: Double); overload;
    constructor Create(AMinimo: Double; ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;

    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;

    property Minimo: Double read FMinimo;
  end;

  ValidaValorMaximoAttribute = class(ValidacaoAttribute)
  private
    FMaximo: Double;
  public
    constructor Create(AMaximo: Double); overload;
    constructor Create(AMaximo: Double; ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;

    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;

    property Maximo: Double read FMaximo;
  end;

  ValidaFaixaDeValorAttribute = class(ValidacaoAttribute)
  private
    FMinimo: Double;
    FMaximo: Double;
  public
    constructor Create(AMinimo: Double; AMaximo: Double); overload;
    constructor Create(AMinimo: Double; AMaximo: Double; ASeveridade: TValidacaoSeveridade; AMensagem: String); overload;

    function Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean; override;

    property Minimo: Double read FMinimo;
    property Maximo: Double read FMaximo;
  end;

  CaptionAttribute = class(TValidacoesAttribute)
  private
    FSingular: String;
    FPlural  : String;
  public
    constructor Create(ANome: String); overload;
    constructor Create(ASingular, APlural: String); overload;

    property Singular: String read FSingular;
    property Plural  : String read FPlural;
  end;

implementation

uses
  uUtils;

{ ValidaNaoVazioAttribute }

constructor ValidaNaoVazioAttribute.Create;
begin
  FSeveridade := vsErro;
  FMensagem := '%s não pode ficar vazio.';
end;

constructor ValidaNaoVazioAttribute.Create(ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
end;

function ValidaNaoVazioAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor    : TValue;
  vMetodo   : TRttiMethod;
  vInterface: IEnumerable;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      // Não implementado
//      tkInterface:
//        begin
//          if Supports(vValor.AsInterface, IEnumerable, vInterface) then
//          begin
//            Result := not vInterface.IsEmpty;
//          end;
//        end;

      tkEnumeration, tkInt64, tkInteger, tkFloat:
        begin
          Result := vValor.AsExtended <> 0;
        end;

      tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
        begin
          Result := not vValor.AsString.IsEmpty;
        end;

      tkRecord:
        begin
//          if vValor.IsType<Booleano> then
//            Result := vValor.AsType<Booleano>.ToBoolean
//          else if vValor.IsType<Numerico> then
//            Result := not vValor.AsType<Numerico>.Vazio
//          else if vValor.IsType<DataHora> then
//            Result := not vValor.AsType<DataHora>.Vazio
//          else if vValor.IsType<Texto> then
//            Result := not vValor.AsType<Texto>.Vazio
//          else if String(vValor.TypeInfo.Name).StartsWith('Enumerado<') then
//          begin
//            vMetodo := APropriedade.PropertyType.GetMethod('Vazio');
//            if Assigned(vMetodo) then
//            begin
//              vValor := vMetodo.Invoke(vValor, []);
//              if not vValor.IsEmpty then
//              begin
//                Result := not vValor.AsBoolean;
//              end;
//            end;
//          end;
        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaSomenteNumerosAttribute }

constructor ValidaSomenteNumerosAttribute.Create;
begin
  FSeveridade := vsErro;
  FMensagem := '%s deve conter somente números.';
end;

constructor ValidaSomenteNumerosAttribute.Create(ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
end;

function ValidaSomenteNumerosAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
        begin

          Result := TUtils.SomenteNumeros(vValor.AsString);
        end;

      tkRecord:
//        if (vValor.IsType<Texto>) then
//        begin
//          Result := TUtils.SomenteNumeros(vValor.AsType<Texto>.ToString);
//        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaSomenteLetrasAttribute }

constructor ValidaSomenteLetrasAttribute.Create;
begin
  FSeveridade := vsErro;
  FMensagem := '%s deve conter somente letras.';
end;

constructor ValidaSomenteLetrasAttribute.Create(ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
end;

function ValidaSomenteLetrasAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
        begin
          Result := TUtils.SomenteLetras(vValor.AsString);
        end;

//      tkRecord:
//        if (vValor.IsType<Texto>) then
//        begin
//          Result := TUtils.SomenteLetras(vValor.AsType<Texto>.ToString);
//        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaSomenteAlfanumericoAttribute }

constructor ValidaSomenteAlfanumericoAttribute.Create;
begin
  FSeveridade := vsErro;
  FMensagem := '%s deve conter somente letras e/ou números.';
end;

constructor ValidaSomenteAlfanumericoAttribute.Create(ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
end;

function ValidaSomenteAlfanumericoAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
        begin
          Result := TUtils.SomenteAlfaNumericos(vValor.AsString);
        end;

//      tkRecord:
//        if (vValor.IsType<Texto>) then
//        begin
//          Result := TUtils.SomenteAlfaNumericos(vValor.AsType<Texto>.ToString);
//        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaTamanhoMinimoAttribute }

constructor ValidaTamanhoMinimoAttribute.Create(ATamanhoMinimo: Integer);
begin
  FTamanhoMinimo := ATamanhoMinimo;
  FSeveridade := vsErro;
  FMensagem := '%s deve conter no mínimo %d caracteres.';
end;

constructor ValidaTamanhoMinimoAttribute.Create(ATamanhoMinimo: Integer; ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FTamanhoMinimo := ATamanhoMinimo;
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
end;

function ValidaTamanhoMinimoAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
        begin
          Result := Length(vValor.AsString) >= Self.TamanhoMinimo;
        end;

//      tkRecord:
//        if (vValor.IsType<Texto>) then
//        begin
//          Result := vValor.AsType<Texto>.PossuiTamanhoMinimo(Self.TamanhoMinimo);
//        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaTamanhoMaximoAttribute }

constructor ValidaTamanhoMaximoAttribute.Create(ATamanhoMaximo: Integer);
begin
  FTamanhoMaximo := ATamanhoMaximo;
  FSeveridade := vsErro;
  FMensagem := '%s deve conter no máximo %d caracteres.';
end;

constructor ValidaTamanhoMaximoAttribute.Create(ATamanhoMaximo: Integer; ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FTamanhoMaximo := ATamanhoMaximo;
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
end;

function ValidaTamanhoMaximoAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkChar, tkString, tkWChar, tkLString, tkWString, tkUString:
        begin
          Result := Length(vValor.AsString) <= Self.TamanhoMaximo;
        end;

//      tkRecord:
//        if (vValor.IsType<Texto>) then
//        begin
//          Result := vValor.AsType<Texto>.Tamanho <= Self.TamanhoMaximo;
//        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaValorMinimoAttribute }

constructor ValidaValorMinimoAttribute.Create(AMinimo: Double);
begin
  FSeveridade := vsErro;
  FMensagem := '%s deve conter valor maior ou igual a %s.';
  FMinimo := AMinimo;
end;

constructor ValidaValorMinimoAttribute.Create(AMinimo: Double; ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
  FMinimo := AMinimo;
end;

function ValidaValorMinimoAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkEnumeration, tkInt64, tkInteger, tkFloat:
        begin
          Result := vValor.AsExtended >= Self.Minimo;
        end;

//      tkRecord:
//        if (vValor.IsType<Numerico>) then
//        begin
//          Result := vValor.AsType<Numerico> >= Self.Minimo;
//        end
//        else if (vValor.IsType<DataHora>) then
//        begin
//          Result := vValor.AsType<DataHora> >= Self.Minimo;
//        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaValorMaximoAttribute }

constructor ValidaValorMaximoAttribute.Create(AMaximo: Double);
begin
  FSeveridade := vsErro;
  FMensagem := '%s deve conter valor menor ou igual a %s.';
  FMaximo := AMaximo;
end;

constructor ValidaValorMaximoAttribute.Create(AMaximo: Double; ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
  FMaximo := AMaximo;
end;

function ValidaValorMaximoAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkEnumeration, tkInt64, tkInteger, tkFloat:
        begin
          Result := vValor.AsExtended >= Self.Maximo;
        end;

//      tkRecord:
//        if (vValor.IsType<Numerico>) then
//        begin
//          Result := vValor.AsType<Numerico> <= Self.Maximo;
//        end
//        else if (vValor.IsType<DataHora>) then
//        begin
//          Result := vValor.AsType<DataHora> <= Self.Maximo;
//        end;
    else
      Result := False;
    end;
  end;
end;

{ ValidaFaixaDeValorAttribute }

constructor ValidaFaixaDeValorAttribute.Create(AMinimo, AMaximo: Double);
begin
  FSeveridade := vsErro;
  FMensagem := '%s deve conter valor entre %s e %s.';
  FMinimo := AMinimo;
  FMaximo := AMaximo;
end;

constructor ValidaFaixaDeValorAttribute.Create(AMinimo, AMaximo: Double; ASeveridade: TValidacaoSeveridade; AMensagem: String);
begin
  FSeveridade := ASeveridade;
  FMensagem := AMensagem;
  FMinimo := AMinimo;
  FMaximo := AMaximo;
end;

function ValidaFaixaDeValorAttribute.Validar(AEntidade: TObject; APropriedade: TRttiProperty): Boolean;
var
  vValor: TValue;
begin
  vValor := APropriedade.GetValue(AEntidade);
  Result := not vValor.IsEmpty;
  if Result then
  begin
    case APropriedade.PropertyType.TypeKind of
      tkEnumeration, tkInt64, tkInteger, tkFloat:
        begin
          Result := (vValor.AsExtended >= Self.Minimo) and (vValor.AsExtended <= Self.Maximo);
        end;

//      tkRecord:
//        if (vValor.IsType<Numerico>) then
//        begin
//          Result := (vValor.AsType<Numerico> >= Self.Minimo) and (vValor.AsType<Numerico> <= Self.Maximo);
//        end
//        else if (vValor.IsType<DataHora>) then
//        begin
//          Result := (vValor.AsType<DataHora> >= Self.Minimo) and (vValor.AsType<DataHora> <= Self.Maximo);
//        end;
    else
      Result := False;
    end;
  end;
end;

{ CaptionAttribute }

constructor CaptionAttribute.Create(ANome: String);
begin
  FSingular := ANome;
end;

constructor CaptionAttribute.Create(ASingular, APlural: String);
begin
  FSingular := ASingular;
  FPlural   := APlural;
end;

end.
