{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit SignUp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Hash, Vcl.Mask, Vcl.DBCtrls;

type
  TRegistrar = class(TForm)
    edit_user: TEdit;
    lbl_title: TLabel;
    lbl_user: TLabel;
    lbl_password: TLabel;
    btn_submit: TButton;
    btn_cancel: TButton;
    db_edit_id: TDBEdit;
    lbl_repeat_password: TLabel;
    db_edit_name: TDBEdit;
    mask_password: TMaskEdit;
    mask_repeat_password: TMaskEdit;
    procedure btn_submitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Registrar: TRegistrar;

implementation

{$R *.dfm}

uses db;

procedure TRegistrar.btn_submitClick(Sender: TObject);
var
  id, hash:string;
begin
  db.DataModule1.FDQuery8.SQL.Clear;

  db.DataModule1.FDQuery8.SQL.Add('select nome from usuarios where nome = :nome');

  db.DataModule1.FDQuery8.ParamByName('nome').AsString := edit_user.Text;

  db.DataModule1.FDQuery8.Active;
  db.DataModule1.FDQuery8.Open;

  if (edit_user.Text = '') or (mask_password.Text = '') or (mask_repeat_password.Text = '') then
    begin
      edit_user.Color := clMaroon;
      mask_password.Color := clMaroon;
      mask_repeat_password.Color := clMaroon;
      ShowMessage('Preencha todos os dados');      
    end
  else if mask_password.Text  <> mask_repeat_password.Text  then
    begin
      mask_password.Color := clMaroon;
      mask_repeat_password.Color := clMaroon;
      ShowMessage('As senhas digitadas �o s�o iguais!');
    end
  else if db_edit_name.Text = edit_user.Text  then
    begin
      edit_user.Color := clMaroon;
      ShowMessage('J� existe um usu�rio com esse nome, use outro');      
    end
  else
    begin
      try
        db.DataModule1.FDQuery6.SQL.Clear;

        if db_edit_id.Text = '' then
          begin
            id := '1';
          end
        else
          begin
            id := IntToStr(StrToInt(db_edit_id.Text ) + 1);
          end;

        hash := THashMD5.GetHashString(mask_password.Text );

        db.DataModule1.FDQuery6.SQL.Add('insert into usuarios(id, nome, senha) values ('
        + chr(39) + id + chr(39) + ',' + chr(39) + edit_user.Text  + chr(39) + ',' + chr(39)
        + hash + chr(39)+ ');');

        db.DataModule1.FDQuery6.Active;
        db.DataModule1.FDQuery6.ExecSQL;

        ShowMessage('Usu�rio Cadastrado, fa�a Login!');

        db_edit_id.DataSource.DataSet.Refresh;

        Registrar.Close;
      except
        ShowMessage('N�o foi possivel cadastrar o usu�rio!');

      end;
    end;

end;
end.
