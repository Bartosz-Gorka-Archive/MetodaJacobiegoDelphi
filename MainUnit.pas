unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, StdCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    Application: TMenuItem;
    HelpOption: TMenuItem;
    CloseApplication: TMenuItem;
    LabelSetting: TLabel;
    VarNumber: TEdit;
    Button1: TButton;
    UpDownVarNumber: TUpDown;
    Label1: TLabel;
    procedure CloseApplicationClick(Sender: TObject);
    procedure HelpOptionClick(Sender: TObject);
    procedure VarNumberChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ CLOSE APPLICATIONS AS OPTION IN MENU }
procedure TMainForm.CloseApplicationClick(Sender: TObject);
begin
  MainForm.Close();
end;

{ OPEN HELP FORM WITH INFORMATIONS HOW TO USE A PROGRAM }
procedure TMainForm.HelpOptionClick(Sender: TObject);
begin
  //
end;

procedure TMainForm.VarNumberChange(Sender: TObject);
begin
  if(VarNumber.Text <> '') then
  begin
    if(StrToInt(VarNumber.Text) < 2) then
      VarNumber.Text := '2';
  end
  else
    VarNumber.Text := '2';
end;

end.
