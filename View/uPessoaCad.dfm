object frPessoaCad: TfrPessoaCad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 496
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edtID: TLabeledEdit
    Left = 28
    Top = 24
    Width = 54
    Height = 21
    Color = clMedGray
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Registro N'#186
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object edtNome: TLabeledEdit
    Left = 89
    Top = 24
    Width = 154
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    TabOrder = 1
  end
  object edtSobrenome: TLabeledEdit
    Left = 249
    Top = 24
    Width = 130
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = 'Sobrenome'
    TabOrder = 2
  end
  object edtCelular: TLabeledEdit
    Left = 241
    Top = 69
    Width = 137
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Celular'
    TabOrder = 4
  end
  object edtEmail: TLabeledEdit
    Left = 28
    Top = 69
    Width = 203
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Email'
    TabOrder = 3
  end
  object edtLinkedIn: TLabeledEdit
    Left = 28
    Top = 114
    Width = 351
    Height = 21
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'LinkedIn'
    TabOrder = 5
  end
  object edtGitHub: TLabeledEdit
    Left = 28
    Top = 159
    Width = 351
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'GitHub'
    TabOrder = 6
  end
  object Panel1: TPanel
    Left = 0
    Top = 447
    Width = 409
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    ParentBackground = False
    TabOrder = 8
    ExplicitWidth = 387
    object btnSalvar: TButton
      Left = 9
      Top = 4
      Width = 91
      Height = 41
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnSair: TButton
      Left = 308
      Top = 4
      Width = 91
      Height = 41
      Caption = 'Sair'
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 190
    Width = 371
    Height = 252
    Caption = 'Historico de Empresas'
    TabOrder = 7
    object TPanel
      Left = 2
      Top = 15
      Width = 367
      Height = 100
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object lblDataAdmissao: TLabel
        Left = 153
        Top = 49
        Width = 71
        Height = 13
        Caption = 'Data Admiss'#227'o'
      end
      object edtNomeEmpresa: TLabeledEdit
        Left = 7
        Top = 17
        Width = 257
        Height = 21
        EditLabel.Width = 71
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome Empresa'
        TabOrder = 0
      end
      object edtCargo: TLabeledEdit
        Left = 7
        Top = 65
        Width = 135
        Height = 21
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = 'Cargo'
        TabOrder = 1
      end
      object dtEdtAdmissao: TDateTimePicker
        Left = 149
        Top = 65
        Width = 115
        Height = 21
        Date = 44967.000000000000000000
        Time = 0.583795381942763900
        TabOrder = 2
      end
      object Panel2: TPanel
        Left = 308
        Top = 0
        Width = 59
        Height = 100
        Align = alRight
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 3
        object btnSalvarHistorico: TButton
          Left = 4
          Top = 10
          Width = 51
          Height = 28
          Caption = 'Salvar'
          TabOrder = 0
          OnClick = btnSalvarHistoricoClick
        end
        object btnExcluirHistorico: TButton
          Left = 4
          Top = 52
          Width = 51
          Height = 28
          Caption = 'Remover'
          TabOrder = 1
          OnClick = btnExcluirHistoricoClick
        end
      end
    end
    object grdHistorico: TDBGrid
      Left = 2
      Top = 115
      Width = 367
      Height = 135
      Align = alClient
      DataSource = dsHistorico
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object dsHistorico: TDataSource
    Left = 145
    Top = 335
  end
end
