program ProjetoVendas;

uses
  Vcl.Forms,
  Menu in 'Menu.pas' {frmMenu},
  Clientes in 'Clientes.pas' {frmClientes},
  Vendas in 'Vendas.pas' {frmCaixa},
  ConexaoBancoSQL in 'ConexaoBancoSQL.pas' {ConexaoBanco: TDataModule},
  Produtos in 'Produtos.pas' {frmProdutos},
  Consultas in 'Consultas.pas' {frmConsultas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmConsultas, frmConsultas);
  //Application.CreateForm(TfrmProdutos, frmProdutos);
  //Application.CreateForm(TfrmClientes, frmClientes);
  Application.CreateForm(TConexaoBanco, ConexaoBanco);
  Application.Run;
end.

