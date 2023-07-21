unit Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  ConexaoBancoSQL, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TfrmProdutos = class(TForm)
    imgBackProdutos: TImage;
    gridProdutos: TDBGrid;
    txtNomeProduto: TEdit;
    txtPrecoProduto: TEdit;
    txtEstoqueProduto: TEdit;
    lblNome: TLabel;
    lblPreco: TLabel;
    lblQuantidade: TLabel;
    btnGravar: TButton;
    btnLimpar: TButton;
    btnVoltar: TButton;
    lblEditar: TLabel;
    procedure FormShow(Sender: TObject);
    procedure gridProdutosCellClick(Column: TColumn);
    procedure btnLimparClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InserirProduto(Nome: string; Preco, Estoque: Currency);
    procedure AtualizarProduto(Nome: string; ID_Produto, Preco, Estoque: Currency);
  end;

var
  gridProdutos: TDBGrid;
  frmProdutos: TfrmProdutos;
  idCodigoProduto : Integer;
implementation

{$R *.dfm}

procedure TfrmProdutos.btnGravarClick(Sender: TObject);
begin
    if (idCodigoProduto = 0) then
    begin
      InserirProduto(txtNomeProduto.Text,
                      StrToCurr(txtPrecoProduto.Text),
                      StrToCurr(txtEstoqueProduto.Text));
    end
    else
    begin
      AtualizarProduto(txtNomeProduto.Text,
                       idCodigoProduto,
                       StrToCurr(txtPrecoProduto.Text),
                       StrToCurr(txtEstoqueProduto.Text));
    end;
    {ConexaoBanco.QueryProdutos.Close;
    ConexaoBanco.QueryProdutos.ExecSQL;
    ConexaoBanco.QueryProdutos.Open;
    gridProdutos.DataSource.DataSet.Close;
    gridProdutos.DataSource.DataSet.Open;
    gridProdutos.Refresh;
    gridProdutos.Update;}
end;

procedure TfrmProdutos.btnLimparClick(Sender: TObject);
begin
   gridProdutos.CleanupInstance;
   txtNomeProduto.Text := '';
   txtPrecoProduto.Text := '';
   txtEstoqueProduto.Text := '';
   lblEditar.Visible := False;
end;

procedure TfrmProdutos.btnVoltarClick(Sender: TObject);
begin
  Parent.Hide;
  frmProdutos.Free;
  Close;
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  ConexaoBanco.QueryTmp.SQL.Text :=
    'SELECT * FROM Produtos';
  ConexaoBanco.QueryTmp.Open;
  ConexaoBanco.BdSource.DataSet := ConexaoBanco.QueryTmp;
  gridProdutos.DataSource := ConexaoBanco.BdSource;
  gridProdutos.Columns[0].Title.Caption := 'Cod.';
  gridProdutos.Columns[0].Width := 30;
  gridProdutos.Columns[1].Width := 110;
  gridProdutos.Columns[2].Width := 40;
  gridProdutos.Columns[3].Width := 40;
end;

procedure TfrmProdutos.gridProdutosCellClick(Column: TColumn);
begin
  lblEditar.Visible := true;
  if Assigned(Column.Field) and not Column.Field.IsNull then
  begin
    with gridProdutos.DataSource.DataSet do
    begin
      txtNomeProduto.Text := FieldByName('Nome').AsString;
      txtPrecoProduto.Text := FieldByName('Preco').AsString;
      txtEstoqueProduto.Text := FieldByName('Estoque').AsString;
      idCodigoProduto := FieldByName('ProdutoID').AsInteger;
    end;
  end;
end;

procedure TfrmProdutos.InserirProduto(Nome: string; Preco, Estoque: Currency);
begin
  // Prepare a instrução SQL para a inserção
  ConexaoBanco.Conexao.Open;
  ConexaoBanco.QueryTmp.SQL.Text :=
    'INSERT INTO Produtos (Nome, Preco, Estoque) VALUES (:Nome, :Preco, :Estoque)';

  // Atribua os valores dos parâmetros na instrução SQL
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Nome').Value := Nome;
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Preco').Value := Preco;
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Estoque').Value := Estoque;

  try
    // Execute a instrução SQL
    ConexaoBanco.QueryTmp.ExecSQL;
    ShowMessage('Produto inserido com sucesso!');
    ConexaoBanco.QueryTmp.Close;
  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao inserir o produto: ' + E.Message);
  end;
end;


procedure TfrmProdutos.AtualizarProduto(Nome: string; ID_Produto, Preco, Estoque: Currency);
begin
  // Prepare a instrução SQL para a inserção
  ConexaoBanco.Conexao.Open;
  ConexaoBanco.QueryTmp.SQL.Text :=
    'UPDATE Dbo.Produtos SET Nome = :Nome           ,'+
                           'Preco = :Preco          ,'+
                         'Estoque = :Estoque        '+
                 'WHERE ProdutoID = :ID_Produto     ';

  // Atribua os valores dos parâmetros na instrução SQL

  ConexaoBanco.QueryTmp.Parameters.ParamByName('Nome').Value := Nome;
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Preco').Value := Preco;
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Estoque').Value := Estoque;
  ConexaoBanco.QueryTmp.Parameters.ParamByName('ID_Produto').Value := FloatToStr(ID_Produto);

  try
    // Execute a instrução SQL
    ConexaoBanco.QueryTmp.ExecSQL;
    ShowMessage('Produto inserido com sucesso!');
    ConexaoBanco.QueryTmp.Close;
  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao inserir o produto: ' + E.Message);
  end;
end;



end.
