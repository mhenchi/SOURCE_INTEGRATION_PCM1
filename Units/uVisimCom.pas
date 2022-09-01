unit uVisimCom;

{
********************************************************************************
  Auteur du projet : M'hammed DJAOUTI
  Service : Informatique de Production
  Octobre 2009:Simplification de l'unité, seule la fonction QComplete est gardée
********************************************************************************
}


interface

uses
  SysUtils,
  Classes,
  Dialogs,
  Forms,
  IdHTTP,
  IdHTTPHeaderInfo,
  IdMultipartFormData,
  uReadWriteIni, uGlobale;

  function ConfigurerVisim: boolean;
  procedure GenererFichierErreur(strNumSFC,strInfoErreur : string);
  function QuickComplete(strSFC,strOperation,strRessource: string; var MsgErr:string):boolean;
  function DeconnexionMonHttp: boolean;


implementation

var
  MonHttp : TIdHTTP;
  strHote,strHttpShopFloor : string;
  blnWriteFile : boolean;

//******************************************************************************
//Configuration de http au démarrage  //Parametre Log VISIM
function ConfigurerVisim: boolean;
begin
  MonHttp := TidHttp.Create(Application);
  try
    strHote := LitString(rVisim.strSite + '_VISIM','Host');
    strHttpShopFloor := LitString(rVisim.strSite + '_VISIM','HttpSF');
    blnWriteFile :=  LitBoolean(rVisim.strSite + '_VISIM','EtatWriteFile');
    result := true;
  except
    MonHttp.Free;
    result := false;
  end;
end;

//******************************************************************************
//Quick Start Complete unitaire
function QuickComplete(strSFC,strOperation,strRessource: string; var MsgErr:string):boolean;
type
  PlaChaine = ^String;

var
  Mess : TStringStream;
  Retour,strHost,header,strUrl: PlaChaine;

begin
   new(Retour);
   new(strHost);
   new(header);
   new(strUrl);

   MsgErr := '';
   Result := false;
   Mess := TStringStream.create('');
   strHost^ := strHote;
   strUrl^  := strHttpShopFloor;

 try
    try
      header^ := 'Host:' + strHost^ + ' Accept:www/source,text/html, video/mpeg, image/jpeg, image/x-tiff'
            + chr(13) + chr(10) + 'Content-type:application/x-www-form-urlencoded'
            + chr(13) + chr(10) + ' Accept: www/source, text/html, video/mpeg, image/jpeg, image/x-tiff';

      Mess.WriteString ('<PRODUCTION_REQUEST>');
      Mess.WriteString ('<COMPLETE>');
      Mess.WriteString ('<SFC_LIST>');

      Mess.WriteString ('<SFC>');
      Mess.WriteString ('<SITE>' + rVisim.strSite + '</SITE>');
      Mess.WriteString ('<ID>' +  strSFC + '</ID>');
      Mess.WriteString ('<RESOURCE>' + strRessource + '</RESOURCE>');
      Mess.WriteString ('<OPERATION>' + strOperation + '</OPERATION>');
      Mess.WriteString ('<USER>' + rVisim.strUser + '</USER>');
      Mess.WriteString ('<QUICK_COMPLETE>' + 'true' + '</QUICK_COMPLETE>');
      Mess.WriteString ('</SFC>');

      Mess.WriteString ('</SFC_LIST>');
      Mess.WriteString ('</COMPLETE>');
      Mess.WriteString ('</PRODUCTION_REQUEST>');


            with MonHttp do begin
                try
                  Request.ContentType :=  Header^;
                  Retour^ := PUT(strUrl^,Mess);

                  //Controler le msg de retour
                  if pos('ERROR',Retour^) = 0 then
	            Result := true
                  else
 		    begin
                      MsgErr := Retour^;
                      if blnWriteFile = true then GenererFichierErreur(strSFC,Retour^);
                    end                   

                     
                except
                  on E: Exception do
                    begin
                      MsgErr := 'Erreur VISIM : ' + E.Message;
                      if blnWriteFile = true then GenererFichierErreur(strSFC,MsgErr);
                    end;
                end;
            end;

    except
      on E: Exception do
        begin
          MsgErr := 'Erreur VISIM : ' + E.Message;
          if blnWriteFile = true then GenererFichierErreur(strSFC,MsgErr);
        end;
    end;
 finally
    dispose(Retour);
    dispose(strHost);
    dispose(header);
    dispose(strurl);
    mess.Free;
 end;
end;


//******************************************************************************
//Ecriture des erreurs de communication  le fichier d'erreur
procedure GenererFichierErreur(strNumSFC,strInfoErreur : string);
var
 strFilename : textFile;
 strNomFichier,strRepertoire  : string;

begin
  strRepertoire := '..\ErrVisim';
  if not DirectoryExists(strRepertoire) then  CreateDir(strRepertoire);
  strNomFichier := strRepertoire +'\'+ strNumSFC + '.txt';

  Assignfile(strFilename,strNomFichier);

    try
      Rewrite(strFilename);
      Write(strFilename,strInfoErreur);
    finally
      Close(strFilename);
    end;
end;

//******************************************************************************
//Vidage mémoire de la connexion HTTP
function DeconnexionMonHttp: boolean;
begin
  if Assigned(MonHttp)then MonHttp.Free;
end;

end.


