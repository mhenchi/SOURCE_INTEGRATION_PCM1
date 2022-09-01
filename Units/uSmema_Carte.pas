// Interface avec la Dll de communication avec les boitier interface IO5E2S

unit uSmema_Carte;

interface


Function  SMEMA_Open(ComPort: Byte): Boolean; external 'SMEMA_USB.dll';
Procedure SMEMA_Close; external 'SMEMA_USB.dll';
Function  SMEMA_Out (n : byte; Etat:Boolean): Boolean; external 'SMEMA_USB.dll';
Function  SMEMA_GetOut (n: Byte): Boolean; external 'SMEMA_USB.dll';
Function  SMEMA_In (n: Byte): Boolean; external 'SMEMA_USB.dll';


// Utilisation des Boitier IO5E2S (Pour rester conforme � l'�tiquettage du boitier)
function  IO5E2S_Open(ComPort: Byte): Boolean;
Procedure IO5E2S_Close;
function  IO5E2S_In (n: Byte): Boolean;
function  IO5E2S_Out (n: byte; Etat:Boolean): Boolean;
function  IO5E2S_GetOut (n: byte): Boolean;


implementation


//******************************************************************************
//  Ouvrir le port Com (Pour rester Homog�ne � l'utilisation du IO5S2E)
function IO5E2S_Open(ComPort: Byte): Boolean;
  begin
    result := SMEMA_Open(ComPort);
  end;


//******************************************************************************
//  Fermer le port Com Pour rester Homog�ne � l'utilisation du IO5S2E
Procedure IO5E2S_Close;
  begin
    SMEMA_Close;
  end;


//******************************************************************************
//  Permet d'appeler le n� de l'entr�e conforme � l'�tiquette du module Smema IO5E2S
function IO5E2S_In (n: Byte): Boolean;
  begin
    dec(n);
    result := SMEMA_In(n);
  end;


//******************************************************************************
// Permet de piloter le n� de sortie conforme � l'�tiquette du module Smema IO5E2S
function IO5E2S_Out (n: byte; Etat:Boolean): Boolean;
  begin
    dec(n);
    result := SMEMA_Out(n,Etat);
  end;


//******************************************************************************
// Permet d'appeler le n� de l'entr�e conforme � l'�tiquette du module Smema IO5E2S
function IO5E2S_GetOut(n: byte): Boolean;
  begin                                         
    dec(n);
    result := SMEMA_GetOut(n);
  end;



end.
