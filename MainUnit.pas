unit MainUnit;

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
    procedure RemoveNonNumbersASCIIFromStart(var Str: String; floatAr: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  eps_number, n, mit, st, it: Integer;
  eps: Extended;
  a: matrix;
  b, x: vector;

  ai: intervalMatrix;
  bi, xi: intervalVector;

  floatAritmetic: Boolean;
  correct: Boolean;

const
  CRLF = #13#10; { \n sign }

implementation

{$R *.dfm}

{ CLEAR STRING-GRIDS FROM NON NUMBERS AND ALLOWED CHAR }
procedure TMainForm.RemoveNonNumbersASCIIFromStart(var Str: String;
  floatAr: Boolean);
begin
  if (Str <> '') then
    Str := TRegEx.Replace(Str, '[a-üA-èøØ=\":\[\]!@#$%^&*()_+.<>?/|}{. ]+', '')
  else
    Str := '';

  if (floatAr) then
    Str := TRegEx.Replace(Str, ';', '');
end;

{ READ FROM STRING-GRIDS TO MEMORY }
procedure TMainForm.ReadFromGrids();
var
  I, j: Integer;
  Str: String;
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
      Str := StringGridStartVal.Cells[I, 1];
      RemoveNonNumbersASCIIFromStart(Str, TRUE);
      x[I] := StrToFloat(Str);
    end;

    for I := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 2 do
      begin
        Str := StringGridEquations.Cells[j, I];
        RemoveNonNumbersASCIIFromStart(Str, TRUE);
        a[I, j] := StrToFloat(Str);
      end;

      Str := StringGridEquations.Cells[StringGridEquations.ColCount - 1, I];
      RemoveNonNumbersASCIIFromStart(Str, TRUE);
      b[I] := StrToFloat(Str);
    end;
  end
  else
  begin
    correct := TRUE;
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
        Str := StringGridStartVal.Cells[I, 1];
        RemoveNonNumbersASCIIFromStart(Str, FALSE);
        List.Text := Str;
        if (List.Count = 2) then
        begin
          xi[I].a := StrToFloat(List[0]);
          xi[I].b := StrToFloat(List[1]);
          if (xi[I].a > xi[I].b) then
          begin
            correct := FALSE;
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
            Str := StringGridEquations.Cells[j, I];
            RemoveNonNumbersASCIIFromStart(Str, FALSE);
            List.Text := Str;
            if (List.Count = 2) then
            begin
              ai[I, j].a := StrToFloat(List[0]);
              ai[I, j].b := StrToFloat(List[1]);
              if (ai[I, j].a > ai[I, j].b) then
              begin
                correct := FALSE;
                break;
              end;
            end;
          finally
            List.Clear;
          end;
        end;

        try
          List.LineBreak := ';';
          Str := StringGridEquations.Cells[StringGridEquations.ColCount - 1, I];
          RemoveNonNumbersASCIIFromStart(Str, FALSE);
          List.Text := Str;
          if (List.Count = 2) then
          begin
            bi[I].a := StrToFloat(List[0]);
            bi[I].b := StrToFloat(List[1]);
            if (bi[I].a > bi[I].b) then
            begin
              correct := FALSE;
              break;
            end;
          end;
        finally
          List.Clear;
        end;
      end;

    List.Free;

    if (not correct) then
      MessageDlg
        ('B≥πd przy wczytywaniu danych! Sprawdü poprawnoúÊ przedzia≥Ûw.',
        mtError, [mbOK], 0);
  end;
end;

{ EXAMPLES STORED IN MEMORY }
procedure TMainForm.ImportExample(Number: Integer);
var
  I: Integer;
begin
  case Number of
    1: // FROM BOOK
      begin
        floatAritmetic := TRUE;
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
        eps_number := 14;
        x[1] := 0;
        x[2] := 0;
        x[3] := 0;
        x[4] := 0;
      end;
    2: // FROM BOOK
      begin
        floatAritmetic := TRUE;
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
        eps := Exp(-16);
        eps_number := 16;
        x[1] := 2;
        x[2] := 0.75;
        x[3] := -1;
        x[4] := 0.9;
      end;
    3: // FROM BOOK
      begin
        floatAritmetic := TRUE;
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
        eps := Exp(-16);
        eps_number := 16;
        x[1] := 2;
        x[2] := 0.75;
        x[3] := -1;
        x[4] := 0.9;
      end;
    4:
      begin
        floatAritmetic := FALSE;
        n := 4;
        SetLength(ai, n + 1);
        SetLength(bi, n + 1);
        SetLength(xi, n + 1);
        for I := 0 to n + 1 do
          SetLength(ai[I], n + 1);
        ai[1, 1].a := 0;
        ai[1, 1].b := 0;
        ai[1, 2].a := 0;
        ai[1, 2].b := 0;
        ai[1, 3].a := 1;
        ai[1, 3].b := 1;
        ai[1, 4].a := 2;
        ai[1, 4].b := 2;
        ai[2, 1].a := 2;
        ai[2, 1].b := 2;
        ai[2, 2].a := 1;
        ai[2, 2].b := 1;
        ai[2, 3].a := 0;
        ai[2, 3].b := 0;
        ai[2, 4].a := 2;
        ai[2, 4].b := 2;
        ai[3, 1].a := 7;
        ai[3, 1].b := 7;
        ai[3, 2].a := 3;
        ai[3, 2].b := 3;
        ai[3, 3].a := 0;
        ai[3, 3].b := 0;
        ai[3, 4].a := 1;
        ai[3, 4].b := 1;
        ai[4, 1].a := 0;
        ai[4, 1].b := 0;
        ai[4, 2].a := 5;
        ai[4, 2].b := 5;
        ai[4, 3].a := 0;
        ai[4, 3].b := 0;
        ai[4, 4].a := 0;
        ai[4, 4].b := 0;
        bi[1].a := 1;
        bi[1].b := 1;
        bi[2].b := 1;
        bi[2].a := 1;
        bi[3].a := 1;
        bi[3].b := 1;
        bi[4].a := 1;
        bi[4].b := 1;
        mit := 100;
        eps := Exp(-14);
        eps_number := 14;
        xi[1].a := 0;
        xi[1].b := 0;
        xi[2].a := 0;
        xi[2].b := 0;
        xi[3].a := 0;
        xi[3].b := 0;
        xi[4].a := 0;
        xi[4].b := 0;
      end;
    5:
      begin
        floatAritmetic := FALSE;
        n := 4;
        SetLength(ai, n + 1);
        SetLength(bi, n + 1);
        SetLength(xi, n + 1);
        for I := 0 to n + 1 do
          SetLength(ai[I], n + 1);
        ai[1, 1].a := -12.235;
        ai[1, 1].b := -12.235;
        ai[1, 2].a := 1.229;
        ai[1, 2].b := 1.229;
        ai[1, 3].a := 0.5597;
        ai[1, 3].b := 0.5597;
        ai[1, 4].a := 0;
        ai[1, 4].b := 0;
        ai[2, 1].a := 1.229;
        ai[2, 1].b := 1.229;
        ai[2, 2].a := -6.78;
        ai[2, 2].b := -6.78;
        ai[2, 3].a := 0.765;
        ai[2, 3].b := 0.765;
        ai[2, 4].a := 0;
        ai[2, 4].b := 0;
        ai[3, 1].a := 0.5597;
        ai[3, 1].b := 0.5597;
        ai[3, 2].a := 0.765;
        ai[3, 2].b := 0.765;
        ai[3, 3].a := 91.0096;
        ai[3, 3].b := 91.0096;
        ai[3, 4].a := 2;
        ai[3, 4].b := 2;
        ai[4, 1].a := 0;
        ai[4, 1].b := 0;
        ai[4, 2].a := 0;
        ai[4, 2].b := 0;
        ai[4, 3].a := -2;
        ai[4, 3].b := -2;
        ai[4, 4].a := 5.5;
        ai[4, 4].b := 5.5;
        bi[1].a := 0.956;
        bi[1].b := 0.956;
        bi[2].a := 51.5603;
        bi[2].b := 51.5603;
        bi[3].a := 2;
        bi[3].b := 2;
        bi[4].a := 5.8;
        bi[4].b := 5.8;
        mit := 10;
        eps := Exp(-16);
        eps_number := 16;
        xi[1].a := 2;
        xi[1].b := 2;
        xi[2].a := 0.75;
        xi[2].b := 0.75;
        xi[3].a := -1;
        xi[3].b := -1;
        xi[4].a := 0.9;
        xi[4].b := 0.9;
      end;
    6:
      begin
        floatAritmetic := FALSE;
        n := 4;
        SetLength(ai, n + 1);
        SetLength(bi, n + 1);
        SetLength(xi, n + 1);
        for I := 0 to n + 1 do
          SetLength(ai[I], n + 1);
        ai[1, 1].a := -12.235;
        ai[1, 1].b := -12.235;
        ai[1, 2].a := 1.229;
        ai[1, 2].b := 1.229;
        ai[1, 3].a := 0.5597;
        ai[1, 3].b := 0.5597;
        ai[1, 4].a := 0;
        ai[1, 4].b := 0;
        ai[2, 1].a := 1.229;
        ai[2, 1].b := 1.229;
        ai[2, 2].a := -6.78;
        ai[2, 2].b := -6.78;
        ai[2, 3].a := 0.765;
        ai[2, 3].b := 0.765;
        ai[2, 4].a := 0;
        ai[2, 4].b := 0;
        ai[3, 1].a := 0.5597;
        ai[3, 1].b := 0.5597;
        ai[3, 2].a := 0.765;
        ai[3, 2].b := 0.765;
        ai[3, 3].a := 91.0096;
        ai[3, 3].b := 91.0096;
        ai[3, 4].a := 2;
        ai[3, 4].b := 2;
        ai[4, 1].a := 0;
        ai[4, 1].b := 0;
        ai[4, 2].a := 0;
        ai[4, 2].b := 0;
        ai[4, 3].a := -2;
        ai[4, 3].b := -2;
        ai[4, 4].a := 5.5;
        ai[4, 4].b := 5.5;
        bi[1].a := 0.956;
        bi[1].b := 0.956;
        bi[2].a := 51.5603;
        bi[2].b := 51.5603;
        bi[3].a := 2;
        bi[3].b := 2;
        bi[4].a := 5.8;
        bi[4].b := 5.8;
        mit := 5;
        eps := Exp(-16);
        eps_number := 16;
        xi[1].a := 2;
        xi[1].b := 2;
        xi[2].a := 0.75;
        xi[2].b := 0.75;
        xi[3].a := -1;
        xi[3].b := -1;
        xi[4].a := 0.9;
        xi[4].b := 0.9;
      end;
    7:
      begin
        floatAritmetic := FALSE;
        n := 4;
        SetLength(ai, n + 1);
        SetLength(bi, n + 1);
        SetLength(xi, n + 1);
        for I := 0 to n + 1 do
          SetLength(ai[I], n + 1);
        ai[1, 1].a := -12.235;
        ai[1, 1].b := -12.235;
        ai[1, 2].a := 1.229;
        ai[1, 2].b := 1.229;
        ai[1, 3].a := 0.5597;
        ai[1, 3].b := 0.5597;
        ai[1, 4].a := 0;
        ai[1, 4].b := 0;
        ai[2, 1].a := -5.229;
        ai[2, 1].b := 1.229;
        ai[2, 2].a := -2;
        ai[2, 2].b := 0;
        ai[2, 3].a := 0;
        ai[2, 3].b := 0;
        ai[2, 4].a := 0;
        ai[2, 4].b := 0;
        ai[3, 1].a := 0;
        ai[3, 1].b := 0;
        ai[3, 2].a := 0;
        ai[3, 2].b := 0;
        ai[3, 3].a := 91.0096;
        ai[3, 3].b := 91.0096;
        ai[3, 4].a := 2;
        ai[3, 4].b := 2;
        ai[4, 1].a := 0;
        ai[4, 1].b := 0;
        ai[4, 2].a := 0;
        ai[4, 2].b := 0;
        ai[4, 3].a := -2;
        ai[4, 3].b := -2;
        ai[4, 4].a := 5.5;
        ai[4, 4].b := 5.5;
        bi[1].a := 0.956;
        bi[1].b := 0.956;
        bi[2].a := 51.5603;
        bi[2].b := 51.5603;
        bi[3].a := 2;
        bi[3].b := 2;
        bi[4].a := 5.8;
        bi[4].b := 5.8;
        mit := 5;
        eps := Exp(-14);
        eps_number := 14;
        xi[1].a := 2;
        xi[1].b := 2;
        xi[2].a := 0.75;
        xi[2].b := 0.75;
        xi[3].a := -1;
        xi[3].b := -1;
        xi[4].a := 0.9;
        xi[4].b := 0.9;
      end
  else
    begin
      ShowMessage('B≥πd przy wczytywaniu przyk≥adu!');
    end;
  end;
end;

{ WRITE EXAMPLE FROM MEMORY TO STRING-GRIDS }
procedure TMainForm.WriteExample();
var
  I, j: Integer;
begin
  EditEpsilon.Text := IntToStr(eps_number);
  IterNumber.Text := IntToStr(mit);
  VarNumber.Text := IntToStr(n);

  if (floatAritmetic) then
  begin
    RadioButtonZmienno.Checked := TRUE;
    for j := 1 to StringGridStartVal.ColCount - 1 do
      StringGridStartVal.Cells[j, 1] := FloatToStr(x[j]);

    for I := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 2 do
        StringGridEquations.Cells[j, I] := FloatToStr(a[I, j]);
      StringGridEquations.Cells[StringGridEquations.ColCount - 1, I] :=
        FloatToStr(b[I]);
    end;
  end
  else
  begin
    RadioButtonPrzedzialowa.Checked := TRUE;
    for j := 1 to StringGridStartVal.ColCount - 1 do
      StringGridStartVal.Cells[j, 1] := FloatToStr(xi[j].a) + ';' +
        FloatToStr(xi[j].b);

    for I := 1 to StringGridEquations.RowCount - 1 do
    begin
      for j := 1 to StringGridEquations.ColCount - 2 do
        StringGridEquations.Cells[j, I] := FloatToStr(ai[I, j].a) + ';' +
          FloatToStr(ai[I, j].b);
      StringGridEquations.Cells[StringGridEquations.ColCount - 1, I] :=
        FloatToStr(bi[I].a) + ';' + FloatToStr(bi[I].b);
    end;
  end;
end;

{ DISPLAY VALUES IN STRING-GRIDS, ROW AND COLUMNS TITLE }
procedure TMainForm.PrepareStringGrids(Clear: Boolean);
var
  I, j: Integer;
begin
  for j := 1 to StringGridEquations.ColCount - 2 do
    StringGridEquations.Cells[j, 0] := 'x[' + IntToStr(j) + ']';

  StringGridEquations.Cells[StringGridEquations.ColCount - 1, 0] := 'WartoúÊ B';

  for j := 1 to StringGridEquations.RowCount - 1 do
    StringGridEquations.Cells[0, j] := 'RÛwnanie ' + IntToStr(j);

  for j := 1 to StringGridStartVal.ColCount - 1 do
    StringGridStartVal.Cells[j, 0] := 'x[' + IntToStr(j) + ']';

  StringGridStartVal.Cells[0, 1] := 'WartoúÊ';

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

{ OPEN APPLICATION DATA FORM }
procedure TMainForm.ApplicationClick(Sender: TObject);
begin
  AppInfo.ApplicationData.Show();
end;

{ PROCEDURE ON CLICK CLEAR BUTTON }
procedure TMainForm.ButtonClearClick(Sender: TObject);
begin
  PrepareStringGrids(TRUE);
end;

{ PROCEDURE ON CLICK CLEAR RESULTS }
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

{ PROCEDURE ON CLICK IMPORT EXAMPLES FROM MEMORY TO APPLICATION }
procedure TMainForm.ButtonReadExampleClick(Sender: TObject);
begin
  ImportExample(StrToInt(ExampleNumber.Text));
  WriteExample();
end;

{ PROCEDURE SOLVE PROBLEM }
procedure TMainForm.ButtonSolveClick(Sender: TObject);
begin
  try
    ClearData();
    floatAritmetic := TRUE;

    ButtonSolve.Enabled := FALSE;
    ButtonSolve.Caption := 'LiczÍ...';

    if (RadioButtonZmienno.Checked) then
      floatAritmetic := TRUE
    else
      floatAritmetic := FALSE;

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

  finally
    ClearData();
    ButtonSolve.Enabled := TRUE;
    ButtonSolve.Caption := '&Oblicz';
  end;
end;

{ CLEAR ARRAYS }
procedure TMainForm.ClearData();
begin
  SetLength(a, 0);
  SetLength(b, 0);
  SetLength(x, 0);
  SetLength(ai, 0);
  SetLength(bi, 0);
  SetLength(xi, 0);
end;

{ DISPLAY RESULTS TO USER }
procedure TMainForm.StoreResults();
var
  I: Integer;
  left, right : String;
begin
  MemoResults.Clear();
  MemoResults.Lines.Add
    ('Wynik obliczeÒ dla wprowadzonych danych uk≥adu rÛwnaÒ:');
  MemoResults.Lines.Add('');
  case st of
    0:
      begin
        MemoResults.Lines.Add('SUKCES!');
      end;
    1:
      begin
        MemoResults.Lines.Add
          ('B£•D - Liczba zmiennych nie moøe byÊ mniejsza od 1.');
      end;
    2:
      begin
        MemoResults.Lines.Add('B£•D - Macierz A jest osobliwa.');
      end;
    3:
      begin
        MemoResults.Lines.Add('CZ åCIOWY B£•D - Wymagana dok≥adnoúÊ rozwiπzania'
          + ' nie zosta≥a osiπgniÍta po ' + Format('%d', [mit]) +
          ' iteracjach.');
      end;
    4:
      begin
        MemoResults.Lines.Add
          ('B£•D - PrÛba dzielenia przez przedzia≥ zawierajπcy 0 (zero).');
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
        iends_to_strings(xi[I], left, right);
        MemoResults.Lines.Add(Format('%s%s%s', [left, CRLF, right]));
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

{ CHANGE PRECISSION }
procedure TMainForm.EditEpsilonChange(Sender: TObject);
begin
  if (EditEpsilon.Text <> '') then
  begin
    if (StrToInt(EditEpsilon.Text) < 1) then
      EditEpsilon.Text := '1';
    if (StrToInt(EditEpsilon.Text) > 26) then
      EditEpsilon.Text := '26';
  end
  else
    EditEpsilon.Text := '16';
end;

{ CHANGE NUMBER OF EXAMPLES }
procedure TMainForm.ExampleNumberChange(Sender: TObject);
begin
  if (ExampleNumber.Text <> '') then
  begin
    if (StrToInt(ExampleNumber.Text) < 1) then
      ExampleNumber.Text := '1';
    if (StrToInt(ExampleNumber.Text) > 7) then
      ExampleNumber.Text := '7';
  end
  else
    ExampleNumber.Text := '1';
end;

{ PROCEDURE CREATE FORM }
procedure TMainForm.FormCreate(Sender: TObject);
begin
  PrepareStringGrids(FALSE);
end;

{ OPEN HELP FORM WITH INFORMATIONS HOW TO USE A PROGRAM }
procedure TMainForm.HelpOptionClick(Sender: TObject);
begin
  HelpUnit.HelpForm.Show();
end;

{ CHANGE NUMBER OF MIT }
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

{ CHANGE VARIABLE NUMBER }
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
  PrepareStringGrids(FALSE);
end;

{ RESIZE GRIDS }
procedure TMainForm.ResizeGrids(value: Integer);
begin
  StringGridEquations.ColCount := value + 2;
  StringGridEquations.RowCount := value + 1;

  StringGridStartVal.ColCount := value + 1;
end;

end.
