object frPrincipal: TfrPrincipal
  Left = 0
  Top = 0
  Caption = 'MPS - Banco de Talentos'
  ClientHeight = 422
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object edtPesquisa: TSearchBox
    Left = 60
    Top = 32
    Width = 313
    Height = 21
    AutoSize = False
    TabOrder = 0
    OnChange = edtPesquisaChange
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 71
    Width = 425
    Height = 134
    BorderStyle = bsNone
    DataSource = dsGridPesquisa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
  end
  object Panel1: TPanel
    Left = 0
    Top = 382
    Width = 447
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 470
    object btnSair: TButton
      Left = 351
      Top = 4
      Width = 82
      Height = 32
      Caption = 'Sair'
      TabOrder = 0
      OnClick = btnSairClick
    end
    object btnAddPessoa: TButton
      Left = 8
      Top = 4
      Width = 96
      Height = 32
      Caption = 'Adicionar Pessoa'
      TabOrder = 1
      OnClick = btnAddPessoaClick
    end
    object btnAlterarPessoa: TButton
      Left = 110
      Top = 4
      Width = 96
      Height = 32
      Caption = 'Alterar Pessoa'
      TabOrder = 2
      OnClick = btnAlterarPessoaClick
    end
    object btnRemoverPessoa: TButton
      Left = 212
      Top = 4
      Width = 96
      Height = 32
      Caption = 'Remover Pessoa'
      TabOrder = 3
      OnClick = btnRemoverPessoaClick
    end
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 211
    Width = 425
    Height = 150
    BorderStyle = bsNone
    DataSource = dsGridHistorico
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
  end
  object dsGridPesquisa: TDataSource
    OnDataChange = dsGridPesquisaDataChange
    Left = 240
    Top = 104
  end
  object dsGridHistorico: TDataSource
    Left = 312
    Top = 256
  end
end
