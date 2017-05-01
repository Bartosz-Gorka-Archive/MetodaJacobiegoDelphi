unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, StdCtrls, Grids, Clipbrd;

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
    ButtonSolve: TButton;
    UpDownVarNumber: TUpDown;
    LabelVarNumber: TLabel;
    LabelIterNumber: TLabel;
    UpDownIterNumber: TUpDown;
    IterNumber: TEdit;
    LabelEpsilon: TLabel;
    LabelRownanie: TLabel;
    EditEpsilon: TEdit;
    UpDownEpsilon: TUpDown;
    Panel4: TPanel;
    Splitter2: TSplitter;
    RadioButtonZmienno: TRadioButton;
    RadioButtonPrzedzialowa: TRadioButton;
    LabelArytm: TLabel;
    LabelClear: TLabel;
    ButtonClear: TButton;
    LabelExample: TLabel;
    ExampleNumber: TEdit;
    UpDown1: TUpDown;
    ButtonReadExample: TButton;
    LabelEquations: TLabel;
    DrawGridEquations: TDrawGrid;
    LabelFirstVal: TLabel;
    LabelResults: TLabel;
    DrawGridStartVal: TDrawGrid;
    MemoResults: TMemo;
    ButtonCopy: TButton;
    ButtonClearResults: TButton;
    procedure CloseApplicationClick(Sender: TObject);
    procedure HelpOptionClick(Sender: TObject);
    procedure VarNumberChange(Sender: TObject);
    procedure IterNumberChange(Sender: TObject);
    procedure EditEpsilonChange(Sender: TObject);
    procedure ExampleNumberChange(Sender: TObject);
    procedure ButtonCopyClick(Sender: TObject);
    procedure ButtonClearResultsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ CLEAR RESULTS IN MEMORESULTS }
procedure TMainForm.ButtonClearResultsClick(Sender: TObject);
begin
  MemoResults.Clear;
end;

{ COPY RESULTS FROM MEMORESULTS TO CLIPBOARD }
procedure TMainForm.ButtonCopyClick(Sender: TObject);
begin
  MemoResults.SelectAll;
  MemoResults.CopyToClipboard;
end;

{ CLOSE APPLICATIONS AS OPTION IN MENU }
procedure TMainForm.CloseApplicationClick(Sender: TObject);
begin
  MainForm.Close();
end;

{ OPEN HELP FORM WITH INFORMATIONS HOW TO USE A PROGRAM }
procedure TMainForm.EditEpsilonChange(Sender: TObject);
begin
  if(EditEpsilon.Text <> '') then
  begin
    if(StrToInt(EditEpsilon.Text) < 1) then
      EditEpsilon.Text := '1';
    if(StrToInt(EditEpsilon.Text) > 16) then
      EditEpsilon.Text := '16';
  end
  else
    EditEpsilon.Text := '14';
end;

procedure TMainForm.ExampleNumberChange(Sender: TObject);
begin
  if(ExampleNumber.Text <> '') then
  begin
    if(StrToInt(ExampleNumber.Text) < 1) then
      ExampleNumber.Text := '1';
    if(StrToInt(ExampleNumber.Text) > 3) then
      ExampleNumber.Text := '3';
  end
  else
    ExampleNumber.Text := '1';
end;

procedure TMainForm.HelpOptionClick(Sender: TObject);
begin
  //
end;

procedure TMainForm.IterNumberChange(Sender: TObject);
begin
  if(IterNumber.Text <> '') then
  begin
    if(StrToInt(IterNumber.Text) < 1) then
      IterNumber.Text := '1';
  end
  else
    IterNumber.Text := '1';
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
