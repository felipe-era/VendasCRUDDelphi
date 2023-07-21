object ConexaoBanco: TConexaoBanco
  Height = 323
  Width = 425
  object Conexao: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSOLEDBSQL.1;Persist Security Info=False;User ID=sa;Pas' +
      'sword=root;Initial Catalog=BDVENDAS;Data Source=FEVELOPER;Use Pr' +
      'ocedure for Prepare=1;Auto Translate=True;Packet Size=4096;Works' +
      'tation ID=FEVELOPER;Initial File Name="";Use Encryption for Data' +
      '=False;Tag with column collation when possible=False;MARS Connec' +
      'tion=False;DataTypeCompatibility=0;Trust Server Certificate=Fals' +
      'e;Server SPN="";Application Intent=READWRITE;MultiSubnetFailover' +
      '=False;Use FMTONLY=False;Authentication="";Access Token="";Trans' +
      'parentNetworkIPResolution=True;Connect Retry Count=1;Connect Ret' +
      'ry Interval=10'
    Provider = 'MSOLEDBSQL.1'
    Left = 152
    Top = 136
  end
  object QueryTmp: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    Left = 240
    Top = 72
    object QueryTmpProdutoID: TAutoIncField
      FieldName = 'ProdutoID'
      ReadOnly = True
    end
    object QueryTmpNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object QueryTmpPreco: TBCDField
      FieldName = 'Preco'
      Precision = 10
      Size = 2
    end
    object QueryTmpEstoque: TIntegerField
      FieldName = 'Estoque'
    end
  end
  object BdSource: TDataSource
    AutoEdit = False
    DataSet = QueryProdutos
    Left = 312
    Top = 136
  end
  object QueryProdutos: TADOQuery
    Active = True
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Produtos')
    Left = 240
    Top = 136
    object AutoIncField1: TAutoIncField
      DisplayWidth = 9
      FieldName = 'ProdutoID'
      ReadOnly = True
    end
    object StringField1: TStringField
      DisplayWidth = 8
      FieldName = 'Nome'
      Size = 100
    end
    object BCDField1: TBCDField
      DisplayWidth = 8
      FieldName = 'Preco'
      currency = True
      Precision = 10
      Size = 2
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 5
      FieldName = 'Estoque'
    end
  end
  object QueryClientes: TADOQuery
    Active = True
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Clientes')
    Left = 240
    Top = 200
    object QueryClientesClienteID: TAutoIncField
      FieldName = 'ClienteID'
      ReadOnly = True
    end
    object QueryClientesNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object QueryClientesEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object QueryClientesTelefone: TStringField
      FieldName = 'Telefone'
      Size = 50
    end
  end
  object BdClientes: TDataSource
    AutoEdit = False
    DataSet = QueryClientes
    Left = 320
    Top = 200
  end
  object BdIdVenda: TDataSource
    AutoEdit = False
    DataSet = QueryIdVenda
    Left = 320
    Top = 264
  end
  object QueryIdVenda: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT MAX(VendaID) as VendaID FROM Vendas')
    Left = 232
    Top = 264
    object QueryIdVendaVendaID: TIntegerField
      FieldName = 'VendaID'
      ReadOnly = True
    end
  end
end
