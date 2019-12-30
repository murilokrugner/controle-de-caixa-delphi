unit SignIn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TEntrar = class(TForm)
    edit_user: TEdit;
    edit_password: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Entrar: TEntrar;

implementation

{$R *.dfm}

uses SignUp, db;

procedure TEntrar.Button2Click(Sender: TObject);
begin
  db.DataModule1.FDQuery8.SQL.Clear;

  db.DataModule1.FDQuery8.SQL.Add('select nome, password from usuarios where nome = :nome and password = :password');

  db.DataModule1.FDQuery8.ParamByName('nome').AsString := edit_user;

  db.DataModule1.FDQuery8.ParamByName('password').AsString := edit_password;

  db.DataModule1.FDQuery8.Active;
  db.DataModule1.FDQuery8.Open;

  Registrar := TRegistrar.Create(self);
  Registrar.ShowModal;
end;

end.
