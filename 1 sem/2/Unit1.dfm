object Form1: TForm1
  Left = 238
  Top = 126
  Width = 284
  Height = 359
  Caption = #1051#1072#1073'. '#1056#1072#1073#1086#1090#1072' '#8470'2; 152003; '#1057#1077#1088#1085#1103#1074#1089#1082#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 13
    Height = 13
    Caption = 'X='
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 13
    Height = 13
    Caption = 'Y='
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 13
    Height = 13
    Caption = 'Z='
  end
  object Label4: TLabel
    Left = 8
    Top = 96
    Width = 55
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object Edit1: TEdit
    Left = 24
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 24
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 24
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object RadioGroup1: TRadioGroup
    Left = 152
    Top = 8
    Width = 113
    Height = 73
    Caption = 'f(x)='
    Items.Strings = (
      'sh(x)'
      'sqr(x)'
      'exp(x)')
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 8
    Top = 112
    Width = 249
    Height = 201
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
    OnClick = Memo1Click
  end
  object CheckBox1: TCheckBox
    Left = 152
    Top = 88
    Width = 105
    Height = 17
    Caption = #1054#1082#1088#1091#1075#1083#1103#1090#1100
    TabOrder = 5
  end
end
