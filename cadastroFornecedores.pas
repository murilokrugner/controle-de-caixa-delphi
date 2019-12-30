unit cadastroFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, db, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ComCtrls;

type
  TCadastro = class(TForm)
    lbl_cadastro_fornecedor: TLabel;
    edit_id: TEdit;
    edit_nome: TEdit;
    edit_telefone: TEdit;
    edit_email: TEdit;
    lbl_id: TLabel;
    lbl_nome: TLabel;
    lbl_telefone: TLabel;
    lbl_email: TLabel;
    btn_salvar: TButton;
    btn_cancelar: TButton;
    DBEdit1: TDBEdit;
    ProgressBar1: TProgressBar;
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cadastro: TCadastro;

implementation

{$R *.dfm}

uses Inicio, loading;

procedure TCadastro.btn_cancelarClick(Sender: TObject);
begin
  db.DataModule1.FDQuery2.SQL.Clear;
  Cadastro.Close;


end;

procedure TCadastro.btn_salvarClick(Sender: TObject);
var
  sql:string;
begin
  try
    ProgressBar1.Visible := True;
    ProgressBar1.Position := 0;
    ProgressBar1.Position := ProgressBar1.Position + 50;

    if (edit_nome.Text = '') or (edit_telefone.Text = '') or (edit_email.Text = '') then
      begin
        ShowMessage('Preencha todos os campos!');
      end
    else
      begin
        db.DataModule1.FDQuery2.SQL.Clear;

        sql := ('insert into clientes'
        + '(id, nome, telefone, email, excluded)'
        + 'values('+ chr(39) + edit_id.Text + chr(39 ) + ',' + chr(39) + edit_nome.Text + chr(39 ) + ',' + chr(39) +
        edit_telefone.Text + chr(39)+ ',' +  chr(39) + edit_email.Text + chr(39) + ','  +  chr(39) + 'F' + chr(39) + ')');

        db.DataModule1.FDQuery2.SQL.Add(sql);


        db.DataModule1.FDQuery2.Active;
        db.DataModule1.FDQuery2.ExecSQL;

        ProgressBar1.Position := ProgressBar1.Position + 50;

        ShowMessage('Cliente Cadastrado com sucesso!');

        ProgressBar1.Visible := False;

        edit_nome.Clear;
        edit_telefone.Clear;
        edit_email.Clear;

        edit_id.Text := IntToStr(StrToInt(edit_id.Text) + 1);
        edit_nome.SetFocus;
        Clientes.dbgrid_clientes.DataSource.DataSet.Refresh;

      end;

  except
    ShowMessage('Cliente não cadastrado, verifique seus dados!');
  end;
end;

procedure TCadastro.FormActivate(Sender: TObject);
begin
  Cadastro.edit_nome.SetFocus;
end;

end.
