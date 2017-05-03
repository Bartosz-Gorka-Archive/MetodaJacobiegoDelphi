program MetodaJacobiego_Project;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MyVarType in 'MyVarType.pas',
  JacobiEqu in 'JacobiEqu.pas',
  AppInfo in 'AppInfo.pas' {ApplicationData};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Metoda Jacobiego - Bartosz Górka';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TApplicationData, ApplicationData);
  Application.Run;
end.
