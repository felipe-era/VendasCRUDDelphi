unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Produtos,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Clientes, Vendas, Consultas;

type
  TfrmMenu = class(TForm)
    btnClientes: TButton;
    btnProdutos: TButton;
    pnlClientes: TPanel;
    grpCadastros: TGroupBox;
    imgBackCadastros: TImage;
    grpVendas: TGroupBox;
    btnVendas: TButton;
    grpConsulta: TGroupBox;
    imgBackVendas: TImage;
    imgBackConsultas: TImage;
    btnConsultas: TButton;
    lblCadastros: TLabel;
    lblVendas: TLabel;
    Label1: TLabel;
    procedure btnClientesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVendasClick(Sender: TObject);
    procedure btnConsultasClick(Sender: TObject);
  private
    { Private declarations }
  public
    frmClientes: TfrmClientes;
    frmProdutos: TfrmProdutos;
    frmCaixa: TfrmCaixa;
    frmConsultas : TfrmConsultas;
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;


implementation

{$R *.dfm}




procedure TfrmMenu.btnClientesClick(Sender: TObject);
begin
  frmClientes := TfrmClientes.Create(pnlClientes);
  frmClientes.Visible := False;
  frmClientes.Parent := pnlClientes;
  frmClientes.Align := alClient;
  frmClientes.BorderStyle := bsNone;
  pnlClientes.Visible := True;
  pnlClientes.BringToFront;
  frmClientes.Visible := True;
end;

procedure TfrmMenu.btnConsultasClick(Sender: TObject);
begin
    frmConsultas:= TfrmConsultas.Create(pnlClientes);
  frmConsultas.Visible := False;
  frmConsultas.Parent := pnlClientes;
  frmConsultas.Align := alClient;
  frmConsultas.BorderStyle := bsNone;
  pnlClientes.Visible := True;
  pnlClientes.BringToFront;
  frmConsultas.Visible := True;
end;

procedure TfrmMenu.btnProdutosClick(Sender: TObject);
begin
  frmProdutos:= TfrmProdutos.Create(pnlClientes);
  frmProdutos.Visible := False;
  frmProdutos.Parent := pnlClientes;
  frmProdutos.Align := alClient;
  frmProdutos.BorderStyle := bsNone;
  pnlClientes.Visible := True;
  pnlClientes.BringToFront;
  frmProdutos.Visible := True;
end;

procedure TfrmMenu.btnVendasClick(Sender: TObject);
begin
  frmCaixa:= TfrmCaixa.Create(pnlClientes);
  frmCaixa.Visible := False;
  frmCaixa.Parent := pnlClientes;
  frmCaixa.Align := alClient;
  frmCaixa.BorderStyle := bsNone;
  pnlClientes.Visible := True;
  pnlClientes.BringToFront;
  frmCaixa.Visible := True;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Sender is TfrmClientes then
  begin
    TfrmClientes(Sender).Close;
    // Limpar ou atualizar quaisquer outras referências relacionadas ao formulário "Clientes" aqui
  end;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
   frmMenu.Show;
   //imgBackCadastros.Picture.LoadFromFile('C:\Users\felip\Desktop\feee\Projetos\Delphi\Vendas\Imagens\abc.jpg');
   //grpCadastros.ParentBackground := False;
end;








end.
