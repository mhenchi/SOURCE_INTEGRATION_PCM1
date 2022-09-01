unit UInterlock;



interface


uses Windows, Forms, IniFiles, SysUtils;

//******************************************************************************
// Function NET_Ping
// Elle permet de tester la r�ponse d'une adresse IP
// AdresseIP : adress IP du poste � pinguer
// Retour    : true : poste pr�sent, false : poste non connect�
//******************************************************************************
Function NET_Ping (AdresseIP: Pchar):Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Procedure Configure
// Elle permet d'outrepasser les param�trages issus du fichier interlock.ini
// System   : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Host     : adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// Port     : pour Actitrace = 80, pour Visiprise = 7001
// Document : url vers le script qui traitrera les demandes
//******************************************************************************
Procedure INTERLOCK_Configure (System, Host : PChar; Port: Word; Document: PChar); cdecl; external 'interlock.dll';

{*******************************************************************************
|---------------------------------------|
|	               | VisiPrise | ActiLock |
|----------------|-----------|----------|
|Configure	     |     X     |    X     |
|Init		         |           |    X     |
|Start           |     X     |    X     |
|Complete        |     X     |    X     |
|NcLog           |     X     |          |
|NcLogComplete   |     X     |    X     |
|QuickComplete   |     X     |    X     |
|Done            |           |    X     |
|ProductStatus   |           |    X     |
|IsExpectedAt    |           |    X     |
|GetLastResponse |     X     |    X     |
|---------------------------------------|
*******************************************************************************}

//******************************************************************************
// Fonction Init
// Elle ne sert que pour Actitrace et permet d'initier un num�ro de s�rie dans le syst�me
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilis� pour l'op�ration
// Operation : code de l'op�ration
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est sp�cifier dans Reponse
//******************************************************************************
Function INTERLOCK_Init (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction Start
// Elle permet de tester la faisabilit� d'une op�ration pour un SFC donn� sur une Ressource
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilis� pour l'op�ration
// Operation : code de l'op�ration
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est sp�cifier dans Reponse
//******************************************************************************
Function INTERLOCK_Start (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction Complete
// Elle permet de statuer la r�ussite de l'op�ration initi�e pr�c�demment par un start
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilis� pour l'op�ration
// Operation : code de l'op�ration
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est sp�cifier dans Reponse
//******************************************************************************
Function INTERLOCK_Complete (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction NcLogComplete
// Elle permet de statuer l'�chec de l'op�ration initi�e pr�c�demment par un start
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilis� pour l'op�ration
// Operation : code de l'op�ration
// User      : nom de l'utilisateur utilisateur
// NcCode    : code d�faut
// Location  :
// NbDefaut  :
// Reference :
// Composant :
// Retour    : true ou false, si false alors l'erreur est sp�cifier dans Reponse
//******************************************************************************
Function INTERLOCK_NcLogComplete (System, Site, ID, Ressource, Operation, User, NcCode, Location, NbDefaut,Reference, Composant: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction NcLog
// Elle permet de statuer l'�chec de l'op�ration initi�e pr�c�demment par un start
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilis� pour l'op�ration
// Operation : code de l'op�ration
// User      : nom de l'utilisateur utilisateur
// NcCode    : code d�faut
// Location  :
// NbDefaut  :
// Reference :
// Composant :
// Retour    : true ou false, si false alors l'erreur est sp�cifier dans Reponse
//******************************************************************************
Function INTERLOCK_NcLog (System, Site, ID, Ressource, Operation, User, NcCode, Location, NbDefaut,Reference, Composant: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction QuickComplete
// Elle permet de combiner en une seule op�ration un Start et un Complete
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilis� pour l'op�ration
// Operation : code de l'op�ration
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est sp�cifier dans Reponse
//******************************************************************************
Function INTERLOCK_QuickComplete (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction Done
// Elle permet de finir et donc cloturer l'usage d'un SFC
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur d�livrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilis� pour l'op�ration
// Operation : code de l'op�ration
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est sp�cifier dans Reponse
//******************************************************************************
Function INTERLOCK_Done (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction ProductStatus
// Cette fonction est sp�cifique � Actitrace et permet d'avoir des informations sur la situation d'un SFC
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Parameter : code de l'information demand�e pour une SFC donn�e
//             valeurs possibles :
//             STATUS      status du SFC : inqueue, fail, pass, inwork, done
//             CURRENTPOS  position courante du SFC, donne le code de l'op�ration et de la ressource
//             NEXTOP      donne la liste des codes op�rations ou le SFC est attendu
// ID        : SFC du produit
// Retour    : texte de la r�ponse fournie par la fonction
//******************************************************************************
Function INTERLOCK_ProductStatus (System, Parameter, ID: PChar): PChar; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction IsExpectedAt
// Cette fonction est sp�cifique � Actitrace et permet de savoir si un produit est attendu � une certaine op�ration
// System    : indique le syst�me d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// ID        : SFC du produit
// Operation : code de l'op�ration
// Retour    : true ou false
//******************************************************************************
Function INTERLOCK_IsExpectedAt  (System, ID, Operation: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction GetLastResponse
// Cette fonction permet de r�cup�rer le dernier message renvoy� par le syst�me d'interblocage lors
// de la derni�re requ�te effectu�e aupr�s de ce dernier
// Retour    : Message en clair renvoy� par l'interblocage
//******************************************************************************
Function INTERLOCK_GetLastResponse: PChar; cdecl; external 'interlock.dll';


//******************************************************************************
// Les fonctions suivantes ne servent que pour le d�veloppement
// NE PAS LES UTILISER POUR LA PRODUCTION
//******************************************************************************
Procedure INTERLOCK_Debug_Open;  external 'interlock.dll';
Procedure INTERLOCK_Debug_Enable; external 'interlock.dll';
Procedure INTERLOCK_Debug_Disable; external 'interlock.dll';
Procedure INTERLOCK_Debug_Close; external 'interlock.dll';
Function INTERLOCK_Delete (System, Pass, ID: PChar): Boolean; cdecl;  external 'interlock.dll';
//******************************************************************************

implementation

end.
