object Entrar: TEntrar
  Left = 0
  Top = 0
  Caption = 'Entrar'
  ClientHeight = 374
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 142
    Top = 32
    Width = 195
    Height = 40
    Caption = 'BEM VINDO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 157
    Width = 104
    Height = 24
    Caption = 'USU'#193'RIO:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 231
    Width = 76
    Height = 24
    Caption = 'SENHA:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edit_user: TEdit
    Left = 142
    Top = 154
    Width = 321
    Height = 21
    TabOrder = 0
  end
  object edit_password: TEdit
    Left = 142
    Top = 228
    Width = 321
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 348
    Top = 288
    Width = 99
    Height = 41
    Caption = 'ENTRAR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Button2: TButton
    Left = 184
    Top = 288
    Width = 143
    Height = 41
    Caption = 'CADASTRAR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object DBEdit1: TDBEdit
    Left = 15
    Top = 32
    Width = 66
    Height = 21
    ReadOnly = True
    TabOrder = 4
    Visible = False
  end
  object DBEdit2: TDBEdit
    Left = 15
    Top = 78
    Width = 66
    Height = 21
    ReadOnly = True
    TabOrder = 5
    Visible = False
  end
end
