unit uFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Data.DB,
  Vcl.ActnList, Vcl.StdActns, System.Classes, System.Actions, System.ImageList,
  Vcl.ImgList, Vcl.Controls, Vcl.Menus, Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Forms,
  uAcaoLancamentosHoras, uAcaoTipos, uAcaoSetores, uAcaoObservacoes, uAcaoMotivos,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormPrincipal = class(TForm)
    TimerHoras: TTimer;
    TrayIcon: TTrayIcon;
    ApplicationEvents: TApplicationEvents;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    Salvarformatotxt: TMenuItem;
    ImageList: TImageList;
    ActionListMenu: TActionList;
    FileSaveAsTxt: TFileSaveAs;
    PanelTopo: TPanel;
    LabelObservacao: TLabel;
    LabelData: TLabel;
    LabelHoraInicio: TLabel;
    LabelHoraTermino: TLabel;
    LabelMotivo: TLabel;
    LabelHoras: TLabel;
    DateTimePickerData: TDateTimePicker;
    MaskEditHora_Inicio: TMaskEdit;
    MaskEditHora_Termino: TMaskEdit;
    MemoObservacao: TMemo;
    ButtonSalvar: TButton;
    ImportarTxt: TMenuItem;
    FileOpen: TFileOpen;
    LabelTipos: TLabel;
    ButtonCancelar: TButton;
    DeleteAll: TMenuItem;
    ActionLimparTabelas: TAction;
    ButtonLimpar: TButton;
    Edit_ID: TEdit;
    LabelSetor: TLabel;
    ComboBoxSetor: TComboBox;
    ComboBoxTipo: TComboBox;
    ComboBoxMotivo: TComboBox;
    PageControlRegistros: TPageControl;
    TabSheetRegistros: TTabSheet;
    LabelTotalRegistros: TLabel;
    DBGridRegistros: TDBGrid;
    Button2: TButton;
    TabSheet1: TTabSheet;
    DBGridSetores: TDBGrid;
    Button1: TButton;
    TabSheetTipos: TTabSheet;
    DBGridTipos: TDBGrid;
    TabSheetMotivos: TTabSheet;
    DBGridMotivos: TDBGrid;
    Button4: TButton;
    TabSheetObservacoes: TTabSheet;
    DBGridObservacoes: TDBGrid;
    Button3: TButton;
    TabSheetResumo: TTabSheet;
    LabelFiltros: TLabel;
    LabelDetalhamento: TLabel;
    LabelFiltroTipo: TLabel;
    LabelFiltroMotivo: TLabel;
    Splitter1: TSplitter;
    DBGridResumoDoDia: TDBGrid;
    DateTimePickerResumoDoDiaInicio: TDateTimePicker;
    ButtonFiltrar: TButton;
    DBLookupComboBoxFiltroTipo: TDBLookupComboBox;
    DateTimePickerResumoDoDiaFim: TDateTimePicker;
    DBGridDetalhamento: TDBGrid;
    DBLookupComboBoxFiltroMotivo: TDBLookupComboBox;
    EditTotal: TEdit;
    ButtonFiltroLimpar: TButton;
    ButtonCopiarMotivo: TButton;
    Button5: TButton;
    ComboBoxObservacoes: TComboBox;
    procedure ActionLimparTabelasExecute(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ButtonCopiarMotivoClick(Sender: TObject);
    procedure ButtonFiltrarClick(Sender: TObject);
    procedure ButtonFiltroLimparClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ComboBoxObservacoesChange(Sender: TObject);
    procedure DBGridRegistrosDblClick(Sender: TObject);
    procedure KeyDown_Limpar_Lookup(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBLookupComboBoxObservacaoClick(Sender: TObject);
    procedure FileOpenAccept(Sender: TObject);
    procedure FileSaveAsTxtAccept(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSheetResumoExit(Sender: TObject);
    procedure TabSheetResumoShow(Sender: TObject);
    procedure TimerHorasTimer(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
  private
    FAcaoLancamentosHoras: TAcaoLancamentosHoras;
    FAcaoSetores: TAcaoSetores;
    FAcaoMotivos: TAcaoMotivos;
    FAcaoObservacoes: TAcaoObservacoes;
    FAcaoTipos: TAcaoTipos;

    FDataSourceLancamentos: TDataSource;
    FDataSourceSetores: TDataSource;
    FDataSourceTipos: TDataSource;
    FDataSourceMotivos: TDataSource;
    FDataSourceObservacoes: TDataSource;

    procedure CarregaCombos;
    procedure Filtrar;
    procedure Limpar;
    procedure RefazConsultas;
    procedure TotalizarHorasPeriodo;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  Vcl.Clipbrd, uDataModuleFormPrincipal, uHoraUtils, Vcl.Dialogs, uEntidade, uEntidadeLancamentoHora;

{$R *.dfm}

procedure TFormPrincipal.ActionLimparTabelasExecute(Sender: TObject);
begin
  DataModuleFormPrincipal.LimparTudo;
end;

procedure TFormPrincipal.AfterConstruction;
begin
  inherited;
  FAcaoLancamentosHoras := TAcaoLancamentosHoras.Create;
  FAcaoSetores := TAcaoSetores.Create;
  FAcaoMotivos := TAcaoMotivos.Create;
  FAcaoObservacoes := TAcaoObservacoes.Create;
  FAcaoTipos := TAcaoTipos.Create;
end;

procedure TFormPrincipal.ApplicationEventsMinimize(Sender: TObject);
begin
  Self.Hide();
  Self.WindowState := wsMinimized;

  TrayIcon.Visible := True;
  TrayIcon.Animate := True;
  TrayIcon.ShowBalloonHint;
end;

procedure TFormPrincipal.BeforeDestruction;
begin
  inherited;
  FAcaoLancamentosHoras.Free;

  FDataSourceLancamentos.Free;
  FDataSourceSetores.Free;
  FDataSourceTipos.Free;
  FDataSourceMotivos.Free;
  FDataSourceObservacoes.Free;
end;

procedure TFormPrincipal.Button1Click(Sender: TObject);
var
  vBookmark: Integer;
begin
  vBookmark := DBGridSetores.DataSource.DataSet.RecNo;
  try
    FAcaoSetores.Excluir(DBGridSetores.DataSource.DataSet.FieldByName('ID').AsInteger);

    FDataSourceSetores.DataSet := FAcaoSetores.Consulta();
  finally
    DBGridSetores.DataSource.DataSet.RecNo := vBookmark;
  end;
end;

procedure TFormPrincipal.Button2Click(Sender: TObject);
var
  vBookmark: Integer;
begin
  vBookmark := DBGridRegistros.DataSource.DataSet.RecNo;
  try
    FAcaoLancamentosHoras.Excluir(DBGridRegistros.DataSource.DataSet.FieldByName('ID').AsInteger);

    FDataSourceLancamentos.DataSet := FAcaoLancamentosHoras.Consulta();
  finally
    DBGridRegistros.DataSource.DataSet.RecNo := vBookmark;
  end;
end;

procedure TFormPrincipal.Button3Click(Sender: TObject);
var
  vBookmark: Integer;
begin
  vBookmark := DBGridObservacoes.DataSource.DataSet.RecNo;
  try
    FAcaoObservacoes.Excluir(DBGridObservacoes.DataSource.DataSet.FieldByName('ID').AsInteger);

    FDataSourceObservacoes.DataSet := FAcaoObservacoes.Consulta();
  finally
    DBGridObservacoes.DataSource.DataSet.RecNo := vBookmark;
  end;
end;

procedure TFormPrincipal.Button4Click(Sender: TObject);
var
  vBookmark: Integer;
begin
  vBookmark := DBGridMotivos.DataSource.DataSet.RecNo;
  try
    FAcaoMotivos.Excluir(DBGridMotivos.DataSource.DataSet.FieldByName('ID').AsInteger);

    FDataSourceMotivos.DataSet := FAcaoMotivos.Consulta();
  finally
    DBGridMotivos.DataSource.DataSet.RecNo := vBookmark;
  end;
end;

procedure TFormPrincipal.Button5Click(Sender: TObject);
var
  vBookmark: Integer;
begin
  vBookmark := DBGridTipos.DataSource.DataSet.RecNo;
  try
    FAcaoTipos.Excluir(DBGridTipos.DataSource.DataSet.FieldByName('ID').AsInteger);

    FDataSourceTipos.DataSet := FAcaoTipos.Consulta();
  finally
    DBGridTipos.DataSource.DataSet.RecNo := vBookmark;
  end;
end;

procedure TFormPrincipal.ButtonCopiarMotivoClick(Sender: TObject);
var
  vBookMark: TBookmark;
  vInd: Integer;
  vRetorno: string;
  vSelecionados: TBookmarkList;
begin
  vRetorno := EmptyStr;

  vSelecionados := DBGridResumoDoDia.SelectedRows;
  for vInd := 0 to Pred(vSelecionados.Count) do
  begin
    vBookMark := vSelecionados[vInd];

    DBGridResumoDoDia.DataSource.DataSet.GotoBookmark(vBookMark);

    vRetorno := Concat(vRetorno, #13#10,
      DBGridResumoDoDia.DataSource.DataSet.FieldByName(DBGridResumoDoDia.Columns[0].FieldName).AsString+ ' - '+
      DBGridResumoDoDia.DataSource.DataSet.FieldByName(DBGridResumoDoDia.Columns[6].FieldName).AsString+ ' - '+
      DBGridResumoDoDia.DataSource.DataSet.FieldByName(DBGridResumoDoDia.Columns[5].FieldName).AsString);
  end;
  Clipboard.AsText := vRetorno;
end;

procedure TFormPrincipal.ButtonFiltrarClick(Sender: TObject);
begin
  Filtrar;
  if DataModuleFormPrincipal.FDQueryAuxiliar.RecordCount = 0 then
  begin
    ShowMessage('Não existem dados para exibir.');
  end;
end;

procedure TFormPrincipal.ButtonFiltroLimparClick(Sender: TObject);
begin
  DateTimePickerResumoDoDiaInicio.Date := Now;
  DateTimePickerResumoDoDiaFim.Date := DateTimePickerResumoDoDiaInicio.Date;
  DBLookupComboBoxFiltroTipo.KeyValue := Null;
  DBLookupComboBoxFiltroMotivo.KeyValue := Null;
end;

procedure TFormPrincipal.Filtrar;
begin
  DataModuleFormPrincipal.FDQueryAuxiliar.Close;
  DataModuleFormPrincipal.FDQueryAuxiliar.Params.ClearValues();
  DataModuleFormPrincipal.FDQueryAuxiliar.ParamByName('DATAINICIO').AsDate := DateTimePickerResumoDoDiaInicio.Date;
  DataModuleFormPrincipal.FDQueryAuxiliar.ParamByName('DATATERMINO').AsDate := DateTimePickerResumoDoDiaFim.Date;
  if DBLookupComboBoxFiltroTipo.KeyValue > 0 then
  begin
    DataModuleFormPrincipal.FDQueryAuxiliar.ParamByName('TIPOID').AsInteger := DBLookupComboBoxFiltroTipo.KeyValue;
  end;
  if DBLookupComboBoxFiltroMotivo.KeyValue > 0 then
  begin
    DataModuleFormPrincipal.FDQueryAuxiliar.ParamByName('MOTIVOID').AsInteger := DBLookupComboBoxFiltroMotivo.KeyValue;
  end;
  DataModuleFormPrincipal.FDQueryAuxiliar.Open();
  DataModuleFormPrincipal.FDQueryAuxiliar.IndexFieldNames := 'DATA:D;HORA_INICIO';

  TotalizarHorasPeriodo;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  PageControlRegistros.ActivePage := TabSheetRegistros;

  DateTimePickerResumoDoDiaInicio.Date := Now;
  DateTimePickerResumoDoDiaFim.Date := Now;
  DateTimePickerData.Date := Now;

  FDataSourceLancamentos := TDataSource.Create(nil);
  FDataSourceSetores := TDataSource.Create(nil);
  FDataSourceTipos := TDataSource.Create(nil);
  FDataSourceMotivos := TDataSource.Create(nil);
  FDataSourceObservacoes := TDataSource.Create(nil);

  DBGridRegistros.DataSource := FDataSourceLancamentos;
  DBGridSetores.DataSource := FDataSourceSetores;
  DBGridTipos.DataSource := FDataSourceTipos;
  DBGridMotivos.DataSource := FDataSourceMotivos;
  DBGridObservacoes.DataSource := FDataSourceObservacoes;
end;

procedure TFormPrincipal.ButtonSalvarClick(Sender: TObject);
var
  vEntidade: TEntidadeLancamentoHora;
begin
  vEntidade := TEntidadeLancamentoHora.Create;
  try
    vEntidade.ID := StrToIntDef(Edit_ID.Text, 0);
    vEntidade.SetorID := FAcaoSetores.SetorID(ComboBoxSetor.Text);
    vEntidade.TipoID := FAcaoTipos.TipoID(ComboBoxTipo.Text);
    vEntidade.MotivoID := FAcaoMotivos.MotivoID(ComboBoxMotivo.Text);
    vEntidade.ObservacaoID := FAcaoObservacoes.ObservacaoID(MemoObservacao.Text);
    vEntidade.Data := DateTimePickerData.Date;
    vEntidade.HoraInicio := MaskEditHora_Inicio.Text;
    vEntidade.HoraTermino := MaskEditHora_Termino.Text;

    FAcaoLancamentosHoras.Salvar(vEntidade);

    RefazConsultas;
  finally
    vEntidade.Free;
  end;

  Limpar;

  CarregaCombos;

  Self.Caption := EmptyStr;
end;

procedure TFormPrincipal.ButtonLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TFormPrincipal.Limpar;
begin
  ComboBoxSetor.ItemIndex := -1;
  ComboBoxSetor.Clear;
  Edit_ID.Text := EmptyStr;
  ComboBoxTipo.Clear;
  ComboBoxMotivo.Clear;
  MemoObservacao.Lines.Clear;
  DateTimePickerData.Date := Now;
  MaskEditHora_Inicio.Text := TimeToStr(Now);
  MaskEditHora_Termino.Text := '  :  ';
end;

procedure TFormPrincipal.DBGridRegistrosDblClick(Sender: TObject);
begin
  Caption := 'Modo - Edição';
  Edit_ID.Text := IntToStr(DBGridRegistros.DataSource.DataSet.FieldByName('ID').AsInteger);

  ComboBoxTipo.ItemIndex        := ComboBoxTipo.Items.IndexOf(DBGridRegistros.DataSource.DataSet.FieldByName('DESCRICAO_TIPO').AsString);
  ComboBoxMotivo.ItemIndex      := ComboBoxMotivo.Items.IndexOf(DBGridRegistros.DataSource.DataSet.FieldByName('DESCRICAO_MOTIVO').AsString);
  ComboBoxSetor.ItemIndex       := ComboBoxSetor.Items.IndexOf(DBGridRegistros.DataSource.DataSet.FieldByName('DESCRICAO_SETOR').AsString);
  ComboBoxObservacoes.ItemIndex := ComboBoxObservacoes.Items.IndexOf(DBGridRegistros.DataSource.DataSet.FieldByName('DESCRICAO_OBSERVACAO').AsString);
  MemoObservacao.Text           := ComboBoxObservacoes.Text;

  DateTimePickerData.Date := DBGridRegistros.DataSource.DataSet.FieldByName('DATA').AsDateTime;
  MaskEditHora_Inicio.Text := FormatDateTime('HH:MM', DBGridRegistros.DataSource.DataSet.FieldByName('HORA_INICIO').AsDateTime);
  MaskEditHora_Termino.Text := FormatDateTime('HH:MM', DBGridRegistros.DataSource.DataSet.FieldByName('HORA_TERMINO').AsDateTime);
end;

procedure TFormPrincipal.KeyDown_Limpar_Lookup(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if Sender is TDBLookupComboBox then
    begin
      TDBLookupComboBox(Sender).KeyValue := Null;
    end;
  end;
end;

procedure TFormPrincipal.DBLookupComboBoxObservacaoClick(Sender: TObject);
begin
  MemoObservacao.Text := ComboBoxObservacoes.Text;
end;

procedure TFormPrincipal.FileOpenAccept(Sender: TObject);
var
  vCaminho: string;
begin
  vCaminho := FileOpen.Dialog.FileName;
  if vCaminho <> EmptyStr then
  begin
    //ImportarRegistros(vCaminho);
  end;
end;

procedure TFormPrincipal.FileSaveAsTxtAccept(Sender: TObject);
var
  vCaminho: string;
begin
  vCaminho := FileSaveAsTxt.Dialog.FileName;
  if vCaminho <> EmptyStr then
  begin
    //SalvarRegistrosFormatoTexto(vCaminho);
  end;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  CarregaCombos();

  RefazConsultas;
end;

procedure TFormPrincipal.CarregaCombos;
begin
  FAcaoTipos.CarregaCombo(ComboBoxTipo.Items);
  FAcaoMotivos.CarregaCombo(ComboBoxMotivo.Items);
  FAcaoSetores.CarregaCombo(ComboBoxSetor.Items);
  FAcaoObservacoes.CarregaCombo(ComboBoxObservacoes.Items);
end;

procedure TFormPrincipal.ComboBoxObservacoesChange(Sender: TObject);
begin
  MemoObservacao.Text := ComboBoxObservacoes.Text;
end;

procedure TFormPrincipal.RefazConsultas;
begin
  FDataSourceLancamentos.DataSet.Free;
  FDataSourceLancamentos.DataSet := FAcaoLancamentosHoras.Consulta();

  FDataSourceSetores.DataSet.Free;
  FDataSourceSetores.DataSet := FAcaoSetores.Consulta();

  FDataSourceTipos.DataSet.Free;
  FDataSourceTipos.DataSet := FAcaoTipos.Consulta();

  FDataSourceMotivos.DataSet.Free;
  FDataSourceMotivos.DataSet := FAcaoMotivos.Consulta();

  FDataSourceObservacoes.DataSet.Free;
  FDataSourceObservacoes.DataSet := FAcaoObservacoes.Consulta();
end;

procedure TFormPrincipal.TabSheetResumoExit(Sender: TObject);
begin
  DataModuleFormPrincipal.FDQueryAuxiliar.Close;
end;

procedure TFormPrincipal.TabSheetResumoShow(Sender: TObject);
begin
  Filtrar;
end;

procedure TFormPrincipal.TimerHorasTimer(Sender: TObject);
var
  vTime1, vTime2: TTime;
begin
  vTime1 := StrToTimeDef(MaskEditHora_Termino.Text, 0);
  if vTime1 = 0 then
  begin
    vTime1 := Now;
  end;

  vTime2 := StrToTimeDef(MaskEditHora_Inicio.Text, 0);
  if vTime2 > 0 then
  begin
    LabelHoras.Caption := FormatDateTime('HH:MM', vTime1 - vTime2);
  end
  else
  begin
    LabelHoras.Caption := '00:00';
  end;
end;

procedure TFormPrincipal.TotalizarHorasPeriodo;
var
  vTotalHoras: string;
begin
  EditTotal.Text := EmptyStr;
  vTotalHoras := '00:00';
  try
    DataModuleFormPrincipal.MemTableResumo.First;
    while not DataModuleFormPrincipal.MemTableResumo.Eof do
    begin
      vTotalHoras := THoraUtils.SomaHoras(vTotalHoras, DataModuleFormPrincipal.MemTableResumo.FieldByName('HORAS').AsString);
      DataModuleFormPrincipal.MemTableResumo.Next;
    end;
  finally
    EditTotal.Text := vTotalHoras;
  end;
end;

procedure TFormPrincipal.TrayIconDblClick(Sender: TObject);
begin
  TrayIcon.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
