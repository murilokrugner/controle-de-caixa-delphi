unit editarClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ComCtrls;

type
  TEditar = class(TForm)
    lbl_id: TLabel;
    lbl_nome: TLabel;
    lbl_telefone: TLabel;
    lbl_email: TLabel;
    btn_salvar: TButton;
    btn_cancelar: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Editar: TEditar;

implementation

{$R *.dfm}

uses db, Inicio;

procedure TEditar.btn_salvarClick(Sender: TObject);
begin
  try
    ProgressBar1.Position := 0;
    ProgressBar1.Visible := True;
    ProgressBar1.Position := ProgressBar1.Position + 50;

    db.DataModule1.FDQuery5.SQL.Clear;

    db.DataModule1.FDQuery5.SQL.Add('update clientes set nome = '+
      chr(39) + DBEdit2.Text + chr(39) + ', telefone = ' + chr(39) +
      DBEdit3.Text + chr(39) + ', email = ' + chr(39) + DBEdit4.Text + chr(39) + 'where id = :id');

    db.DataModule1.FDQuery5.ParamByName('id').AsString := DBEdit1.Text;

    db.DataModule1.FDQuery5.Active;

    db.DataModule1.FDQuery5.Prepare;
    db.DataModule1.FDQuery5.ExecSQL;

    ProgressBar1.Position := ProgressBar1.Position + 50;

    ShowMessage('Dados do cliente atualizados!');

    ProgressBar1.Visible := False;

    Clientes.dbgrid_clientes.DataSource.DataSet.Refresh;

    Editar.Close;

  except
    ShowMessage('Não foi possivel atualizar os dados do cliente');

  end;
end;

procedure TEditar.FormCreate(Sender: TObject);
var
  select:string;
begin
  select := Clientes.dbgrid_clientes.Fields[0].value;

  db.DataModule1.FDQuery4.SQL.Clear;

  db.DataModule1.FDQuery4.SQL.Add('select * from clientes where id = :id');

  db.DataModule1.FDQuery4.ParamByName('id').AsString := select;

  db.DataModule1.FDQuery4.Open;

end;

end.
