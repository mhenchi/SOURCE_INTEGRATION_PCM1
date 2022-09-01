unit uReprintLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CDEdit, ExtCtrls, Menus;

type
  TFReprintLabel = class(TForm)
    grpReprint: TGroupBox;
    lblReprint: TLabel;
    GroupBox4: TGroupBox;
    Shape1: TShape;
    lblEtatReprint: TLabel;
    txtScanReprint: TCDEdit;
    cmdManuel: TButton;
    grpInfo: TGroupBox;
    lblInfo: TLabel;
    MainMenu1: TMainMenu;
    Annuler1: TMenuItem;
    mnuRetour: TMenuItem;
    procedure Annuler1Click(Sender: TObject);
    procedure mnuRetourClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdManuelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GestionReprintLabel(strNumSerie: string): boolean;
    function AdresseFichierZpl(strNum: string): string;
    function EnregistreReimpression(strNumeroSerie, strFileZpl: string): boolean;
    procedure InitReprintLabel;
  public
   procedure ReprintLabelScan(strScan: string);
  end;

var
  FReprintLabel: TFReprintLabel;

implementation

{$R *.dfm}

uses
  uGlobale , uReadWriteIni, uConnexionBdd, uPrintZpl, uFonctions, uPrincipale;


//******************************************************************************
// Positionner la feuille au demarrage
procedure TFReprintLabel.FormCreate(Sender: TObject);
begin
  // self.Top :=
  // self.Left:=
end;




//******************************************************************************
// GESTION DE lA REIMPRESSION DES ETIQUETTES EN DEFAUT
//******************************************************************************

//******************************************************************************
// Vérifier que le scan correspond à l'index CIE du boitier ou du produit en cours
function ControleIndexCIE(strData: string): boolean;
begin

  result := (rArticle[1].idArticle = ExtractionString(strData,rArticle[1].PositionIndex))
    or (rProduit.IndexVisim = ExtractionString(strData,rProduit.PositionIndex));
  if result = false then
        FReprintLabel.lblInfo.Caption :='ERREUR : Le n° de série "' + strData +'" ne correspond pas au produit Attendu (Index différent)';

end;

//******************************************************************************
// Traiter le scan ou le mode manuel
procedure TFReprintLabel.ReprintLabelScan(strScan: string);
begin
  InitReprintLabel;
  txtScanReprint.Text := strScan;
  txtScanReprint.Refresh;
  cmdManuelClick(nil);
end;
//*********
procedure TFReprintLabel.cmdManuelClick(Sender: TObject);
begin
  lblInfo.Font.Color := clRed;
  if txtScanReprint.Text <> '' then
    begin
    if not ControleIndexCIE(txtScanReprint.Text) then exit;
      GestionReprintLabel(txtScanReprint.Text);
    end
  else
    begin
      lblInfo.Font.Color := clBlue;
      lblInfo.Caption := ('Veuillez saisir ou scanner un n° de série carte ou produit');
      txtScanReprint.SetFocus;
    end;
end;

//*********
procedure txtScanReprintKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then FReprintLabel.cmdManuelClick(nil);
end;

//******************************************************************************
// Initialiser l'affichage
procedure TFReprintLabel.InitReprintLabel;
begin
  lblInfo.Caption  := '';
  txtScanReprint.Text := '';
end;


//******************************************************************************
// Gestion de la réimpression
function TFReprintLabel.GestionReprintLabel(strNumSerie: string): boolean;
var
  FichierZpl: string;
begin
  try
    FichierZpl := AdresseFichierZpl(strNumSerie);

    if FichierZpl = 'ERREUR' then exit;

    if not EnregistreReimpression(strNumSerie, FichierZpl)then exit;

    if not ImprimerFichierZPL(FichierZpl) then exit;

    sleep(2000);
    InitReprintLabel;

  finally
    txtScanReprint.Text := '';
  end;
end;

//******************************************************************************
// Retourne l'adresse du fichier sauvegardé pour le n° de série aprés avoir
// contrôlé que le fichier existe , Recherche dans la colonne du CIe et du produit
function TFReprintLabel.AdresseFichierZpl(strNum: string): string;
begin
  with CnxBdd.ZSelectFdb1  do
    begin
      case intIdPoste of
          1:begin // Association 1
              sql.Clear;
              sql.Add('SELECT PATH_LABEL_IMPRIME FROM ASSOCIATION_INTEGRATION_1');
             // sql.Add(' WHERE SFC_BOITIER_MONTE = ' + quotedStr(strNum));
                 sql.Add(' WHERE SFC_BOITIER_MONTE = ' + quotedStr(strNum) + ' OR  NUM_SERIE_CIE = ' + quotedStr(strNum));
              //sql.Add(' OR WHERE NUM_SERIE_CIE = ' + quotedStr(strNum));
            end;

      end; // fin case of
      Active := true;
      if RecordCount = 1 then
        begin
          result := FieldByName('PATH_LABEL_IMPRIME').AsString;
          if  not FileExists(result) then
                       begin
              lblInfo.Font.Color := clRed;
              lblInfo.caption := ('ERREUR : Absence du fichier de réimpression "' + result +'" ');
              result := 'ERREUR';
            end;
        end
      else
        begin
          result := 'ERREUR';
          lblInfo.Font.Color := clRed;
          lblInfo.Caption := ('ERREUR : Ce n° de série "' + strNum +'" n''existe pas dans la base de donnée ')
        end;

    end;
end;

//******************************************************************************
// Enregistrement des n° de serie réimprimé
function TFReprintLabel.EnregistreReimpression(strNumeroSerie, strFileZpl: string): boolean;
begin
  result := false;
  with CnxBdd.ZWriteFdb1 do
    begin
      sql.Clear;
      sql.Add ('INSERT INTO LABEL_REIMPRIME (CODE_PRODUIT, PATH_LABEL_IMPRIME, DATE_REPRINT)');
      sql.Add(' VALUES (');
      sql.Add(Format('''%s'',''%s'',''%s''',
                            [ strNumeroSerie,
                              strFileZpl,
                              FormatDateTime('mm/dd/yyyy hh:mm:ss',now)
                            ])+ ')');

      try
        ExecSql;
        result := true;
      except
        on E: Exception do
          begin
            lblInfo.Font.Color := clRed;
            lblInfo.Caption := ('ERREUR lors de l''enregistrement dans la table " LABEL_REIMPRIME " '+#13 + E.Message  +'');
          end;
      end;
    end;
end;

//******************************************************************************
// Annuler la réimpression en cours
procedure TFReprintLabel.Annuler1Click(Sender: TObject);
begin
  InitReprintLabel;
end;

//******************************************************************************
// Retour à lafiche principale
procedure TFReprintLabel.mnuRetourClick(Sender: TObject);
begin
  InitReprintLabel;
  FReprintLabel.visible    := false;
  FMain.Visible            := true;
  blnReimpressionActive    := false;
end;

procedure TFReprintLabel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  mnuRetourClick(nil);
end;




end.
