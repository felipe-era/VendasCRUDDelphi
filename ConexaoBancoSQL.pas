unit ConexaoBancoSQL;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TConexaoBanco = class(TDataModule)
    Conexao: TADOConnection;
    QueryTmp: TADOQuery;
    BdSource: TDataSource;
    QueryTmpProdutoID: TAutoIncField;
    QueryTmpNome: TStringField;
    QueryTmpPreco: TBCDField;
    QueryTmpEstoque: TIntegerField;
    QueryProdutos: TADOQuery;
    AutoIncField1: TAutoIncField;
    StringField1: TStringField;
    BCDField1: TBCDField;
    IntegerField1: TIntegerField;
    QueryClientes: TADOQuery;
    QueryClientesClienteID: TAutoIncField;
    QueryClientesNome: TStringField;
    QueryClientesEmail: TStringField;
    QueryClientesTelefone: TStringField;
    BdClientes: TDataSource;
    BdIdVenda: TDataSource;
    QueryIdVenda: TADOQuery;
    QueryIdVendaVendaID: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConexaoBanco: TConexaoBanco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
