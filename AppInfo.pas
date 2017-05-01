unit AppInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TApplicationData = class(TForm)
    MemoAppData: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ApplicationData: TApplicationData;

implementation

{$R *.dfm}

end.
