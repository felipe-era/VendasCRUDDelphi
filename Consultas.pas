unit Consultas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Printers;

type
  TfrmConsultas = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultas: TfrmConsultas;

implementation

{$R *.dfm}

procedure PrintExample;
var
  I: Integer;
begin
  Printer.BeginDoc;
  try
    Printer.Canvas.Font.Name := 'Arial';
    Printer.Canvas.Font.Size := 12;

    // Imprime um título
    Printer.Canvas.TextOut(100, 100, 'Exemplo de Impressão');

    // Imprime algumas linhas de texto
    for I := 1 to 10 do
    begin
      Printer.Canvas.TextOut(100, 150 + (I * 20), 'Linha ' + IntToStr(I));
    end;
  finally
    Printer.EndDoc;
  end;
end;









procedure TfrmConsultas.Button1Click(Sender: TObject);
begin
PrintExample;
end;

end.
