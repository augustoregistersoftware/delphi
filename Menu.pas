unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Cadastro2: TMenuItem;
    Fornecedor1: TMenuItem;
    Fornecedor2: TMenuItem;
    Estoque1: TMenuItem;
    Relatorios1: TMenuItem;
    Relatorios2: TMenuItem;
    Sair1: TMenuItem;
    Movimentaes1: TMenuItem;
    procedure Cadastro2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses CadastroLogin;

procedure TFrmMenu.Cadastro2Click(Sender: TObject);
begin
    FrmCadastroLogin := TFrmCadastroLogin.Create(self);
    FrmCadastroLogin.ShowModal;
end;

end.
