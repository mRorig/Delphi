unit uDataModuleFormPrincipal;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.DApt;

type
  TDataModuleFormPrincipal = class(TDataModule)
    FDQueryAuxiliar: TFDQuery;
    DataSourceAuxiliar: TDataSource;
    FDQueryAuxiliarDESCRICAO_TIPO: TStringField;
    FDQueryAuxiliarDESCRICAO_MOTIVO: TStringField;
    FDQueryAuxiliarHORA_INICIO: TTimeField;
    FDQueryAuxiliarHORA_TERMINO: TTimeField;
    FDQueryAuxiliarHORAS: TTimeField;
    dsResumo: TDataSource;
    MemTableResumo: TFDMemTable;
    MemTableResumoTIPO: TStringField;
    MemTableResumoMOTIVO: TStringField;
    MemTableResumoHORAS: TStringField;
    FDQueryAuxiliarDESCRICAO_OBSERVACAO: TStringField;
    FDQueryAuxiliarDATA: TDateField;
    MemTableResumoOBSERVACAO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDQueryAuxiliarAfterOpen(DataSet: TDataSet);
    procedure FDQueryAuxiliarCalcFields(DataSet: TDataSet);
  public
    procedure LimparTudo;
  end;

var
  DataModuleFormPrincipal: TDataModuleFormPrincipal;

implementation

uses
  System.Variants, uHoraUtils, uConexao;

{$R *.dfm}

procedure TDataModuleFormPrincipal.DataModuleCreate(Sender: TObject);
begin
  FDQueryAuxiliar.Close();
  FDQueryAuxiliar.Connection := vgConexao;
end;

procedure TDataModuleFormPrincipal.LimparTudo;
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := vgConexao;

    vQuery.Close;
    vQuery.SQL.Clear;
    vQuery.SQL.Add('DELETE FROM LANCAMENTOS_HORAS');
    vQuery.ExecSQL;

    vQuery.Close;
    vQuery.SQL.Clear;
    vQuery.SQL.Add('DELETE FROM TIPOS');
    vQuery.ExecSQL;

    vQuery.Close;
    vQuery.SQL.Clear;
    vQuery.SQL.Add('DELETE FROM MOTIVOS');
    vQuery.ExecSQL;

    vQuery.Close;
    vQuery.SQL.Clear;
    vQuery.SQL.Add('DELETE FROM OBSERVACOES');
    vQuery.ExecSQL;

    vQuery.Close;
    vQuery.SQL.Clear;
    vQuery.SQL.Add('DELETE FROM SETORES');
    vQuery.ExecSQL;
  finally
    vQuery.Free;
  end;
end;

procedure TDataModuleFormPrincipal.FDQueryAuxiliarAfterOpen(DataSet: TDataSet);
begin
  MemTableResumo.Close;
  MemTableResumo.Open;

  FDQueryAuxiliar.First;
  while not FDQueryAuxiliar.Eof do
  begin
    MemTableResumo.First;
    if MemTableResumo.Locate('TIPO;MOTIVO', VarArrayOf([FDQueryAuxiliar.FieldByName('DESCRICAO_TIPO').AsString, FDQueryAuxiliar.FieldByName('DESCRICAO_MOTIVO').AsString]), []) then
    begin
      MemTableResumo.Edit;

      MemTableResumo.FieldByName('HORAS').AsString := THoraUtils.SomaHoras(MemTableResumo.FieldByName('HORAS').AsString,
                                                                           FDQueryAuxiliar.FieldByName('HORAS').AsString);
    end
    else
    begin
      MemTableResumo.Insert;
      MemTableResumo.FieldByName('TIPO').AsString := FDQueryAuxiliar.FieldByName('DESCRICAO_TIPO').AsString;
      MemTableResumo.FieldByName('MOTIVO').AsString := FDQueryAuxiliar.FieldByName('DESCRICAO_MOTIVO').AsString;
      MemTableResumo.FieldByName('HORAS').AsString := TimeToStr(FDQueryAuxiliar.FieldByName('HORAS').AsDateTime);
      MemTableResumo.FieldByName('OBSERVACAO').AsString := FDQueryAuxiliar.FieldByName('DESCRICAO_OBSERVACAO').AsString;
    end;
    MemTableResumo.Post;

    FDQueryAuxiliar.Next;
  end;
end;

procedure TDataModuleFormPrincipal.FDQueryAuxiliarCalcFields(DataSet: TDataSet);
var
  vHoras: TTime;
begin
  vHoras := FDQueryAuxiliar.FieldByName('HORA_TERMINO').AsDateTime - FDQueryAuxiliar.FieldByName('HORA_INICIO').AsDateTime;
  if vHoras > 0 then
  begin
    FDQueryAuxiliar.FieldByName('HORAS').AsDateTime := vHoras;
  end;
end;

end.
