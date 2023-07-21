object frmCaixa: TfrmCaixa
  Left = 286
  Top = 177
  Caption = 'frmCaixa'
  ClientHeight = 551
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object lblTotal: TLabel
    Left = 296
    Top = 415
    Width = 129
    Height = 57
  end
  object lblClienteNome: TLabel
    Left = 343
    Top = 11
    Width = 130
    Height = 23
    Caption = 'Nome do Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object lblCodigoCliente: TLabel
    Left = 287
    Top = 13
    Width = 31
    Height = 21
    Caption = 'C'#243'd.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object lblCodigoProduto: TLabel
    Left = 279
    Top = 110
    Width = 42
    Height = 15
    Caption = 'Cod. do'
  end
  object gridProdutos: TDBGrid
    AlignWithMargins = True
    Left = 8
    Top = 131
    Width = 273
    Height = 278
    DataSource = ConexaoBanco.BdSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = gridProdutosCellClick
  end
  object gridClientes: TDBGrid
    Left = 8
    Top = 8
    Width = 273
    Height = 97
    DataSource = ConexaoBanco.BdClientes
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = gridClientesCellClick
  end
  object txtNomeCliente: TEdit
    Left = 343
    Top = 40
    Width = 226
    Height = 36
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object txtCodigoProduto: TEdit
    Left = 287
    Top = 131
    Width = 34
    Height = 40
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object txtValorProduto: TEdit
    Left = 287
    Top = 175
    Width = 162
    Height = 53
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object txtNomeProduto: TEdit
    Left = 327
    Top = 131
    Width = 123
    Height = 40
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object btnOk: TButton
    Left = 544
    Top = 118
    Width = 114
    Height = 110
    Caption = 'Confirmar Produto'
    TabOrder = 6
    OnClick = btnOkClick
  end
  object txtQuantidade: TEdit
    Left = 455
    Top = 131
    Width = 83
    Height = 78
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object gridDetalhes: TStringGrid
    Left = 296
    Top = 234
    Width = 362
    Height = 175
    ColCount = 4
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 8
    RowHeights = (
      24)
  end
  object btnFinalizar: TButton
    Left = 448
    Top = 415
    Width = 192
    Height = 119
    Caption = 'Finalizar'
    TabOrder = 9
    OnClick = btnFinalizarClick
  end
  object txtIDCliente: TEdit
    Left = 287
    Top = 40
    Width = 50
    Height = 36
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object btnVoltar: TButton
    Left = 8
    Top = 415
    Width = 105
    Height = 57
    Caption = 'Voltar'
    TabOrder = 11
    OnClick = btnVoltarClick
  end
  object btnLimpar: TButton
    Left = 119
    Top = 415
    Width = 138
    Height = 57
    Caption = 'Limpar Campos'
    TabOrder = 12
  end
  object PrintDialog1: TPrintDialog
    Left = 16
    Top = 408
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 8
    Top = 416
  end
end
