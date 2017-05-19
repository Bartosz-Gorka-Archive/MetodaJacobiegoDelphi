program MetodaJacobiego_Project;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MyVarType in 'MyVarType.pas',
  JacobiEqu in 'JacobiEqu.pas',
  AppInfo in 'AppInfo.pas' {ApplicationData},
  HelpUnit in 'HelpUnit.pas' {HelpForm},
  IntervalArithmetic32and64 in 'IntervalArithmetic32and64.pas',
  JacobiEquInterval in 'JacobiEquInterval.pas',
  MyIntervalType in 'MyIntervalType.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Metoda Jacobiego - Bartosz Górka';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TApplicationData, ApplicationData);
  Application.CreateForm(THelpForm, HelpForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.Run;
end.
