           unit uPrincipale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, CDEdit, StrUtils, GIFImage, AppEvnts,
  NoDaveComponent, Spin, ComCtrls,uReadWriteIni, jpeg, DateUtils;

type
  TFMain = class(TForm)
    Label10: TLabel;
    LogoActia: TImage;
    LogoCipi: TImage;
    lblTitre: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    txtIndex: TCDEdit;
    txtRefActia: TCDEdit;
    txtDesignation: TCDEdit;
    grpArticle2: TGroupBox;
    lblDesignation2: TLabel;
    shp2: TShape;
    txtPN2: TCDEdit;
    txtIndex2: TCDEdit;
    txtNumeroSerie2: TCDEdit;
    grpInfo: TGroupBox;
    lblInfo: TLabel;
    grpArticle3: TGroupBox;
    lblDesignation3: TLabel;
    shp3: TShape;
    txtPN3: TCDEdit;
    txtIndex3: TCDEdit;
    txtNumeroSerie3: TCDEdit;
    grpArticle4: TGroupBox;
    lblDesignation4: TLabel;
    shp4: TShape;
    txtPN4: TCDEdit;
    txtIndex4: TCDEdit;
    txtNumeroSerie4: TCDEdit;
    grpArticle5: TGroupBox;
    lblDesignation5: TLabel;
    shp5: TShape;
    txtPN5: TCDEdit;
    txtIndex5: TCDEdit;
    txtNumeroSerie5: TCDEdit;
    grpArticle6: TGroupBox;
    lblDesignation6: TLabel;
    shp6: TShape;
    txtPN6: TCDEdit;
    txtIndex6: TCDEdit;
    txtNumeroSerie6: TCDEdit;
    grpArticle7: TGroupBox;
    lblDesignation7: TLabel;
    shp7: TShape;
    txtPN7: TCDEdit;
    txtIndex7: TCDEdit;
    txtNumeroSerie7: TCDEdit;
    grpArticle8: TGroupBox;
    lblDesignation8: TLabel;
    shp8: TShape;
    txtPN8: TCDEdit;
    txtIndex8: TCDEdit;
    txtNumeroSerie8: TCDEdit;
    MainMenu1: TMainMenu;
    mnuInitialiser: TMenuItem;
    mnuReprint: TMenuItem;
    mnuRetour: TMenuItem;
    pnlCnx: TPanel;
    Label6: TLabel;
    lblVisim: TLabel;
    lblOracle: TLabel;
    lblAccess: TLabel;
    Panel2: TPanel;
    Loupe: TImage;
    TimerScrute: TTimer;
    grpAutomate: TGroupBox;
    Label4: TLabel;
    txtNewNumSerieProduit: TCDEdit;
    TimerClignoter: TTimer;
    TimerAutorisation: TTimer;
    lblAutomate: TLabel;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    StaticText1: TStaticText;
    Button1: TButton;
    ComboBox1: TComboBox;
    Button3: TButton;
    ComboBox2: TComboBox;
    ProgressBar2: TProgressBar;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    ComboBox3: TComboBox;
    ListBox1: TListBox;
    NoDave: TNoDave;
    ApplicationEvents1: TApplicationEvents;
    Timer_etape: TTimer;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Imagedefaut: TImage;
    lblPassFail: TLabel;
    grpArticle1: TGroupBox;
    lblDesignation1: TLabel;
    shp1: TShape;
    txtPN1: TCDEdit;
    txtIndex1: TCDEdit;
    txtNumeroSerie1: TCDEdit;
    Label13: TLabel;
    GroupBox3: TGroupBox;
    txtcompteur: TCDEdit;
    txtcode_client: TCDEdit;
    Label15: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    shpControle: TShape;
    shpMiniControle: TShape;
    lblSanction: TLabel;
    shpSanction: TShape;
    shpMiniSanction: TShape;
    lblbasetrace: TLabel;
    lblrework: TLabel;
    GroupBox4: TGroupBox;
    Label18: TLabel;
    ProgressBar1: TProgressBar;
    Timercmp: TTimer;
    NoDave1: TNoDave;
    txtnbrvis: TCDEdit;
    tempovissage: TTimer;
    Button2: TButton;
    procedure mnuRetourClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuInitialiserClick(Sender: TObject);
    procedure LoupeClick(Sender: TObject);
    procedure mnuReprintClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TimerScruteTimer(Sender: TObject);
    procedure TimerClignoterTimer(Sender: TObject);
    procedure TimerAutorisationTimer(Sender: TObject);
    procedure ValidationManuelle(Sender: TObject; var Key: Char);
   
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);

    procedure NoDaveRead(Sender: TObject);
    procedure NoDaveReadcmp(Sender: TObject);
    procedure NoDaveDisconnect(Sender: TObject);
    procedure NoDaveConnect(Sender: TObject);
    procedure NoDaveError(Sender: TObject; ErrorMsg: String);
    procedure tempovissageTimer(Sender: TObject);
    procedure txtnbrvisChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
//    procedure cmdScan2Click(Sender: TObject);



  private
    blnResize             : boolean;
    intNbreArticle        : integer;
    intCountArticle       : integer;

    intDebutCount         : integer;
    intNbreArticlePhase2  : integer;
    NbreArticleDeLaPhase  : integer;

    strLeBuffer : string;
    intClignoter: integer;
    blnBreakTimer      : boolean;
    blnDepartPhase2    : boolean;
    blnFail            : boolean;
    DataType: Integer;
    DataOffset: Integer;
    DataCount: Integer;
    DataSize: Integer;
    MustRefresh: Boolean;


    iC_DeBug       : integer;  // rajout pour compter les passages du cycle d'attente

    function ListerArticleAssocie: boolean;
    procedure MisaAjourIHM(intNbre: integer);
    procedure lblInfoColor(strInfos: string);
    function VerificationNumeroSerie(strSN: string): boolean;
    function VerificationEtiquette (strSN: string): boolean;
    function ConstruireDateCodeClient : boolean;
    function Controletrace(strData, strChamp : string): boolean;
    procedure InitIHM;
    function TraitementAppli: boolean;
    function TraitementAppliRework  : boolean;
    function EnregistrementData(Statut: string): boolean;
    function EnregistrementtraceProduit :boolean;
    function VISIM_QuickCompleteArticle(intIc: integer): boolean;
    procedure Phase1ToPhase2;
    procedure InitialisePhase(intEtape: integer);

    procedure DoLoop;
    function VISIM_Start: boolean;
    function VISIM_NcLogComplete(strNcCode: string): boolean;
    function VISIM_Complete: boolean;
    function CtrlDoublonCodeclient(strTable, strNumserie, strColonne: string): boolean;

  public
    procedure DataDuPortCom(strScan: string);
    procedure LoadImage(intEtape: string );
    procedure UnloadImage;
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses uGlobale, uSelectionProduit, uFonctions, uConnexionBdd, u1PortCom,
uPrintZPL, UInterlock, uDialog, uReprintLabel,  uLogin, uSmema_Carte, MMDebug,uPatienter;
const
  AreaNames: Array[0..13] of String = ('SI%1:s%4u', 'SF%1:s%4u', 'I%1:s%4u', 'Q%1:s%4u', 'I%1:s%4u', 'Q%1:s%4u', 'M%1:s%4u', 'DB%u.%s%4u', 'DI%u.%s%4u', 'DL%u.%s%4u', '?%u.%s%4u', 'C%1:s%4u', 'T%1:s%4u', 'PE%1:s%4u');
  TypeNames: Array[0..5] of String = ('B', 'W', 'Int', 'DW', 'DInt', 'Real');

var
 memoSeq: byte;
 blnStatutIn5         : boolean = true;   // Permet les actions que sur le front montant du contact IN5 (Boitier Inf)



//******************************************************************************
// Affichage de l'état des connexions
function AfficheEtatConnexions : boolean;
var
  iCount : word;
begin
  iCount := 0;
  result := false;
  with FMain do
    begin
      lblOracle.Caption   := '';
      lblAccess.Caption   := '';
      lblVisim.Caption    := '';
      lblAutomate.Caption := '';
      lblbasetrace.Caption := '';
      lblrework .Caption := '';
      if not CnxBdd.ZCnxOracle.Connected then
        begin
          lblOracle.Caption := 'ORACLE désactivé';
          inc(icount);
        end;
         if not CnxBdd.ZCnxFdb2.Connected  then
        begin
          lblbasetrace.Caption := 'Base trace désactivé ';
          inc(icount);
        end;

      if not rProduit.blnPrdVisim then
        begin
          lblVisim.Caption := 'VISIM désactivé';
          inc(icount);
        end;

      if not rProduit.Automate then
        begin
          lblAutomate.Caption := 'Automate Désactivé';
          inc(icount);
        end;
       if  blnReworkActive  then
        begin
          lblrework.Caption := 'Mode Rework Activé';
          inc(icount);
        end;
   end;

  result := icount >= 1;
  if result then
    begin
      //FMain.Height := FMain.Height + 20;
     // FMain.pnlCnx.Visible := true;
      //FMain.pnlCnx.Left := 4;
     // FMain.pnlCnx.Top  := FMain.grpInfo.Top + FMain.grpInfo.Height + 2;
    end
   else FMain.pnlCnx.Visible := false;
end;

//******************************************************************************
//
procedure TFMain.FormCreate(Sender: TObject);
begin

  // Infos des labels et du logo
  Caption := 'POSTE INTEGRATION ' +  IntToStr(intIdPoste)  + ' / Version : ' + VersionIni;
  lblTitre.Caption            :='POSTE INTEG 1.2 : ' +rproduit.MenuSelection ;
  logoActia.Visible := blnLogoActia;
  logoCipi.Visible := not blnLogoActia;

  // Afficher les infos du produit sélectionné
  with rproduit do
    begin
      txtIndex.Text               := IndexVisim;
      txtRefActia.Text            := CodeActia;
      txtDesignation.Text         := Designation1;
    end;


   // initialiser la gestion des phases
   bln2Phase        := false;
   blnResize        := false;

  // Liste de tous les articles associés au produit sélectionné
  ListerArticleAssocie;

  // Ajuster l'affichage au nombre d'articles
  MisaAjourIHM(intNbreArticle);

  // Etat de la com avec Automate
  grpAutomate.Visible := (rProduit.Automate);
  Timer_etape.Enabled := (rProduit.Automate) ;
  nodave.IPAddress  := (rAutomatecom.Adresse);
  nodave.Interval   := (rAutomatecom.Vitesse);

  nodave1.IPAddress  := (rAutomatecom.Adresse);
  nodave1.Interval   := (rAutomatecom.Vitesse);


  If rProduit.Automate = true then
  begin
  Button1Click(button1);  // a modifier   TO do
  nodave.Active:=true;
  nodave1.Active:=true;
  nodave.WriteBit(12,2,true);
  sleep( 1000);
  nodave.WriteBit(12,2,false);
  nodave.WriteBit(200,0,rProduit.Version);
  nodave.WriteBit(200,0,rProduit.Version);
  nodave.WriteInt(2,1);
  end;
  Timer_etape.Enabled := (rProduit.Automate) ;
  // cmdScan2.Visible    := rProduit.Automate;


  // Init Phase 1
  if bln2Phase then
    InitialisePhase(1)
  else
    begin
   //   grpPhase.Visible := false ;
      //grpCtrlOK.Left := 136;
     // grpAttenteSanction.Left := 408;
    end;

  // Afficher l'état des connexions
  pnlCnx.Visible := AfficheEtatConnexions;

  // Afficher ou non le menu réimpression
  mnuReprint.Visible := blnImpressionActive;

  // Activer lecteur code barre
  blnEtatLecteurCB := true;




      DB_WriteStrLn(0, 'Programme PCM');
      DB_WriteStrLn(0, 'sequence := 0');
     

  sequence := 0;
  TimerScrute.Enabled := true;




end;

//******************************************************************************
//
procedure TFMain.InitialisePhase(intEtape: integer);
var
  ic: integer;
begin
  case intEtape of
    1:begin
        if rproduit.Automate then
          begin
            intDebutCount := 1;
          //  lblPhase.Font.Color := clBlue;
       //     lblPhase.Caption := 'Phase 1';
            NbreArticleDeLaPhase := intNbreArticle - intNbreArticlePhase2;
            for iC := intDebutCount to intNbreArticle do
              begin
                if rArticle[ic].Phase = 1 then
                  TGroupBox(FMain.FindComponent('grpArticle' + IntToStr(iC))).Visible := true
                else
                  TGroupBox(FMain.FindComponent('grpArticle' + IntToStr(iC))).Visible := false;
              end;
           end
        else
          begin
            intDebutCount := 1;
            NbreArticleDeLaPhase := intNbreArticle;
          end;
      end;
      
    2:begin
        intDebutCount  := (intNbreArticle - intNbreArticlePhase2) + 1;
        NbreArticleDeLaPhase := intNbreArticle;

        if rproduit.Automate then
          for iC := intDebutCount to NbreArticleDeLaPhase do
            TGroupBox(FMain.FindComponent('grpArticle' + IntToStr(iC))).Visible := true;
      end;
  end;

end;


//******************************************************************************
// Afficher la liste des articles à associer pour le produit sélectionné
function TFMain.ListerArticleAssocie: boolean;
var
  iC            : integer;
  DIndex        : TEdit;
  DPartNumber   : TEdit;
  DTxtSerie     : TEdit;
  DDesignation  : TLabel;
  DGrpArticle   : TGroupBox;


begin
  result := false;
  intNbreArticlePhase2 := 0;
  with CnxBdd.ZSelectFdb1 do
    begin
      sql.Clear;
      sql.Add('SELECT * FROM LISTE_ARTICLE');
      sql.Add(' WHERE ASSOCIATION LIKE ' + quotedStr('%' + rProduit.IndexVisim + '%'));
      sql.Add(' ORDER BY PHASE ASC, FAMILLE ASC');
      Active := true;

      // Afficher le nombre d'article à associer
      intNbreArticle := RecordCount;

      if intNbreArticle <> 0 then
        begin

          // La position 0 du tableau n'est pas prise en compte dans la dimension du tableau des articles.
          setLength(rArticle, intNbreArticle + 1);

          iC := 1;
          while (not Eof) do
            begin
              with rArticle[iC] do
                begin
                  idArticle               := fieldByName('ID_ARTICLE').AsString;
                  CodeActia               := fieldByName('PN_ACTIA').AsString;
                  Designation             := fieldByName('DESIGNATION').AsString;
                  blnArticleVisim         := IntToBoolean(FieldByName('VISIM').AsInteger); //
                  Operation               := fieldByName('OPERATION').AsString;
                  Ressource               := fieldByName('RESSOURCE').AsString;
                  PositionIndex           := fieldByName('POS_INDEX').AsString;
                  ControleDoublon         := fieldByName('CTRL_DOUBLON').AsInteger;
                  NomColonneArticle       := fieldByName('NOM_COL_ASSOCIE').AsString;
                  Famille                 := fieldByName('FAMILLE').AsInteger;
                  Phase                   := fieldByName('PHASE').AsInteger;
                  blnSaisieManuelle       := IntToBoolean(fieldByName('SAISIE_MANUELLE').AsInteger);
                  NombreDigits            := fieldByName('NOMBRE_DIGITS').AsInteger;
                  TagArticle              := iC;

                  // Vérifier que les ressource et l'opération est présente pour les articles sélectionné
                  if blnArticleVisim then
                    begin
                      if (Operation ='') or (Operation ='0') or (Ressource ='') or (Ressource ='0') then
                        begin
                          MessageBoxA(0,Pchar('ERREUR : La Ressource ou l''opération VISIM pour l''article ' + Designation + ' n''est pas renseigné dans la Base de donnée !'+#13+'  '),
                                Pchar('Chargement produit'),0 + MB_ICONEXCLAMATION + 0);
                          //exit;
                        end;
                    end;


                  // Renseigner et configurer chaque article
                  DTxtSerie     := TEdit(FMain.FindComponent('txtNumeroSerie' + IntToStr(iC)));
                  DIndex        := TEdit(FMain.FindComponent('txtIndex' + IntToStr(iC)));
                  DPartNumber   := TEdit(FMain.FindComponent('txtPN' + IntToStr(iC)));
                  DDesignation  := TLabel(FMain.FindComponent('lblDesignation' + IntToStr(iC)));
                  DGrpArticle   := TGroupBox(FMain.FindComponent('grpArticle' + IntToStr(iC)));

                  DIndex.Text           := idArticle;
                  DPartNumber.text      := CodeActia;
                  DDesignation.Caption  := 'Code ACTIA' ;//Designation;
                  DGrpArticle.Caption   := 'Article ' + IntToStr(Ic)+ ': '+CodeActia;
                  DTxtSerie.ReadOnly    := not(blnSaisieManuelle);

                  // Signaler que l'article est désactivé de visim


                  // Dans le cas de deux phases de travail afficher la phase encours
                  if Phase = 2 then
                    begin
                      inc(intNbreArticlePhase2);
                      bln2Phase := true;
                    end;    

                end;
              iC := Ic + 1;
              next ;
              result := true;
            end;
        end
      else
        begin
          lblInfoColor('ERREUR : Pas d''articles associés avec le produit en cours'
                        + #13#10 + 'Vérifier l''association des articles avec le produit en cours,R');
        end;
    end;

end;



//******************************************************************************
// Reception de la lecture faite sur le port com et distribution vers le
// le mode réimpression s'il est sélectionné sinon vers le traitement du n° de série
procedure TFMain.DataDuPortCom(strScan: string );
var
  strResult: string;
begin
  lblInfo.Caption := '';
  try
    // Désactiver Lecture Code barre et mnuretour
    blnEtatLecteurCB  := false;

    // si le mode réimpression est activé
    if blnReimpressionActive then
       FReprintLabel.ReprintLabelScan(strScan)
    else
      begin
         if ( etape = etape_lecture_1 )or( etape = etape_lecture_2 ) or (rProduit.Automate=false) then
           begin
          // showmessage ('a');
           VerificationNumeroSerie(strScan);
           end;
         end;

  finally
    // Réactiver Lecture Code barre
    blnEtatLecteurCB := true;
  end;

end;


//******************************************************************************
// Gestion de l'affichage final suite au résultat de l'association produit
//******************************************************************************

procedure GestionPassFail(blnEtat: boolean);
begin
  with FMain.lblPassFail do
    if blnEtat then
      begin
        Font.Color := clTeal;
        Caption := 'PASS';
        Fmain.intCountArticle := 0;
        Visible := true;
      end
    else
      begin
        Font.Color := clRed;
        Caption := 'FAIL';
        Visible := true;
      end;
end;

//*******************************************************************************************
// Créer le date code du client en deux partie car séparé par le  n° du poste d'intégration *
// 1006 1 00001  annee_semaine_n°poste_compteur_sur_5_digits                                *
//*******************************************************************************************
function TFMain.ConstruireDateCodeClient: boolean;
var
  Inidate, IniCompteur : integer;
  date_Courante         : string;

begin
  result := false;

  try
    // Récupérer la derniere semaine ou jour et le nombre de carte enregistré
    Inidate := LitInteger('COMPTEUR','Numdate',strFichierIni);
    IniCompteur := LitInteger('COMPTEUR','ProduitJour',strFichierIni);

   // Mémoriser les valeurs et les réinscrire en cas d'erreur en cours de cycle
   // MemoSemaine := Inidate;
    //MemoCompteur:= IniCompteur;

   // Compteur de carte par semaine , Si la semaine change initialiser le compteur de carte semaine
    date_Courante := format('%.2d',[WeekOfTheYear(Now)]); //week

   // Compteur de carte par jour , Si le jour change initialiser le compteur de carte par jour
   // date_Courante := format('%.3d',[DayOfTheYear(Now)]);  // day

   // if Inidate <> StrToInt(date_Courante) then
     if inidate <> StrToInt( date_Courante ) then
      begin
        IniCompteur :=  LitInteger('COMPTEUR','InitCompteur',strFichierIni);
      end
    else
      begin
        IniCompteur := IniCompteur + 1 ;
      end;

    // Formattage sur 6 digits du compteur de carte par semaine
     rPrint.DayCompteur := format('%.6d',[IniCompteur]);

    // Année et semaine courante
    rPrint.YearWeekNow := YearWWeek   ;

     //rPrint.YearWeekNow := FormatDateTime('yy',Date) + FormatDateTime('mm',Date)+ FormatDateTime('dd',Date) ;
//*************************************************************************************
    // Ecrire dans le fichier Ini les dernier n° utilisé


    rPrint.Code_client := rPrint.YearWeekNow + rPrint.DayCompteur;
//***************************************************
// contrle doublons dans la base code client
//*****************************************************
     if CtrlDoublonCodeclient('CODE_CLIENT_1', rPrint.Code_client,'NUMERO_SERIE') then
      begin
       // AnnulerTransaction(CnxBdd.ZCnxFdb1);
        exit;
      end;
//***************************************************
   // sauvgarde code client dans la base code client
 //***************************************************
   DebutTransaction(cnxBdd.ZCnxFdb1);

     if not EnregistrementData('CODE') then
      begin
        AnnulerTransaction(CnxBdd.ZCnxFdb1);
        exit;
      end;

   ValiderTransaction(CnxBdd.ZCnxFdb1);
   EcritInteger('COMPTEUR','Numdate',strFichierIni,StrToInt(date_Courante));
   EcritInteger('COMPTEUR','ProduitJour',strFichierIni,StrToInt(rPrint.DayCompteur ));
   txtcode_client.Text := rPrint.Code_client ;
   txtcompteur.Text := rPrint.DayCompteur ;

   result := true;

  except
     on E: Exception do
       begin
       lblInfoColor('ERREUR lors de la création date code client : '+#13+ E.Message +',R');

       end;
   end;
end;

 //******************************************************************************
// Rechercher si le n° de série n'a pas déjà été utilisé (Contrôle Doublon complet)
function TFMain.CtrlDoublonCodeclient(strTable, strNumserie, strColonne: string): boolean;
            begin
              result := false;
              with CnxBdd.ZSelectFdb1 do
                begin
                  sql.Clear;
                  sql.Add('SELECT ' + strColonne );
                  sql.Add(' FROM ' + strTable);
                  sql.Add(' WHERE ' + strColonne + '=' + quotedStr(strNumserie));
                  Active := true;

                  if RecordCount <> 0 then
                    begin
                      result := true;
                      //lblInfoColor('ERREUR : le n° de série "'+ strNumserie + '" à déjà été traité (Il existe dans la Bdd),R');
                    end;
                end;



            end;

//*********************************************************************************
// Vérifier la validité de l'etiquette    finalle
//*********************************************************************************
function TFMain. VerificationEtiquette(strSN: string): boolean;
 var

  Car           : Char;
  iCount        : word;
  DNumSerie     :TCDEdit;




  begin
  
       result := false;
       while mlePortCOM.ComPort1.InBufUsed <> 0   do
       begin
            DB_WriteStrLn(0, 'Réception des caractères sur le port com reimp ');
            Car := mlePortCOM.ComPort1.ReadChar;
            if Car in [' ','-','_','/','0'..'9','A'..'Z','a'..'z'] then strLeBuffer := strLeBuffer + Car;
            if Car = #$0D then
            //**********************************************************************************
            //      Controle sur lecture de data matrix
            //**********************************************************************************
            begin
                  if txtNewNumSerieProduit.Text = strLeBuffer then
                  begin
                      //sequence := 0;
                      txtNewNumSerieProduit.Color := cllime;
                  end ;

                 { if txtcode_client.Text = strLeBuffer then
                  begin
                       //sequence := 0;
                       txtcode_client.Color := cllime;
                  end ; }

                 strLeBuffer := '';
            end ;
       if  (txtNewNumSerieProduit.Color = cllime) then result := true;
  //end ;
   // strLeBuffer := '';
 end;
 end;
//******************************************************************************
// Vérifier la validité et affecter le n° de série
function TFMain.VerificationNumeroSerie(strSN: string): boolean;
var
  iC                  : word;
  DNumSerie           : TCDEdit;
  DShp                : TShape;
  MsgPosition         : string;


          //******************************************************************************
          // Rechercher si le n° de série n'a pas déjà été utilisé (Contrôle Doublon complet)
          function CtrlDoublonNumeroSerie(strTable, strNumserie, strColonne: string): boolean;
            begin
              result := false;
              with CnxBdd.ZSelectFdb1 do
                begin
                  sql.Clear;
                  sql.Add('SELECT ' + strColonne );
                  sql.Add(' FROM ' + strTable);
                  sql.Add(' WHERE ' + strColonne + '=' + quotedStr(strNumserie));
                  Active := true;

                  if RecordCount <> 0 then
                    begin
                      result := true;
                      lblInfoColor('ERREUR : le n° de série "'+ strNumserie + '" à déjà été traité (Il existe dans la Bdd),R');
                    end;
                end;
            end;

            
          //******************************************************************************
          // REWORK :Rechercher si le n° de série n'a pas déjà été utilisé (Contrôle Doublon complet)
	  //*********************************************************************************
          function CtrlDoublonNumeroSerieRework(strTable, strNumserie, strColonne: string): boolean;
            begin
              result := false;
              with CnxBdd.ZSelectFdb1 do
                begin
                  sql.Clear;
                  sql.Add('SELECT ' + strColonne );
                  sql.Add(' FROM ' + strTable);
                  sql.Add(' WHERE ' + strColonne + '=' + quotedStr(strNumserie));
                  Active := true;

                  if RecordCount = 0 then
                    begin
                      result := true;
                      lblInfoColor('ERREUR : le n° de série "'+ strNumserie + '" non traité (Il n''existe pas dans la Bdd),R');
                    end;
                end;
            end;
      //********************************************************************



begin
  {
    Controler que l'index est conforme à l'un des articles attendu
    Faire le controle doublon du N° de serie
    Vérifier que le sfc est à la bonne position sur le routeur
    Récupérer à l'aide du n° série Boitier les informations de son contenu sur le poste précédent
   }
  lblInfo.Caption := '';
  
  result := false;

  // Initialiser l'affichage si nouvelle série d'articles.
  if intCountArticle = 0 then InitIHM;


  // Parcourir les index à associer pour vérifier si le n° serie scanné correspond à un article
  for iC := intDebutCount to NbreArticleDeLaPhase do
    begin
      if (rArticle[iC].idArticle = ExtractionString(strSN,rArticle[iC].PositionIndex)) then
          begin

            // Récupérer le text box correspondant

            DNumSerie := TCDEdit(FMain.FindComponent('txtNumeroSerie' + IntToStr(rArticle[iC].TagArticle)));
            DShp := TShape(FMain.FindComponent('Shp' + IntToStr(rArticle[iC].TagArticle)));
            DShp.Visible := true;
            DNumSerie.Refresh;

            DShp.Brush.Color := clWhite;
            Dshp.Refresh;

            // Si un n° de série est présent dans le text box concernant ce n° de série :
            // c'est que le compteur à déjà comptabilisé cet article, il faut décompter 1
            if (DNumSerie.Text <> '') then
              begin
                Dec(intCountArticle);
                DNumSerie.Text := '';
              end;


            // Vérifier le nombre de digits de l'article saisi
            if (rArticle[iC].NombreDigits <> 0) and  (not(rArticle[iC].NombreDigits = length(strSN))) then
              begin
                lblInfoColor('ERREUR : le nombre de digits du n° de série de l''article "'+ strSN + '" ('+ IntToStr(length(strSN)) + ') ne correspond pas au nombre attendu : (' + IntToStr(rArticle[iC].NombreDigits) +'),R');
                exit;
              end;




            // Passer le statut controle Visim dans une variable Bool pour être
            // éventuellement modifié en cas de présence article dans la table reprise
            // les articles en reprise sont déjà Done (terminé).
            rArticle[iC].blnControleVisim := rArticle[iC].blnArticleVisim;
         {
            // Vérif doublons
            if (rArticle[iC].ControleDoublon = 1) then
              begin
              showmessage (IntToStr(intIdPoste)) ;
            //  showmessage('Vérif doublons');
                // Vérifier que ce n° de série n'a pas déjà été Utilisé dansla table Association

                if (CtrlDoublonNumeroSerie('ASSOCIATION_INTEGRATION_'+ IntToStr(intIdPoste),strSN,rArticle[iC].NomColonneArticle)) then
                  begin
                  showmessage ('CtrlDoublonNumeroSerie1') ;
                    lblInfoColor('ERREUR : le n° de série article "'+ strSN + '" à déjà été traité (Il existe dans la Bdd),R');
                    exit;
                  end;

                // En cas de reprise suite à une dissociation
                // Vérifier que ce n° de série existe dans la table Reprise Integration
                // s'il existe ne pas faire de controle visiprise pour cet article
                if (CtrlDoublonNumeroSerie('REPRISE_INTEGRATION_'+ IntToStr(intIdPoste),strSN,rArticle[iC].NomColonneArticle)) then
                  begin
                    if ControlerDoneSFC(strSN) then
                      lblInfoColor(' Information : Article ayant fait l''objet d''une dissociation et possède le statut de terminé (Done),B')
                    else
                      lblInfoColor(' Information : Article ayant fait l''objet d''une dissociation,B');


                    // Je pense que dans le cas ou l'article n'est pas Done on vérifie sa position pour faire un start complete
                    // car le poste réparation aura fait un NC LOG

                    rArticle[iC].blnControleVisim := false;
                  end;
              end;

              }

            // Si le produit et l'article doit faire l'objet d'un traitement VISIM
            // Vérifier que le n° de série de l'article se trouve à la bonne position sur le routeur
            if rProduit.blnPrdVisim  and not blnReworkActive then
              begin
                if rArticle[iC].blnControleVisim then
                  begin
                    if not(RktPositionSFC(strSN,rVisim.strSITE,rArticle[iC].Operation,MsgPosition)) then
                      begin
                    //    DB_WriteStrLn(0, 'k1 ');
                        lblInfoColor('ERREUR rencontré lors de l''exécution de la requête "Position SFC",R');
                        exit;
                      end;
                    if (pos(rArticle[iC].Operation,MsgPosition) >= 1) then
                      begin
                    //  DB_WriteStrLn(0, 'k2 ');
                        // On ne fait rien l'opération existe à la bone position
                      end
                    else
                      begin
                     //   DB_WriteStrLn(0, 'MsgPosition = ' + MsgPosition );
                     // DB_WriteStrLn(0, 'k3 ');
                        if MsgPosition = '' then
                          begin
                        //  DB_WriteStrLn(0, 'k4 ');
                            if ControlerDoneSFC(strSN) then
                              
                              lblInfoColor('Erreur : Le n° de série article : "' + strSN + '" est terminé dans visiprise (Done)!,R')  
                               
                              
                            else
                              lblInfoColor('Le n° de série article : "' + strSN +' ' + rArticle[iC].Operation + '" n''existe pas ou n''est pas "IN_QUEUE" dans visiprise !,R')
                          end
                        else
                          begin
                            lblInfoColor('Le n° de série article : "' + strSN + '" ne se trouve pas à la bonne opération sur le routeur " ' +#13+' POSITION = " ' + MsgPosition + ' ",R');
                            exit;
                          end;
                      end;
                  end;
              end;


            // Si le produit et l'article doit faire l'objet d'un traitement Trace
            // Vérifier que le n° de série de l'article se trouve à la Base Trace

                if  LitBoolean('BDD_FIREBIRD_2','Activer')  then
                  begin
                    if not (Controletrace(strSN, 'SFC_CIE')) then
                      begin
                       // lblInfoColor('ERREUR rencontré lors de l''exécution de la requête "Position SFC",R');


                       // lblInfoColor('ERREUR: Doublon trouvé dans la base pour le n° " ' + strSN +' " ,R');
                        exit;
                      end;
                  end;

             // Si l'article fait partie de la famille 1 Créer le n° de série du produit Fini à partir du n° de série boitier
             if rArticle[iC].Famille = 1 then
                begin

                  rProduit.SfcProduitFini  := '';
                  rProduit.SfcProduitFiniVISIM  := '';
                  txtNewNumSerieProduit.Text := '';
                  rProduit.SevenDigitSerie := '';
                  rProduit.SevenDigitSerie := SeptDernierDigits(strSN);
                  if rProduit.SevenDigitSerie = '' then
                    begin
                      txtcode_client.Text    := '';
                      txtcompteur.Text    := '';
                      lblInfoColor('ERREUR rencontré lors de la recherche des derniers digits du n° de série : " ' + strSN + ' ",R');
                      exit;
                    end;

  //****************************************************************************************************************************************

                  rProduit.SfcProduitFini := rProduit.IndexVisim +'5'+ AnsiRightStr(FormatDateTime('yy',Now ),1) + rProduit.SevenDigitSerie +'0'+ rProduit.num_post_integ ;            //'/' + YearWWeek + '/'
                   rProduit.SfcProduitFiniVISIM := rProduit.IndexVisim +'5'+ AnsiRightStr(FormatDateTime('yy',Now ),1) + rProduit.SevenDigitSerie  ;
  //***************************************************************************************************************************************
                  // Contrôle doublon des 7 derniers digits du n° de série parce que la semaine change pour le n° de série produit
                  if  not blnReworkActive then
                  begin
                  if (CtrlDoublonNumeroSerie('ASSOCIATION_INTEGRATION_'+ IntToStr(intIdPoste), rProduit.SfcProduitFini ,'SFC_BOITIER_MONTE')) then
                    begin
                      lblInfoColor('ERREUR : le n° de série SFC ("'+ rProduit.SfcProduitFini  + '") du produit existe dans la Bdd,R');
                      exit;
                    end;
                   end;

                    // Contrôle doublon des sfc derniers digits du n° de série parce que la semaine change pour le n° de série produit
                  if  blnReworkActive then
                  begin
                  if (CtrlDoublonNumeroSerieRework('ASSOCIATION_INTEGRATION_'+ IntToStr(intIdPoste), rProduit.SfcProduitFini ,'SFC_BOITIER_MONTE')) then
                    begin
                      lblInfoColor('ERREUR : le n° de série SFC ("'+ rProduit.SfcProduitFini  + '") du produit n''existe pas dans la Bdd,R');
                      exit;
                    end;
                   end;

                  txtNewNumSerieProduit.Text := rProduit.SfcProduitFini;




                  // Vérifier que ce n° nouveau n° de série se trouve à la bonne position sur le routeur
                  if  not blnReworkActive then
                  begin
                  if rProduit.blnPrdVisim then
                    begin
                      if not(RktPositionSFC(rProduit.SfcProduitFiniVISIM,rVisim.strSITE,rProduit.Operation,MsgPosition)) then
                        begin
                          lblInfoColor('ERREUR rencontré lors de l''exécution de la requête "Position SFC",R');
                          exit;
                        end;
                      if (pos(rProduit.Operation,MsgPosition) >= 1) or (MsgPosition = '')then
                        begin
                          // On ne fait rien l'opération existe à la bone position ou il n'est pas encore crée (il va être créé automatiquement)
                          // Dans le cas d'une reprise il aura été remis in_queue par le poste reparation (dissociation)
                        end
                      else
                        begin
                          lblInfoColor('Le n° de série produit : "' + rProduit.SfcProduitFini + '" ne se trouve pas à la bonne opération sur le routeur' +#13+' POSITION = " ' + MsgPosition + ' ",R');
                          exit;
                        end;
                    end;
                end;
                end;

            // Mettre le n° de série dans le textbox et dans le tableau des articles
            DNumSerie.Text := strSN;
            rArticle[iC].NumeroSerie := strSN;
 //*******************************************************************************************
// création code client et verfication doublons
//**********************************************************************************************
                   {if  not blnReworkActive then
                   begin
                     if not ConstruireDateCodeClient then
                     begin
                      lblInfoColor('ERREUR : DE Creation code Client dans la base code client",R');
                      exit;
                     end;
                    end;}
//*******************************************************************************************************
 if blnReworkActive then
 begin
  with CnxBdd.ZSelectFdb1  do
    begin
      sql.Clear;
      Close;
      sql.Add('SELECT * FROM ASSOCIATION_INTEGRATION_1 WHERE NUM_SERIE_CIE  = ' + quotedStr(strSN));
      Open;
      Active := true;
      if RecordCount = 1 then
        begin
          rRwork.NUMERO_SERIE       := FieldByName('NUMERO_SERIE').AsString;
          rRwork.SFC_BOITIER_MONTE := FieldByName('SFC_BOITIER_MONTE').AsString;
          rRwork.REF_PRODUIT        := FieldByName('REF_PRODUIT').AsString;
          rRwork.DESIGNATION        := FieldByName('DESIGNATION_1').AsString;
          rRwork.PATH_LABEL_IMPRIME := FieldByName('PATH_LABEL_IMPRIME').AsString;
          txtcode_client.Text := rRwork.NUMERO_SERIE  ;
          txtcompteur.Text :=  rightstr(rRwork.NUMERO_SERIE,6);
       end;
    end;
    end;

   













            //********************************************************
            // Mettre le voyant à vert et incrémenter le compteur;
            //********************************************************
            DShp.Brush.Color := clLime;
            Inc(intCountArticle);

            DNumSerie.Refresh;DShp.Refresh;
            result := true;

            break;

          end;
      end;


  if not result then
    begin
      lblInfoColor('ERREUR : le n° de série "'+ strSN + '" n''est pas attendu pour le produit en cours,R');
      exit;
    end;

end;





 //******************************************************************************
// Contrôle doublon des n° de série et des datecodeclient
//******************************************************************************
function TFMain.Controletrace(strData, strChamp : string): boolean;  // to do enlever
begin
  result := true;
  with CnxBdd.ZSelectFdb2  do
    begin
      sql.Clear;
      Close;
      sql.Add('SELECT * FROM TRACE WHERE SFC_CARTE  = ' + quotedStr(strData));
      Open;
      Active := true;
      if RecordCount = 1 then
        begin

           //rPrint.WLAN_MAC_tr       := FieldByName('WLAN_MAC').AsString;
           //rPrint.DLC_MAC_tr        := FieldByName('DLC_MAC').AsString;
          // txtwlan.Text             := FieldByName('WLAN_MAC').AsString;
          // txtdlc.Text              := FieldByName('DLC_MAC').AsString;
           end
        else
        begin

          result := false;
          lblInfoColor('ERREUR: Le n° " ' + strData +' ne se trouve pas dans la base trace  " ,R');

        end;
    end;
end;


//******************************************************************************
// Basculer de la Phase 1 vers la Phase 2
procedure TFMain.Phase1ToPhase2;
var
  iC : integer;
begin
 { InitialisePhase(2);

  lblPhase.Caption := 'Phase 1 Terminé......';

  lblPhase.Caption := 'Contact Phase 1 ACTIVE'; Refresh;
  // Actionner le contact Phase1 et Afficher Phase 1 OK
  IO5E2S_Out(1,true);
  sleep(2000);

  IO5E2S_Out(1,false);

  lblPhase.Caption := 'Phase 2 en cours......';



  // Se mettre en Attente du scan du premier article de la phase 2

  for iC := intDebutCount to NbreArticleDeLaPhase do
     TGroupBox(FMain.FindComponent('grpArticle' + IntToStr(iC))).Visible := true;
  }
end;


//******************************************************************************
// Finaliser l'application
function TFMain.TraitementAppli: boolean;
var
  iC     : integer;
  MsgErr : string;

begin
  result := false;
    {
    Préparer l'étiquette à imprimer.
    Enregistrer les datas dans la Bdd des produits assemblé
    Faire un QuickComplete des articles sur le routeur
    Passage à Done du boitier monté
    Création du SFC sur le routeur produit fini
    En cas d'erreur dans le déroulement faire un roll back et sortir.
    Afficher PASS ou enregistrer dans la Bdd des produits Fail car réponse KO

    }
    // Préparer l'étiquette à imprimer
 //   if blnImpressionActive then
  //    if not ConstruireEtiquetteProduit then exit;

    DebutTransaction(cnxBdd.ZCnxFdb1);
   // DebutTransaction(cnxBdd.ZCnxFdb2);  // Enregistrer les articles dans la base de données  Trace

    // Enregistrer les articles dans la base de données
    if not EnregistrementData('PASS') then
      begin
        AnnulerTransaction(CnxBdd.ZCnxFdb1);
     //   AnnulerTransaction (CnxBdd.ZCnxFdb2); // annule l'enregistremant dans la base trace
        exit;
      end;

    if not EnregistrementtraceProduit then
      begin
      AnnulerTransaction(CnxBdd.ZCnxFdb1);
      AnnulerTransaction (CnxBdd.ZCnxFdb2); // annule l'enregistremant dans la base trace
      exit;
      end;
    

    // Validation dans visim
    if rProduit.blnPrdVisim then
      begin

        // Création du nouveau produit dans Visprise
        if not VISIM_Complete then
          begin
            AnnulerTransaction(CnxBdd.ZCnxFdb1);
         //   AnnulerTransaction (CnxBdd.ZCnxFdb2); // annule l'enregistremant dans la base trace
            lblInfoColor('ERREUR lors de la validation du Cie dans VISIM (QuickComplete)' + MsgErr+ ',R');
            exit;
          end;
         
        // Valider les articles
        for iC := 1 to IntNbreArticle do
          begin
            DB_WriteStrLn(0, 'Valider le article N° '+ inttostr(iC)) ;
            if rArticle[iC].blnControleVisim then
              if not VISIM_QuickCompleteArticle(iC) then
                begin
                  AnnulerTransaction(CnxBdd.ZCnxFdb1);
           //       AnnulerTransaction (CnxBdd.ZCnxFdb2); // annule l'enregistremant dans la base trace
                  exit;
                end;
          end;
      end;



   // Finaliser l'enregistrement des datas
   ValiderTransaction(CnxBdd.ZCnxFdb1);
//   ValiderTransaction(CnxBdd.ZCnxFdb2);   // Finaliser l'enregistrement des datas Base TRACE
   result := true;



end;

 //******************************************************************************
// Finaliser l'application en mode rework
function TFMain.TraitementAppliRework: boolean;
var
  iC     : integer;
  MsgErr : string;

begin
  result := false;
    {
    Préparer l'étiquette à imprimer.
    Enregistrer les datas dans la Bdd des produits assemblé
    Faire un QuickComplete des articles sur le routeur
    Passage à Done du boitier monté
    Création du SFC sur le routeur produit fini
    En cas d'erreur dans le déroulement faire un roll back et sortir.
    Afficher PASS ou enregistrer dans la Bdd des produits Fail car réponse KO

    }
    // Préparer l'étiquette à imprimer


    DebutTransaction(cnxBdd.ZCnxFdb1);
   // DebutTransaction(cnxBdd.ZCnxFdb2);  // Enregistrer les articles dans la base de données  Trace

    // Enregistrer les articles dans la base de données
    if not EnregistrementData('REWORK') then
      begin
        AnnulerTransaction(CnxBdd.ZCnxFdb1);
     //   AnnulerTransaction (CnxBdd.ZCnxFdb2); // annule l'enregistremant dans la base trace
        exit;
      end;

   {  if not EnregistrementtraceProduit then
      begin
      AnnulerTransaction(CnxBdd.ZCnxFdb1);
      AnnulerTransaction (CnxBdd.ZCnxFdb2); // annule l'enregistremant dans la base trace
      exit;
      end;
    }
    // Validation dans visim




   // Finaliser l'enregistrement des datas
   ValiderTransaction(CnxBdd.ZCnxFdb1);
//   ValiderTransaction(CnxBdd.ZCnxFdb2);   // Finaliser l'enregistrement des datas Base TRACE
   result := true;



end;



//******************************************************************************
// A l'aide du nom du Champ, retourne la valeur du n° serie carte enregistré dans le tableau des articles
function ValeurChamp(strChamp: string): string;
var
  iC : integer;
begin
  result := '';
  for iC := 1 to  FMain.intNbreArticle do
    if strChamp = rArticle[iC].NomColonneArticle then
      result := rArticle[iC].NumeroSerie;

end;

//******************************************************************************
//  Enregistrer toutes les données du produit courant dans la Bdd
function TFMain.EnregistrementData(Statut: string): boolean;
var
intStatut : integer;
Strfail   : string;
ID_POSTE :  string;
begin
  result := false;
  ID_POSTE :=  'POSTE 1.2';
  rProduit.DataAssociation := '';

  if statut ='PASS'   then intStatut:= 0 ;
  if statut ='FAIL'   then intStatut:= 1 ;
  if statut ='CODE'   then intStatut:= 2 ;
  if statut ='REWORK' then intStatut:= 3 ;
  try
    with CnxBdd.ZWriteFdb1 do

      begin
        sql.Clear;
        case intIdPoste of
          1:begin // Pass
             Begin
              case intStatut of
                 0:begin
                  sql.Add('INSERT INTO ASSOCIATION_INTEGRATION_1') ;
                  //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                  sql.Add(' VALUES (');
                  sql.Add('NULL' + ',');                    //Champ auto-incrément
                  rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client,
						                                        rProduit.SfcProduitFini,
                                                    rProduit.CodeActia,
						                                        rProduit.Designation1,
						                                        ValeurChamp('NUM_SERIE_CIE'),
                                                    ValeurChamp('NUM_SERIE_AUX'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now),
                                                    rPrint.PathNameFichierZPL,
                                                    ID_POSTE
                                                     ])+')';


                sql.Add(rProduit.DataAssociation);
                end;

              1:begin  // FAIL
               Strfail := (lblInfo.Caption);
               Strfail := StringReplace( Strfail,'''' , chr(39)+ chr(39) ,[rfReplaceAll, rfIgnoreCase]);
                 //Strfail  :=  ReplaceStr(Strfail ,'"') ;
                 sql.Add('INSERT INTO FAIL_INTEGRATION_1') ;
                //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                 sql.Add(' VALUES (');
                 sql.Add('NULL' + ',');                    //Champ auto-incrément
                  rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client,
                                                    rProduit.SfcProduitFini,
                                                    rProduit.CodeActia,
                                                    rProduit.Designation1,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    ValeurChamp('NUM_SERIE_AUX'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now),
                                                    rPrint.PathNameFichierZPL,
                                                    Strfail
                                                    ])+')';


               sql.Add(rProduit.DataAssociation);
               end;
               2:begin  // code
                 sql.Add('INSERT INTO CODE_CLIENT_1') ;
                 //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                 sql.Add(' VALUES (');
                 sql.Add('NULL' + ',');                    //Champ auto-incrément

                 rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client,
                                                    rProduit.SfcProduitFini,
                                                    ValeurChamp('NUM_SERIE_CIE'),                                          // ValeurChamp('NUM_SERIE_CIE'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now)
                                                    ])+')';
                  sql.Add(rProduit.DataAssociation);
               end;
               3:begin  // rework
                  sql.Add('INSERT INTO REWORK_INTEGRATION_1') ;
                  //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                  sql.Add(' VALUES (');
                  sql.Add('NULL' + ',');                    //Champ auto-incrément
                  rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',
                                                  [ rRwork.NUMERO_SERIE,
                                                    rRwork.SFC_BOITIER_MONTE,
                                                    rRwork.REF_PRODUIT ,
                                                    rRwork.DESIGNATION ,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    ValeurChamp('NUM_SERIE_AUX'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now),
                                                    rRwork.PATH_LABEL_IMPRIME
                                                    ])+')';


                sql.Add(rProduit.DataAssociation);
                end;
               end;
         end;
        end;





          2:begin // Association 2
               Begin
              case intStatut of
                 0:begin
                  sql.Add('INSERT INTO ASSOCIATION_INTEGRATION_2') ;
                  //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                  sql.Add(' VALUES (');
                  sql.Add('NULL' + ',');                    //Champ auto-incrément

                  rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client,
                                                    rProduit.SfcProduitFini,
                                                    rProduit.CodeActia,
                                                    rProduit.Designation1,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    ValeurChamp('NUM_SERIE_AUX'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now),
                                                    rPrint.PathNameFichierZPL
                                                  ])+')';


                sql.Add(rProduit.DataAssociation);
                end;

              1:begin  // FAIL
               Strfail := (lblInfo.Caption);
               Strfail := StringReplace( Strfail,'''' , ' ',[rfReplaceAll, rfIgnoreCase]);
                 sql.Add('INSERT INTO FAIL_INTEGRATION_2') ;
              //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                 sql.Add(' VALUES (');
                 sql.Add('NULL' + ',');                    //Champ auto-incrément

                 rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client,
                                                    rProduit.SfcProduitFini,
                                                    rProduit.CodeActia,
                                                    rProduit.Designation1,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    ValeurChamp('NUM_SERIE_AUX'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now),
                                                    rPrint.PathNameFichierZPL
                                                  ])+')';


               sql.Add(rProduit.DataAssociation);
               end;
               2:begin  // code
                 sql.Add('INSERT INTO CODE_CLIENT_2') ;
                 //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                 sql.Add(' VALUES (');
                 sql.Add('NULL' + ',');                    //Champ auto-incrément

                 rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client ,
                                                    rProduit.SfcProduitFini,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now)
                                                   ])+')';


               sql.Add(rProduit.DataAssociation);
               end;
               end;
         end;
         end;

          3:begin // Association 3
               Begin
              case intStatut of
                 0:begin
                  sql.Add('INSERT INTO ASSOCIATION_INTEGRATION_3') ;
                  //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                  sql.Add(' VALUES (');
                  sql.Add('NULL' + ',');                    //Champ auto-incrément

                  rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client,
                                                    rProduit.SfcProduitFini,
                                                    rProduit.CodeActia,
                                                    rProduit.Designation1,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    ValeurChamp('NUM_SERIE_AUX'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now),
                                                    rPrint.PathNameFichierZPL
                                                  ])+')';


                sql.Add(rProduit.DataAssociation);
                end;

              1:begin  // FAIL
               Strfail := (lblInfo.Caption);
               Strfail := StringReplace( Strfail,'''' , ' ',[rfReplaceAll, rfIgnoreCase]);
                 sql.Add('INSERT INTO FAIL_INTEGRATION_3') ;
              //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                 sql.Add(' VALUES (');
                 sql.Add('NULL' + ',');                    //Champ auto-incrément

                 rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s''',   //to do
                                                  [ rPrint.Code_client,
                                                    rProduit.SfcProduitFini,
                                                    rProduit.CodeActia,
                                                    rProduit.Designation1,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    ValeurChamp('NUM_SERIE_AUX'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now),
                                                    rPrint.PathNameFichierZPL
                                                  ])+')';


               sql.Add(rProduit.DataAssociation);
               end;
               2:begin  // code
                 sql.Add('INSERT INTO CODE_CLIENT_3') ;
                 //sql.Add(' (NUMERO_SERIE,SFC_BOITIER_MONTE,REF_PRODUIT,DESIGNATION_1,NUM_SERIE_CIE,NUM_SERIE_AUX,DATE_HEURE,PATH_LABEL_IMPRIME)');
                 sql.Add(' VALUES (');
                 sql.Add('NULL' + ',');                    //Champ auto-incrément

                 rProduit.DataAssociation := Format('''%s'',''%s'',''%s'',''%s''',
                                                  [ rPrint.Code_client,
                                                    rProduit.SfcProduitFini,
                                                    ValeurChamp('NUM_SERIE_CIE'),
                                                    FormatDateTime('mm/dd/yyyy hh:mm:ss',now)
                                                   ])+')';


               sql.Add(rProduit.DataAssociation);
               end;
               end;
            end;
            end;















        end; // fin case of

  // showmessage(sql.Text);

        try
          ExecSql;
          result := true;
        except
          on E: Exception do
            begin
              lblInfoColor('ERREUR lors de l''enregistrement (INSERT  '+ Statut + ') des données '+#13 + E.Message  +',R');
            end;
        end;
      end;
  except
    on E: Exception do
      begin
        lblInfoColor('ERREUR lors de la construction de la requête " EnregistrementDataProduit "'+#13 + E.Message  +',R');
      end;
  end;
end;
 //******************************************************************************
 //  Enregistrer toutes les données du produit courant dans la Bdd TRACE
function TFMain.EnregistrementtraceProduit: boolean;
var
  intBool: byte;
begin
  result := false;
  //if rProduit.blnComAutomate then intBool := 1 else intBool := 0;
  try
    with CnxBdd.ZWriteFdb2 do
      begin
        sql.Clear;
     //   sql.Add('UPDATE TRACE SET DATE_INTEGRATION= ' + FormatDateTime('mm/dd/yyyy hh:mm:ss',now));
     //   sql.Add('SET POSTE_INTEGRATION= V10');
       // sql.add('WHERE SFC_BOITIER='+ txtScan.Text);

      sql.add('UPDATE TRACE SET DATE_INTEGRATION1= ' + quotedStr(FormatDateTime('mm/dd/yyyy hh:mm:ss',now))+ ',SFC_BOITIER= ' + rProduit.SfcProduitFiniVISIM );

      sql.add('WHERE SFC_CARTE= '''+txtNumeroSerie1.Text +'''');

      ExecSql;



        try
          ExecSql;
          result := true;
        except
          on E: Exception do
            begin
              lblInfoColor('ERREUR lors de l''enregistrement dans la table " NUMERO_SERIE_INTEGRE " '+#13 + E.Message  +',R');
            end;
        end;
      end;
  except
    on E: Exception do
      begin
        lblInfoColor('ERREUR lors de la construction de la requête " EnregistrementDataProduit "'+#13 + E.Message  +',R');
      end;
  end;
end;

//******************************************************************************
// Effectuer le passage des articles CIE à l'opération d'intégration
function TFMain.VISIM_QuickCompleteArticle(intIc: integer): boolean;
var
  MsgErr: PChar;
begin
  result := false;
  if INTERLOCK_QuickComplete(
      PChar(rVisim.strInterBlocage),
      PChar(rVisim.strSITE),
      PChar(rArticle[intIc].NumeroSerie),
      PChar(rArticle[intIc].Ressource),
      PChar(rArticle[intIc].Operation),
      PChar(rVisim.strUSER)) then
    begin
      result := true;
      DB_WriteStrLn(0, 'VISIM_QuickCompleteArticle = OK');
    end
  else
    begin
      lblInfoColor('ERREUR lors de la validation du Cie dans VISIM (QuickCompleteArticle)' + String(INTERLOCK_GetLastResponse)+ ',R');
    end;

end;


//******************************************************************************
// Effectuer le Start dans visim
function TFMain.VISIM_Start: boolean;
var
  strInWork: string;
  strRetour: string;

begin
  result := false;
  //with rVisim, rProduit do
  //showmessage(strInterBlocage +' ; '+  strSITE +' ; '+ SfcProduitFini  +' ; '+ Ressource  +' ; '+Operation+' ; '+strUSER);
  DB_WriteStrLn(0, 'VISIM_Start  ' +  rVisim.strInterBlocage +'  '+ rVisim.strSITE +'  '+ rProduit.SfcProduitFiniVISIM +'  '+ rProduit.Ressource +'  '+ rProduit.Operation +'  '+ rVisim.strUSER );

 if INTERLOCK_Start(

 // if INTERLOCK_QuickComplete(
      PChar(rVisim.strInterBlocage),
      Pchar(rVisim.strSITE),
      PChar(rProduit.SfcProduitFiniVISIM),
      // PChar('21594541839147'),
      PChar(rProduit.Ressource),
      PChar(rProduit.Operation),
      PChar(rVisim.strUSER)) then
    begin
     result := true;
     DB_WriteStrLn(0, 'VISIM_Start = OK');
    end
  else
    begin
      // Vérifier si le SFC est in Work pour le réinitialiser
      strRetour := INTERLOCK_GetLastResponse;
      strInWork := 'It is in work at "'+ rProduit.Operation +'"' ;
      if pos(strInWork,strRetour) >1 then
        begin
          // Faire un Fail pour le repositionner in Queue à cette opération = ncLogComplete
          // enregistrer le fait que le SFC était déja InWork et ne pas toucher
          result := true;
        end
      else
        begin
          lblInfoColor('ERREURlors de la validation du Produit dans VISIM (VISIM_Start)' + String(strRetour)+ ',R');
          DB_WriteStrLn(0, 'VISIM_Start = False' + String(strRetour));
        end;
    end;

end;


//******************************************************************************
// Indiquer le défaut constaté et terminer l'opération
function TFMain.VISIM_NcLogComplete(strNcCode: string): boolean;
var
  MsgErr: PChar;
begin
  result := false;
  if INTERLOCK_NcLogComplete(
      PChar(rVisim.strInterBlocage),
      Pchar(rVisim.strSITE),
      PChar(rProduit.SfcProduitFiniVISIM),
      PChar(rProduit.Ressource),
      PChar(rProduit.Operation),
      PChar(rVisim.strUSER),
      PChar(strNcCode),
      '','','','') then
    begin
      result := true;
    end
  else
    begin
      lblInfoColor('ERREUR lors de la validation du Cie dans VISIM (VISIM_NcLogComplete)' + String(INTERLOCK_GetLastResponse)+ ',R');
    end;

end;
//******************************************************************************
// Effectuer le COMPLETE
function TFMain.VISIM_Complete: boolean;
var
  MsgErr: PChar;
begin
  result := false;
 if INTERLOCK_Complete(
      PChar(rVisim.strInterBlocage),
      Pchar(rVisim.strSITE),
      PChar(rProduit.SfcProduitFiniVISIM),
      PChar(rProduit.Ressource),
      PChar(rProduit.Operation),
      PChar(rVisim.strUSER)) then
    begin
      result := true;
    end
  else
    begin
      lblInfoColor('ERREUR lors de la validation du Produit dans VISIM (VISIM_Complete)' + String(INTERLOCK_GetLastResponse)+ ',R');
    end;

end;


//******************************************************************************
// Initialiser l'affichage des articles avec n° de série p
procedure TFMain.mnuInitialiserClick(Sender: TObject);
begin
  if blnBreakTimer then
  begin
   InitIHM ;
  If rProduit.Automate = true then
   begin
   nodave.WriteBit(7,0,true);
   sleep( 1000);
   nodave.WriteBit(7,0,false);
   end;
end;
  blnBreakTimer := true;
end;

procedure TFMain.InitIHM;
var
  iC: word;
  DTxtBox: TEdit;
  DShp: TShape;
begin
  InitialisePhase(1);
  intCountArticle := 0;
  lblPassFail.Visible := false;
  lblInfo.Caption := '';
  txtNewNumSerieProduit.Text := '';
  rProduit.SfcProduitFini := '';
  rProduit.SfcProduitFiniVISIM := '';
  txtcode_client.Text := '';
  txtcompteur.Text := '';
  shpMiniControle.Brush.Color := clWhite;
  shpMiniSanction.Brush.Color := clWhite;
  //txtcode_client.Color :=clWindow;
  txtNewNumSerieProduit.Color :=clWindow;
  blnDepartPhase2 := false;
  TimerClignoter.Enabled := false;
  blnFail := false;
  rPrint.PathNameFichierZPL := '';

  for iC := 1 to intNbreArticle do
    begin
      DTxtBox := TEdit(FMain.FindComponent('txtNumeroserie' + IntToStr(rArticle[iC].TagArticle)));
      DShp := TShape(FMain.FindComponent('Shp' + IntToStr(rArticle[iC].TagArticle)));
      DTxtBox.Text := '';
      DShp.Brush.Color := clWhite;
      DShp.Visible := false;
      rArticle[iC].NumeroSerie := '';
    end;
  sequence:=0;
end;


//******************************************************************************
// AFFICHAGE DES ERREURS
// Gestion des erreurs et de la couleur d'affichage du label info
procedure TFMain.lblInfoColor(strInfos: string);
var
  strColor: string;
begin
  strColor := RightStr(strInfos,1);
  lblInfo.Caption := LeftStr(Trim(strInfos),Length(strInfos)-2);
  if (strcolor = 'B') or (strcolor = 'b') then
    begin
      lblInfo.Font.Color := clBlue;
      exit;
    end
  else
    if (strColor = 'R') or (strColor = 'r') then
        begin
          lblInfo.Font.Color := clRed;
          exit;
        end;
end;

//******************************************************************************
//  QUITTER L'APPLICATION POUR RETOURNER à LA FICHE DE SELECTION PRODUIT
//******************************************************************************
procedure QuitterIHM;
begin
  FSelectProduit.visible := true;
  FMain.ModalResult := mrOk;

  // Initialiser la connexion visim
  //DeconnexionMonHttp;
  // FMain.Visible := false;

end;
//******************************************************************************
// Quitter l'application
procedure TFMain.mnuRetourClick(Sender: TObject);
begin
  sequence := 0;
  if TimerScrute.Enabled then TimerScrute.Enabled := false;
  if TimerAutorisation.Enabled then TimerAutorisation.Enabled := false;
  if TimerClignoter.Enabled then TimerClignoter.Enabled := false;

   NoDave1.Disconnect    ;
  //blnResize := false;
  //WritePositionForm('POS_RESIZE',self);
  QuitterIHM;
end;


//******************************************************************************
// Gestion de l'affichage selon le nombre d'articles
procedure TFMain.MisaAjourIHM(intNbre: integer);
var
  Offset, MaxHeight, MaxInfo, MaxAutomate: integer;

begin
  Offset      := 52;
  MaxHeight   := 842;
  MaxInfo     := 666;
  MaxAutomate := 580;

  case intNbre of
    1:begin
        grpArticle2.Visible := false;
        grpArticle3.Visible := false;
        grpArticle4.Visible := false;
        grpArticle5.Visible := false;
        grpArticle6.Visible := false;
        grpArticle7.Visible := false;
        grpArticle8.Visible := false;
       // grpPassFail.Top:= 135;
        //grpAutomate.Top := MaxAutomate - (5* Offset);
        //grpinfo.Top := MaxInfo - (5* Offset);
       // Height := MaxHeight - (5* Offset);

      end;
    2:begin
        grpArticle3.Visible := false;
        grpArticle4.Visible := false;
        grpArticle5.Visible := false;
        grpArticle6.Visible := false;
        grpArticle7.Visible := false;
        grpArticle8.Visible := false;
        // grpPassFail.Top:= 135;
       // grpAutomate.Top := MaxAutomate - (5* Offset);
        //grpinfo.Top := MaxInfo - (5* Offset);
       // Height := MaxHeight - (5* Offset);
      end;
    3:begin
        grpArticle4.Visible := false;
        grpArticle5.Visible := false;
        grpArticle6.Visible := false;
        grpArticle7.Visible := false;
        grpArticle8.Visible := false;
        //grpPassFail.Top:= 160;
        //grpAutomate.Top := MaxAutomate - (5* Offset);
        //grpinfo.Top := MaxInfo - (5* Offset);
       // Height := MaxHeight - (5* Offset);
      end;
    4:begin
        grpArticle5.Visible := false;
        grpArticle6.Visible := false;
        grpArticle7.Visible := false;
        grpArticle8.Visible := false;
        // grpPassFail.Top:= 190;
        //grpAutomate.Top := MaxAutomate - (4* Offset);
        //grpinfo.Top := MaxInfo - (4* Offset);
       // Height := MaxHeight - (4* Offset);
      end;
    5:begin
        grpArticle6.Visible := false;
        grpArticle7.Visible := false;
        grpArticle8.Visible := false;
        // grpPassFail.Top:= 210;
     //   grpAutomate.Top := MaxAutomate - (3* Offset);
       // grpinfo.Top := MaxInfo - (3* Offset);
       // Height := MaxHeight - (3* Offset);
      end;
    6:begin
        grpArticle7.Visible := false;
        grpArticle8.Visible := false;
        // grpPassFail.Top:= 245;
        //grpAutomate.Top := MaxAutomate - (2* Offset);
        //grpinfo.Top := MaxInfo - (2* Offset);
       // Height := MaxHeight - (2* Offset);
       end;
    7:begin
        grpArticle8.Visible := false;
        // grpPassFail.Top:= 245;
        //grpAutomate.Top := MaxAutomate - (1* Offset);
        //grpinfo.Top := MaxInfo - (1* Offset);
       // Height := MaxHeight - (1* Offset);
      end;

    8:begin
        // grpPassFail.Top:= 245;
        //grpinfo.Top := MaxInfo;
       // Height := MaxHeight;
      end;

   end;
  
 // if bln2Phase then lblPhase.Visible := true;


    left :=(Screen.Width Div 2) - (Width Div 2);
    top  :=((Screen.Height - HauteurBarreDeTache) Div 2) - (Height Div 2);
end;




//******************************************************************************
// Visualiser le message d'erreur
procedure TFMain.LoupeClick(Sender: TObject);
begin
  Application.CreateForm(TDlgErreur, DlgErreur);
  DlgErreur.memo1.Clear;
  DlgErreur.memo1.Lines.Add(lblinfo.Caption);
  DlgErreur.ShowModal;
  DlgErreur.Free;
end;


//******************************************************************************
// Menu réimpression
procedure TFMain.mnuReprintClick(Sender: TObject);
begin
  if TLoginForm.Execute then
    begin
      //Afficher l'interface de réimpression
      FReprintLabel.visible := true;
      FMain.Visible := false;
      blnReimpressionActive := true;
    end;
end;

//******************************************************************************
// Redimmensionner la fiche
procedure TFMain.FormResize(Sender: TObject);
begin
  //if blnResize then FormResizer1.ResizeAll;
end;



//******************************************************************************
// Traitement de l'application
procedure TFMain.DoLoop;
var
  Carreimp           : Char;
  Car           : Char;
  iCount        : word;
  DNumSerie     :TCDEdit;
  CheminComplet : string;
  
begin
  Application.ProcessMessages;

           // if IO5E2S_In(3) then DB_WriteStrLn(0, 'DoLoop IN_3(FAIL) vient d''être activé');
           // if IO5E2S_In(4) then DB_WriteStrLn(0, 'DoLoop IN_4(PASS) vient d''être activé');

    // Fail
    if (rproduit.Automate) and (IO5E2S_In(3)) and (not blnFail) then
      begin
        sequence := 100;
      end;


    if memoSeq <> sequence then
        begin
          DB_WriteStrLn(0, 'Doloop SEQUENCE = ' + IntToStr(Sequence)) ;
          memoSeq := Sequence;
        end;


  case Sequence of
    0 : begin
          mnuReprint.Visible := True;

          mlePortCOM.ComPort1.PurgeRX;
          strLeBuffer := '';
         // showmessage('0')   ;
          Sequence := 10;

        end;

    //********************// Reception info Port Com
    10: begin

     {while mlePortCOM.ComPort.InBufUsed <> 0   do

            begin
              DB_WriteStrLn(0, 'Réception des caractères sur le port com reimp ');
               Carreimp := mlePortCOM.ComPort.ReadChar;
              if Carreimp in [' ','-','_','/','0'..'9','A'..'Z','a'..'z'] then strLeBuffer := strLeBuffer + Carreimp;
              if Carreimp = #$0D then
                begin
                  if blnReimpressionActive then
                    begin
                      sequence := 0;
                      FReprintLabel.txtScanReprint.Text := strLeBuffer;
                    end ;
                 strLeBuffer := '';
                end ;
               end ; }






          while mlePortCOM.ComPort1.InBufUsed <> 0   do
            begin
              DB_WriteStrLn(0, 'Réception des caractères sur le port com');
              Car := mlePortCOM.ComPort1.ReadChar;

              if Car in [' ','-','_','/','0'..'9','A'..'Z','a'..'z'] then strLeBuffer := strLeBuffer + Car;

              if Car = #$0D then
                begin
                  if blnReimpressionActive then
                    begin
                      sequence := 0;
                      FReprintLabel.txtScanReprint.Text := strLeBuffer;
                    end
                  else
                    begin
                     if  (etape = etape_lecture_1) or (rProduit.Automate=false) then
                       begin
                       //showmessage('10');
                        lblInfo.Caption := '';
                        // Verifier la validité du n° de série scanné
                        DB_WriteStrLn(0, 'Vérification de la validité du n° de série scanné et enregistrement code client  ' + strLeBuffer);
                        if VerificationNumeroSerie(strLeBuffer) then sequence := 20 else sequence := 0;
                        DB_WriteStrLn(0, 'N° de série vérifié et prochaine seq = ' + IntToStr(Sequence)) ;

                        end;
                   end ;
                  strLeBuffer := '';
                end;
            end;

          // vérifier si pas de fail de la part de l'automate lors de la séquence de vissage réalisé entre phase 1 et phase 2 
          //if Sequence = 10 then sequence := 100;

            // Vérifier l'état du Pass à chaque passage
          // if IO5E2S_In(4) then DB_WriteStrLn(0, 'IN_4(PASS) vient d''être activé');

          {if blnBreakTimer or  IO5E2S_In(3) then
            begin
              sequence := 60;
              DB_WriteStrLn(0, 'Fail ou Initialisation détectée et prochaine seq = ' + IntToStr(Sequence));
            end;
           }


        end;

    //********************// Gestion des produits avec une ou deux Phases de montage
    20: begin
          sequence := 10;
          // Vérifier la présence des saisies pour les textbox avec autorisation de saisie Manuelle (car possibilté d'effacement)
          if intCountArticle = NbreArticleDeLaPhase then
          begin
            DB_WriteStrLn(0, 'Nombre d''articles de la phase atteint = ' + IntToStr(NbreArticleDeLaPhase)) ;

            for iCount := intDebutCount to NbreArticleDeLaPhase do
              begin
                if rArticle[iCount].blnSaisieManuelle then
                  begin
                    DNumSerie := TCDEdit(FMain.FindComponent('txtNumeroSerie' + IntToStr(rArticle[iCount].TagArticle)));
                    if DNumSerie.Text = '' then
                      begin
                        lblInfoColor('Veuillez faire la saisie de tous les articles ,R'); //'+ inttostr(intCountArticle) +'
                        dec(intCountArticle);
                        DNumSerie.setfocus;
                        exit;
                      end;
                  end;
               end;
            end;

          // Validation Phase 1
          if (bln2Phase) then
            begin
              if (intCountArticle = intNbreArticle - intNbreArticlePhase2) then
                begin
                  DB_WriteStrLn(0, 'Nombre d''articles de la phase 1 atteint = ' + IntToStr(intCountArticle)) ;
                  if rproduit.Automate then   // AUTOMATE
                    begin
                      // Actionner le contact Phase1 Autorisation de montage phase 1
                      shpControle.Brush.Color := clGreen;
                      shpMiniControle.Brush.Color := clGreen;
                      intClignoter := 1;
                      TimerClignoter.Enabled := true;

                      // Start VISM  et lancer timer autorisation
                      if (rProduit.blnPrdVisim ) or (not rProduit.blnPrdVisim) then   // ILMINER LE I?TERBLACAGE PRODUIT
  { activation start}  if (rProduit.blnPrdVisim and VISIM_START) or (not rProduit.blnPrdVisim) then
                        begin
                          TimerAutorisation.Enabled := true;

                         // IO5E2S_Out(1,true);
                          sequence := 30;
                          DB_WriteStrLn(0, 'Sortie 1 Activé et prochaine seq = ' + IntToStr(Sequence)) ;
                        end;
                    end;
                end;
            end;


          // Modifier l'affichage pour indiquer la phase en cours
          if blnDepartPhase2 then
                begin
                  blnDepartPhase2 := false;
                  TimerClignoter.Enabled := false;
          //        lblPhase.Font.Color := clGreen;
       //           lblPhase.Visible := true; lblPhase.Caption := 'Phase 2';
                  shpControle.Brush.Color := clWhite;
                  shpMiniControle.Brush.Color := clWhite;
                end;


          // Lorsque la saisie de tous les articles est terminée
          if intCountArticle = intNbreArticle then
            begin
              DB_WriteStrLn(0, 'Nombre d''articles de la phase 2 atteint ') ;
              if rproduit.Automate then   // AUTOMATE
                begin
                  shpControle.Brush.Color := clGreen;
                  shpMiniControle.Brush.Color := clGreen;
                  intClignoter := 1;
                  TimerClignoter.Enabled := true;

                  if (bln2Phase) then
                    begin
                      TimerAutorisation.Enabled := true;
                      //IO5E2S_Out(2,true);
                      sequence := 40;
                      DB_WriteStrLn(0, 'Fermeture Sortie 2');
                    end
                  else
                    // Start VISM pour le produit et lancer timer autorisation
                     if ((rProduit.blnPrdVisim) and (VISIM_START)) or (not rProduit.blnPrdVisim) then          /// ko
                     //if (rProduit.blnPrdVisim)  or (not rProduit.blnPrdVisim) then          /// ko
                      begin
                      DB_WriteStrLn(0, 'ss');
                        TimerAutorisation.Enabled := true;
                   //    IO5E2S_Out(1,true);

                        sequence := 30;
                        DB_WriteStrLn(0, 'Fermeture Sortie 1');
                      end;
                end
              else
                begin
                   if ((rProduit.blnPrdVisim) and (VISIM_START)) or ( not rProduit.blnPrdVisim) then
                 // if (rProduit.blnPrdVisim)  or ( not rProduit.blnPrdVisim) then
                      sequence := 60   //impression
                   // sequence := 80   // Pass
                  else
                    sequence := 70;  // Fail
                end;
            end;
        end;



    //********************// Fin de l'action sur le contact de l'autorisation de montage phase 1
    30: begin
          if not TimerAutorisation.Enabled then
            begin
                mnuReprint.Visible := false ;
              IO5E2S_Out(1,false);
              TimerClignoter.Enabled := false;
              shpControle.Visible := false;
              sequence := 0;
              DB_WriteStrLn(0, 'Sortie 1 DESACTIVE et prochaine seq = ' + IntToStr(Sequence)) ;

              if (bln2Phase) then
                begin
                  blnDepartPhase2 := true;
                  intClignoter := 3;
       //           lblPhase.Font.Color := clBlue;
       //           lblPhase.Caption := 'Phase 1 en cours ...';  // Montage Phase 1
                  TimerClignoter.Enabled := true;
                  lblInfoColor('Saisir les articles de la phase 2 aprés la fin des opérations de vissage de la phase 1,B');

                  // Se mettre en Attente du scan du premier article de la phase 2
                  // InitialisePhase(2);  Déplacé dans attente signal phase 1 ok  MD130710
                  blnStatutIn5 := true;
                  sequence := 51;
                  DB_WriteStrLn(0, 'Initialisation Phase 2 et prochaine seq = ' + IntToStr(Sequence) );
                end
              else
                sequence := 50;
            end;
        end;



    //********************// Fin de l'action sur le contact de l'autorisation de montage phase 2
    40: begin
          if not TimerAutorisation.Enabled then
            begin
              IO5E2S_Out(2,false);
              TimerClignoter.Enabled := false;
              shpControle.Visible := false;
              sequence := 50;
              DB_WriteStrLn(0, 'Sortie 1 DESACTIVE et prochaine seq = ' + IntToStr(Sequence)) ;
            end;
        end;


    //********************// Lancer l'attente sanction de l'automate
    50: begin
             nodave.WriteBit(12,0,true);
             sleep( 1000);
             nodave.WriteBit(12,0,false);
                         // Showmessage ('TAPER ENTRE POUR LECURE ETIQUETTE PF');

      //    lblphase2.Visible := false;
          intClignoter := 2;
          shpSanction.Brush.Color := clYellow;
          shpMiniSanction.Brush.Color := clYellow;
          TimerClignoter.Enabled := true;
          blnBreakTimer := false;
          blnFail := false;
          sequence := 60;
          DB_WriteStrLn(0, 'Attente Sanction de l''automate et prochaine seq = ' + IntToStr(Sequence));
        end;


    //******************** // Attente signal fin sequence de vissage phase 1 pour scanner les articles de la phase 2
    51: begin
          if IO5E2S_In(5) and blnStatutIn5 then
            begin
              InitialisePhase(2);
              blnStatutIn5 := false;
              intClignoter := 6;
              TimerClignoter.Enabled := true;
              lblinfo.Caption := 'Phase 1 terminé, vous pouvez scanner les articles de la phase 2';
              sequence := 10;
              DB_WriteStrLn(0, 'Fin de la phase 1 détecté et prochaine seq = ' + IntToStr(Sequence) );
            end;

        end;


    //**************************************************************
    // sequence de traitement de premiere lecture
    //*************************************************************
    60: begin



          // Vérfier qu'une initialisation manuelle n'a pas été demandé
          if blnBreakTimer then
            begin
              blnFail := true;
              lblinfo.Caption := 'Annulation du cycle demandé par l''opérateur';
              if (rProduit.blnPrdVisim) then VISIM_NcLogComplete('INT_POSTE');
            end;
          if   rproduit.Automate then
             begin
               if (( etape >= limite_inf) and (etape < limite_sup)and (etape <>32)) or (etape = def_raz )  then
                 begin
                   blnFail := true;
                   blnBreakTimer := true;
                   lblinfo.Caption := 'Réponse FAIL de l''automate';
               if (rProduit.blnPrdVisim) then VISIM_NcLogComplete('INT_AUTOMATE');

              DB_WriteStrLn(0, 'OUTILLAGE a renvoyé (Fermeture de (In3) = FAIL');
                end;
          end;

          // FAIL
          if blnFail then
            begin
              blnDepartPhase2 := false;
              TimerClignoter.Enabled := false;
              shpMiniSanction.Brush.Color := clRed;
              shpSanction.Visible := false;
              sequence := 70;
              DB_WriteStrLn(0, 'Traitement du FAIL');
            end;

             // imrpession
          if (etape = etape_impression) or not (rproduit.Automate) then
           Begin
             // Préparer l'étiquette à imprimer
             if blnImpressionActive and not blnReworkActive then
             if not ConstruireEtiquetteProduit then exit;

             if blnImpressionActive and not blnReworkActive  then ImprimerFichierZPL(rPrint.PathNameFichierZPL);


           //  if blnImpressionActive and blnReworkActive then ImprimerFichierZPL(rRwork.PATH_LABEL_IMPRIME);   //elimener le lecture demde de hamdi

            //nodave.WriteBit(12,3,true);
            //sleep( 1000);
            //nodave.WriteBit(12,3,false);
             if (rproduit.Automate)  then  sequence := 61    else sequence := 80;
           
            DB_WriteStrLn(0, 'sequence= ' + IntToStr(Sequence));
            DB_WriteStrLn(0, 'impression etiqiutte ');

          end;


         end;



          //**************************************************
          // sequence de deusiemme traitemet de lecture
          //**************************************************
    61: begin
          // Vérfier qu'une initialisation manuelle n'a pas été demandé
          if blnBreakTimer then
            begin
              blnFail := true;
              lblinfo.Caption := 'Annulation du cycle demandé par l''opérateur';
              if (rProduit.blnPrdVisim) then VISIM_NcLogComplete('INT_POSTE');
            end;

             if (( etape >= limite_inf ) and (etape < limite_sup)and (etape<>32)) or ( etape = def_raz ) then
            begin
              blnFail := true;
              blnBreakTimer := true;
              lblinfo.Caption := 'Réponse FAIL de l''automate';
              if (rProduit.blnPrdVisim) then VISIM_NcLogComplete('INT_AUTOMATE');

              DB_WriteStrLn(0, 'OUTILLAGE a renvoyé (Fermeture de (In3) = FAIL');
            end;

          // FAIL
          if blnFail then
            begin
              blnDepartPhase2 := false;
              TimerClignoter.Enabled := false;
              shpMiniSanction.Brush.Color := clRed;
              shpSanction.Visible := false;
              sequence := 70;
              DB_WriteStrLn(0, 'Traitement du FAIL');
            end;

             // verif imrpession
          if etape = etape_lecture_2 then

          Begin
         

           if VerificationEtiquette(strLeBuffer) then
            begin

              TimerClignoter.Enabled := false;
              shpMiniSanction.Brush.Color := clGreen;
              shpSanction.Visible := false;
              sequence := 80;
              DB_WriteStrLn(0, 'sequence= = ' + IntToStr(Sequence));
              DB_WriteStrLn(0, 'OUTILLAGE a renvoyé (Fermeture de (In4) = PASS');
            end
          //else
            // begin
            // sequence:= 70  ;
            //end
         end;



        end;


    //******************** // FAIL NcLog Complete + enregistrement
    70: begin
          sequence := 0;
          EnregistrementData('FAIL');
          GestionPassFail(false);
          intCountArticle := 0;  // pour permettre de recommencer

            nodave.WriteBit(12,2,true);
                 sleep( 1000);
                 nodave.WriteBit(12,2,false);

          DB_WriteStrLn(0, 'Produit FAIL');
        end;

    //******************** // PASS Complete + Enregistrement et impression
    80: begin
          sequence := 0;


          if not blnReworkActive then
           begin
            if TraitementAppli then
             begin
                if rProduit.Automate = true then
                 begin
                 DB_WriteStrLn(0, 'OUTILLAGE a renvoyé (etape = 16) = PASS');
                 nodave.WriteBit(12,1,true);
                 sleep( 1000);
                 nodave.WriteBit(12,1,false);
                 end;
                 GestionPassFail(true);
              // Impression de l'étiquette

              intCountArticle := 0;
              // Faire un enregistrement de l'association dans le fichier Log
              CheminComplet := PathLog +'\'+ FormatDateTime('yyyy',Now) + '\' + 'POSTE_'+ IntToStr(intIdPoste) + '\';
              if (CreatePath(CheminComplet)) and
              (not LogLine(CheminComplet + FormatDateTime('mmmm',Now)+ '.log', rProduit.DataAssociation)) then
              lblInfoColor('Erreur rencontré lors de l''écriture des données de log de l''association,B');
              DB_WriteStrLn(0, 'Produit PASS');
              end;
             end;

            if  blnReworkActive then
              begin
              if TraitementAppliRework then
              begin
              if rProduit.Automate = true then
                 begin
                 DB_WriteStrLn(0, 'OUTILLAGE a renvoyé (etape = 16) = PASS');
                 nodave.WriteBit(12,1,true);
                 sleep( 1000);
                 nodave.WriteBit(12,1,false);
                 end;
                 GestionPassFail(true);
              // Impression de l'étiquette

              intCountArticle := 0;
              // Faire un enregistrement de l'association dans le fichier Log
              CheminComplet := PathLog +'\'+ FormatDateTime('yyyy',Now) + '\' + 'POSTE_'+ IntToStr(intIdPoste) + '\';
              if (CreatePath(CheminComplet)) and
              (not LogLine(CheminComplet + FormatDateTime('mmmm',Now)+ '.log', rProduit.DataAssociation)) then
              lblInfoColor('Erreur rencontré lors de l''écriture des données de log de l''association,B');
              DB_WriteStrLn(0, 'Produit PASS');
              end;


            end;
        end;


   //******************** // Init envoyé par l'automate pendant les séquences de vissage
   100: begin
         { sequence := 10;

          // Vérifier l'état du Pass à chaque passage
          //if IO5E2S_In(4) then DB_WriteStrLn(0, 'IN_4(PASS) vient d''être activé');

          Inc(iC_Debug);
          if  iC_Debug = 400 then
            begin
              DB_WriteStrLn(0, 'Passage dans la séquence 100 (200 fois)') ;
              iC_Debug := 0;
            end;
          }
          // Détecter si un fail est activé
          //if (rproduit.Automate) and (IO5E2S_In(3)) and (not blnFail) then
          //  begin
              blnDepartPhase2 := false;
              TimerClignoter.Enabled := false;
         //     lblPhase.Caption := '';
              blnBreakTimer := true;
              lblinfo.Caption := 'Réception FAIL de l''automate';
              GestionPassFail(false);
              intCountArticle := 0;
              sequence := 0;
              DB_WriteStrLn(0, 'Reception Fail en sequence 100');
          // end

        end;

  end; // Fin Case Of

  // Application.ProcessMessages;
end;



//******************************************************************************
// Gestion du clignotement des shapes et des labels
procedure TFMain.TimerClignoterTimer(Sender: TObject);
begin
  TimerClignoter.Enabled := false;
  try
    case  intClignoter  of
      0 : exit;
      1:begin
          shpControle.Visible := not shpControle.Visible;
          exit;
        end;

      2:begin
          shpSanction.visible := not shpSanction.visible;
          exit;
        end;

      3:begin
    //      lblphase.Visible := not lblphase.Visible;
          exit;
        end;

      4:begin
          //frmDefaut.lblCapot.Visible := not frmDefaut.lblCapot.Visible;
          exit;
        end;

      5:begin
          //frmDefaut.shpControleCam1.visible := not frmDefaut.shpControleCam1.visible;
          exit;
        end;

      6:begin
      //    lblphase2.Visible := not lblphase2.Visible;
          exit;
        end;
    end;

  finally

    TimerClignoter.Enabled := true;
  end;

end;



//******************************************************************************
// Timer de scrutation
procedure TFMain.TimerScruteTimer(Sender: TObject);
begin
  TimerScrute.Enabled := false;
  DoLoop;
  TimerScrute.Enabled := true;
end;


procedure TFMain.TimerAutorisationTimer(Sender: TObject);
begin
  TimerAutorisation.Enabled := false;
end;




//******************************************************************************
// Validation de la saisie manuelle des n° de série
procedure TFMain.ValidationManuelle(Sender: TObject; var Key: Char);
var
  iC            : word;
  DShp          : TShape;
  strSaisie     : string;
  
begin
  if TCDEdit(sender).ReadOnly then exit;

  if not (Key in ['0'..'9','A'..'Z','a'..'z','-','_',' ',Chr(VK_BACK), Chr(VK_DELETE),chr(VK_RETURN)]) then Key := #0;

  if (Key = chr(VK_RETURN)) then
    begin
      key := #0;
      strSaisie := TCDEdit(sender).Text;

      // Eteindre le voyant s''il s'agit d'une deuxieme saisie et décompter le nombre d'article
      if intCountArticle <> 0 then
        begin
          for iC := intDebutCount to NbreArticleDeLaPhase do
            if TCDEdit(sender).Name = 'txtNumeroSerie' + IntToStr(rArticle[iC].TagArticle) then
              begin
                DShp := TShape(FMain.FindComponent('Shp' + IntToStr(rArticle[iC].TagArticle)));
                  if DShp.Brush.Color = clLime then
                    begin
                      DShp.Brush.Color := clWhite;
                      if intCountArticle > 0 then dec(intCountArticle);
                    end;
               end;
        end
      else if intCountArticle = 0 then InitIHM;



      // Verifier la validité du n° de série saisi
      if strSaisie = '' then exit;
      TCDEdit(sender).Text:= '';   // comme si l'info arrive du port com afin de maintenir a jour le compteur d'article
      if VerificationNumeroSerie(UpperCase(strSaisie)) then sequence := 20 else sequence := 0;
    end;
end;


{
//******************************************************************************
// Forcer le DoLoop à prendre en compte la séquence de scan   NOT USE
procedure TFMain.cmdScan2Click(Sender: TObject);
var
  strChemin, DataLog: string;
begin
  Datalog := FormatDateTime('mm/dd/yyyy hh:mm:ss',now) + '   La séquence courante est : '+ IntToStr(sequence);

  // Enregistre la situation actuelle pour comprendre d'ou vient l'erreur ?
  strChemin := ExtractFilePath(Application.ExeName)+'SCAN_DCDC.txt' ;
 // if not FileExists(strChemin)then fileCreate(strChemin);
  if not LogLine(strChemin,DataLog) then
    lblInfoColor('Erreur rencontré lors de l''écriture des données de log de l''association,B');


  sequence := 51;

end;

}

procedure TFMain.NoDaveRead(Sender: TObject);

var
  Data: Array of Variant;
  Index: Integer;
  Count: Integer;
  boucle: bool;
  Item: String;
  Display: String;
  begin

    With ProgressBar1 do
      begin
      If Position = 10 then Position:=0 else Position:=Position + 1;
      end;
      SetLength(Data, DataCount);
      Count:=0;
    While Count < DataCount do
  begin

    Index:=(Count * DataSize) + DataOffset;
    Case DataType of
      0: Data[Count]:=NoDave.GetByte(Index);
      1: Data[Count]:=NoDave.GetWord(Index);
      2: Data[Count]:=NoDave.GetInt(Index);
      3: Data[Count]:=NoDave.GetDWord(Index);
      4: Data[Count]:=NoDave.GetDInt(Index);
      5: Data[Count]:=NoDave.GetFloat(Index);

    end;
    begin
      Etape  := strtoint(vartostr(Data[0]));
      Compteur_vis   := strtoint(vartostr(Data[0]));


   //nodave.WriteByte(100,2);
    Inc(Count);
     end;
     end;

  Index:=0;
  While Index < DataCount do
  begin
    Item:=ListBox1.Items.Names[Index];
    Display:=' ' + Format('%10s', [VarToStr(Data[Index])]);
    If Display <> ListBox1.Items.Values[Item] then ListBox1.Items.Values[Item]:=Display;
    label5.Caption:=VarToStr(Data[Index]) ;
    Inc(Index);
  end;
  StaticText1.Caption:='Last cycle time: ' + IntToStr(NoDave.CycleTime) + ' ms';
  //StatusBar1.SimpleText:='';
  begin
   if etape < limite_inf then
     begin
      FMain.lblSanction.color:=  clBtnFace;
      FMain.lblSanction.Font.Color :=clNavy;
      end
        else
        begin
           if etape = 50 then
            begin
            FMain.lblSanction.color:=  clyellow;
            FMain.lblSanction.Font.Color :=clSilver;
            end
            else
               begin
                FMain.lblSanction.color:=  clred;
                FMain.lblSanction.Font.Color :=clSilver;

                end

        end
        end;
       begin
    if etape<> xetape then
    begin
     if ((etape < limite_sup) and (etape >= limite_inf)and(etape<>32)) then  sequence := 100;
    xetape :=etape ;

    FMain.lblSanction.caption:= LitString('ETAPE_MESSAGE', inttostr(etape)) ;
    UnloadImage ;
    LoadImage(LitString('ETAPE_IMAGE', inttostr(etape)))  ;
    DB_WriteStrLn(0, 'ETAPE =' + inttostr(etape));

    Case etape of
     // FMain.lblSanction.caption:='Interface non connecté';
    0:begin
     InitIHM;
        InitIHM;

    end;
    1:begin
        InitIHM;
        InitIHM;
        mlePortCOM.ComPort1.WriteString('LOFF');
        mlePortCOM.ComPort1.WriteChar (#13) ;
        // charger version
      {  if (rproduit.Version = false) then nodave.Writebit(200,0,false)

         else if  (rproduit.Version = true) then  nodave.Writebit(200,0,true) ;}



      end;
       2:begin
        InitIHM;
        InitIHM;

      end;
    3:begin
       InitIHM;
       InitIHM;

      end;
    //3:
    4:begin
   InitIHM;
      InitIHM;
     mlePortCOM.ComPort1.WriteString('LOFF');
        mlePortCOM.ComPort1.WriteChar (#13) ;
    end;

    5:begin
      mlePortCOM.ComPort1.WriteString('LON');
      mlePortCOM.ComPort1.WriteChar (#13) ;

    end;
    8:begin


           { Num_vis := round (nodave.GetInt(12))  ;
            DB_WriteStrLn(0,inttostr(Num_vis));
           LoadImage(LitString('ETAPE_IMAGE', inttostr(Num_vis)))  ;}


      end;

    16:  begin
          mlePortCOM.ComPort1.WriteString('LON');
          mlePortCOM.ComPort1.WriteChar (#13) ;
    end;



     50:begin

        InitIHM;

        sleep( 1000);

     InitIHM;

    FMain.lblSanction.caption:='MODE MANUELLE ACTIVE';
    end;
    100:begin
      InitIHM;
      InitIHM;
      end;

  end;
  end;
end;
  
end;

procedure TFMain.Button1Click(Sender: TObject);
var
  Active: Boolean;
  Area: Integer;
  DBNumber: Integer;
  Index: Integer;
  Display: String;
begin
//*********************************************
  Active:=NoDave.Active;
  Area:=ComboBox2.ItemIndex;
  Area:=6;

  NoDave.Area:=TNoDaveArea(Area);
  NoDave1.Area:=TNoDaveArea(Area);
  DBNumber:=SpinEdit1.Value;
  NoDave.DBNumber:=DBNumber;


  NoDave1.DBNumber:=DBNumber;

  DataType:=Combobox1.ItemIndex;
  DataCount:=SpinEdit2.Value;
  DataOffset:=SpinEdit3.Value;

  Case DataType of
    0: DataSize:=1;
    1: DataSize:=2;
    2: DataSize:=2;
    3: DataSize:=4;
    4: DataSize:=4;
    5: DataSize:=4;
  end;
  NoDave.BufLen:=DataCount * DataSize;
  NoDave.BufOffs:=DataOffset;

  NoDave1.BufLen:=DataCount * DataSize;
  NoDave1.BufOffs:=300;
  ListBox1.Clear;
  Index:=DataOffset;

  While Index < DataOffset + DataCount do
  begin
    Display:=StringReplace(Format(AreaNames[Area], [DBNumber, TypeNames[DataType], Index]), ' ', '0', [rfReplaceAll]) + ' =         ?';
    ListBox1.Items.Append(Display);
    Inc(Index);
  end;

  NoDave.Active:=Active;
  NoDave1.Active:=Active;


end;
 procedure TFMain.NoDaveReadcmp(Sender: TObject);

var
  Data: Array of Variant;
  Index: Integer;
  Count: Integer;
  boucle: bool;
  Item: String;
  Display: String;
  begin

  // NoDave.BufLen:=1 * 2;
 // NoDave.BufOffs:=300;
//ListBox1.Clear;


  Compteur_vis    := NoDave1.GetInt(300);


 // txtnbrvis.Text  := inttostr( Compteur_vis ) ;
    txtnbrvis.Text  := '--' ;
//  sleep(1000);

  //NoDave.BufOffs:=2;
end;

procedure TFMain.Button3Click(Sender: TObject);
begin
 NoDave.Active:=not NoDave.Active;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 If rProduit.Automate = true then
 begin
  nodave.WriteBit(12,2,true);
  sleep( 1000);
  nodave.WriteBit(12,2,false);
end;
Timercmp.Enabled :=False;
NoDave.Active:=False;
NoDave1.Active:=False;
end;



procedure TFMain.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  // If NoDave.Active then Button3.Caption:='Stop' else Button3.Caption:='Start';
end;





procedure TFMain.NoDaveDisconnect(Sender: TObject);
begin

  ProgressBar1.Position:=0;
  ListBox1.Enabled:=False;
end;

procedure TFMain.NoDaveConnect(Sender: TObject);
begin
ProgressBar1.Position:=0;
  ListBox1.Enabled:=True;
end;

procedure TFMain.NoDaveError(Sender: TObject; ErrorMsg: String);
begin
MessageBoxA(0,Pchar('Erreur de comunication avec l''automate de vissage'),Pchar('Contrôle '),MB_OK + MB_ICONEXCLAMATION + 0);
rProduit.Automate := FAlse ;
 mlePortCOM.ComPort.Active:=false;
 mlePortCOM.ComPort1.Active:=false;
Timer_etape.Enabled:= FAlse;
//NoDave.Destroy;

//NoDave.Active:= false ;

//QuitterIHM;
CloseQuery;

Application.Terminate;
halt ;
exit ;
end;

procedure TFMain.LoadImage(intEtape: STRING);
var

  Jpeg: TJpegImage;
begin
  Jpeg := TJpegImage.Create;
  try
   if  FileExists(GetCurrentDir + '\image\'+ (intEtape)) then
   begin
    imageDefaut.Picture := nil;
    Jpeg.LoadFromFile(GetCurrentDir + '\image\'+ (intEtape) );
    //copie de l'image du jpeg dans un bitmap
    imageDefaut.Picture.Bitmap.Assign(Jpeg);
    // imageDefaut.Picture.LoadFromFile(GetCurrentDir + '\defaut.jpg');  ++++++++++
    imageDefaut.Visible := true;
    end
     except
      on E: Exception do Jpeg.Free;
      end;

      end;
  {frmMain.Left := 6;
  Left := frmMain.Width + 6;
  Top  := frmMain.Top;
  Visible := true;
  }




procedure TFMain.UnloadImage;
begin
  //frmMain.Position := poDesktopCenter;
  //Visible := false;

  imageDefaut.Visible := false;
 // cmdRetester.Visible := false;
 // cmdREPRINT.Visible := false;
 // blnImageLoad := false;
end;




procedure TFMain.tempovissageTimer(Sender: TObject);
begin
tempovissage.Enabled:= false ;
txtnbrvis.Color :=    clInfoBk;
end;

procedure TFMain.txtnbrvisChange(Sender: TObject);
begin
 tempovissage.Enabled := true ;
 txtnbrvis.Color :=   clLime;
end;

procedure TFMain.Button2Click(Sender: TObject);
begin
 EnregistrementData('PASS');
end;

end.

