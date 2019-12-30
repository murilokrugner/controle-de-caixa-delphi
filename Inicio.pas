unit Inicio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, db,
  Vcl.ComCtrls, Vcl.WinXCalendars;

type
  TClientes = class(TForm)
    lbl_fornecedores: TLabel;
    dbgrid_clientes: TDBGrid;
    btn_novo: TButton;
    btn_editar: TButton;
    btn_excluir: TButton;
    ProgressBar1: TProgressBar;
    procedure btn_novoClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Clientes: TClientes;

implementation

{$R *.dfm}

uses cadastroFornecedores, editarClientes;

procedure TClientes.btn_excluirClick(Sender: TObject);
var
  select:string;
begin
  if Application.MessageBox('Deseja realmente excluir o cliente?','Excluir Cliente',mb_yesno + mb_iconquestion) = id_yes then
    begin
      try
        ProgressBar1.Position := 0;
        ProgressBar1.Visible := True;
        ProgressBar1.Position := ProgressBar1.Position + 50;

        select := dbgrid_clientes.Fields[0].value;

        db.DataModule1.FDQuery5.SQL.Clear;

        db.DataModule1.FDQuery5.SQL.Add('update clientes set excluded =' + chr(39) + 'T' + chr(39) + 'where id = :id');

        db.DataModule1.FDQuery5.ParamByName('id').AsString := select;

        db.DataModule1.FDQuery5.Active;

        db.DataModule1.FDQuery5.Prepare;
        db.DataModule1.FDQuery5.ExecSQL;

        Cadastro.Refresh;

        ProgressBar1.Position := ProgressBar1.Position + 50;

        ShowMessage('cliente excluido');

        ProgressBar1.Visible := False;

        Clientes.dbgrid_clientes.DataSource.DataSet.Refresh;

      except
        ShowMessage('N�o foi possivel excluir o cliente');

      end;
    end
    else
    begin
      ShowMessage('Opera��o cancelada!');
    end;



end;

procedure TClientes.btn_novoClick(Sender: TObject);
var
  sql, id:integer;
begin
  Cadastro := TCadastro.Create(self);

  Cadastro.DBEdit1.DataSource.DataSet.Refresh;

  if Cadastro.DBEdit1.Text = '' then
    begin
      Cadastro.edit_id.Text := '1';
    end
  else
    begin
      id := StrToInt(Cadastro.DBEdit1.Text) + 1;
      Cadastro.edit_id.Text := IntToStr(id);
    end;

  Cadastro.ShowModal;

end;

procedure TClientes.btn_editarClick(Sender: TObject);

begin
  Editar := TEditar.Create(self);
  Editar.ShowModal;
end;

end.
