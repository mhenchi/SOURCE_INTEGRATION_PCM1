unit uConnexionBdd;

//******************************************************************************
{ CONNEXIONS AUX BASES DE DONNEES FIREBIRD(plusieurs bases simultané)
  FIREBIRD, POSTGREE, ORACLE et ACCESS

UVersion

U1.0.0.0  04/02/2011 M'hammed Djaouti
          Création de l'unité ainsi que son fichier ini : ConnexionDatabases.ini


NOTE: Rajouter la connexion aux bdd Postgree
 }
//******************************************************************************


interface

uses
  Windows, SysUtils, Classes, ZAbstractDataset, ZDataset, DB, ZAbstractRODataset,
  ZConnection, Forms, Dialogs, ADODB;

type
  TCnxBdd = class(TDataModule)
    ZCnxFdb1: TZConnection;
    ZSelectFdb1: TZReadOnlyQuery;
    ZWriteFdb1: TZQuery;
    ZCnxFdb2: TZConnection;
    ZSelectFdb2: TZReadOnlyQuery;
    ZWriteFdb2: TZQuery;
    ZCnxAccess: TZConnection;
    ZSelectAccess: TZReadOnlyQuery;
    ZWriteAccess: TZQuery;
    ZCnxOracle: TZConnection;
    ZSelectOra: TZReadOnlyQuery;
    ZWriteOra: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    
  private
    procedure ParametreFdb(ACnx:TZConnection; strSection: string);
    procedure ParametreOracle(ACnx:TZConnection; strSection: string);
    procedure ParametreAccess(ACnx:TZConnection; strSection: string);
    function ConnectBdd(ACnx:TZConnection; blnCnxAction: boolean): boolean;
    function ConnectFdb1(blnCnx: boolean): boolean;
    function ConnectFdb2(blnCnx: boolean): boolean;

    function ConnectAccess(blnCnx: boolean): boolean;
    
  public
    function EtablirConnexionBdd: boolean;
    function ConnectOracle(blnCnx: boolean): boolean;
  end;


var
  CnxBdd : TCnxBdd;



  function DebutTransaction(ACnx:TZConnection): Boolean;
  function AnnulerTransaction(ACnx:TZConnection): Boolean;
  function ValiderTransaction(ACnx:TZConnection): Boolean;
  function ControlerDoneSFC(strNumeroSerie : string): boolean;
  function RktPositionSFC(strCodeBarre,LeSite,LOperation : string; var strPosition:string): boolean;


implementation

{$R *.dfm}

uses uReadWriteIni;

type
  TConnexionBdd = record
    FBD1    : boolean;
    FBD2    : boolean;
    ORACLE  : boolean;
    ACCESS  : boolean;
  end;

var
  strIni  : string;
  EtatCnx :TConnexionBdd;



//******************************************************************************
// Parametrage et activation des différentes connexions aux Bdds
procedure TCnxBdd.DataModuleCreate(Sender: TObject);
begin
  //strIni := '..\Ini\ConnexionDatabases.ini';
  strIni :='';  // Utilise le .ini global

  with EtatCnx do
    begin
      FBD1    := LitBoolean('BDD_FIREBIRD_1','Activer',strIni);
      FBD2    := LitBoolean('BDD_FIREBIRD_2','Activer',strIni);
      ORACLE  := LitBoolean('BDD_ORACLE','Activer',strIni);
      //ACCESS  := LitBoolean('BDD_ACCESS_1','Activer',strIni);

      //
      if FBD1 then
          ParametreFdb(ZCnxFdb1,'BDD_FIREBIRD_1');

      if FBD2 then
         ParametreFdb(ZCnxFdb2,'BDD_FIREBIRD_2');

      if ORACLE then
          ParametreOracle(ZCnxOracle,'BDD_ORACLE');

      //if ACCESS then
      //    ParametreAccess(ZCnxAccess,'BDD_ACCESS_1');

    end;

end;

//******************************************************************************
// Etablir les connexions aux bdd actives
function TCnxBdd.EtablirConnexionBdd: boolean;
begin
  result := true;
  with EtatCnx do
    begin
      if FBD1   then  if not CnxBdd.ConnectFdb1(true) then result := false;
      if FBD2   then  if not CnxBdd.ConnectFdb2(true) then result := false;
      // Connexion Oracle faite lors du chargement des articles  
      //if ORACLE then  if not CnxBdd.ConnectOracle(true) then result := false;
      //if ACCESS then  if not CnxBdd.ConnectAccess(true) then result := false;
    end;
end;

//******************************************************************************
// Paramètrage des connexions aux bdds FIREBIRD
procedure TCnxBdd.ParametreFdb(ACnx:TZConnection; strSection: string);
var
  strChemin : string;

begin

  // Récupérer le Chemin pour une bdd réseau si chemin absent appliquer répertoire courant
  strChemin := LitString(strSection,'CheminReseau',strIni);
  if strChemin = '' then strChemin := ExtractFilePath(Application.ExeName);

  // Paramètrage de la Connexion
  with ACnx  do
    begin
      Protocol := LitString(strSection,'Protocol',strIni);
      HostName := LitString(strSection,'HostName',strIni);
      Database := strChemin + LitString(strSection,'Base',strIni);  //'/datas/firebird/INTEGRATION_POWER_TRAIN.FDB';   
      Port     := LitInteger(strSection,'Port',strIni);
      User     := LitString(strSection,'User',strIni);
      Password := LitString(strSection,'Pwd',strIni);
    end;
end;

//******************************************************************************
// Paramètrage de la connexion à la bdd ORACLE
procedure TCnxBdd.ParametreOracle(ACnx:TZConnection; strSection: string);
begin
  with Acnx do
    begin
      Protocol := LitString(strSection,'Protocol',strIni);
      HostName := LitString(strSection,'HostName',strIni);
      Database := LitString(strSection,'Base',strIni);
      Port     := LitInteger(strSection,'Port',strIni);
      User     := LitString(strSection,'User',strIni);
      Password := LitString(strSection,'Password',strIni);
    end;

end;

//******************************************************************************
// Paramètrage des connexions aux bdds  ACCESS
procedure TCnxBdd.ParametreAccess(ACnx:TZConnection; strSection: string);
var
  strBaseName, strPwd, strChemin, strChaineCnx : string;
begin

  // Récupérer le Chemin pour une bdd réseau si chemin absent appliquer répertoire courant
  strChemin := LitString(strSection,'CheminReseau',strIni);
  if strChemin = '' then strChemin := ExtractFilePath(Application.ExeName);

  strBaseName   := strChemin + LitString(strSection,'Base',strIni);
  strPwd        := LitString(strSection,'Pwd',strIni);
  strChaineCnx  := LitString(strSection,'ChaineCnx',strIni);
  //'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%S;Jet OLEDB:Database Password=%S;Persist Security Info=False;';

  with Acnx do
    begin
      Protocol := LitString(strSection,'Protocol',strIni);
      Database := Format(strChaineCnx,[strBaseName,strPwd]);
    end;

end;


//******************************************************************************
function DebutTransaction(ACnx:TZConnection): Boolean;
begin
  Result := True;
  try
    ACnx.StartTransaction;
  except
    Result := False;
  end;
end;

//******************************************************************************
function AnnulerTransaction(ACnx:TZConnection): Boolean;
begin
  Result := True;
  try
    ACnx.Rollback;
  except
    Result := False;
  end;
end;

//******************************************************************************
function ValiderTransaction(ACnx:TZConnection): Boolean;
begin
  Result := True;
  try
    ACnx.Commit;
  except
    Result := False;
  end;
end;


//******************************************************************************
//Connection ou deconnexion aux BDD
function TCnxBdd.ConnectBdd(ACnx:TZConnection; blnCnxAction: boolean): boolean;
begin
  with ACnx do
    begin
      if blnCnxAction then
        begin
          try
            Connected := true;
            result := true;
          except
            result := false;
          end;
        end
      else
        begin
          if Connected = true then connected := false;
          result := true;
          //Free;
        end;
   end;
end;

//******************************************************************************
// Connecter la premiere base de données Firebird
function TCnxBdd.ConnectFdb1(blnCnx: boolean): boolean;
begin
  if ConnectBdd(ZCnxFdb1,blnCnx) then
    begin
      result := true
    end
  else
    begin
      if blnCnx then MessageBoxA(0,Pchar('ERREUR DE CONNEXION A LA BASE FIREBIRD_1  !'+#13+'  '),
                                 Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
      result := false;
    end;

end;

//******************************************************************************
// Connecter la deuxieme base de données Firebird
function TCnxBdd.ConnectFdb2(blnCnx: boolean): boolean;
begin
  if ConnectBdd(ZCnxFdb2,blnCnx) then
    begin
      result := true
    end
  else
    begin
      if blnCnx then MessageBoxA(0,Pchar('ERREUR DE CONNEXION A LA BASE FIREBIRD_2  !'+#13+'  '),
                                 Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
      result := false;
    end;

end;

//******************************************************************************
//Connection à la BDD Oracle
function TCnxBdd.ConnectOracle(blnCnx: boolean): boolean;
begin
  if EtatCnx.ORACLE then
    begin
      if blnCnx then if CnxBdd.ZCnxOracle.Connected then CnxBdd.ZCnxOracle.Connected := false;
      if ConnectBdd(ZCnxOracle,blnCnx) then
        begin
          result := true
        end
      else
        begin
          if blnCnx then MessageBoxA(0,Pchar('ERREUR DE CONNEXION A LA BASE ORACLE  !'+#13+'  '),
                                     Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);

          result := false;
        end;
    end;
end;

//******************************************************************************
// Connecter la base de données ACCESS
function TCnxBdd.ConnectAccess(blnCnx: boolean): boolean;
begin
  // Firebird locale
  if ConnectBdd(ZCnxAccess,blnCnx) then
    begin
      result := true
    end
  else
    begin
      if blnCnx then MessageBoxA(0,Pchar('ERREUR DE CONNEXION A LA BASE ACCESS_1  !'+#13+'  '),
                                 Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);

      result := false;
    end;

end;


//******************************************************************************
// Déconnexion des bases de données actives
procedure TCnxBdd.DataModuleDestroy(Sender: TObject);
begin
  with EtatCnx do
    begin
      if FBD1   then ConnectFdb1(false);
      if FBD2   then ConnectFdb2(false);
      if ORACLE then ConnectOracle(false);
      //if ACCESS then ConnectAccess(false);
    end;
end;

//******************************************************************************
// Contrôler que le SFC est ou pas Done (Terminé)
function ControlerDoneSFC(strNumeroSerie : string): boolean;
var
  strRkt : string;
  strRetourRkt :string;
begin
  result := false;
  with CnxBdd.ZSelectOra do
    begin
      SQL.Clear;
      SQL.Add('SELECT SFC.QTY_DONE ');
      SQL.Add(' FROM SCE3011_WIP.SFC SFC ');
      SQL.Add(' WHERE SFC.SFC =' + QuotedStr(strNumeroSerie));

      Active := true;

      if not (EOF) then if FieldByName('QTY_DONE').Value > 0 then result := true;
    end;
end;

//******************************************************************************
//Requete pour contrôler dans la base Oracle que le SFC est à la bonne opération dans visiprise
function RktPositionSFC(strCodeBarre,LeSite,LOperation : string; var strPosition:string): boolean;
var
  strRkt    : string;
begin

  result:= false;

  strRkt := 'SELECT SFC_STEP.OPERATION_BO, SFC_STEP.STEP_ID FROM SCE3011_WIP.SFC_ROUTER SFC_ROUTER, SCE3011_WIP.SFC_STEP SFC_STEP ';
  strRkt := strRkt + ' WHERE SFC_STEP.SFC_ROUTER_BO = SFC_ROUTER.HANDLE ';
  strRkt := strRkt + ' AND (SFC_ROUTER.SFC_ROUTING_BO = ' + QuotedStr('SFCRoutingBO:SFCBO:' + LeSite + ',' + strCodeBarre) + ')';
  strRkt := strRkt + ' AND (SFC_STEP.QTY_IN_QUEUE>0)';

  // Pour préciser la requete sur une opération précise
  // AND (SFC_STEP.OPERATION_BO Like ' + '''' + '%' + LOperation + '%' + '''' + ')';
 
  with CnxBdd.ZSelectOra do
    begin
      sql.Clear;
      sql.Add(strRkt);
      //DisableControls
      try
        Active := True;
        First;

        while not Eof do
          begin

            strPosition := strPosition +(FieldByName('OPERATION_BO').AsString) +' ; ';
            next;
          end;
       
        result:= true;
      finally
        //EnableControls;
      end;
    end;

end;




 {
//******************************************************************************
//Requete pour contrôler dans la base Oracle que le SFC est à la bonne opération dans visiprise   Version avant le 01/02/2012
function RktPositionSFC(strCodeBarre,LeSite,LOperation : string; var strPosition:string): boolean;
var
  strRkt    : string;
begin
  result:= false;

  strRkt := 'SELECT SFC_STEP.OPERATION_BO, SFC_STEP.STEP_ID FROM SCE3011_WIP.SFC_ROUTER SFC_ROUTER, SCE3011_WIP.SFC_STEP SFC_STEP ';
  strRkt := strRkt + ' WHERE SFC_STEP.SFC_ROUTER_BO = SFC_ROUTER.HANDLE ';
  strRkt := strRkt + ' AND (SFC_ROUTER.SFC_ROUTING_BO = ' + QuotedStr('SFCRoutingBO:SFCBO:' + LeSite + ',' + strCodeBarre) + ')';
  strRkt := strRkt + ' AND (SFC_STEP.QTY_IN_QUEUE>0)';
 
  with CnxBdd.ZSelectOra do
    begin
      sql.Clear;
      sql.Add(strRkt);
      //DisableControls
      try
        Active := True;
        First;
        strPosition := (FieldByName('OPERATION_BO').AsString);
        result:= true;
      finally
        //EnableControls;
      end;
    end;

end;




UTILISATION:

Générer en dynamique au démarrage:
Application.CreateForm(TCnxBdd, CnxBdd);

puis pour connecter une base
firebird :
if not CnxBdd.ConnectFdb1(true) then Application.Terminate;
if not CnxBdd.ConnectFdb2(true) then Application.Terminate;
oracle :
if not CnxBdd.ConnectOracle(true) then Application.Terminate;
access :
if not CnxBdd.ConnectAccess(true) then Application.Terminate;

et ne pas oublier lorsque l'on quitte l'application :
CnxBdd.Free;



REMARQUES :

LE MODULE ZEOS ACCESS :
Pour la base de données ACCESS les modules Début, Annuler et valider Transaction
ne fonctionne pas !!!


POUR ACCEDER à ORACLE : Installer INSTANT CLIENT sur le poste

}

{
  FICHIER INI POUR L'UNITE uCnxBddFbd
********************************************************************************

[BDD_FIREBIRD_1]

;CONNEXION A LA BASE DE DONNEE FIREBIRD
Activer=1

;Paramètres
User     = sysdba
Pwd  	 = masterkey
Protocol = firebird-2.0
HostName = localhost
Port     = 3050
Base     = Integration_OMNIEXPRESS.FDB
CheminReseau = 

;Pour le Chemin réseau mettre le chemin  (sans le nom de la base)
; si VIDE la base doit se trouver dans le Même répertoire que l'executable 

********************************************************************************
[BDD_FIREBIRD_2]

;CONNEXION A LA BASE DE DONNEE FIREBIRD

Activer=1

;Paramètres
User     = sysdba
Pwd  	   = masterkey
Protocol = firebird-2.0
HostName = localhost
Port     = 3050
Base     = Integration_OMNIEXPRESS.FDB

********************************************************************************

[BDD_ORACLE]

;CONNEXION A LA BASE DE DONNEE ORACLE  ACTIA Colomiers

Activer=1

User     = sce3011_wip
Pwd      = sce
Protocol = oracle
HostName = 192.168.151.11
Port     = 1521
Base     = ACTIAORA

;POUR LA CONNEXION A LA BASE DE DONNEE ORACLE  CIPI ACTIA  Modifier :
;HostName = serveur-bd
;Port     = 1521
;Base     = SCEORA_SERVEUR_BD


POUR ACCEDER à ORACLE : Installer INSTANT CLIENT sur le poste

********************************************************************************

[BDD_ACCESS_1]

;CONNEXION A LA BASE DE DONNEE ACCESS

;Activer(1) ou désactiver(0)
Activer=1

;Paramètres

Pwd  	  = secu
Protocol  = ado
Base      = SecuriseApproSoudure.mdb
ChaineCnx = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%S;Jet OLEDB:Database Password=%S;Persist Security Info=False;'

CheminReseau = 

;Pour le Chemin réseau mettre le chemin  (sans le nom de la base)
; si VIDE la base doit se trouver dans le Même répertoire que l'executable

********************************************************************************



}




end.
