object DataModuleFormPrincipal: TDataModuleFormPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 557
  Width = 969
  object FDQueryAuxiliar: TFDQuery
    AfterOpen = FDQueryAuxiliarAfterOpen
    OnCalcFields = FDQueryAuxiliarCalcFields
    SQL.Strings = (
      'SELECT   '
      '    L.DATA, '
      '    T.DESCRICAO AS DESCRICAO_TIPO,'
      '    M.DESCRICAO AS DESCRICAO_MOTIVO,'
      '    L.HORA_INICIO,'
      '    L.HORA_TERMINO,'
      '    O.DESCRICAO AS DESCRICAO_OBSERVACAO'
      'FROM'
      '    LANCAMENTOS_HORAS L'
      'LEFT JOIN'
      '    "TIPOS" T ON T.ID = L.TIPO_ID'
      'LEFT JOIN'
      '    "MOTIVOS" M ON M.ID = L.MOTIVO_ID'
      'LEFT JOIN'
      '    "OBSERVACOES" O ON O.ID = L.OBSERVACAO_ID'
      'WHERE'
      '    L.DATA BETWEEN :DATAINICIO AND :DATATERMINO'
      'AND'
      '    ((L.TIPO_ID = :TIPOID) OR (:TIPOID IS NULL))'
      'AND'
      '    ((L.MOTIVO_ID = :MOTIVOID) OR (:MOTIVOID IS NULL))'
      ''
      '')
    Left = 128
    Top = 80
    ParamData = <
      item
        Name = 'DATAINICIO'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATATERMINO'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TIPOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MOTIVOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryAuxiliarDESCRICAO_TIPO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Tipo'
      DisplayWidth = 25
      FieldName = 'DESCRICAO_TIPO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object FDQueryAuxiliarDESCRICAO_MOTIVO: TStringField
      DisplayLabel = 'Motivo'
      DisplayWidth = 30
      FieldName = 'DESCRICAO_MOTIVO'
      Origin = 'DESCRICAO_MOTIVO'
      Required = True
      Size = 150
    end
    object FDQueryAuxiliarHORA_INICIO: TTimeField
      DisplayLabel = 'In'#237'cio'
      FieldName = 'HORA_INICIO'
      Origin = 'HORA_INICIO'
    end
    object FDQueryAuxiliarHORA_TERMINO: TTimeField
      DisplayLabel = 'T'#233'rmino'
      FieldName = 'HORA_TERMINO'
      Origin = 'HORA_TERMINO'
    end
    object FDQueryAuxiliarHORAS: TTimeField
      DisplayLabel = 'Horas'
      FieldKind = fkCalculated
      FieldName = 'HORAS'
      Calculated = True
    end
    object FDQueryAuxiliarDESCRICAO_OBSERVACAO: TStringField
      FieldName = 'DESCRICAO_OBSERVACAO'
      Size = 1000
    end
    object FDQueryAuxiliarDATA: TDateField
      FieldName = 'DATA'
    end
  end
  object DataSourceAuxiliar: TDataSource
    DataSet = FDQueryAuxiliar
    Left = 128
    Top = 32
  end
  object dsResumo: TDataSource
    DataSet = MemTableResumo
    Left = 218
    Top = 86
  end
  object MemTableResumo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 218
    Top = 38
    object MemTableResumoTIPO: TStringField
      FieldName = 'TIPO'
      Size = 100
    end
    object MemTableResumoMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 1000
    end
    object MemTableResumoHORAS: TStringField
      FieldName = 'HORAS'
    end
    object MemTableResumoOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 300
    end
  end
end
