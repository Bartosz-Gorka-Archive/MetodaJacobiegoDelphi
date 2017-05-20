unit AppInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls;

type
  TApplicationData = class(TForm)
    LabelInfo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Label6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ApplicationData: TApplicationData;

implementation

{$R *.dfm}

procedure TApplicationData.Label6Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, PChar('open'), PChar('www.bartosz-gorka.pl'), nil, nil, SW_SHOW);
end;

end.
