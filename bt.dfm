object bwindow: Tbwindow
  Left = 539
  Top = 180
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Battery monitor'
  ClientHeight = 222
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMinimized
  OnCreate = FormCreate
  DesignSize = (
    249
    222)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 5
    Top = 5
    Width = 238
    Height = 156
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvRaised
    Color = clBtnFace
    Enabled = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 5
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Quit'
    TabOrder = 1
    OnClick = quit1Click
  end
  object stw: TCheckBox
    Left = 5
    Top = 165
    Width = 121
    Height = 17
    Caption = 'Indulj a windows-zal'
    TabOrder = 2
    OnClick = stwClick
  end
  object tt: TTextTrayIcon
    CycleInterval = 0
    Icon.Data = {
      0000010001001010040000000000280100001600000028000000100000002000
      0000010004000000000080000000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888
      8888888888888888888888888888888888888888888888888888888888888800
      0888880008888888008888880088888880088888800888000008880000088008
      8008800880088008800880088008800880088008800888000088880000888888
      8888888888888888888888888888888888888888888888888888888888880000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconIndex = 0
    PopupMenu = PopupMenu1
    MinimizeToTray = True
    OnDblClick = ttDblClick
    Text = '99'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    Border = False
    Options.OffsetX = 0
    Options.OffsetY = 0
    Options.LineDistance = 0
    Left = 10
    Top = 10
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 10
    object quit1: TMenuItem
      Caption = 'Quit'
      OnClick = quit1Click
    end
  end
  object Timer1: TTimer
    OnTimer = Button1Click
    Left = 70
    Top = 10
  end
end
