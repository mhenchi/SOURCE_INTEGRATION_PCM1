unit UInterlock;



interface


uses Windows, Forms, IniFiles, SysUtils;

//******************************************************************************
// Function NET_Ping
// Elle permet de tester la réponse d'une adresse IP
// AdresseIP : adress IP du poste à pinguer
// Retour    : true : poste présent, false : poste non connecté
//******************************************************************************
Function NET_Ping (AdresseIP: Pchar):Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Procedure Configure
// Elle permet d'outrepasser les paramétrages issus du fichier interlock.ini
// System   : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Host     : adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
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
// Elle ne sert que pour Actitrace et permet d'initier un numéro de série dans le système
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilisé pour l'opération
// Operation : code de l'opération
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est spécifier dans Reponse
//******************************************************************************
Function INTERLOCK_Init (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction Start
// Elle permet de tester la faisabilité d'une opération pour un SFC donné sur une Ressource
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilisé pour l'opération
// Operation : code de l'opération
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est spécifier dans Reponse
//******************************************************************************
Function INTERLOCK_Start (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction Complete
// Elle permet de statuer la réussite de l'opération initiée précédemment par un start
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilisé pour l'opération
// Operation : code de l'opération
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est spécifier dans Reponse
//******************************************************************************
Function INTERLOCK_Complete (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction NcLogComplete
// Elle permet de statuer l'échec de l'opération initiée précédemment par un start
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilisé pour l'opération
// Operation : code de l'opération
// User      : nom de l'utilisateur utilisateur
// NcCode    : code défaut
// Location  :
// NbDefaut  :
// Reference :
// Composant :
// Retour    : true ou false, si false alors l'erreur est spécifier dans Reponse
//******************************************************************************
Function INTERLOCK_NcLogComplete (System, Site, ID, Ressource, Operation, User, NcCode, Location, NbDefaut,Reference, Composant: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction NcLog
// Elle permet de statuer l'échec de l'opération initiée précédemment par un start
// System    : indique le système d'interblocage choisi, valeurs possible : 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilisé pour l'opération
// Operation : code de l'opération
// User      : nom de l'utilisateur utilisateur
// NcCode    : code défaut
// Location  :
// NbDefaut  :
// Reference :
// Composant :
// Retour    : true ou false, si false alors l'erreur est spécifier dans Reponse
//******************************************************************************
Function INTERLOCK_NcLog (System, Site, ID, Ressource, Operation, User, NcCode, Location, NbDefaut,Reference, Composant: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction QuickComplete
// Elle permet de combiner en une seule opération un Start et un Complete
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilisé pour l'opération
// Operation : code de l'opération
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est spécifier dans Reponse
//******************************************************************************
Function INTERLOCK_QuickComplete (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction Done
// Elle permet de finir et donc cloturer l'usage d'un SFC
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Site      : code du site de production, pour Colomiers COL, pour Cipi CIPI, Actia Tunisie ACTUN adresse du serveur délivrant le service d'interblocage, bien souvent une adresse IP
// ID        : SFC du produit
// Ressource : code de la ressource utilisé pour l'opération
// Operation : code de l'opération
// User      : nom de l'utilisateur utilisateur
// Retour    : true ou false, si false alors l'erreur est spécifier dans Reponse
//******************************************************************************
Function INTERLOCK_Done (System, Site, ID, Ressource, Operation, User: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction ProductStatus
// Cette fonction est spécifique à Actitrace et permet d'avoir des informations sur la situation d'un SFC
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// Parameter : code de l'information demandée pour une SFC donnée
//             valeurs possibles :
//             STATUS      status du SFC : inqueue, fail, pass, inwork, done
//             CURRENTPOS  position courante du SFC, donne le code de l'opération et de la ressource
//             NEXTOP      donne la liste des codes opérations ou le SFC est attendu
// ID        : SFC du produit
// Retour    : texte de la réponse fournie par la fonction
//******************************************************************************
Function INTERLOCK_ProductStatus (System, Parameter, ID: PChar): PChar; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction IsExpectedAt
// Cette fonction est spécifique à Actitrace et permet de savoir si un produit est attendu à une certaine opération
// System    : indique le système d'interblocage choisi, valeurs possible : 'ACTI' pour actitrace, 'VISI' pour Visiprise
// ID        : SFC du produit
// Operation : code de l'opération
// Retour    : true ou false
//******************************************************************************
Function INTERLOCK_IsExpectedAt  (System, ID, Operation: PChar): Boolean; cdecl; external 'interlock.dll';

//******************************************************************************
// Fonction GetLastResponse
// Cette fonction permet de récupérer le dernier message renvoyé par le système d'interblocage lors
// de la dernière requête effectuée auprès de ce dernier
// Retour    : Message en clair renvoyé par l'interblocage
//******************************************************************************
Function INTERLOCK_GetLastResponse: PChar; cdecl; external 'interlock.dll';


//******************************************************************************
// Les fonctions suivantes ne servent que pour le développement
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
