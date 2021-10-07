unit uEntidadeValidacao;

interface

uses
  uAtributoValidacoes;

type
  TValidacaoErro = class(TObject)
  strict private
    FPropriedade: String;
    FSeveridade: TValidacaoSeveridade;
    FMensagem: String;
  public
    constructor Create(APropriedade: String; AMensagem: String; ASeveridade: TValidacaoSeveridade = vsErro); virtual;
    property Propriedade: String read FPropriedade;
    property Severidade: TValidacaoSeveridade read FSeveridade;
    property Mensagem: String read FMensagem;
  end;

  TValidacaoErros = class(TObject)
  strict private
    FEntidade: TEntidade;
    FErros: IList<TValidacaoErro>;
    procedure OrdenarMensagens(ARetorno: Vetor<TValidacaoErro>);
    procedure ExecutarValidacoesPorAtributos;
    procedure ExecutarValidacoesAdicionais;
  public
    constructor Create(AEntidade: TEntidade);

    function EntidadeValida: Boolean;
    function RetornaErros: TArray<TValidacaoErro>; overload;
    function RetornaErros(APropriedade: String): TArray<TValidacaoErro>; overload;
    function PossuiErros: Boolean; overload;
    function PossuiErros(APropriedade: String): Boolean; overload;
    function PossuiAlertas: Boolean; overload;
    function PossuiAlertas(APropriedade: String): Boolean; overload;
    function RetornaMensagens: String; overload;
    function RetornaMensagens(APropriedade: String): String; overload;
    function RetornaMensagens(ASeveridade: TValidacaoSeveridade): String; overload;

    procedure Adicionar(APropriedade: String; AMensagem: String; ASeveridade: TValidacaoSeveridade);
    procedure AdicionarAlerta(APropriedade: String; AMensagem: String);
    procedure AdicionarErro(APropriedade: String; AMensagem: String);
    procedure Limpar;
  end;

implementation

end.
