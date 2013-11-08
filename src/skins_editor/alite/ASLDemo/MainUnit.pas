unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, sScrollBar, ExtDlgs, sEdit, Menus,
  sButton, StdCtrls, sSkinProvider, sSkinManager, sCheckBox, Buttons,
  sBitBtn, sComboBox, sLabel, ImgList, sAlphaListBox, sGauge, sPanel,
  ComCtrls, CheckLst, Mask, Grids;

type
  TMainForm = class(TForm)
    sSkinManager1: TsSkinManager;
    sPanel4: TsPanel;
    ComboBox1: TsComboBox;
    OpenPictureDialog1: TOpenPictureDialog;
    MainMenu1: TMainMenu;
    MenuItem11: TMenuItem;
    MenuItem111: TMenuItem;
    MenuItem121: TMenuItem;
    MenuItem131: TMenuItem;
    MenuItem141: TMenuItem;
    MenuItem151: TMenuItem;
    MenuItem161: TMenuItem;
    MenuItem1511: TMenuItem;
    MenuItem1521: TMenuItem;
    MenuItem1531: TMenuItem;
    MenuItem1541: TMenuItem;
    MenuItem1551: TMenuItem;
    sSkinProvider1: TsSkinProvider;
    sCheckBox1: TsCheckBox;
    sButton9: TsBitBtn;
    About1: TMenuItem;
    Gotoonlinehome1: TMenuItem;
    Writetosupport1: TMenuItem;
    ImageList1: TImageList;
    sPanel1: TsPanel;
    sEdit1: TsEdit;
    sCheckBox2: TsCheckBox;
    sComboBox1: TsComboBox;
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sGauge1: TsGauge;
    sScrollBar3: TsScrollBar;
    sButton4: TsButton;
    sPanel2: TsPanel;
    sListBox1: TsListBox;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sBitBtn3: TsBitBtn;
    sCheckBox3: TsCheckBox;
    sPanel3: TsPanel;
    sButton5: TsButton;
    sPanel5: TsPanel;
    sScrollBar1: TsScrollBar;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sScrollBar2: TsScrollBar;
    sPanel6: TsPanel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sPanel7: TsPanel;
    sPanel8: TsPanel;
    sPanel9: TsPanel;
    sCheckBox4: TsCheckBox;
    sCheckBox5: TsCheckBox;
    sCheckBox6: TsCheckBox;
    sCheckBox7: TsCheckBox;
    sPanel10: TsPanel;
    sPanel11: TsPanel;
    sPanel12: TsPanel;
    sCheckBox8: TsCheckBox;
    sLabel5: TsLabel;
    sEdit2: TsEdit;
    sPanel13: TsPanel;
    sPanel14: TsPanel;
    sLabel6: TsLabel;
    sCheckBox9: TsCheckBox;
    sEdit3: TsEdit;
    sPanel15: TsPanel;
    sBitBtn4: TsBitBtn;
    sComboBox2: TsComboBox;
    sComboBox3: TsComboBox;
    sPanel16: TsPanel;
    sLabel7: TsLabel;
    sButton6: TsButton;
    sButton7: TsButton;
    sPanel17: TsPanel;
    Memo1: TMemo;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    ListBox1: TListBox;
    MaskEdit1: TMaskEdit;
    RichEdit1: TRichEdit;
    TreeView1: TTreeView;
    CheckListBox1: TCheckListBox;
    ListView1: TListView;
    procedure ComboBox1Change(Sender: TObject);
    procedure sButton9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OpenPictureDialog1SelectionChange(Sender: TObject);
    procedure sSkinManager1AfterChange(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sSkinManager1BeforeChange(Sender: TObject);
    procedure sScrollBar3Change(Sender: TObject);
    procedure sScrollBar2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sScrollBar2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sScrollBar1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sScrollBar1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sScrollBar1Change(Sender: TObject);
    procedure sScrollBar2Change(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sCheckBox4Click(Sender: TObject);
    procedure sCheckBox5Click(Sender: TObject);
    procedure sCheckBox6Click(Sender: TObject);
    procedure sCheckBox7Click(Sender: TObject);
    procedure sCheckBox8Click(Sender: TObject);
    procedure sEdit2Change(Sender: TObject);
    procedure sComboBox2Change(Sender: TObject);
    procedure sComboBox3Change(Sender: TObject);
    procedure SetActivePage(PageIndex : integer);
    procedure sEdit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var
  MainForm: TMainForm;
  Loading : boolean;
  NewBGName : string;

implementation

uses
  sSkinProps, FileCtrl, sStyleSimply, sConst, sMaskData, sVclUtils;

var
  CurPanel : TsPanel = nil;

{$R *.DFM}

procedure TMainForm.ComboBox1Change(Sender: TObject);
var
  sl : TStringList;
  s : string;
  i : integer;
begin
  if Loading then Exit;
  if ComboBox1.ItemIndex = 0 then begin
    if SelectDirectory(s, [], 0) then begin
      sSkinManager1.SkinDirectory := s;
      sl := TStringList.Create;
      sSkinManager1.SkinName := sSkinManager1.GetSkinNames(sl);
      ComboBox1.Items.Clear;
      ComboBox1.Items.Add('Skins directory...');
      for i := 0 to sl.Count - 1 do begin
        ComboBox1.Items.Add(sl[i]);
      end;
      FreeAndNil(sl);
    end;
  end
  else begin
    sSkinManager1.SkinName := ComboBox1.Text;
  end;
end;

procedure TMainForm.sButton9Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then begin
    NewBGName := OpenPictureDialog1.FileName;
    // SkinSections and PropNames are defined in sSkinProps.pas unit
    ChangeImageInSkin(NormalForm, PatternFile, OpenPictureDialog1.FileName, sSkinManager1);
    ChangeImageInSkin(NormalForm, HotPatternFile, OpenPictureDialog1.FileName, sSkinManager1);
    // Update of all controls
    sSkinManager1.UpdateSkin;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  sl : TStringList;
  i : integer;
begin
  sl := TStringList.Create;
  sSkinManager1.GetSkinNames(sl);
  ComboBox1.Clear;
  ComboBox1.Items.Add('Skins directory...');
  for i := 0 to sl.Count - 1 do begin
    ComboBox1.Items.Add(sl[i]);
  end;
  // If no available skins...
  if ComboBox1.Items.Count < 1 then begin
    ComboBox1.Items.Add('No skins available');
    ComboBox1.ItemIndex := 0;
  end
  else begin
    // Sets ComboBox to current skin name value without skin changing
    Loading := True;
    ComboBox1.ItemIndex := sl.IndexOf(sSkinManager1.SkinName) + 1;
    Loading := False;
  end;
  FreeAndNil(sl);
end;

procedure TMainForm.OpenPictureDialog1SelectionChange(Sender: TObject);
begin
  if (pos('.BMP', UpperCase(OpenPictureDialog1.FileName)) > 0) or
       (pos('.JPG', UpperCase(OpenPictureDialog1.FileName)) > 0) or
         (pos('.BMP', UpperCase(OpenPictureDialog1.FileName)) > 0) then begin
    // SkinSections and PropNames are defined in sSkinProps.pas unit
    NewBGName := OpenPictureDialog1.FileName;
    ChangeImageInSkin(s_Form, s_Pattern, OpenPictureDialog1.FileName, sSkinManager1);
    ChangeImageInSkin(s_Form, s_HotPattern, OpenPictureDialog1.FileName, sSkinManager1);
    // Update of all controls
    sSkinManager1.UpdateSkin;
  end;
end;

procedure TMainForm.sSkinManager1AfterChange(Sender: TObject);
var
  i : integer;
begin
  i := sSkinManager1.GetSkinIndex(NormalForm);
  if sSkinManager1.IsValidSkinIndex(i) then sButton9.Enabled := sSkinManager1.gd[i].ImagePercent > 0;
end;

procedure TMainForm.sCheckBox1Click(Sender: TObject);
begin
  sSkinManager1.Active := sCheckBox1.Checked;
  ComboBox1.Enabled := sSkinManager1.Active;

{  FormTitle.sCheckBox1.Enabled := sSkinManager1.Active;
  Formtitle.ComboBox2.Enabled := sSkinManager1.Active;
  Formtitle.sComboBox3.Enabled := sSkinManager1.Active;}
  sComboBox2.Enabled := sSkinManager1.Active;
  sComboBox3.Enabled := sSkinManager1.Active;
end;

procedure TMainForm.sSkinManager1BeforeChange(Sender: TObject);
begin
//  sSkinManager1.FHueOffset := 0;
//  sSkinManager1.FSaturation := 0;
end;

procedure TMainForm.sScrollBar3Change(Sender: TObject);
begin
  sGauge1.Progress := sScrollBar3.Position
end;

procedure TMainForm.sScrollBar2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  sSkinManager1.HueOffset := sScrollBar2.Position
end;

procedure TMainForm.sScrollBar2MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  sSkinManager1.HueOffset := sScrollBar2.Position
end;

procedure TMainForm.sScrollBar1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  sSkinManager1.Saturation := sScrollBar1.Position;
end;

procedure TMainForm.sScrollBar1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  sSkinManager1.Saturation := sScrollBar1.Position;
end;

procedure TMainForm.sScrollBar1Change(Sender: TObject);
begin
  sLabel3.Caption := IntToStr(sScrollBar1.Position)
end;

procedure TMainForm.sScrollBar2Change(Sender: TObject);
begin
  sLabel4.Caption := IntToStr(sScrollBar2.Position)
end;

procedure TMainForm.sButton5Click(Sender: TObject);
begin
  SetActivePage(TControl(Sender).Tag)
end;

procedure TMainForm.sCheckBox4Click(Sender: TObject);
begin
  if sCheckBox4.Checked
    then sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events + [beMouseEnter]
    else sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events - [beMouseEnter]
end;

procedure TMainForm.sCheckBox5Click(Sender: TObject);
begin
  if sCheckBox5.Checked
    then sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events + [beMouseLeave]
    else sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events - [beMouseLeave]
end;

procedure TMainForm.sCheckBox6Click(Sender: TObject);
begin
  if sCheckBox6.Checked
    then sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events + [beMouseDown]
    else sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events - [beMouseDown]
end;

procedure TMainForm.sCheckBox7Click(Sender: TObject);
begin
  if sCheckBox4.Checked
    then sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events + [beMouseUp]
    else sSkinManager1.AnimEffects.Buttons.Events := sSkinManager1.AnimEffects.Buttons.Events - [beMouseUp]
end;

procedure TMainForm.sCheckBox8Click(Sender: TObject);
begin
  sSKinManager1.AnimEffects.SkinChanging.Active := sCheckBox8.Checked
end;

procedure TMainForm.sEdit2Change(Sender: TObject);
begin
  try
    sSKinManager1.AnimEffects.SkinChanging.Time := StrtoInt(sEdit2.Text)
  except
  end;
end;

procedure TMainForm.sComboBox2Change(Sender: TObject);
begin
  sBitBtn4.SkinData.SkinSection := sComboBox2.Text
end;

procedure TMainForm.sComboBox3Change(Sender: TObject);
begin
  sPanel16.SkinData.SkinSection := sComboBox3.Text
end;

procedure TMainForm.SetActivePage(PageIndex: integer);
begin
  if sCheckBox9.Checked and sSkinManager1.Active  then PrepareForAnimation(Self);

  sButton5.Down := PageIndex = sButton5.Tag;
  sButton4.Down := PageIndex = sButton4.Tag;
  sButton6.Down := PageIndex = sButton6.Tag;
  sButton7.Down := PageIndex = sButton7.Tag;

  case PageIndex of
    0 : CurPanel := sPanel3;
    1 : CurPanel := sPanel1;
    2 : CurPanel := sPanel15;
    3 : CurPanel := sPanel17;
  end;
  CurPanel.BringToFront;
  
  if sCheckBox9.Checked and sSkinManager1.Active then begin
    AnimShowControl(Self, StrToInt(sEdit3.Text));
//    RedrawWindow(Self.Handle, nil, 0, RDW_ERASE or RDW_INTERNALPAINT or RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
  end;
end;

procedure TMainForm.sEdit3Change(Sender: TObject);
begin
  try
    StrtoInt(sEdit3.Text)
  except
    sEdit3.Text := '200'
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  CurPanel := sPanel3;
end;

end.
