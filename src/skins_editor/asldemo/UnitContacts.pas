unit UnitContacts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UnitChildForm, sSkinProvider, StdCtrls, Buttons, sBitBtn;

type
  TFormContacts = class(TChildForm)
    sButton5: TsBitBtn;
    sButton6: TsBitBtn;
    procedure sButton5Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  FormContacts: TFormContacts;

implementation

uses MainUnit, ShellAPI;

{$R *.DFM}

procedure TFormContacts.sButton5Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar('mailto: support@alphaskins.com'), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormContacts.sButton6Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar('http://www.alphaskins.com'), nil, nil, SW_SHOWNORMAL);
end;

end.
