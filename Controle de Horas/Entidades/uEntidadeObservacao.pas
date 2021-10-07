unit uEntidadeObservacao;

interface

uses
  uEntidade, uAtributosTabelas;

type
  [Tabela('OBSERVACOES')]
  TEntidadeObservacao = class(TEntidade)
  private
    FDescricao: string;
    FDataInclusao: TDateTime;
    FID: Integer;
    FDataAlteracao: TDateTime;
  public
    [CampoChavePrimaria('ID')]
    property ID: Integer read FID write FID;

    [Campo('DESCRICAO')]
    property Descricao: string read FDescricao write FDescricao;

    [Campo('DATA_INCLUSAO')]
    property DataInclusao: TDateTime read FDataInclusao write FDataInclusao;

    [Campo('DATA_ALTERACAO')]
    property DataAlteracao: TDateTime read FDataAlteracao write FDataAlteracao;
  end;

implementation

end.
