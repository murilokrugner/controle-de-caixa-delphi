program ProjetoCaixa;

uses
  Vcl.Forms,
  Inicio in 'Inicio.pas' {Clientes},
  cadastroFornecedores in 'cadastroFornecedores.pas' {Cadastro},
  db in 'db.pas' {DataModule1: TDataModule},
  editarClientes in 'editarClientes.pas' {Editar},
  loading in 'loading.pas' {LoadingProgress},
  SignIn in 'SignIn.pas' {Entrar},
  SignUp in 'SignUp.pas' {Registrar};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TEntrar, Entrar);
  Application.CreateForm(TRegistrar, Registrar);
  Application.CreateForm(TClientes, Clientes);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TCadastro, Cadastro);
  Application.CreateForm(TLoadingProgress, LoadingProgress);
  Application.Run;
end.
