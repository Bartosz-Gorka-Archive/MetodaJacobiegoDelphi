unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, StdCtrls, Grids, Clipbrd, MyVarType;

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
    LabelFirstVal: TLabel;
    LabelResults: TLabel;
    MemoResults: TMemo;
    ButtonCopy: TButton;
    ButtonClearResults: TButton;
    StringGridEquations: TStringGrid;
    StringGridStartVal: TStringGrid;
    procedure CloseApplicationClick(Sender: TObject);
    procedure HelpOptionClick(Sender: TObject);
    procedure VarNumberChange(Sender: TObject);
    procedure IterNumberChange(Sender: TObject);
    procedure EditEpsilonChange(Sender: TObject);
    procedure ExampleNumberChange(Sender: TObject);
    procedure ButtonCopyClick(Sender: TObject);
    procedure ButtonClearResultsClick(Sender: TObject);
    procedure ResizeGrids(value : Integer);
    procedure ButtonClearClick(Sender: TObject);
    procedure PrepareStringGrids(Clear : Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSolveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  n, mit, eps : Integer;

implementation

{$R *.dfm}

procedure TMainForm.PrepareStringGrids(Clear : Boolean);
var
  i, j : Integer;
begin
  for j := 1 to StringGridEquations.ColCount - 2 do
    StringGridEquations.Cells[j, 0] := 'x(' + IntToStr(j) + ')';

  StringGridEquations.Cells[StringGridEquations.ColCount - 1, 0] := 'Warto�� B';

  for j := 1 to StringGridEquations.RowCount - 1 do
    StringGridEquations.Cells[0, j] := 'R�wnanie ' + IntToStr(j);

  for j := 1 to StringGridStartVal.ColCount - 1 do
    StringGridStartVal.Cells[j, 0] := 'x(' + IntToStr(j) + ')';

  StringGridStartVal.Cells[0, 1] := 'Warto��';

  // If set to clear all data in StringGrids
  if(Clear) then
  begin
    for j := 1 to StringGridStartVal.ColCount - 1 do
      StringGridStartVal.Cells[j, 1] := '';

    for i := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 1 do
        StringGridEquations.Cells[j, i] := '';
    end;
  end;
end;

{ CLEAR RESULTS IN MEMORESULTS }
procedure TMainForm.ButtonClearClick(Sender: TObject);
begin
  PrepareStringGrids(TRUE);
end;

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

procedure TMainForm.ButtonSolveClick(Sender: TObject);
begin
  n := StrToInt(VarNumber.Text);
  mit := StrToInt(IterNumber.Text);
  eps := StrToInt(EditEpsilon.Text);
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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PrepareStringGrids(FALSE);
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

  ResizeGrids(StrToInt(VarNumber.Text));
  PrepareStringGrids(FALSE);
end;

procedure TMainForm.ResizeGrids(value : Integer);
begin
  StringGridEquations.ColCount := value + 2;
  StringGridEquations.RowCount := value + 1;

  StringGridStartVal.ColCount := value + 1;
end;

end.
