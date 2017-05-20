unit MainUnit;

{$N+,E-}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, StdCtrls, Grids, Clipbrd, MyVarType,
  MyIntervalType, IntervalArithmetic32and64, JacobiEquInterval,
  JacobiEqu, AppInfo, HelpUnit, RegularExpressions;

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
    procedure ResizeGrids(value: Integer);
    procedure ButtonClearClick(Sender: TObject);
    procedure PrepareStringGrids(Clear: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSolveClick(Sender: TObject);
    procedure ImportExample(Number: Integer);
    procedure ButtonReadExampleClick(Sender: TObject);
    procedure WriteExample();
    procedure StoreResults();
    procedure ApplicationClick(Sender: TObject);
    procedure ReadFromGrids();
    procedure ClearData();
    procedure RemoveNonNumbersASCIIFromStart(var Str: AnsiString);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  n, mit, st, it: Integer;
  eps: Extended;
  a: matrix;
  b, x: vector;

  ai: intervalMatrix;
  bi, xi: intervalVector;

  floatAritmetic: Boolean;
  correct: Boolean;

const
  CRLF = #13#10;
const
  RemoveChar = ['a'..'z', '=', '\'];

implementation

{$R *.dfm}

procedure TMainForm.RemoveNonNumbersASCIIFromStart(var Str: AnsiString);
const
  ALLOW_CHAR = ['0'..'9', '-', ';', ',', '.'];
var
  i: Integer;
  firstIndex: integer;
begin
  firstIndex := 0;
  for i := 1 to length(Str) do
    if Str[i] in ALLOW_CHAR then
    begin
      firstIndex := i;
      break;
    end;
  if firstIndex > 0 then
    Delete(Str, 1, firstIndex - 1)
  else
    Str := '';
end;

procedure TMainForm.ReadFromGrids();
var
  I, j: Integer;
  str: String;
  List: TStringList;
begin
  n := StrToInt(VarNumber.Text);
  mit := StrToInt(IterNumber.Text);
  eps := Exp(-StrToInt(EditEpsilon.Text));

  if (floatAritmetic) then
  begin
    SetLength(a, n + 1);
    SetLength(b, n + 1);
    SetLength(x, n + 1);
    for I := 0 to n + 1 do
      SetLength(a[I], n + 1);

    for I := 1 to StringGridStartVal.ColCount - 1 do
    begin
      str := StringGridStartVal.Cells[I, 1];
      x[I] := StrToFloat(str);
    end;

    for I := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 2 do
      begin
        str := StringGridEquations.Cells[j, I];
        a[I, j] := StrToFloat(str);
      end;


      str := StringGridEquations.Cells[StringGridEquations.ColCount - 1, I];
      //str := ReplaceAll(str, RemoveChar, EmptyChar, TRUE);
      b[I] := StrToFloat(str);
    end;

    for I := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 2 do
      begin
        Write(I);
        Write('-');
        Write(j);
        WriteLn(a[I, j]);
      end;
    end;
  end
  else
  begin
    correct := True;
    List := TStringList.Create;

    SetLength(ai, n + 1);
    SetLength(bi, n + 1);
    SetLength(xi, n + 1);
    for I := 0 to n + 1 do
      SetLength(ai[I], n + 1);

    for I := 1 to StringGridStartVal.ColCount - 1 do
    begin
      try
        List.LineBreak := ';';
        List.Text := StringGridStartVal.Cells[I, 1];
        if (List.Count = 2) then
        begin
          xi[I].a := StrToFloat(List[0]);
          xi[I].b := StrToFloat(List[1]);
          if (xi[I].a > xi[I].b) then
          begin
            correct := False;
            break;
          end;
        end;
      finally
        List.Clear;
      end;
    end;

    if (correct) then
      for I := 1 to StringGridEquations.RowCount - 1 do
      begin
        for j := 1 to StringGridEquations.ColCount - 2 do
        begin
          try
            List.LineBreak := ';';
            List.Text := StringGridEquations.Cells[j, I];
            if (List.Count = 2) then
            begin
              ai[I, j].a := StrToFloat(List[0]);
              ai[I, j].b := StrToFloat(List[1]);
              if (ai[I, j].a > ai[I, j].b) then
              begin
                correct := False;
                break;
              end;
            end;
          finally
            List.Clear;
          end;
        end;

        try
          List.LineBreak := ';';
          List.Text := StringGridEquations.Cells
            [StringGridEquations.ColCount - 1, I];
          if (List.Count = 2) then
          begin
            bi[I].a := StrToFloat(List[0]);
            bi[I].b := StrToFloat(List[1]);
            if (bi[I].a > bi[I].b) then
            begin
              correct := False;
              break;
            end;
          end;
        finally
          List.Clear;
        end;
      end;

    List.Free;

    for I := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 2 do
      begin
        Write(I);
        Write('-');
        Write(j);
        Write(ai[I, j].a);
        WriteLn(ai[I, j].b);
      end;
    end;

    if (not correct) then
      MessageDlg
        ('B³¹d przy wczytywaniu danych! SprawdŸ poprawnoœæ przedzia³ów.',
        mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.ImportExample(Number: Integer);
var
  I: Integer;
begin
  // Przyk³ad 1
  case Number of
    1:
      begin
        floatAritmetic := True;
        n := 4;
        SetLength(a, n + 1);
        SetLength(b, n + 1);
        SetLength(x, n + 1);
        for I := 0 to n + 1 do
          SetLength(a[I], n + 1);
        a[1, 1] := 0;
        a[1, 2] := 0;
        a[1, 3] := 1;
        a[1, 4] := 2;
        a[2, 1] := 2;
        a[2, 2] := 1;
        a[2, 3] := 0;
        a[2, 4] := 2;
        a[3, 1] := 7;
        a[3, 2] := 3;
        a[3, 3] := 0;
        a[3, 4] := 1;
        a[4, 1] := 0;
        a[4, 2] := 5;
        a[4, 3] := 0;
        a[4, 4] := 0;
        b[1] := 1;
        b[2] := 1;
        b[3] := 1;
        b[4] := 1;
        mit := 100;
        eps := Exp(-14);
        x[1] := 0;
        x[2] := 0;
        x[3] := 0;
        x[4] := 0;
      end;
    2:
      begin
        floatAritmetic := True;
        n := 4;
        SetLength(a, n + 1);
        SetLength(b, n + 1);
        SetLength(x, n + 1);
        for I := 0 to n + 1 do
          SetLength(a[I], n + 1);
        a[1, 1] := -12.235;
        a[1, 2] := 1.229;
        a[1, 3] := 0.5597;
        a[1, 4] := 0;
        a[2, 1] := 1.229;
        a[2, 2] := -6.78;
        a[2, 3] := 0.765;
        a[2, 4] := 0;
        a[3, 1] := 0.5597;
        a[3, 2] := 0.765;
        a[3, 3] := 91.0096;
        a[3, 4] := 2;
        a[4, 1] := 0;
        a[4, 2] := 0;
        a[4, 3] := -2;
        a[4, 4] := 5.5;
        b[1] := 0.956;
        b[2] := 51.5603;
        b[3] := 2;
        b[4] := 5.8;
        mit := 10;
        eps := Exp(-14);
        x[1] := 2;
        x[2] := 0.75;
        x[3] := -1;
        x[4] := 0.9;
      end;
    3:
      begin
        floatAritmetic := True;
        n := 4;
        SetLength(a, n + 1);
        SetLength(b, n + 1);
        SetLength(x, n + 1);
        for I := 0 to n + 1 do
          SetLength(a[I], n + 1);
        a[1, 1] := -12.235;
        a[1, 2] := 1.229;
        a[1, 3] := 0.5597;
        a[1, 4] := 0;
        a[2, 1] := 1.229;
        a[2, 2] := -6.78;
        a[2, 3] := 0.765;
        a[2, 4] := 0;
        a[3, 1] := 0.5597;
        a[3, 2] := 0.765;
        a[3, 3] := 91.0096;
        a[3, 4] := 2;
        a[4, 1] := 0;
        a[4, 2] := 0;
        a[4, 3] := -2;
        a[4, 4] := 5.5;
        b[1] := 0.956;
        b[2] := 51.5603;
        b[3] := 2;
        b[4] := 5.8;
        mit := 100;
        eps := Exp(-14);
        x[1] := 2;
        x[2] := 0.75;
        x[3] := -1;
        x[4] := 0.9;
      end;
  else
    begin
      ShowMessage('B³¹d przy wczytywaniu przyk³adu!');
    end;
  end;

  WriteLn(IntToStr(n));

end;

procedure TMainForm.WriteExample();
var
  I, j: Integer;
begin
  if (floatAritmetic) then
    RadioButtonZmienno.Checked := True
  else
    RadioButtonPrzedzialowa.Checked := True;

  EditEpsilon.Text := IntToStr(14);
  IterNumber.Text := IntToStr(mit);
  VarNumber.Text := IntToStr(n);

  for j := 1 to StringGridStartVal.ColCount - 1 do
    StringGridStartVal.Cells[j, 1] := FloatToStr(x[j]);

  for I := 1 to StringGridEquations.RowCount - 1 do
  begin
    for j := 1 to StringGridEquations.ColCount - 2 do
      StringGridEquations.Cells[j, I] := FloatToStr(a[I, j]);
    StringGridEquations.Cells[StringGridEquations.ColCount - 1, I] :=
      FloatToStr(b[I]);
  end;
end;

procedure TMainForm.PrepareStringGrids(Clear: Boolean);
var
  I, j: Integer;
begin
  for j := 1 to StringGridEquations.ColCount - 2 do
    StringGridEquations.Cells[j, 0] := 'x[' + IntToStr(j) + ']';

  StringGridEquations.Cells[StringGridEquations.ColCount - 1, 0] := 'Wartoœæ B';

  for j := 1 to StringGridEquations.RowCount - 1 do
    StringGridEquations.Cells[0, j] := 'Równanie ' + IntToStr(j);

  for j := 1 to StringGridStartVal.ColCount - 1 do
    StringGridStartVal.Cells[j, 0] := 'x[' + IntToStr(j) + ']';

  StringGridStartVal.Cells[0, 1] := 'Wartoœæ';

  // If set to clear all data in StringGrids
  if (Clear) then
  begin
    for j := 1 to StringGridStartVal.ColCount - 1 do
      StringGridStartVal.Cells[j, 1] := '';

    for I := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 1 do
        StringGridEquations.Cells[j, I] := '';
    end;
  end;
end;

{ CLEAR RESULTS IN MEMORESULTS }
procedure TMainForm.ApplicationClick(Sender: TObject);
begin
  AppInfo.ApplicationData.Show();
end;

procedure TMainForm.ButtonClearClick(Sender: TObject);
begin
  PrepareStringGrids(True);
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

procedure TMainForm.ButtonReadExampleClick(Sender: TObject);
var
  Str : AnsiString;
begin
  ImportExample(StrToInt(ExampleNumber.Text));
  WriteExample();

  Str := 'a-908asd¹œæ_asd=';
  WriteLn(Str);
  Str := TRegEx.Replace(Str, '^[+-]?[0-9]+', '');
  WriteLn(Str);
end;

procedure TMainForm.ButtonSolveClick(Sender: TObject);
begin
  if (RadioButtonZmienno.Checked) then
    floatAritmetic := True
  else
    floatAritmetic := False;

  ReadFromGrids();

  if (floatAritmetic) then
  begin
    Jacobi(n, a, b, mit, eps, x, it, st);
    StoreResults();
  end
  else if (correct) then
  begin
    JacobiInterval(n, ai, bi, mit, eps, xi, it, st);
    StoreResults();
  end;

  ClearData();
end;

procedure TMainForm.ClearData();
var
  I: Integer;
begin
  SetLength(a, 0);
  SetLength(b, 0);
  SetLength(x, 0);
  SetLength(ai, 0);
  SetLength(bi, 0);
  SetLength(xi, 0);
end;

procedure TMainForm.StoreResults();
var
  I: Integer;
begin
  MemoResults.Clear();
  MemoResults.Lines.Add
    ('Wynik obliczeñ dla wprowadzonych danych uk³adu równañ:');
  MemoResults.Lines.Add('');
  case st of
    0:
      begin
        MemoResults.Lines.Add('SUKCES!');
      end;
    1:
      begin
        MemoResults.Lines.Add
          ('B£¥D - Liczba zmiennych nie mo¿e byæ mniejsza od 1.');
      end;
    2:
      begin
        MemoResults.Lines.Add('B£¥D - Macierz A jest osobliwa.');
      end;
    3:
      begin
        MemoResults.Lines.Add('CZÊŒCIOWY B£¥D - Wymagana dok³adnoœæ rozwi¹zania'
          + ' niezosta³a osi¹gniêta po ' + Format('%d', [mit]) +
          ' iteracjach.');
      end;
  end;

  if (st = 0) OR (st = 3) then
  begin
    if (floatAritmetic) then
    begin
      for I := 1 to n do
        MemoResults.Lines.Add('x[' + IntToStr(I) + '] = ' +
          Format('%e', [x[I]]));
    end
    else
    begin
      for I := 1 to n do
      begin
        MemoResults.Lines.Add('x[' + IntToStr(I) + ']:');
        MemoResults.Lines.Add(Format('%e%s%e', [xi[I].a, CRLF, xi[I].b]));
      end;
    end;
    MemoResults.Lines.Add('Liczba iteracji = ' + Format('%d', [it]));
  end;
end;

{ CLOSE APPLICATIONS AS OPTION IN MENU }
procedure TMainForm.CloseApplicationClick(Sender: TObject);
begin
  AppInfo.ApplicationData.Close();
  MainForm.Close();
end;

{ OPEN HELP FORM WITH INFORMATIONS HOW TO USE A PROGRAM }
procedure TMainForm.EditEpsilonChange(Sender: TObject);
begin
  if (EditEpsilon.Text <> '') then
  begin
    if (StrToInt(EditEpsilon.Text) < 1) then
      EditEpsilon.Text := '1';
    if (StrToInt(EditEpsilon.Text) > 20) then
      EditEpsilon.Text := '20';
  end
  else
    EditEpsilon.Text := '14';
end;

procedure TMainForm.ExampleNumberChange(Sender: TObject);
begin
  if (ExampleNumber.Text <> '') then
  begin
    if (StrToInt(ExampleNumber.Text) < 1) then
      ExampleNumber.Text := '1';
    if (StrToInt(ExampleNumber.Text) > 3) then
      ExampleNumber.Text := '3';
  end
  else
    ExampleNumber.Text := '1';
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PrepareStringGrids(False);
end;

procedure TMainForm.HelpOptionClick(Sender: TObject);
begin
  HelpUnit.HelpForm.Show();
end;

procedure TMainForm.IterNumberChange(Sender: TObject);
begin
  if (IterNumber.Text <> '') then
  begin
    if (StrToInt(IterNumber.Text) < 1) then
      IterNumber.Text := '1';
  end
  else
    IterNumber.Text := '1';
end;

procedure TMainForm.VarNumberChange(Sender: TObject);
begin
  if (VarNumber.Text <> '') then
  begin
    if (StrToInt(VarNumber.Text) < 2) then
      VarNumber.Text := '2';
  end
  else
    VarNumber.Text := '2';

  ResizeGrids(StrToInt(VarNumber.Text));
  PrepareStringGrids(False);
end;

procedure TMainForm.ResizeGrids(value: Integer);
begin
  StringGridEquations.ColCount := value + 2;
  StringGridEquations.RowCount := value + 1;

  StringGridStartVal.ColCount := value + 1;
end;

end.
