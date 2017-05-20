unit AppInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls;

type
  TApplicationData = class(TForm)
    LabelInfo: TLabel;
    LabelTitle: TLabel;
    LabelAuthor: TLabel;
    LabelName: TLabel;
    LabelGroup: TLabel;
    LabelIndex: TLabel;
    LabelURL: TLabel;
    procedure LabelURLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ApplicationData: TApplicationData;

implementation

{$R *.dfm}

{ OPEN SITE URL ON LABEL CLICK }
procedure TApplicationData.LabelURLClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, PChar('open'), PChar('www.bartosz-gorka.pl'), nil, nil, SW_SHOW);
end;

end.
