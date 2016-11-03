object Form1: TForm1
  Left = 0
  Top = 0
  Caption = '8 Queens'
  ClientHeight = 741
  ClientWidth = 958
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 805
    Top = 240
    Width = 29
    Height = 64
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -53
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 736
    Top = 43
    Width = 199
    Height = 23
    Caption = 'Number of Steps Taken'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 745
    Top = 85
    Width = 7
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 56
    Top = 43
    Width = 657
    Height = 657
    Color = clWhite
    ColCount = 8
    DefaultColWidth = 75
    DefaultRowHeight = 75
    FixedCols = 0
    RowCount = 8
    FixedRows = 0
    GridLineWidth = 7
    TabOrder = 0
    OnClick = StringGrid1Click
  end
  object Button1: TButton
    Left = 719
    Top = 648
    Width = 75
    Height = 25
    Caption = 'Simulate'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 719
    Top = 503
    Width = 154
    Height = 98
    Caption = 'Reset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -43
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 729
    Top = 376
    Width = 105
    Height = 33
    Caption = 'Animate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object CheckBox2: TCheckBox
    Left = 729
    Top = 407
    Width = 221
    Height = 42
    Caption = 'Clear Before Simulation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
