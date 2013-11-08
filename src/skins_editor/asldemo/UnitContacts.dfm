inherited FormContacts: TFormContacts
  Left = 221
  Top = 208
  Anchors = [akLeft, akTop, akRight]
  Caption = 'Contacts'
  ClientHeight = 55
  ClientWidth = 258
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object sButton5: TsBitBtn [0]
    Left = 26
    Top = 5
    Width = 212
    Height = 23
    Cursor = crHandPoint
    Caption = 'support@alphaskins.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = sButton5Click
    NumGlyphs = 2
    Spacing = 8
    Blend = 50
    SkinData.SkinManager = MainForm.sSkinManager1
    SkinData.SkinSection = 'WEBBUTTON'
    ImageIndex = 1
    Images = MainForm.ImageList1
    ShowFocus = False
  end
  object sButton6: TsBitBtn [1]
    Left = 26
    Top = 27
    Width = 212
    Height = 23
    Cursor = crHandPoint
    Caption = 'http://www.alphaskins.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = sButton6Click
    NumGlyphs = 2
    Spacing = 8
    Blend = 50
    SkinData.SkinManager = MainForm.sSkinManager1
    SkinData.SkinSection = 'WEBBUTTON'
    ImageIndex = 0
    Images = MainForm.ImageList1
    ShowFocus = False
  end
end
