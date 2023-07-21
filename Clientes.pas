unit Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, ConexaoBancoSQL,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmClientes = class(TForm)
    txtNomeCadastro: TEdit;
    btnGravar: TButton;
    txtEmail: TEdit;
    txtTelefone: TEdit;
    imgBackMenuClientes: TImage;
    btnLimpar: TButton;
    btnVoltar: TButton;
    lblNome: TLabel;
    btnEmail: TLabel;
    btnTelefone: TLabel;
    lblObrigatorio: TLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ProcessarDados(Nome, Email, Telefone: string);

  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

procedure TfrmClientes.btnGravarClick(Sender: TObject);
var
  dados: TStringList;
  i: Integer;
begin
  if (txtNomeCadastro.Text = '') then
  begin
    MessageDlg('Nome do Cliente é obrigatório.', mtWarning, [mbOK], 0, mbOK);
    txtNomeCadastro.SetFocus;
    Exit;
  end
  else
  begin
    if Length(txtNomeCadastro.Text) < 4 then
    begin
      MessageDlg('O campo Nome deve ter pelo menos 4 caracteres.', mtWarning,
        [mbOK], 0, mbOK);
      txtNomeCadastro.SetFocus;
      Exit;
    end;
  end;

  ProcessarDados(txtNomeCadastro.Text, txtEmail.Text, txtTelefone.Text);

end;

procedure TfrmClientes.btnLimparClick(Sender: TObject);
begin
  txtNomeCadastro.Clear;
  txtEmail.Clear;
  txtTelefone.Clear;
  txtNomeCadastro.SetFocus;
end;

procedure TfrmClientes.btnVoltarClick(Sender: TObject);
begin
  Parent.Hide;
  frmClientes.Free;
  Close;
end;

procedure TfrmClientes.FormShow(Sender: TObject);
begin
  txtNomeCadastro.SetFocus;
end;

procedure TfrmClientes.ProcessarDados(Nome, Email, Telefone: string);
begin
  ConexaoBanco.QueryTmp.SQL.Text :=
    'insert into dbo.clientes (Nome, Email, Telefone) values (:Nome, :Email, :Telefone)';
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Nome').Value := Nome;
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Email').Value := Email;
  ConexaoBanco.QueryTmp.Parameters.ParamByName('Telefone').Value := Telefone;
  try
    // Execute a instrução SQL
    ConexaoBanco.QueryTmp.ExecSQL;
    ShowMessage('Produto inserido com sucesso!');
	ConexaoBanco.QueryTmp.Close;
  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao inserir um cliente ' + E.Message);
  end;

end;

end.
