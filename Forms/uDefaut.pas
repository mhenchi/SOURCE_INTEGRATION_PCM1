unit uDefaut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, GIFImage, ExtCtrls, StdCtrls;

type
  TfrmDefaut = class(TForm)
    Imagedefaut: TImage;
    mnufermerDefaut: TButton;
    pnlVision: TPanel;
    grpIhmContact: TGroupBox;
    shpMiniCam1: TShape;
    shpControleCam1: TShape;
    Label8: TLabel;
    Label9: TLabel;
    grpVisionConnecteurs: TGroupBox;
    shpMiniConnecteurs: TShape;
    shpConnecteurs: TShape;
    Label1: TLabel;
    grpVisionModem: TGroupBox;
    shpMiniModem: TShape;
    shpModem: TShape;
    Label3: TLabel;
    grpVisionDtx: TGroupBox;
    shpMiniDtx: TShape;
    shpDtx: TShape;
    Label4: TLabel;
    grpCapot: TGroupBox;
    shpMiniCapot: TShape;
    shpCapot: TShape;
    lblCapot: TLabel;
    lblPresenceCapot: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure mnufermerDefautClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    procedure LoadImageDefaut;
    procedure UnloadImageDefaut;
    procedure IhmDatamatrix(iEtat: integer);
    procedure InitIhmDefaut;
    procedure IhmModem(iEtat: integer);
    procedure IhmConnecteurs(iEtat: integer);
  end;

var
  frmDefaut: TfrmDefaut;

implementation

{$R *.dfm}

uses uPrincipale, uGlobale;

procedure TfrmDefaut.FormCreate(Sender: TObject);
begin
  frmMain.Left := 6;
  Left := frmMain.Width + 6;
  Top  := frmMain.Top;
  Visible := true;
  caption := caption + '  /  ' +  rProduit.RefVision;

  grpVisionModem.Visible       :=  blnTestModem;
  grpVisionConnecteurs.Visible :=  blnTestFakras;
  
end;


// Afficher ou non la fiche avec l'image de l'analyse en défaut
procedure TfrmDefaut.LoadImageDefaut;
var
  Jpeg: TJpegImage;
begin
  Jpeg := TJpegImage.Create;
  try
    imageDefaut.Picture := nil;
    Jpeg.LoadFromFile(GetCurrentDir + '\defaut.jpg');
    //copie de l'image du jpeg dans un bitmap
    imageDefaut.Picture.Bitmap.Assign(Jpeg);
    // imageDefaut.Picture.LoadFromFile(GetCurrentDir + '\defaut.jpg');
    imageDefaut.Visible := true;
    pnlVision.Visible := false;
    mnufermerDefaut.Visible := true;
  finally
    Jpeg.Free;
  end;

  {frmMain.Left := 6;
  Left := frmMain.Width + 6;
  Top  := frmMain.Top;
  Visible := true;
  }
end;

procedure TfrmDefaut.UnloadImageDefaut;
begin
  //frmMain.Position := poDesktopCenter;
  //Visible := false;
  pnlVision.Visible := true;
  imageDefaut.Visible := false;
  mnufermerDefaut.Visible := false;

end;

procedure TfrmDefaut.mnufermerDefautClick(Sender: TObject);
begin
  frmMain.InitAffichage;
end;


//******************************************************************************
// Gérer l'affichage des contrôles vision
procedure TfrmDefaut.IhmDatamatrix(iEtat: integer);
begin
  // Etat du voyant
  with shpDtx do
    begin
      case iEtat of
        0: brush.Color  := clWhite;
        1: brush.Color  := clYellow;    // Controle en cours
        2: brush.Color  := clGreen;     // Controle OK
        3: brush.Color  := clRed;       // Controle en Défaut ou affichage de l'image

      end;
      refresh;
    end;
end;

//******************************************************************************
// Gérer l'affichage des contrôles Modem
procedure TfrmDefaut.IhmModem(iEtat: integer);
begin
  // Etat du voyant
  with shpModem do
    begin
      case iEtat of
        0: brush.Color  := clWhite;
        1: brush.Color  := clYellow;    // Controle en cours
        2: brush.Color  := clGreen;     // Controle OK
        3: brush.Color  := clRed;       // Controle en Défaut ou affichage de l'image
      end;
      refresh;
    end;
end;

//******************************************************************************
// Gérer l'affichage des contrôles Modem
procedure TfrmDefaut.IhmConnecteurs(iEtat: integer);
begin
  // Etat du voyant
  with shpConnecteurs do
    begin
      case iEtat of
        0: brush.Color  := clWhite;
        1: brush.Color  := clYellow;    // Controle en cours
        2: brush.Color  := clGreen;     // Controle OK
        3: brush.Color  := clRed;       // Controle en Défaut ou affichage de l'image
      end;
      refresh;
    end;
end;
//******************************************************************************
// Initialiser l'interface
procedure TfrmDefaut.InitIhmDefaut;
begin
  IhmDatamatrix(0);
  IhmModem(0);
  IhmConnecteurs(0);
  lblPresenceCapot.visible := true;
  lblCapot.Visible  := false;
  shpCapot.Visible := true;
  shpCapot.Brush.Color := clWhite;
  shpControleCam1.Visible := true;
  shpControleCam1.Brush.Color := clWhite;
  shpMiniCam1.Brush.Color     := clWhite;

  UnloadImageDefaut;
  refresh;
end;

end.
