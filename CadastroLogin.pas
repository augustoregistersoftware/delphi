unit CadastroLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, IdHTTP, IdSSLOpenSSL, System.JSON, System.Hash;

type
  TFrmCadastroLogin = class(TForm)
    Edit1: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    grid: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    Edit5: TEdit;
    Edit6: TEdit;
    StaticText5: TStaticText;
    Button5: TButton; // Adicione o botão de busca
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject); // Adicione o evento do botão
  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
    procedure limpar;
  public
    { Public declarations }
  end;

var
  FrmCadastroLogin: TFrmCadastroLogin;
  id : string;
  loginAntigo : string;
  login : string;

implementation

{$R *.dfm}

uses Unit1;



procedure TFrmCadastroLogin.associarCampos;
var
hashedPassword: string;
begin
dm.tb_Login.FieldByName('nome').Value := Edit2.Text;
dm.tb_Login.FieldByName('cpf').Value := Edit3.Text;
dm.tb_Login.FieldByName('telefone').Value := Edit4.Text;
dm.tb_Login.FieldByName('login').Value := Edit5.Text;
  // Criptografando a senha usando SHA256
  hashedPassword := THashSHA2.GetHashString(Edit6.Text);
  dm.tb_Login.FieldByName('senha').Value := hashedPassword;
end;

procedure TFrmCadastroLogin.Button1Click(Sender: TObject);


begin
dm.query_login.Close;
dm.query_login.SQL.Clear;
dm.query_login.SQL.Add('SELECT login FROM login where login =' + Quotedstr(Trim(edit5.Text)));
dm.query_login.Open;

if not dm.query_login.IsEmpty then
begin
  login :=  dm.query_login['login'];
  MessageDlg('O Login ' + login + ' já existe!', mtInformation, mbOKCancel, 0);
  edit5.Text := '';
  edit5.SetFocus;
  exit;
end;


associarCampos;
dm.tb_Login.Post;
MessageDlg('Salvo com Sucesso !', mtInformation, mbOKCancel, 0);
limpar;
listar;
end;

procedure TFrmCadastroLogin.Button2Click(Sender: TObject);
begin
associarCampos;
dm.query_login.Close;
dm.query_login.SQL.Clear;
dm.query_login.SQL.Add('UPDATE login SET login = :login, cpf = :cpf, telefone = :telefone, login = :login, senha = :senha WHERE id_login = :id_login');
dm.query_login.ParamByName('login').Value := edit2.Text;
dm.query_login.ParamByName('cpf').Value := edit3.Text;
dm.query_login.ParamByName('telefone').Value := edit4.Text;
dm.query_login.ParamByName('login').Value := edit5.Text;
dm.query_login.ParamByName('senha').Value := edit6.Text;
dm.query_login.ParamByName('id_login').Value := id;
dm.query_login.ExecSQL;

MessageDlg('Edição Salva com Sucesso !', mtInformation, mbOKCancel, 0);
listar;
button2.Visible := false;
button3.Visible := false;
button5.Visible := true;

limpar;
end;

procedure TFrmCadastroLogin.Button3Click(Sender: TObject);
begin
if MessageDlg('Deseja Excluir ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
begin
  dm.tb_Login.Delete;
  MessageDlg('Deleção Salva com Sucesso !', mtInformation, mbOKCancel, 0);
  listar;
end;

end;

procedure TFrmCadastroLogin.Button5Click(Sender: TObject);
begin
button1.Visible := true;
button2.Visible := true;
button3.Visible := true;
button5.Visible := false;
edit2.Enabled := true;
edit3.Enabled := true;
edit4.Enabled := true;
edit5.Enabled := true;
edit6.Enabled := true;

dm.tb_Login.Insert;
end;

procedure TFrmCadastroLogin.FormCreate(Sender: TObject);
begin
dm.tb_Login.Active := true;
listar;
end;

procedure TFrmCadastroLogin.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

procedure TFrmCadastroLogin.gridCellClick(Column: TColumn);
begin
  dm.tb_Login.RecNo := grid.DataSource.DataSet.RecNo;

  edit2.Enabled := true;
  edit3.Enabled := true;
  edit4.Enabled := true;
  edit5.Enabled := true;
  edit6.Enabled := true;
  button2.Visible := true;
  button3.Visible := true;
  button5.Visible := false;

  dm.tb_Login.Edit;
  edit2.Text := dm.tb_Login.FieldByName('nome').AsString;
  edit3.Text := dm.tb_Login.FieldByName('cpf').AsString;
  edit4.Text := dm.tb_Login.FieldByName('telefone').AsString;
  edit5.Text := dm.tb_Login.FieldByName('login').AsString;
  edit6.Text := dm.tb_Login.FieldByName('senha').AsString;
  id := dm.tb_Login.FieldByName('id_login').AsString;
  loginAntigo := dm.tb_Login.FieldByName('nome').AsString;
end;


procedure TFrmCadastroLogin.limpar;
begin
   edit2.Text := '';
   edit3.Text := '';
   edit4.Text := '';
   edit5.Text := '';
   edit6.Text := '';
end;

procedure TFrmCadastroLogin.listar;
begin
     dm.query_login.Close;
     dm.query_login.SQL.Clear;
     dm.query_login.SQL.Add('SELECT id_login,nome,cpf,telefone,login FROM login ORDER BY id_login asc');
     dm.query_login.Open;

end;

end.

