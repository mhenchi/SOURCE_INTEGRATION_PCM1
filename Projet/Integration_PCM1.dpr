{覧覧覧覧覧覧覧覧覧 MD2011-04 - ACTIA Colomiers - Informatique de Production 覧}

// MD130710 = Modification affichage transition phase 1/2


program Integration_PCM1;

uses
  Windows,
  Forms,
  uSelectionProduit in '..\Forms\uSelectionProduit.pas' {FSelectProduit},
  uReadWriteIni in '..\Units\uReadWriteIni.pas',
  u1PortCom in '..\Forms\u1PortCom.pas' {mlePortCOM: TDataModule},
  uConnexionBdd in '..\Forms\uConnexionBdd.pas' {CnxBdd: TDataModule},
  uPatienter in '..\Forms\uPatienter.pas' {Patienter},
  uFonctions in '..\Units\uFonctions.pas',
  UInterlock in '..\Units\UInterlock.pas',
  uPrintZPL in '..\Units\uPrintZPL.pas',
  uSmema_Carte in '..\Units\uSmema_Carte.pas',
  MMDEBUG in '..\Forms\MMDEBUG.PAS',
  uDialog in '..\Forms\uDialog.pas' {DlgErreur},
  uLogin in '..\Forms\uLogin.pas' {LoginForm},
  uPrincipale in '..\Forms\uPrincipale.pas' {FMain},
  uReprintLabel in '..\Forms\uReprintLabel.pas' {FReprintLabel},
  uGlobale in '..\Units\uGlobale.pas',
  uLoginrework in '..\Forms\uLoginrework.pas' {LoginreworkForm};

{$R *.res}


var
 leMutex: THandle;
 strAppli: string ='Integration_PCM1';    // <---------- MODIFIER LE NOM DE L'APPLI ICI

begin
  leMutex := CreateMutex(nil,True,Pchar(strAppli));
  if (leMutex <> 0) and (GetLastError = 0) then
    begin
      Application.Initialize;
     //   Application.MainFormOnTaskbar := True;
      Application.Title := 'PCM1';
      Application.CreateForm(TFSelectProduit, FSelectProduit);
    //  Application.CreateForm(TFSelectProduit,FChargerpwrrework);
      //Application.CreateForm(TmlePortCOM, mlePortCOM);
      //Application.CreateForm(TCnxBdd, CnxBdd);
      //Application.CreateForm(TPatienter, Patienter);
      Application.CreateForm(TDlgErreur, DlgErreur);
      //Application.CreateForm(TFMain, FMain);
      Application.CreateForm(TFReprintLabel, FReprintLabel);
  Application.Run;
    end
  else MessageBoxA(0,Pchar('Application en cours d''utilisation    '),Pchar('Contr�le '),MB_OK + MB_ICONEXCLAMATION + 0);

end.




