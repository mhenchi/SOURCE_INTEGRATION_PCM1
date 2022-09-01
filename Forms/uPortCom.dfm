object mlePortCOM: TmlePortCOM
  OldCreateOrder = False
  Left = 384
  Top = 221
  Height = 161
  Width = 212
  object ComPort1: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    OnRxChar = ComPort1RxChar
    Left = 20
    Top = 8
  end
  object ComPort: TAfComPort
    DTR = False
    RTS = False
    Left = 96
    Top = 8
  end
end
