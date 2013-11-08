unit sRegisterIt;
{$I sDefs.inc}

interface

uses
  Classes, sScrollBar, sLabel, sButton, sBitBtn, sSpeedButton, sPanel,
  sAlphaListBox, sGauge,
  {$IFNDEF ALITE}
    sHintManager, sToolBar, sColorSelect, sDialogs,
    sComboBox, sCurrencyEdit, sSpinEdit, sMemo, sRadioButton, sComboEdit,
    sPageControl, sCurrEdit, sToolEdit, sMonthCalendar,
    sBevel, sGroupBox, sStatusBar, sTrackBar, sCalculator,
    sMaskEdit, sComboBoxes, sSplitter,
    sEdit, sSkinManager, sSkinProvider, sTabControl, sFontCtrls,
    sCheckBox, sScrollBox, sImageList, sCheckListBox, sRichEdit, sFileCtrl,
    sTreeView, sListView, sFrameAdapter, sUpDown, sFrameBar,
    acShellCtrls, acCoolBar, acProgressBar, acNotebook,
    acHeaderControl, acMagn;
  {$ELSE}
    sEdit, sSkinManager, sSkinProvider, sComboBox, sCheckBox;
  {$ENDIF}

procedure Register;

implementation

uses Registry, Windows, acUtils, SysUtils{$IFNDEF ALITE}, sColorDialog{$ENDIF};

procedure Register;
{$IFNDEF ALITE}
var
  r : TRegistry;
{$ENDIF}
begin

{$IFNDEF ALITE}
  r := TRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
  {$IFDEF DELPHI7}
    if r.OpenKey('SOFTWARE\Borland\Delphi\7.0\Palette', False) then begin
  {$ELSE}
    {$IFDEF DELPHI6}
      if r.OpenKey('SOFTWARE\Borland\Delphi\6.0\Palette', False) then begin
    {$ELSE}
      if r.OpenKey('SOFTWARE\Borland\Delphi\5.0\Palette', False) then begin
    {$ENDIF}
  {$ENDIF}
      r.DeleteValue('AlphaLite');
{      r.DeleteValue('AlphaStandard');
      r.DeleteValue('AlphaAdditional');
      r.DeleteValue('AlphaTools');}
      r.DeleteValue('sStyle');
      r.DeleteValue('sTools');

      r.DeleteValue('AlphaControls');

    end;
  finally
    FreeAndNil(r);
  end;

  RegisterComponents('AlphaStandard', [
    TsLabel, TsEdit, TsMemo, TsButton, TsCheckBox, TsRadioButton,
    TsListBox, TsComboBox, TsGroupBox, TsRadioGroup, TsPanel, TsBitBtn,
    TsSpeedButton, TsMaskEdit, TsBevel, TsScrollBox, TsCheckListBox, TsSplitter,
    TsTabControl, TsPageControl, TsRichEdit, TsTrackBar, TsProgressBar, TsUpDown, TsTreeView,
    TsListView, TsHeaderControl, TsStatusBar, TsToolBar, TsGauge, TsSpinEdit, TsCoolBar, TsNotebook]);

  RegisterComponents('AlphaAdditional', [
    TsWebLabel, TsDecimalSpinEdit, TsColorSelect, TsDragBar, TsComboBoxEx, TsColorBox, TsScrollBar,
    TsMonthCalendar, TsComboEdit, TsCurrencyEdit, TsDateEdit, TsCalcEdit, TsDirectoryEdit,
    TsFileNameEdit, TsFilterComboBox, TsFontComboBox, TsFontListBox,
    TsFrameBar, TsColorsPanel, TsStickyLabel, TsLabelFX, TsShellTreeView, TsShellComboBox,
    TsShellListView, TsTimePicker]);

  RegisterComponents('AlphaTools', [
    TsSkinManager, TsSkinProvider, TsFrameAdapter, TsHintManager,
    TsCalculator, TsOpenDialog, TsSaveDialog, TsOpenPictureDialog,
    TsSavePictureDialog, TsMagnifier{, TsImageList in progress}, TsColordialog{, TsFontDialog}, TsPathDialog]);

  RegisterNoIcon([TsTabSheet]);
//  RegisterNoIcon([TsDlgShellListView]);
  RegisterClasses([TsTabSheet, TsEditLabel, TsStdColorsPanel, TsDlgShellListView]);

{$ELSE}

  RegisterComponents('AlphaLite', [
    TsSkinManager, TsSkinProvider, TsEdit, TsCheckBox, TsPanel, TsButton,
    TsScrollBar, TsLabel, TsWebLabel, TsBitBtn, TsComboBox, TsListBox, TsGauge]);

{$ENDIF}

end;

end.
