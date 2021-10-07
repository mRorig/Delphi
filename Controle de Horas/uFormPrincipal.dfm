object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Lan'#231'amentos das Horas Trabalhadas'
  ClientHeight = 783
  ClientWidth = 1046
  Color = clBtnFace
  Constraints.MinHeight = 841
  Constraints.MinWidth = 1062
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTopo: TPanel
    AlignWithMargins = True
    Left = 20
    Top = 15
    Width = 1006
    Height = 154
    Margins.Left = 20
    Margins.Top = 15
    Margins.Right = 20
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object LabelObservacao: TLabel
      Left = 389
      Top = 15
      Width = 67
      Height = 13
      Margins.Left = 20
      Margins.Top = 10
      Margins.Right = 0
      Caption = 'Observa'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object LabelData: TLabel
      Left = 769
      Top = 15
      Width = 27
      Height = 13
      Margins.Left = 20
      Margins.Top = 15
      Margins.Right = 0
      Caption = 'Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object LabelHoraInicio: TLabel
      Left = 769
      Top = 57
      Width = 31
      Height = 13
      Margins.Left = 20
      Margins.Top = 15
      Margins.Right = 0
      Caption = 'In'#237'cio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object LabelHoraTermino: TLabel
      Left = 864
      Top = 57
      Width = 47
      Height = 13
      Margins.Left = 20
      Margins.Top = 15
      Margins.Right = 0
      Caption = 'T'#233'rmino'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object LabelMotivo: TLabel
      Left = 20
      Top = 115
      Width = 39
      Height = 13
      Margins.Left = 20
      Margins.Top = 10
      Margins.Right = 0
      Caption = 'Motivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object LabelHoras: TLabel
      Left = 960
      Top = 76
      Width = 28
      Height = 13
      Caption = '00:00'
    end
    object LabelTipos: TLabel
      Left = 20
      Top = 65
      Width = 24
      Height = 13
      Margins.Left = 20
      Margins.Top = 10
      Margins.Right = 0
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object LabelSetor: TLabel
      Left = 20
      Top = 15
      Width = 31
      Height = 13
      Margins.Left = 20
      Margins.Top = 10
      Margins.Right = 0
      Caption = 'Setor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object DateTimePickerData: TDateTimePicker
      Left = 769
      Top = 31
      Width = 88
      Height = 21
      Date = 44364.000000000000000000
      Time = 0.375564687499718300
      TabOrder = 0
    end
    object MaskEditHora_Inicio: TMaskEdit
      Left = 769
      Top = 73
      Width = 89
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
    end
    object MaskEditHora_Termino: TMaskEdit
      Left = 864
      Top = 73
      Width = 90
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  :  '
    end
    object MemoObservacao: TMemo
      Left = 389
      Top = 55
      Width = 360
      Height = 97
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 0
      TabOrder = 3
    end
    object ButtonSalvar: TButton
      Left = 901
      Top = 122
      Width = 60
      Height = 30
      Caption = 'Salvar'
      TabOrder = 4
      OnClick = ButtonSalvarClick
    end
    object ButtonCancelar: TButton
      Left = 835
      Top = 122
      Width = 60
      Height = 30
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = ButtonSalvarClick
    end
    object ButtonLimpar: TButton
      Left = 769
      Top = 122
      Width = 60
      Height = 30
      Caption = 'Limpar'
      TabOrder = 6
      OnClick = ButtonLimparClick
    end
    object Edit_ID: TEdit
      Left = 936
      Top = 0
      Width = 57
      Height = 21
      TabOrder = 7
      Visible = False
    end
    object ComboBoxSetor: TComboBox
      Left = 20
      Top = 31
      Width = 349
      Height = 21
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 0
      TabOrder = 8
    end
    object ComboBoxTipo: TComboBox
      Left = 20
      Top = 81
      Width = 349
      Height = 21
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 0
      TabOrder = 9
    end
    object ComboBoxMotivo: TComboBox
      Left = 20
      Top = 131
      Width = 349
      Height = 21
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 0
      TabOrder = 10
    end
    object ComboBoxObservacoes: TComboBox
      Left = 389
      Top = 31
      Width = 360
      Height = 22
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 0
      Style = csOwnerDrawFixed
      TabOrder = 11
      OnChange = ComboBoxObservacoesChange
    end
  end
  object PageControlRegistros: TPageControl
    AlignWithMargins = True
    Left = 20
    Top = 179
    Width = 1006
    Height = 584
    Margins.Left = 20
    Margins.Top = 10
    Margins.Right = 20
    Margins.Bottom = 20
    ActivePage = TabSheetRegistros
    Align = alClient
    TabOrder = 1
    object TabSheetRegistros: TTabSheet
      Caption = 'Registros'
      object LabelTotalRegistros: TLabel
        AlignWithMargins = True
        Left = 20
        Top = 540
        Width = 958
        Height = 13
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 20
        Align = alBottom
        Alignment = taRightJustify
        ExplicitLeft = 975
        ExplicitWidth = 3
      end
      object DBGridRegistros: TDBGrid
        AlignWithMargins = True
        Left = 133
        Top = 20
        Width = 845
        Height = 500
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = DBGridRegistrosDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'DATA'
            Title.Alignment = taCenter
            Title.Caption = 'Data'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HORA_INICIO'
            Title.Alignment = taCenter
            Title.Caption = 'Hora in'#237'cio'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HORA_TERMINO'
            Title.Alignment = taCenter
            Title.Caption = 'Hora t'#233'rmino'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_SETOR'
            Title.Alignment = taCenter
            Title.Caption = 'Setor'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_TIPO'
            Title.Alignment = taCenter
            Title.Caption = 'Tipo'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_MOTIVO'
            Title.Alignment = taCenter
            Title.Caption = 'Motivo'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_OBSERVACAO'
            Title.Alignment = taCenter
            Title.Caption = 'Observa'#231#227'o'
            Width = 200
            Visible = True
          end>
      end
      object TPanel
        AlignWithMargins = True
        Left = 0
        Top = 20
        Width = 113
        Height = 500
        Margins.Left = 0
        Margins.Top = 20
        Margins.Right = 0
        Margins.Bottom = 20
        Align = alLeft
        TabOrder = 1
        object Button2: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 105
          Height = 50
          Align = alTop
          Caption = 'Excluir'
          TabOrder = 0
          OnClick = Button2Click
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Setores'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGridSetores: TDBGrid
        AlignWithMargins = True
        Left = 133
        Top = 20
        Width = 845
        Height = 516
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object TPanel
        AlignWithMargins = True
        Left = 0
        Top = 20
        Width = 113
        Height = 516
        Margins.Left = 0
        Margins.Top = 20
        Margins.Right = 0
        Margins.Bottom = 20
        Align = alLeft
        TabOrder = 1
        object Button1: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 105
          Height = 50
          Align = alTop
          Caption = 'Excluir'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
    object TabSheetTipos: TTabSheet
      Caption = 'Tipos'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGridTipos: TDBGrid
        AlignWithMargins = True
        Left = 133
        Top = 20
        Width = 845
        Height = 516
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object TPanel
        AlignWithMargins = True
        Left = 0
        Top = 20
        Width = 113
        Height = 516
        Margins.Left = 0
        Margins.Top = 20
        Margins.Right = 0
        Margins.Bottom = 20
        Align = alLeft
        TabOrder = 1
        object Button5: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 105
          Height = 50
          Align = alTop
          Caption = 'Excluir'
          TabOrder = 0
          OnClick = Button5Click
        end
      end
    end
    object TabSheetMotivos: TTabSheet
      Caption = 'Motivos'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGridMotivos: TDBGrid
        AlignWithMargins = True
        Left = 133
        Top = 20
        Width = 845
        Height = 516
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object TPanel
        AlignWithMargins = True
        Left = 0
        Top = 20
        Width = 113
        Height = 516
        Margins.Left = 0
        Margins.Top = 20
        Margins.Right = 0
        Margins.Bottom = 20
        Align = alLeft
        TabOrder = 1
        object Button4: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 105
          Height = 50
          Align = alTop
          Caption = 'Excluir'
          TabOrder = 0
          OnClick = Button4Click
        end
      end
    end
    object TabSheetObservacoes: TTabSheet
      Caption = 'Observa'#231#245'es'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGridObservacoes: TDBGrid
        AlignWithMargins = True
        Left = 133
        Top = 20
        Width = 845
        Height = 516
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alClient
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object TPanel
        AlignWithMargins = True
        Left = 0
        Top = 20
        Width = 113
        Height = 516
        Margins.Left = 0
        Margins.Top = 20
        Margins.Right = 0
        Margins.Bottom = 20
        Align = alLeft
        TabOrder = 1
        object Button3: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 105
          Height = 50
          Align = alTop
          Caption = 'Excluir'
          TabOrder = 0
          OnClick = Button3Click
        end
      end
    end
    object TabSheetResumo: TTabSheet
      Caption = 'Resumo do dia'
      ImageIndex = 3
      OnExit = TabSheetResumoExit
      OnShow = TabSheetResumoShow
      DesignSize = (
        998
        556)
      object LabelFiltros: TLabel
        Left = 20
        Top = 15
        Width = 35
        Height = 13
        Margins.Left = 20
        Margins.Top = 15
        Margins.Right = 0
        Caption = 'Filtros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object LabelDetalhamento: TLabel
        Left = 20
        Top = 166
        Width = 81
        Height = 13
        Margins.Left = 20
        Margins.Top = 15
        Margins.Right = 0
        Caption = 'Detalhamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object LabelFiltroTipo: TLabel
        Left = 20
        Top = 63
        Width = 24
        Height = 13
        Margins.Left = 20
        Margins.Top = 15
        Margins.Right = 0
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object LabelFiltroMotivo: TLabel
        Left = 20
        Top = 111
        Width = 39
        Height = 13
        Margins.Left = 20
        Margins.Top = 15
        Margins.Right = 0
        Caption = 'Motivo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Splitter1: TSplitter
        Left = 0
        Top = 342
        Width = 998
        Height = 9
        Cursor = crVSplit
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alBottom
        ExplicitTop = 304
      end
      object DBGridResumoDoDia: TDBGrid
        AlignWithMargins = True
        Left = 20
        Top = 361
        Width = 958
        Height = 165
        Margins.Left = 20
        Margins.Top = 10
        Margins.Right = 20
        Margins.Bottom = 30
        Align = alBottom
        DataSource = DataModuleFormPrincipal.DataSourceAuxiliar
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DATA'
            Title.Caption = 'Data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_TIPO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_MOTIVO'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HORA_INICIO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HORA_TERMINO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HORAS'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO_OBSERVACAO'
            Title.Caption = 'Observa'#231#245'es'
            Width = 400
            Visible = True
          end>
      end
      object DateTimePickerResumoDoDiaInicio: TDateTimePicker
        Left = 20
        Top = 31
        Width = 88
        Height = 21
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 0
        Date = 44364.000000000000000000
        Time = 0.375564687499718300
        TabOrder = 0
      end
      object ButtonFiltrar: TButton
        Left = 492
        Top = 127
        Width = 75
        Height = 25
        Margins.Left = 20
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Filtrar'
        TabOrder = 4
        OnClick = ButtonFiltrarClick
      end
      object DBLookupComboBoxFiltroTipo: TDBLookupComboBox
        Left = 20
        Top = 79
        Width = 357
        Height = 21
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 0
        KeyField = 'ID'
        ListField = 'DESCRICAO'
        TabOrder = 2
        OnKeyDown = KeyDown_Limpar_Lookup
      end
      object DateTimePickerResumoDoDiaFim: TDateTimePicker
        Left = 128
        Top = 31
        Width = 88
        Height = 21
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 0
        Date = 44364.000000000000000000
        Time = 0.375564687499718300
        TabOrder = 1
      end
      object DBGridDetalhamento: TDBGrid
        AlignWithMargins = True
        Left = 20
        Top = 190
        Width = 958
        Height = 142
        Margins.Left = 20
        Margins.Top = 190
        Margins.Right = 20
        Margins.Bottom = 10
        Align = alClient
        DataSource = DataModuleFormPrincipal.dsResumo
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 6
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'TIPO'
            Title.Alignment = taCenter
            Title.Caption = 'Tipo'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MOTIVO'
            Title.Alignment = taCenter
            Title.Caption = 'Motivo'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HORAS'
            Title.Alignment = taCenter
            Title.Caption = 'Horas'
            Width = 80
            Visible = True
          end>
      end
      object DBLookupComboBoxFiltroMotivo: TDBLookupComboBox
        Left = 20
        Top = 127
        Width = 357
        Height = 21
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 0
        KeyField = 'ID'
        ListField = 'DESCRICAO'
        TabOrder = 3
        OnKeyDown = KeyDown_Limpar_Lookup
      end
      object EditTotal: TEdit
        Left = 587
        Top = 129
        Width = 109
        Height = 21
        Margins.Left = 20
        TabOrder = 5
      end
      object ButtonFiltroLimpar: TButton
        Left = 397
        Top = 127
        Width = 75
        Height = 25
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Limpar'
        TabOrder = 8
        OnClick = ButtonFiltroLimparClick
      end
      object ButtonCopiarMotivo: TButton
        Left = 904
        Top = 530
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = 'Copiar'
        TabOrder = 9
        OnClick = ButtonCopiarMotivoClick
      end
    end
  end
  object TimerHoras: TTimer
    OnTimer = TimerHorasTimer
    Left = 761
    Top = 272
  end
  object TrayIcon: TTrayIcon
    Animate = True
    OnDblClick = TrayIconDblClick
    Left = 616
    Top = 272
  end
  object ApplicationEvents: TApplicationEvents
    OnMinimize = ApplicationEventsMinimize
    Left = 688
    Top = 272
  end
  object MainMenu: TMainMenu
    Images = ImageList
    Left = 880
    Top = 272
    object N1: TMenuItem
      Caption = 'Op'#231#245'es'
      object ImportarTxt: TMenuItem
        Action = FileOpen
      end
      object Salvarformatotxt: TMenuItem
        Action = FileSaveAsTxt
        Caption = 'Salvar no formato .Txt...'
        SubMenuImages = ImageList
        ImageIndex = 0
      end
      object DeleteAll: TMenuItem
        Action = ActionLimparTabelas
      end
    end
  end
  object ImageList: TImageList
    Left = 816
    Top = 272
    Bitmap = {
      494C010103000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8B4C800DAD2E100DAD2
      E100DAD2E100CECDDD00CDCCDD00CDCCDD00CDCCDD00CDCCDD00CDCCDD00C8C4
      D700B895AD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DCD4E200BA9AB300C2A8
      BE00DFDAE700D2C7D800CAC4D600D1D3E300BAA4BC00B498B100DEEFFA00DEEF
      FA00B28DA7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DAD3E200F0F7FF00F0F7
      FF00F0F7FF00F0F7FF00F0F7FF00DEF0FA00DEEFFA00DEEFFA00DEEFFA00DEEF
      FA00B28DA7000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1CFDF00EFF6FE00EAED
      F700DAD2E100DAD2E100DAD2E100D7D1E000CECDDD00CDCCDD00CDCCDD00CDCC
      DD00AD84A000E3D6DF00E5D9E000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DBD4E200E3F1FC00B48B
      9F00F8CB8500F8CB8500F8CB8500F8CB8500F8CB8500F8CB8500F8CB8500F8CB
      8500F8CB8500F8CB8500E2B387000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DAD3E100EFF7FF00B18A
      9E00F8CB8500F8CB8500F9D69F00F8CB8500FBE3BC00FBE4C100FAD6A000FDEE
      D600F8CB8500F8CB8500E2B38700000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D9D3E100E1F0FB00B48B
      9F00F8CB8500F8CB8500FAD8A400F8CB8500F8CB8500FCE5C200F8CB8500FDF2
      E000F8CB8500F8CB8500E2B387000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1D0DF00ECF6FE00B38B
      9F00F8CB8500F8CE8C00FBE2BC00F9D19400FADBAA00FDF2E100F9D19200FEF5
      E900FAD8A300F8CB8500E2B38700000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECEDE00DEEFFA00B38B
      9F00F8CB8500F8CB8500F8CB8500F8CB8500F8CB8500F8CB8500F8CB8500F8CB
      8500F8CB8500F8CB8500E2B387000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECEDE00DEEFFA00C9BA
      C700B58C9F00B58C9F00B68D9F00B38B9E00B68C9F00B68D9F00B68D9F00B68D
      9F00A2729000B68C9D00B68C9D00000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD859E00B38DA300B38E
      A400CEC7D300ECF6FE00E1F0FB00EFF7FF00E3F1FC00FCFDFF00F9FCFF00F0F7
      FF00B28EA8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AF88A100F0D6BA00F5D9
      B900B38DA300E7F4FC00F5FAFE00EDF5FE00EFF7FF00F1F8FD00F3F8FE00F0F7
      FF00B28DA8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EAE0E600EFD4
      B900B18BA200DEEFFA00DEEFFA00ECF6FE00E1F0FB00EFF7FF00E3F1FC00EFF6
      FE00B18EA7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AF89
      A100AD839D00CDCCDD00CDCCDD00D0CEDE00D7D1E000D8D1E000D9D2E100CCC6
      D700B794AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF00008007FFFFFFFF0000
      8007001FFFFF00008007000FFFFF000080010007FFFF000080010003FFFF0000
      80010001FFFF000080010000E00700008001001FE00700008001001FE0070000
      8001001FFFFF000080078FF1FFFF00008007FFF9FFFF0000C007FF75FFFF0000
      E007FF8FFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object ActionListMenu: TActionList
    Images = ImageList
    Left = 944
    Top = 271
    object FileSaveAsTxt: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Dialog.DefaultExt = 'txt'
      Dialog.FileName = 'Registros de Horas.txt'
      Dialog.InitialDir = 'C:\Users\Documents'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 30
      OnAccept = FileSaveAsTxtAccept
    end
    object FileOpen: TFileOpen
      Category = 'File'
      Caption = 'Importar Registros'
      Hint = 'Importar Registros'
      ImageIndex = 1
      ShortCut = 16463
      OnAccept = FileOpenAccept
    end
    object ActionLimparTabelas: TAction
      Category = 'File'
      Caption = 'Limpar tabelas'
      OnExecute = ActionLimparTabelasExecute
    end
  end
end
