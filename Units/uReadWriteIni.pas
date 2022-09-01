unit uReadWriteIni;

{
Service : Informatique de Production
Unité pour Lire Ecrire des "strings","boolean" ou des "integer" dans un fichier .ini


UVersion

U1.0.0.0  09/10/2006 M'hammed Djaouti
          Création    

U1.0.0.1  03/06/2008  M'hammed Djaouti
          Ajout des procedures EffacerSection,EffacerCle,LaSectionExiste

U1.0.0.2 16/06/2008  M'hammed Djaouti
          Ajout de la lecture de toutes les cles d'une section "ListerClesSection"

U1.0.0.3 23/09/2008 M'hammed Djaouti
          Overload des fonctions pour une utilisation sans passage du fichier ini
          en paramètres

U1.0.0.4 03/11/2008 M'hammed Djaouti
          Modification du message de retour en cas d'erreur de lecture d'un string
          'STR' devient 'ERR'

U1.0.0.5  04/02/2011 M'hammed Djaouti
          Suppression de la dépendance du module "uglobale" par ajout de la
          "procedure SetNomFichierIni(strNomIni: string);"
          et ajout de la possibilité de passer un fichier ini différent du ini général
          et un nom de fichier ini vide qui sera remplacé par le fichier ini général
          Suppression dans uses des modules non utilisés

}


interface

uses Classes,IniFiles;



 procedure SetNomFichierIni(strNomIni: string);

 function LitString(Section,SousSection: String):String; overload;
 function LitString(Section,SousSection,strFichier: String):String; overload;

 procedure EcritString(Section,SousSection,strFichier,strValeur : String); overload;
 procedure EcritString(Section,SousSection,strValeur: string);overload;

 function LitInteger(Section,SousSection: string):Integer; overload;
 function LitInteger(Section,SousSection,strFichier: string):Integer; overload;

 procedure EcritInteger(Section,SousSection: string ; strValeur : Integer);overload;
 procedure EcritInteger(Section,SousSection,strFichier : string ;strValeur : Integer); overload;

 function LitBoolean(Section,SousSection: string):Boolean; overload;
 function LitBoolean(Section,SousSection,strFichier: string):Boolean; overload;

 procedure EcritBoolean(Section,SousSection: string;strValeur : Boolean); overload;
 procedure EcritBoolean(Section,SousSection,strFichier : string ;strValeur : Boolean); overload;

 function ListerSections(strFichier: string):TStringList;
 function ListerClesSection(strSection, strFichier: string):TStringList;
 function ListerValeurClesSection(strSection, strFichier: string):TStringList;
 procedure EffacerSection(strSection,strFichier: string);
 procedure EffacerCle(strSection,strCle,strFichier: string);

 function LaSectionExiste(strSection:string): boolean; overload;
 function LaSectionExiste(strSection,strFichier:string): boolean; overload;
 

implementation

var
  strFileIni : string;

procedure SetNomFichierIni(strNomIni: string);
begin
  strFileIni :=  strNomIni;
end;


//***************************************************************************************************
// Toutes les fonctions sans le passage du fichier Ini
function LitString(Section,SousSection: String):String;overload;
begin result := LitString(Section,SousSection,strFileIni); end;

procedure EcritString(Section,SousSection,strValeur: string);overload;
begin EcritString(Section,SousSection,strFileIni,strValeur); end;

function LitInteger(Section,SousSection: string):Integer;overload;
begin result := LitInteger(Section,SousSection,strFileIni); end;

procedure EcritInteger(Section,SousSection: string ;strValeur : Integer);overload;
begin EcritInteger(Section,SousSection,strFileIni,strValeur); end;

function LitBoolean(Section,SousSection: string):Boolean;overload;
begin result := LitBoolean(Section,SousSection,strFileIni); end;

procedure EcritBoolean(Section,SousSection: string; strValeur : Boolean); overload;
begin EcritBoolean(Section,SousSection,strFileIni,strValeur); end;

function LaSectionExiste(strSection: string): boolean; overload;
begin result := LaSectionExiste(strSection, strFileIni); end;

//***************************************************************************************************
//Lire STRING, Retourne 'ERR' en cas d'erreur
function LitString(Section,SousSection,strFichier: String):String;
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  Result := FichierIni.ReadString(Section,SousSection,'ERR');
  FichierIni.Free;
end;

//***************************************************************************************************
//Ecrire STRING
procedure EcritString(Section,SousSection,strFichier,strValeur : String);
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni:=TIniFile.Create (strFichier);
  FichierIni.WriteString(Section,SousSection,strValeur);
  FichierIni.Free; 
end;

//***************************************************************************************************
// Lire INTEGER, Retourne 8888 en cas d'erreur
function LitInteger(Section,SousSection,strFichier: string):Integer;
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  Result := FichierIni.ReadInteger(Section,SousSection,8888);
  FichierIni.Free;
end;

//***************************************************************************************************
//Ecrire INTEGER
procedure EcritInteger(Section,SousSection,strFichier : string ;strValeur : Integer);
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni:=TIniFile.Create (strFichier);
  FichierIni.WriteInteger(Section,SousSection,strValeur);
  FichierIni.Free;
end;

//***************************************************************************************************
//Lire BOOLEAN
function LitBoolean(Section,SousSection,strFichier: string):Boolean;
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  Result := FichierIni.ReadBool(Section,SousSection,False);
  FichierIni.Free;
end;

//***************************************************************************************************
//Ecrire BOOLEAN
procedure EcritBoolean(Section,SousSection,strFichier : string ;strValeur : Boolean);
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni:=TIniFile.Create (strFichier);
  FichierIni.WriteBool(Section,SousSection,strValeur);
  FichierIni.Free;
end;

//***************************************************************************************************
// Lister Toutes les sections du fichier .ini
function ListerSections(strFichier: string):TStringList;
var
  FichierIni : TIniFile;
begin
  result := TStringList.Create;
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  FichierIni.ReadSections(result);
  FichierIni.Free;
end;

//***************************************************************************************************
// Lister Toutes les cles d'une section du fichier .ini
function ListerClesSection(strSection, strFichier: string):TStringList;
var
  FichierIni : TIniFile;
begin
  result := TStringList.Create;
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  FichierIni.ReadSection(strSection,result);
  FichierIni.Free;
end;

//***************************************************************************************************
// Lister Toutes les cles d'une section du fichier .ini
function ListerValeurClesSection(strSection, strFichier: string):TStringList;
var
  FichierIni : TIniFile;
begin
  result := TStringList.Create;
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  FichierIni.ReadSectionValues(strSection,result);
  FichierIni.Free;
end;
//***************************************************************************************************
//  Effacer une cle
procedure EffacerSection(strSection,strFichier: string);
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  FichierIni.EraseSection(strSection);
  FichierIni.Free;
end;

//***************************************************************************************************
//  Effacer une cle
procedure EffacerCle(strSection,strCle, strFichier: string);
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  FichierIni.DeleteKey(strSection,strCle);
  FichierIni.Free;
end;

//***************************************************************************************************
// Contrôler si une section existe
function LaSectionExiste(strSection,strFichier:string): boolean;
var
  FichierIni : TIniFile;
begin
  if strFichier = '' then strFichier := strFileIni;
  FichierIni := TIniFile.Create (strFichier);
  Result := FichierIni.SectionExists(strSection);
  FichierIni.Free;
end;


end.
