unit UnitTitleManage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UnitChildForm, sSkinProvider, StdCtrls, sComboBox, sCheckBox;

type
  TFormTitle = class(TChildForm)
    sCheckBox1: TsCheckBox;
    ComboBox2: TsComboBox;
    sComboBox3: TsComboBox;
    procedure sCheckBox1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure sComboBox3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTitle: TFormTitle;

implementation

uses MainUnit;

{$R *.DFM}

procedure TFormTitle.sCheckBox1Click(Sender: TObject);
begin
  MainForm.sSkinProvider1.ShowAppIcon := sCheckBox1.Checked;
end;

procedure TFormTitle.ComboBox2Change(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
    0 : MainForm.sSkinProvider1.CaptionAlignment := taLeftJustify;
    1 : MainForm.sSkinProvider1.CaptionAlignment := taCenter;
    2 : MainForm.sSkinProvider1.CaptionAlignment := taRightJustify;
  end;
end;

procedure TFormTitle.sComboBox3Change(Sender: TObject);
begin
  MainForm.sSkinProvider1.TitleSkin := sComboBox3.Text
end;

end.
