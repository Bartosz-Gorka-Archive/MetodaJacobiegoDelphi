program MetodaJacobiego_Project;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Metoda Jacobiego - Bartosz Górka';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
