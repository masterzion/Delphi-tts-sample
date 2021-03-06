object GradBuilder: TGradBuilder
  Left = 357
  Top = 274
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Gradient builder'
  ClientHeight = 332
  ClientWidth = 297
  Color = clBtnFace
  Constraints.MinHeight = 263
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sGroupBox2: TsGroupBox
    Left = 8
    Top = 3
    Width = 281
    Height = 266
    Caption = ' Triangles '
    TabOrder = 7
    SkinData.SkinSection = 'GROUPBOX'
    object sColorSelect3: TsColorSelect
      Tag = 4
      Left = 5
      Top = 236
      Width = 16
      Height = 16
      SkinData.SkinSection = 'EDIT'
      OnChange = sColorSelect1Change
      ColorValue = 11856354
      ImgWidth = 16
      ImgHeight = 16
    end
    object sColorSelect4: TsColorSelect
      Tag = 3
      Left = 258
      Top = 237
      Width = 16
      Height = 16
      SkinData.SkinSection = 'EDIT'
      OnChange = sColorSelect1Change
      ColorValue = 11856354
      ImgWidth = 16
      ImgHeight = 16
    end
    object sColorSelect2: TsColorSelect
      Tag = 2
      Left = 258
      Top = 22
      Width = 16
      Height = 16
      SkinData.SkinSection = 'EDIT'
      OnChange = sColorSelect1Change
      ColorValue = 11856354
      ImgWidth = 16
      ImgHeight = 16
    end
    object sColorSelect1: TsColorSelect
      Left = 5
      Top = 22
      Width = 16
      Height = 16
      SkinData.SkinSection = 'EDIT'
      OnChange = sColorSelect1Change
      ColorValue = 11856354
      ImgWidth = 16
      ImgHeight = 16
    end
    object sPanel1: TsPanel
      Left = 20
      Top = 37
      Width = 239
      Height = 201
      BevelOuter = bvNone
      Caption = ' '
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      SkinData.SkinSection = 'EDIT'
      object PaintBox2: TPaintBox
        Left = 0
        Top = 0
        Width = 239
        Height = 201
        Align = alClient
        OnPaint = PaintBox1Paint
      end
      object sColorSelect5: TsColorSelect
        Tag = 1
        Left = 114
        Top = 90
        Width = 16
        Height = 16
        SkinData.SkinSection = 'EDIT'
        OnChange = sColorSelect1Change
        ColorValue = 11856354
        ImgWidth = 16
        ImgHeight = 16
      end
    end
  end
  object sGroupBox1: TsGroupBox
    Left = 8
    Top = 3
    Width = 281
    Height = 266
    Caption = ' Linear (faster) '
    TabOrder = 6
    SkinData.SkinSection = 'GROUPBOX'
    object PaintPanel: TsPanel
      Left = 13
      Top = 26
      Width = 217
      Height = 220
      BevelOuter = bvNone
      Caption = ' '
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      SkinData.SkinSection = 'EDIT'
      object PaintBox1: TPaintBox
        Left = 0
        Top = 0
        Width = 217
        Height = 220
        Align = alClient
        OnPaint = PaintBox1Paint
      end
    end
    object Panel2: TsPanel
      Left = 239
      Top = 26
      Width = 29
      Height = 220
      BorderWidth = 4
      Caption = ' '
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      OnClick = Panel2Click
      SkinData.SkinSection = 'PANEL_LOW'
      object TemplatePanel: TsPanel
        Left = 4
        Top = 107
        Width = 19
        Height = 28
        Caption = ' '
        DragCursor = crHandPoint
        PopupMenu = PopupMenu1
        TabOrder = 0
        Visible = False
        OnDblClick = TemplatePanelDblClick
        OnMouseDown = TemplatePanelMouseDown
        OnMouseMove = TemplatePanelMouseMove
        OnMouseUp = TemplatePanelMouseUp
        SkinData.SkinSection = 'PANEL'
      end
    end
  end
  object BitBtn1: TsButton
    Left = 139
    Top = 301
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = BitBtn1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton1: TsButton
    Left = 63
    Top = 301
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton2: TsButton
    Left = 215
    Top = 301
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Clear'
    TabOrder = 2
    OnClick = sButton2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sRadioButton1: TsRadioButton
    Left = 20
    Top = 276
    Width = 63
    Height = 20
    Caption = 'Vertical'
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = sRadioButton1Click
    SkinData.SkinSection = 'RADIOBUTTON'
  end
  object sRadioButton2: TsRadioButton
    Tag = 1
    Left = 102
    Top = 276
    Width = 75
    Height = 20
    Caption = 'Horizontal'
    TabOrder = 4
    OnClick = sRadioButton1Click
    SkinData.SkinSection = 'RADIOBUTTON'
  end
  object sRadioButton3: TsRadioButton
    Tag = 2
    Left = 188
    Top = 276
    Width = 70
    Height = 20
    Caption = 'Diagonal'
    TabOrder = 5
    OnClick = sRadioButton1Click
    SkinData.SkinSection = 'RADIOBUTTON'
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 280
    Top = 8
    object Changecolor1: TMenuItem
      Caption = 'Change color'
      Default = True
      OnClick = Changecolor1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
  object sSkinProvider1: TsSkinProvider
    CaptionAlignment = taCenter
    SkinData.SkinSection = 'FORM'
    MakeSkinMenu = False
    ShowAppIcon = False
    TitleButtons = <>
    Left = 282
    Top = 40
  end
end
