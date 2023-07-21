unit Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Printers,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, ConexaoBancoSQL, Vcl.DBCtrls;

type
  TfrmCaixa = class(TForm)
    gridProdutos: TDBGrid;
    gridClientes: TDBGrid;
    txtNomeCliente: TEdit;
    txtCodigoProduto: TEdit;
    txtValorProduto: TEdit;
    txtNomeProduto: TEdit;
    btnOk: TButton;
    txtQuantidade: TEdit;
    gridDetalhes: TStringGrid;
    btnFinalizar: TButton;
    lblTotal: TLabel;
    txtIDCliente: TEdit;
    lblClienteNome: TLabel;
    lblCodigoCliente: TLabel;
    btnVoltar: TButton;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnLimpar: TButton;
    lblCodigoProduto: TLabel;
    procedure txtFiltroNomeClienteChange(Sender: TObject);
    procedure txtFiltroNomeClienteClick(Sender: TObject);
    procedure gridProdutosCellClick(Column: TColumn);
    procedure btnOkClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure gridClientesCellClick(Column: TColumn);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AdicionarProdutoNoGridDetalhes(codigo, nome: string;
      quantidade: Integer; valor: Double);
    function ObterValoresAgrupadosDoGrid: Currency;
    function ObterProdutosDaVenda: string;
    function ObterNomeProdutosDaVenda: string;
    function ObterQuantidadeProdutosDaVenda: string;
    function ObterValorProdutosDaVenda: string;
    function ObterValorDoSelect: Integer;
    procedure GeraImpressaoVenda(IDVenda, IDCliente, NomeCliente: string;
      ValorTotal: Currency; arrIdProduto, arrNomeProduto, arrQuantidadeProduto,
      arrVlrProduto: TArray<string>);
    procedure RegistrarVenda(IDCliente: Integer);
    procedure RegistrarVendaItens(VendaID, ProdutoID, quantidade: Integer;
      ValorTotal: Currency);
  end;

var
  frmCaixa: TfrmCaixa;
  strClienteEmail, strClienteTelefone: string;

implementation

{$R *.dfm}

procedure TfrmCaixa.btnFinalizarClick(Sender: TObject);
var
  strProdutosVenda, strNomeProdutosVenda, strQtdeProdutos,
    strVlrProdutos: string;
  intIdVenda: Integer;
  intIdProdutoIndividual: Integer;
  curTotalVenda: Currency;
  arrIdProduto, arrNomeProduto, arrQtdeProduto, arrVlrProduto: TArray<string>;

begin
  strProdutosVenda := ObterProdutosDaVenda;
  strNomeProdutosVenda := ObterNomeProdutosDaVenda;
  strQtdeProdutos := ObterQuantidadeProdutosDaVenda;
  strVlrProdutos := ObterValorProdutosDaVenda;

  curTotalVenda := ObterValoresAgrupadosDoGrid; // se ele pega
  RegistrarVenda(StrToInt(txtIDCliente.Text));
  intIdVenda := ObterValorDoSelect;

  arrIdProduto := strProdutosVenda.Split([',']);
  arrNomeProduto := strNomeProdutosVenda.Split([',']);
  arrQtdeProduto := strQtdeProdutos.Split([',']);
  arrVlrProduto := strVlrProdutos.Split(['.']);
  for var i := 0 to High(arrIdProduto) - 1 do
  begin
    intIdProdutoIndividual := StrToInt(arrIdProduto[i]);
    RegistrarVendaItens(intIdVenda, intIdProdutoIndividual,
      StrToInt(txtQuantidade.Text), curTotalVenda);
  end;
  //
  GeraImpressaoVenda(IntToStr(intIdVenda), txtIDCliente.Text,
    txtNomeCliente.Text, curTotalVenda, arrIdProduto, arrNomeProduto,
    arrQtdeProduto, arrVlrProduto);

end;

procedure TfrmCaixa.RegistrarVendaItens(VendaID, ProdutoID, quantidade: Integer;
  ValorTotal: Currency);
begin
  try
    ConexaoBanco.QueryTmp.CleanupInstance;
    ConexaoBanco.QueryTmp.SQL.Text :=
      'INSERT INTO Itens_Venda (VendaID, ProdutoID, Quantidade, ValorTotal)' +
      'VALUES (:VendaID, :ProdutoID, :Quantidade, :ValorTotal)';
    ConexaoBanco.Conexao.Open;

    ConexaoBanco.QueryTmp.Parameters.ParamByName('VendaID').Value := VendaID;
    ConexaoBanco.QueryTmp.Parameters.ParamByName('ProdutoID').Value :=
      ProdutoID;
    ConexaoBanco.QueryTmp.Parameters.ParamByName('Quantidade').Value :=
      quantidade;
    ConexaoBanco.QueryTmp.Parameters.ParamByName('ValorTotal').Value :=
      ValorTotal;

    ConexaoBanco.QueryTmp.ExecSQL;
    ShowMessage('Inseriu na tabela Itens_Venda com sucesso!');
  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao inserir o item de venda: ' + E.Message);
  end;
end;

procedure TfrmCaixa.RegistrarVenda(IDCliente: Integer);
var
  intIdVenda: Integer;
begin
  try
    // Prepare a instrução SQL para a inserção
    ConexaoBanco.Conexao.Open;
    ConexaoBanco.QueryTmp.SQL.Text :=
      'INSERT INTO Vendas (ClienteID, DataVenda) values (:IDCliente, CURRENT_TIMESTAMP)';

    ConexaoBanco.QueryTmp.Parameters.ParamByName('IDCliente').Value :=
      IDCliente;

    ConexaoBanco.QueryTmp.ExecSQL;
    ShowMessage('inseriu na tabela vendas ok!');

  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao inserir a venda: ' + E.Message);
  end;
end;

procedure TfrmCaixa.GeraImpressaoVenda(IDVenda, IDCliente, NomeCliente: string;
  ValorTotal: Currency; arrIdProduto, arrNomeProduto, arrQuantidadeProduto,
  arrVlrProduto: TArray<string>); // produtos em array
var
  X, Y: Integer;
  DataHoraAtual: TDate;
  ListaStrings: TArray<string>;
  strTeste: string;
  StrItem: string;
  i, intAlturaProdutos: Integer;

begin
  intAlturaProdutos := 1650;
  if PrintDialog1.Execute then
  begin
    Printer.BeginDoc;
    try
      Printer.Canvas.Font.Name := 'Arial';
      Printer.Canvas.Font.Size := 22;
      Printer.Canvas.TextOut(1750, 100, 'NOTA DE VENDA');
      Printer.Canvas.Font.Name := 'Arial';
      Printer.Canvas.Font.Size := 14;
      Printer.Canvas.TextOut(1900, 300, 'DADOS DO CLIENTE');

      Printer.Canvas.Font.Size := 12;
      Printer.Canvas.TextOut(500, 500, 'Venda Nº:' + IDVenda + ' ' +
        DateTimeToStr(Now));
      Printer.Canvas.TextOut(500, 650, 'Cadastro Nº: ' + IDCliente);
      Printer.Canvas.TextOut(500, 800, 'Nome: ' + NomeCliente);
      Printer.Canvas.TextOut(500, 950, 'E-Mail: ' + strClienteEmail);
      Printer.Canvas.TextOut(500, 1100, 'Telefone: ' + strClienteTelefone);

      Printer.Canvas.Font.Size := 14;
      Printer.Canvas.TextOut(2100, 1300, 'PRODUTOS');
      Printer.Canvas.Font.Size := 12;

      Printer.Canvas.TextOut(500, 1500, 'CÓD.');
      Printer.Canvas.TextOut(1300, 1500, 'DESCRIÇÃO');
      Printer.Canvas.TextOut(2400, 1500, 'QTDE');
      Printer.Canvas.TextOut(3100, 1500, 'VALOR');

      for i := 0 to Length(arrIdProduto) - 2 do
      begin
        Printer.Canvas.TextOut(550, intAlturaProdutos, arrIdProduto[i]);
        // codigoproduto
        Printer.Canvas.TextOut(1352, intAlturaProdutos, arrNomeProduto[i]);
        // desc produto
        Printer.Canvas.TextOut(2500, intAlturaProdutos, arrQuantidadeProduto[i]
          ); // qtd produto
        Printer.Canvas.TextOut(3100, intAlturaProdutos, arrVlrProduto[i]);
        // preco prod

        intAlturaProdutos := intAlturaProdutos + 150;
      end;

      Printer.Canvas.TextOut(2800, 2300, 'Total R$ ' + CurrToStr(ValorTotal));

    finally
      Printer.EndDoc;
    end;
  end;

END;

function TfrmCaixa.ObterValorDoSelect: Integer;
begin
  ConexaoBanco.QueryIdVenda.Open;
  Result := ConexaoBanco.QueryIdVenda.FieldByName('VendaID').AsInteger;
  ConexaoBanco.QueryIdVenda.Close;

end;

procedure TfrmCaixa.btnOkClick(Sender: TObject);
var
  i: Integer;
  ID_Produto: string;
  nomeProduto: string;
  quantidade: Integer;
  valor: Double;
  ValorTotal: Double;
begin
  ID_Produto := txtCodigoProduto.Text;
  nomeProduto := txtNomeProduto.Text;
  quantidade := StrToIntDef(txtQuantidade.Text, 0);
  valor := StrToFloatDef(txtValorProduto.Text, 0);

  if quantidade <> 1 then
    ValorTotal := valor * quantidade
  else
    ValorTotal := valor;

  AdicionarProdutoNoGridDetalhes(ID_Produto, nomeProduto, quantidade,
    ValorTotal);


end;

procedure TfrmCaixa.btnVoltarClick(Sender: TObject);
begin
  Parent.Hide;
  frmCaixa.Free;
  Close;
end;

procedure TfrmCaixa.AdicionarProdutoNoGridDetalhes(codigo, nome: string;
  quantidade: Integer; valor: Double);
var
  newRow: Integer;
begin
  newRow := gridDetalhes.RowCount; // Obtém a próxima linha disponível

  // Define a quantidade de colunas necessárias, se ainda não estiver definido
  if gridDetalhes.ColCount < 4 then
    gridDetalhes.ColCount := 4;

  // Ajusta a quantidade de linhas para a nova linha do produto
  gridDetalhes.RowCount := newRow + 1;

  // Adiciona os dados do produto nas células correspondentes

  gridDetalhes.Cells[0, newRow] := codigo;
  gridDetalhes.Cells[1, newRow] := nome;
  gridDetalhes.Cells[2, newRow] := IntToStr(quantidade);
  gridDetalhes.Cells[3, newRow] := FormatFloat('#0.00', valor);
end;

procedure TfrmCaixa.gridClientesCellClick(Column: TColumn);
var
  strIDCliente: string;
begin
  if Assigned(Column.Field) and not Column.Field.IsNull then
  begin
    with gridClientes.DataSource.DataSet do
    begin
      txtNomeCliente.Text := FieldByName('Nome').AsString;
      txtIDCliente.Text := FieldByName('ClienteID').AsString;
      strClienteEmail := FieldByName('Email').AsString;
      strClienteTelefone := FieldByName('Telefone').AsString;
      lblClienteNome.Visible := True;
      lblCodigoCliente.Visible := True;
    end;
  end;
end;

procedure TfrmCaixa.gridProdutosCellClick(Column: TColumn);
begin
  if Assigned(Column.Field) and not Column.Field.IsNull then
  begin
    with gridProdutos.DataSource.DataSet do
    begin
      txtNomeProduto.Text := FieldByName('Nome').AsString;
      txtValorProduto.Text := FieldByName('Preco').AsString;
      txtQuantidade.Text := '1';
      txtCodigoProduto.Text := FieldByName('ProdutoID').AsString;
    end;
  end;
end;

procedure TfrmCaixa.txtFiltroNomeClienteChange(Sender: TObject);
var
  strNome: string;
  i: Integer;
begin
  with gridProdutos.DataSource.DataSet do
  begin
    strNome := FieldByName('Nome').AsString;

  end;

end;

procedure TfrmCaixa.txtFiltroNomeClienteClick(Sender: TObject);
var
  strNome: string;
  i: Integer;
begin

  { for i := 0 to gridProdutos.DataSource.DataSet.FieldCount - 1 do
    begin
    with gridProdutos.DataSource.DataSet do
    begin
    strNome := FieldByName('Nome').AsString;
    gridProdutos.Columns[0];
    if  Pos(strNome, gridClientes.Columns[0, 'd']) > 0 then
    begin
    gridClientes.Row := i;
    Exit; // Sai do loop assim que encontrar uma correspondência
    end;

    end;
    end; }
end;

function TfrmCaixa.ObterValoresAgrupadosDoGrid: Currency;
var
  decSoma: Currency;
  i: Integer;
  strValorAgrupado: string;

begin
  strValorAgrupado := '';
  decSoma := 0.00;

  for i := 1 to gridDetalhes.RowCount - 1 do
  begin
    strValorAgrupado := gridDetalhes.Cells[3, i];

    decSoma := decSoma + StrToCurr(strValorAgrupado);

  end;

  Result := decSoma;
end;

function TfrmCaixa.ObterProdutosDaVenda: string;
var
  i: Integer;
  strIdProdutos: string;
begin
  strIdProdutos := '';
  for i := 1 to gridDetalhes.RowCount - 1 do
  begin
    strIdProdutos := strIdProdutos + gridDetalhes.Cells[0, i] + ',';
  end;
  Result := strIdProdutos;
end;

function TfrmCaixa.ObterNomeProdutosDaVenda: string;
var
  i: Integer;
  strNomeProdutos: string;
begin
  strNomeProdutos := '';
  for i := 1 to gridDetalhes.RowCount - 1 do
  begin
    strNomeProdutos := strNomeProdutos + gridDetalhes.Cells[1, i] + ',';
  end;
  Result := strNomeProdutos;
end;

function TfrmCaixa.ObterQuantidadeProdutosDaVenda: string;
var
  i: Integer;
  strQtdProdutos: string;
begin
  strQtdProdutos := '';
  for i := 1 to gridDetalhes.RowCount - 1 do
  begin
    strQtdProdutos := strQtdProdutos + gridDetalhes.Cells[2, i] + ',';
  end;
  Result := strQtdProdutos;
end;

function TfrmCaixa.ObterValorProdutosDaVenda: string;
var
  i: Integer;
  strVlrProdutos: string;
begin
  strVlrProdutos := '';
  for i := 1 to gridDetalhes.RowCount - 1 do
  begin
    strVlrProdutos := strVlrProdutos + gridDetalhes.Cells[3, i] + '.';
  end;
  Result := strVlrProdutos;
end;

end.
