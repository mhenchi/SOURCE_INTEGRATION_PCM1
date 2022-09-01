object CnxBdd: TCnxBdd
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 852
  Top = 247
  Height = 209
  Width = 402
  object ZCnxFdb1: TZConnection
    TransactIsolationLevel = tiReadCommitted
    Left = 40
    Top = 12
  end
  object ZSelectFdb1: TZReadOnlyQuery
    Connection = ZCnxFdb1
    Params = <>
    Left = 40
    Top = 60
  end
  object ZWriteFdb1: TZQuery
    Connection = ZCnxFdb1
    Params = <>
    Left = 40
    Top = 116
  end
  object ZCnxFdb2: TZConnection
    TransactIsolationLevel = tiReadCommitted
    Left = 136
    Top = 12
  end
  object ZSelectFdb2: TZReadOnlyQuery
    Connection = ZCnxFdb2
    Params = <>
    Left = 136
    Top = 60
  end
  object ZWriteFdb2: TZQuery
    Connection = ZCnxFdb2
    Params = <>
    Left = 136
    Top = 116
  end
  object ZCnxAccess: TZConnection
    TransactIsolationLevel = tiReadCommitted
    Left = 314
    Top = 13
  end
  object ZSelectAccess: TZReadOnlyQuery
    Connection = ZCnxAccess
    Params = <>
    Left = 316
    Top = 64
  end
  object ZWriteAccess: TZQuery
    Connection = ZCnxAccess
    Params = <>
    Left = 316
    Top = 116
  end
  object ZCnxOracle: TZConnection
    TransactIsolationLevel = tiReadCommitted
    DesignConnection = True
    Left = 224
    Top = 12
  end
  object ZSelectOra: TZReadOnlyQuery
    Connection = ZCnxOracle
    Params = <>
    Left = 224
    Top = 64
  end
  object ZWriteOra: TZQuery
    Connection = ZCnxOracle
    Params = <>
    Left = 224
    Top = 116
  end
end
