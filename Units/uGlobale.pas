 unit uGlobale;

interface

uses
  Windows, Forms, SysUtils, uReadWriteIni;


type
  // Param�tres Produits ou Articles
  TDataProduit = record
    IndexVisim        : string;
    CodeActia         : string;
    Automate          : Boolean;
    Designation1      : string;
    Designation2      : string;
    MenuSelection     : string;
    Operation         : string;
    Ressource         : string;
    NomColonneProduit : string;
    PositionIndex     : string;
    NbreEtiquette     : string;
    SourceZPL         : string;
    SfcProduitFini    : string;
    SfcProduitFiniVISIM    : string;
    blnPrdVisim       : boolean;
    SevenDigitSerie   : string;
    DataAssociation   : string; // donn�es enregistr�e dans la bdd;
    blnConnecteur     : boolean;
    reference_client  : string;
    V_HW              : string;
    Version           : boolean;
    num_post_integ    : string;
  end;


  TDataArticle = record
    idArticle               : string;
    CodeActia               : string;
    Designation             : string;
    Operation               : string;
    Ressource               : string;
    PositionIndex           : string;
    ControleDoublon         : integer;
    ControleDone            : integer;
    NomColonneArticle       : string;
    Famille                 : integer;
    TagArticle              : integer;
    Phase                   : integer;
    NumeroSerie             : string;
    blnArticleVisim         : boolean;  //  identiques permet de changer d'�tat en
    blnControleVisim        : boolean;  //  pr�sence d'une reprise d'articles
    blnSaisieManuelle       : boolean;
    NombreDigits            : integer;

  end;


 TImpression = record
    DirSavePrint      : string;
    DataFileSourceZPL : string;
    TableReprint      : string;
    NamePrinter       : string;
    IndexPrinter      : integer;
    YearWeekNow       : string;
    WeekCompteur      : string;
    DayCompteur       : string;
    PathNameFichierZPL: string;
    pwdReprint        : string;
    AnneeWSemaine     : string;
    PwdRework         : string;
    WLAN_MAC_tr       : string;
    DLC_MAC_tr        : string ;
    Code_client       : string ;
  end;



  TDataVisim = record
    strInterBlocage   : string;     // "Acti"lock ou "Visi"m
    strSITE           : string;
    strUSER           : string;
    strAdresse        : string;
    strPort           : word;
  end;

  TConnexionBdd = record
    FBD1    : boolean;
    FBD2    : boolean;
    ORACLE  : boolean;
    ACCESS  : boolean;
  end;


  TPortCom = record
    NumPort   : Byte;
    BaudRate  : Longint;
    Parite    : Char;
    StopBit   : Byte;
    DataBit   : Byte;
    TimeOut   : DWord;        // Temps autoris� � la r�ception
  end;

  TPortIP = record
    Adresse   : string;
    Vitesse   : Cardinal;
  end;
  TDataRework = record
   NUMERO_SERIE       : string;
   SFC_BOITIER_MONTE  : string;
   REF_PRODUIT        : string;
   DESIGNATION        : string;
   NUM_SERIE_CIE      : string;
   PATH_LABEL_IMPRIME : string;
  end;

var
  strFichierIni       : string;
  LabelDuPoste        : string;
  rProduit            : TDataProduit;
  rArticle            : array of TDataArticle;
  rVisim              : TDataVisim;
  rPrint              : TImpression;
  rRwork              : TDataRework;
  intIdPoste          : integer;

  blnLogoActia          : boolean;
  blnEtatLecteurCB      : boolean = false;
  blnImpressionActive   : boolean;
  blnReimpressionActive : boolean = false;
  bln2Phase             : boolean ;
  blnReworkActive       : boolean = false;
  blnReworkActive_cap   : boolean = false;

  Sequence              : integer = 0;
  rLecteurCom           :TPortCom;
  rLecteurComReimp      :TPortCom;
  rAutomatecom          :TPortIP;
  Etape                 : Integer;
  Compteur_vis          : Integer;
  Num_vis : integer;
  XEtape: Integer;
  PathLog               : string;
  blnMenuReglage        : boolean;
  Debug                 : boolean;
// *****************************************************************************
// variable pour etape
   etape_lecture_1: integer;
   etape_lecture_2: integer;
   limite_inf:      integer;
   limite_sup:      integer;
   def_raz:         integer;
   etape_impression : integer;
  
 //**********************************************  
  procedure ParametreAppli;
  
  function  AffecterIni: boolean;

implementation

//******************************************************************************
// D�finir le Logo � afficher  suivant le Site en cours
procedure DefinirLogo;
begin
  if (rVisim.strSITE = 'CIPI') then
    blnLogoActia := false
  else
    blnLogoActia := true;
end;


//******************************************************************************
// R�cup�ration des param�tres du fichier INI
procedure ParametreAppli;
begin
  LabelDuPoste    :=  LitString('APROPOS','TitreAppli');


  // PortCom
  with rLecteurCom do
    begin
      NumPort   := Litinteger('PORT_COM_A','Port');;
      BaudRate  := Litinteger('PORT_COM_A','BaudRate');
      Databit   := Litinteger('PORT_COM_A','Databit');
      Parite    := LitString('PORT_COM_A','Parite')[1];
      StopBit   := Litinteger('PORT_COM_A','StopBit')
      //TimeOut   := DWord;
    end;
    // Port automate
  with rAutomatecom do
    begin
      Adresse   := LitString('PORT_IP','Adresse');
      Vitesse   := Litinteger('PORT_IP','Vitesse');
      //TimeOut   := DWord;
    end;
   with rLecteurComReimp do
    begin
      NumPort   := Litinteger('PORT_COM_B','Port');;
      BaudRate  := Litinteger('PORT_COM_B','BaudRate');
      Databit   := Litinteger('PORT_COM_B','Databit');
      Parite    := LitString('PORT_COM_B','Parite')[1];
      StopBit   := Litinteger('PORT_COM_B','StopBit')
      //TimeOut   := DWord;
    end;

  // Datas concernant Visim
  rVisim.strInterBlocage  := LitString('GENERAL','Interblocage');
  rVisim.strSITE          := LitString('GENERAL','Site');
  rVisim.strUSER          := LitString('GENERAL','User');
  rVisim.strAdresse       := LitString(rVisim.strSITE + '_VISIM','Host');
  rVisim.strPort          := LitInteger(rVisim.strSITE + '_VISIM','Port');

  // Logo actif
  DefinirLogo;

  PathLog               := LitString('GENERAL','DirLogAssociation');
  blnMenuReglage        := LitBoolean('GENERAL','Reglage'+ IntTostr(intIdPoste));

  Debug                := LitBoolean('GENERAL', 'Debug_'+ IntTostr(intIdPoste));
  
  // Datas concernant l'impression
  blnImpressionActive   := LitBoolean('IMPRESSION','PrintActive');
  if blnImpressionActive then
    begin
      rPrint.DirSavePrint   := LitString('IMPRESSION','DirZplImprime');
      rPrint.TableReprint   := LitString('IMPRESSION','TableDeReprint');
      rPrint.NamePrinter    := LitString('IMPRESSION','NomImprimante');
    end;
//******************************************************************************
// PARAMETRE DE LECTURE DATAMATRIX
//********************************************************************************
  etape_lecture_1:= LitInteger('ETAPE_LECTURE','LECURE_1');
  etape_lecture_2:= LitInteger('ETAPE_LECTURE','LECURE_2');
  limite_inf:=       LitInteger('ETAPE_LECTURE','limite_inf');
  limite_sup:=     LitInteger('ETAPE_LECTURE','limite_sup');
  def_raz:=        LitInteger('ETAPE_LECTURE','def_raz');
  etape_impression := LitInteger('ETAPE_LECTURE','impression');
//********************************************************************************


end;



//******************************************************************************
// Memoriser le produit en cours
procedure MemoIndexProduit(strProduit: string);
begin
  EcritString('CHARGEMENT_LOT','MemoIndex',strProduit);
end;

//******************************************************************************
// Fichier Ini dans le repertoire courant ou ..\Ini\
function  AffecterIni: boolean;
var
  strPath: string;
begin
  result := true;
  strPath := '\config_PCM1.ini';   //<-----ICI Modif Fichier INI

  // Affecter le fichier Ini
  strFichierIni := GetCurrentDir + strPath;
  if FileExists(strFichierIni) then
  else
    begin
      strFichierIni := '..\Ini' + strPath;
      if FileExists(strFichierIni) then
        // Affecter le ini au module uReadWriteIni
        // pour �viter de r�p�ter le nom du fichier ini � chaque fois
        SetNomFichierIni(strFichierIni)
      else
        begin
          MessageBoxA(0,Pchar('Erreur: le fichier d''initialisation " ' + strFichierIni +  ' " n''a pas �t� trouv� !!' +#13+'  '),
                      Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
          result := false;
          exit;
        end;
    end;

end;

//******************************************************************************
// D�finition du poste int�gration � l'aide de la ligne de commande
procedure DefinirPosteIntegration;
begin
  // D�finition du poste appelant l'application
 if ParamCount >= 1 then
    begin
      case StrToInt(ParamStr(1)) of
        1: intIdPoste := 1;
        2: intIdPoste := 2;
        3: intIdPoste := 3;
        4: intIdPoste := 4;
        else  intIdPoste := StrToInt(ParamStr(1));
      end;
    end
  else intIdPoste := 1;
  // le param�tre intIdPoste := 9 affiche toute la liste des produits
end;

//******************************************************************************
// Proc�dures � lancer au d�marrage
procedure InitialisationDemarrage;
begin
  //ApplicationPath := ExtractFilePath(Application.ExeName);
  DefinirPosteIntegration;
end;


initialization
  InitialisationDemarrage;

finalization


end.
