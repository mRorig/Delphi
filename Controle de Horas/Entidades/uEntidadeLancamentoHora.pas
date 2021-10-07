unit uEntidadeLancamentoHora;

interface

uses
  uEntidade, uAtributosTabelas;

type
  [Tabela('LANCAMENTOS_HORAS')]
  TEntidadeLancamentoHora = class(TEntidade)
  private
    FID: Integer;
    FTipoID: Integer;
    FObservacaoID: Integer;
    FMotivoID: Integer;
    FHoraTermino: string;
    FHoraInicio: string;
    FData: TDate;
    FDescricaoMotivo: string;
    FDescricaoTipo: string;
    FDescricaoObservacao: string;
    FDescricaoSetor: string;
    FSetorID: Integer;
  public
    [CampoChavePrimaria('ID')]
    property ID: Integer read FID write FID;

    [CampoChaveEstrangeira('SETOR_ID')]
    property SetorID: Integer read FSetorID write FSetorID;

    [CampoChaveEstrangeira('TIPO_ID')]
    property TipoID: Integer read FTipoID write FTipoID;

    [CampoChaveEstrangeira('MOTIVO_ID')]
    property MotivoID: Integer read FMotivoID write FMotivoID;

    [CampoChaveEstrangeira('OBSERVACAO_ID')]
    property ObservacaoID: Integer read FObservacaoID write FObservacaoID;

    [Campo('HORA_INICIO')]
    property HoraInicio: string read FHoraInicio write FHoraInicio;

    [Campo('HORA_TERMINO')]
    property HoraTermino: string read FHoraTermino write FHoraTermino;

    [Campo('DATA')]
    property Data: TDate read FData write FData;

    [CampoExterno('DESCRICAO_SETOR', 'SETORES', 'ID', 'SETOR_ID', 'DESCRICAO', csLeftJoin)]
    property DescricaoSetor: string read FDescricaoSetor write FDescricaoSetor;

    [CampoExterno('DESCRICAO_TIPO', 'TIPOS', 'ID', 'TIPO_ID', 'DESCRICAO', csLeftJoin)]
    property DescricaoTipo: string read FDescricaoTipo write FDescricaoTipo;

    [CampoExterno('DESCRICAO_MOTIVO', 'MOTIVOS', 'ID', 'MOTIVO_ID', 'DESCRICAO', csLeftJoin)]
    property DescricaoMotivo: string read FDescricaoMotivo write FDescricaoMotivo;

    [CampoExterno('DESCRICAO_OBSERVACAO', 'OBSERVACOES', 'ID', 'OBSERVACAO_ID', 'DESCRICAO', csLeftJoin)]
    property DescricaoObservacao: string read FDescricaoObservacao write FDescricaoObservacao;
  end;

implementation

end.
