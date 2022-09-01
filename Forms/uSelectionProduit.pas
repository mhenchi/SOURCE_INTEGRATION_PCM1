unit uSelectionProduit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, jpeg, ExtCtrls, GIFImage;

type
  TFSelectProduit = class(TForm)
    LogoCipi: TImage;
    LogoActia: TImage;
    lblTitreAppli: TLabel;
    Label1: TLabel;
    lstProduit: TListBox;
    MainMenu1: TMainMenu;
    mnuQuitter: TMenuItem;
    mnuReglage: TMenuItem;
    mnuAutomate: TMenuItem;
    mnuRework: TMenuItem;
    ReworkTotale1: TMenuItem;
    Reworkcapot1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnuQuitterClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lstProduitClick(Sender: TObject);
    procedure lstProduitDblClick(Sender: TObject);
    procedure mnuAutomateClick(Sender: TObject);
    procedure mnuReworkClick(Sender: TObject);
    procedure ReworkTotale1Click(Sender: TObject);
    procedure Reworkcapot1Click(Sender: TObject);
  private
    procedure ListerProduits;
    procedure Chargerpwrrework;
    procedure ChargerSelection(idIndex: integer);
  public
    { Déclarations publiques }
  end;

var
  FSelectProduit: TFSelectProduit;

implementation

{$R *.dfm}

uses uGlobale, uPatienter, uConnexionBdd, u1PortCom, uFonctions, uPrincipale,
     uSmema_Carte, MMDebug, uLoginrework;


//******************************************************************************
//  Initialisation du démarrage
procedure TFSelectProduit.FormCreate(Sender: TObject);
begin
  // Vérifier la présence du Fichier INI
  if not AffecterIni then
    begin
      Application.Terminate;
      exit;
    end;

  // Affecter les variables de l'application
  ParametreAppli;

  
  if Debug then
    begin
      DB_Open;
      DB_Clear;
    end;

  mnuReglage.Visible := blnMenuReglage;

  // Afficher le module Pbar de patienter
  Patienter := TPatienter.create(Application);

  // Etablir la connexion aux bases de données
  Application.CreateForm(TCnxBdd, CnxBdd);
  if not CnxBdd.EtablirConnexionBdd then
    begin
      MessageBoxA(0,Pchar('ERREUR DE CONNEXION A LA BASE FIREBIRD !'+#13+'  '),
                                 Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
      Application.Terminate;
      exit;
    end;

  // Paramétrer et Connecter les ports coms
  Application.CreateForm(TmlePortCOM, mlePortCOM);
  if not mlePortCOM.ConnectLECTEUR then
    begin
      Application.Terminate;
      exit;
    end;
    if not mlePortCOM.ConnectLECTEURReimp then
    begin
      Application.Terminate;
      exit;
    end;

  
  // Récupérer la liste des produits à fabriquer
  ListerProduits;
   // Récupérer le mot de passe rework
   Chargerpwrrework ;
  // Infos des labels 
  Caption := '   ' + DateToStr(Date) + '      Sélection des produits'  ;
  lblTitreAppli.Caption := 'PCM:  POSTE INTEGRATION 1.2 ';
  DB_WriteStrLn(0, 'PCM: Num Poste INTEG 1.2 ' );

  // Logos
  logoActia.Visible := blnLogoActia;
  logoCipi.Visible := not blnLogoActia;

  // Effacer le PBar de patienter
  Patienter.PatienterChargement(false);


end;

//******************************************************************************
// Charger le mot de passe rework
procedure TFSelectProduit.Chargerpwrrework;
  begin
// Mot de passe Réwork
    with CnxBdd.ZSelectFdb1 do
    begin
      sql.Clear;
      sql.Add('SELECT SESAME FROM WMDP WHERE SECTEUR = ' + quotedStr('Rework'));
      Active := true;
      if RecordCount = 1 then

        rPrint.PwdRework  := FieldByName('SESAME').AsString
      else
        begin
         // result := false;
          MessageBoxA(0,Pchar('Echec lors du chargement des informations "Pwd" pour autoriser la rework !'+#13+'  '),
                        Pchar('Chargement datas'),0 + MB_ICONEXCLAMATION + 0);
          exit;
        end;
     end;

end;

//******************************************************************************
// Charger la liste de tous les produits disponibles
procedure TFSelectProduit.ListerProduits;
begin
  with CnxBdd.ZSelectFdb1 do
    begin
      sql.Clear;
      sql.Add ('SELECT * FROM LISTE_PRODUIT ');
      sql.Add (' WHERE ETAT = 1');
      if intIdPoste <> 9 then  sql.Add (' AND NUM_POSTE = ' + quotedStr(IntToStr(intIdPoste)));
      sql.Add (' ORDER BY ID_PRODUIT ASC');
      Active := true;
      while (not EOF) do
        begin
          lstProduit.Items.Add(FieldByName('ID_PRODUIT').AsString  +' , '+ FieldByName('MENU_SELECTION').AsString);
          next;
        end;
    end;

  // Si le nombre de produits = 1, lancer son chargement par défaut.
  if lstProduit.Count = 1 then
    begin
      ChargerSelection(0);
    end;
end;



//******************************************************************************
// Lire le fichier source ZPL de l'étiquette
function LireFileLabelZPL(strZplSource: string): TStringStream;
var
  //strStreamZPL : TStringStream;
  strFileZPL   : TextFile;
  strLaLigne   : string;
  wTimeOut     : DWord;
  wTimeStart   : DWord;

begin
  result := TStringStream.create('');

  // Est ce que le fichier existe
  if not(FileExists(strZplSource)) then
      begin
        result.WriteString('ERREUR');
        MessageBoxA(0,Pchar('ERREUR : le fichier source ZPL pour ce produit n''existe pas !'+#13+'  '),
                    Pchar('Contrôle présence fichier Zpl'),0 + MB_ICONEXCLAMATION + 0);
        exit;
      end;

  wTimeOut := 1500;
  wTimeStart := GetTickCount;
  Assignfile(strFileZPL, strZplSource);
  try
    Reset(strFileZPL);
    // Se Positionner au début des données ZPL
    Repeat
      ReadLn(strFileZPL,strLaLigne);
      if (GetTickCount - wTimeStart) > wTimeOut then
        begin
          result.WriteString('ERREUR');
          MessageBoxA(0,Pchar('Timeout atteint lors de la lecture du Fichier Source ZPL (Vérifier présence "[CODE_ZPL] au début du fichier") !'+#13+'  '),
                        Pchar('Chargement fichier source ZPL'),0 + MB_ICONEXCLAMATION + 0);
          exit;
        end;
    Until pos('[CODE_ZPL]',strLaLigne) >= 1;

    // Lire les données ZPL
    while Not EOF(strFileZPL) do
      begin
        ReadLn(strFileZPL,strLaLigne);
        if strLaLigne <> '' then result.WriteString(strLaLigne +chr(13)+ chr(10));
      end;

  finally
    CloseFile(strFileZPL);
  end;

end;


//******************************************************************************
// Datas Impression et Récupérer le mot de passe pour la Réimpression
function DataImpression: boolean;
begin
  result := true;

     
  if not blnImpressionActive then exit;

  // Mot de passe réimpression
  with CnxBdd.ZSelectFdb1 do
    begin
      sql.Clear;
      sql.Add('SELECT SESAME FROM WMDP WHERE SECTEUR = ' + quotedStr('Reprint'));
      Active := true;
      if RecordCount = 1 then
        rPrint.pwdReprint := FieldByName('SESAME').AsString

      else
        begin
          result := false;
          MessageBoxA(0,Pchar('Echec lors du chargement des informations "Pwd" pour autoriser la réimpression !'+#13+'  '),
                        Pchar('Chargement datas'),0 + MB_ICONEXCLAMATION + 0);
          exit;
        end;
     end;



    // Récupérer l'index de l'imprimante, Si le nom de l'imprimante est absent, imprimante par défaut affecté = (-1)
    if rPrint.NamePrinter <> '' then
      begin
        rPrint.IndexPrinter := IndexImprimante(rPrint.NamePrinter);
        if rPrint.IndexPrinter = 888 then
          begin
            result := false;
            MessageBoxA(0,Pchar('L''imprimante "'+ rPrint.NamePrinter + '" n''a pas été trouvé dans la liste des imprimantes !'+#13+' Veuillez contacter le service informatique  '),
                      Pchar(' Contrôle configuration imprimante '),0 + MB_ICONEXCLAMATION + 0);
            exit;
          end;
       end
      else
        rPrint.IndexPrinter := -1;


    // Contrôler et Charger le Zpl pour l'impression de l'étiquette produit
    try
      rPrint.DataFileSourceZPL := LireFileLabelZPL(rProduit.SourceZPL).DataString;
      if rPrint.DataFileSourceZPL = 'ERREUR'  then
        begin
          result := false;
          exit;
        end;
    except
      on E: Exception do
        begin
          MessageBoxA(0,Pchar('ERREUR au chargement du label source Zpl: '+ E.Message +#13+''),
                        Pchar('Chargement source Zpl'),0 + MB_ICONEXCLAMATION + 0);
        end;
      end;


end;

//******************************************************************************
// Charger toutes les infos sur le produit sélectionné
function LoadDataProduit(strIndex: string): boolean;
begin
  result := false;
  with CnxBdd.ZSelectFdb1, rProduit do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT * FROM LISTE_PRODUIT WHERE ID_PRODUIT = ' + quotedStr(strIndex));
      Open;   //Active := true;
      if RecordCount = 1 then
        begin
          IndexVisim        := FieldByName('ID_PRODUIT').AsString;
          intIdPoste        := FieldByName('NUM_POSTE').AsInteger;
          Automate          := IntToBoolean(FieldByName('AUTOMATE').AsInteger);
          CodeActia         := FieldByName('PN_ACTIA').AsString;
          blnPrdVisim       := IntToBoolean(FieldByName('VISIM').AsInteger);    //
          Designation1      := FieldByName('DESIGNATION_1').AsString;
          Designation2      := FieldByName('DESIGNATION_2').AsString;
          MenuSelection     := FieldByName('MENU_SELECTION').AsString;
          Operation         := FieldByName('OPERATION').AsString;
          Ressource         := FieldByName('RESSOURCE').AsString;
          NomColonneProduit := FieldByName('NOM_COL_ASSOCIE').AsString;
          PositionIndex     := FieldByName('POS_INDEX').AsString;
          NbreEtiquette     := FieldByName('NBRE_LABEL').AsString;
          SourceZPL         := FieldByName('SOURCE_ZPL').AsString;
          V_HW              := FieldByName('VERSION_HARDWAR').AsString;
          Version             := IntToBoolean(FieldByName('VERSION').AsInteger);
          reference_client  := FieldByName('REFERENCE_CLIENT').AsString;
          num_post_integ    := FieldByName('NUM_POST_INTEG').AsString;

         // if FieldByName('CONNECTEUR_PROD').AsInteger = 1 then          // variante prod
          // blnConnecteur  := true else blnConnecteur  := false;
            if blnMenuReglage then  rProduit.Automate:= FSelectProduit.mnuAutomate.Checked;
          // Etablir la connexion a Oracle si Visim est activé
          if CnxBdd.ZCnxOracle.Connected then CnxBdd.ZCnxOracle.Connected := false;
          if not CnxBdd.ConnectOracle(rProduit.blnPrdVisim) then exit;

          // Vérifier que les ressource et l'opération est présente pour le produit sélectionné
          if blnPrdVisim then
            begin
              if (Operation ='') or (Operation ='0') or (Ressource ='') or (Ressource ='0') then
                begin
                  MessageBoxA(0,Pchar('ERREUR : La Ressource ou l''opération VISIM pour ce produit n''est pas renseigné dans la Base de donnée !'+#13+'  '),
                        Pchar('Chargement produit'),0 + MB_ICONEXCLAMATION + 0);
                  exit;
                end;  
            end;

          // Vérifier si l'automate n'a pas été activé localement quant il est inactif à partir de la bdd

          // Fermer et ouvrir le port com de l'automate
        //  IO5E2S_Close;



          result := true;
        end
      else
        begin
          MessageBoxA(0,Pchar('ERREUR : L''index " ' + strIndex + ' " n''existe pas dans la table PRODUIT !'+#13+'  '),
                        Pchar('Chargement produit'),0 + MB_ICONEXCLAMATION + 0);
        end;
    end;
end;

//******************************************************************************
// Charger tous les paramètres du produit sélectionné
procedure TFSelectProduit.lstProduitClick(Sender: TObject);
begin
  // Pour le mode debug
end;
procedure TFSelectProduit.lstProduitDblClick(Sender: TObject);
begin
  ChargerSelection(lstProduit.itemindex);

  // Charger la fiche Principale
  Application.CreateForm(TFMain, FMain);
  self.Visible  := false;
  //Patienter.PatienterChargement(false);

  FMain.Showmodal;
  FMain.Free;

end;
procedure TFSelectProduit.ChargerSelection(idIndex: integer);
begin
  //Patienter.PatienterChargement(true);
  // try
    // Charger les données du produit sélectionné
    if not LoadDataProduit(Nomdata1(lstProduit.Items[idIndex])) then exit;

    // Charger et contrôler : le fichier source ZPL, l'index de l'imprimante et le mot de passe pour la réimpression
    if not DataImpression then exit;

   {
    // Configurer la communication avec Visim
    with rVisim do
      if blnActivation then
        begin
          if not ConfigurerVisim then
            begin
              MessageBoxA(0,Pchar('ERREUR rencontré lors de la configuration de VISIM !'+#13+' Veuillez contacter le service informatique  '),
                            Pchar(' Contrôle configuration VISIM '),0 + MB_ICONEXCLAMATION + 0);
              exit;
            end;
        end;
     }
   

  // except
  //  Patienter.PatienterChargement(false);
  // end;
end;





//******************************************************************************
// Quitter  et fermer les connexions aux bases de données ainsi que les ports com
procedure TFSelectProduit.mnuQuitterClick(Sender: TObject);
begin
  CloseQuery;
end;
procedure TFSelectProduit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //if MessageDlg('Voulez vous Quitter l''Application ?', mtConfirmation, [mbYes,mbNo],0) = mrYes then
    //begin
      CanClose := true;

      DB_WriteStrLn(0, 'Port Com de l''automate FERME');
      //IO5E2S_Close;

      // CnxBdd.Free;
      // mlePortCom.Free;
      //
      // Patienter.Free;
      Application.Terminate;
    //end
  //else
    //CanClose := False;
end;



//******************************************************************************
//
procedure TFSelectProduit.mnuAutomateClick(Sender: TObject);
begin
  mnuAutomate.Checked := not mnuAutomate.Checked;
  rProduit.Automate := mnuAutomate.Checked ;  // modifier l'activation avec l'automate
end;


         
procedure TFSelectProduit.mnuReworkClick(Sender: TObject);
begin
 {if TLoginreworkForm.Execute then
    begin
     mnuRework.Checked := not mnuRework.Checked;
      //Afficher l'interface de réimpression
   //   FReprintLabel.visible := true;
  //    FMain.Visible := false;
      blnReworkActive  := mnuRework.Checked ;
    end;   }
end;

procedure TFSelectProduit.ReworkTotale1Click(Sender: TObject);
begin
if TLoginreworkForm.Execute then
    begin
    mnuRework.Checked := false ;
     ReworkTotale1.Checked := not ReworkTotale1.Checked;

       if  Reworkcapot1.Checked    then   Reworkcapot1.Checked := false ;

      //Afficher l'interface de réimpression
   //   FReprintLabel.visible := true;
  //    FMain.Visible := false;
      blnReworkActive  := mnuRework.Checked ;
      if  ReworkTotale1.Checked then mnuRework.Checked := true  ;
      blnReworkActive  := mnuRework.Checked

    end;
end;

procedure TFSelectProduit.Reworkcapot1Click(Sender: TObject);
begin
  if TLoginreworkForm.Execute then
    begin
    mnuRework.Checked := false;
     Reworkcapot1.Checked := not Reworkcapot1.Checked;


      if  ReworkTotale1.Checked    then   ReworkTotale1.Checked := false ;

      //Afficher l'interface de réimpression
   //   FReprintLabel.visible := true;
  //    FMain.Visible := false;
      blnReworkActive  := mnuRework.Checked ;
      blnReworkActive_cap  := Reworkcapot1.Checked  ;
       if  Reworkcapot1.Checked then mnuRework.Checked := true  ;
       blnReworkActive  := mnuRework.Checked
    end;
end;

end.
