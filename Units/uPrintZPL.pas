unit uPrintZPL;

interface


uses
  Windows, Classes, SysUtils, DateUtils, StrUtils, uGlobale, Printers,
  uPrincipale, uReadWriteIni, Dialogs;


  function ConstruireEtiquetteProduit: boolean;
  function LireFileLabelZPL(strZplSource: string): TStringStream;
  function ImprimerFichierZPL(strNomFileZPL : string): boolean;
  function InitialiseDataZPL: boolean;
  function YearWWeek: string;

implementation

var
  MemoSemaine : integer;
  MemoCompteur: integer;

//*********************************************************************************************************************************************
// Annee + W + Semaine
function YearWWeek: string;
begin

  if (MonthOfTheYear(Now)= 12) and ((format('%.2d',[WeekOfTheYear(Now)])) = '01') then
      begin
       result := FormatDateTime('yy',IncYear(Now, 1)) +    format('%.2d',[WeekOfTheYear(Now)]);   //IntToStr(WeekOf(Now));
       end
        else if  (MonthOfTheYear(Now)= 1) and (((format('%.2d',[WeekOfTheYear(Now)])) = '53') or((format('%.2d',[WeekOfTheYear(Now)])) = '52')) then
            begin
              result := FormatDateTime('yy',IncYear(Now, -1)) +    format('%.2d',[WeekOfTheYear(Now)]);
            end

         else
             begin
               result := FormatDateTime('yy',Now )+    format('%.2d',[WeekOfTheYear(Now)]);

       end ;

end;


//****************************************************************************** ****************************************************************
// // D�finir le r�pertoire Annuel/mensuel de sauvegarde s'il n'existe pas  + le nom du fichier � imprimer
function MakeDirSaveLabel: boolean;
var
  Sep : string;
  Tmp, TmpNameFile : string;
begin
  result := false;
  Sep := '\';
  Tmp := Sep + FormatDateTime('yyyy',Now) + Sep + 'POSTE_'+ IntToStr(intIdPoste) + Sep + FormatDateTime('mmmm',Now)+ Sep;
  rPrint.PathNameFichierZPL := rPrint.DirSavePrint + Tmp;

  // V�rifier l'initialisation du chemin de sauvegarde du fichier ZPL
  if not ForceDirectories(rPrint.PathNameFichierZPL) then
    begin
      result := false;
      //fMain.lblInfoColor('ECHEC � la cr�ation du r�pertoire :' + rPrint.DirSavePrint + ',R');
      exit;
    end;

  // D�finir le nom et le chemin complet du fichier
  with rPrint do
    begin
      TmpNameFile := AnsiReplaceText(rProduit.SfcProduitFini,'/','_');   // Remplacer le '/' par '_' s'ils sont pr�sent dans le nom du fichier
      PathNameFichierZPL := PathNameFichierZPL + TmpNameFile + '.zpl';
    end;

  result := true;
end;

//******************  ************************************************************
// Lire le fichier source ZPL de l'�tiquette
function LireFileLabelZPL(strZplSource: string): TStringStream;
var
  strStreamZPL : TStringStream;
  strFileZPL   : TextFile;
  strLaLigne   : string;
begin
   strStreamZPL := TStringStream.create('');
   result := strStreamZPL;
   Assignfile(strFileZPL, strZplSource);
   try
     Reset(strFileZPL);
     // Se Positionner au d�but des donn�es ZPL
     Repeat
      ReadLn(strFileZPL,strLaLigne)
     Until pos('[CODE_ZPL]',strLaLigne) >= 1;

     // Lire les donn�es ZPL
     While Not EOF(strFileZPL) do begin

         begin
           ReadLn(strFileZPL,strLaLigne);
           if strLaLigne <> '' then strStreamZPL.WriteString(strLaLigne +chr(13)+ chr(10));
         end;
     end;
     result := strStreamZPL;

  finally
   CloseFile(strFileZPL);
  end;

end;

//******************************************************************************
//Construction du fichier ZPl par remplacement des variables
function ReplaceVariableFileZPL(strZPL : string): string;
begin
  with rProduit do
    begin
      strZPL := AnsiReplaceText(strZPL,'ReferenceClient',reference_client);
      strZPL := AnsiReplaceText(strZPL,'Designation',Designation2);
      strZPL := AnsiReplaceText(strZPL,'NumeroSerie',SfcProduitFini);
      strZPL := AnsiReplaceText(strZPL,'DateCodeClient', rPrint.Code_client );
      strZPL := AnsiReplaceText(strZPL,'CodeActia',CodeActia );
     // strZPL := AnsiReplaceText(strZPL,'VersionHardware',V_HW );
     // strZPL := AnsiReplaceText(strZPL,'VersionBootLoader',V_BL );



    end;
  result := strZPL;
end;

//***************************************************************************************************
// Sauver le fichier Zpl bon pour impression
procedure SavePrintFileZPL(strData, strDirFile: string);
var
 strFilename : textFile;

begin
  Assignfile(strFilename,strDirFile);
  try
    Rewrite(strFilename);
    Writeln(strFilename,strData);
  finally
    Close(strFilename);
  end;
end;


{
  D�finir le nom du fichier et le chemin de la sauvegarde
  Construire le date code client
  Charger le fichier Source ZPL.
  Renseigner les variables du fichier source
  Sauvegarder le fichier Zpl du produit en cours
}

//******************************************************************************
// Pr�parer le fichier ZPL pr�t � �tre imprim�
function ConstruireEtiquetteProduit: boolean;
var
  FileTempZpl: string;

begin
  result := false;

  // Cr�er le r�pertoire de sauvegarde des labels imprim�s
  if not MakeDirSaveLabel then
    begin
      MessageBoxA(0,Pchar('ECHEC � la cr�ation du r�pertoire :' + rPrint.PathNameFichierZPL +#13+'  '),
                        Pchar('Cr�ation r�pertoire'),0 + MB_ICONEXCLAMATION + 0);
      exit;
    end;

  with rPrint do
    begin

      try
        // Charger le fichier source Zpl  >> Action execut� au d�marrage lors de la s�lection du produit
        //FileTempZpl := LireFileLabelZPL(rProduit.SourceZPL).DataString;

        //Remplacer les variables du fichier source ZPL par less valeurs du produit en cours
        FileTempZpl := ReplaceVariableFileZPL(DataFileSourceZPL);   // rPrint.DataFileSourceZpl

        //Ecrire le Fichier Zpl sur le disque
        SavePrintFileZPL(FileTempZpl, PathNameFichierZPL);

        result := true;

      except
        on E: Exception do
          begin
            MessageBoxA(0,Pchar('ECHEC lors de la cr�ation de l''�tiquette :' + rPrint.PathNameFichierZPL +#13+'  '),
                        Pchar('Cr�ation �tiquette'),0 + MB_ICONEXCLAMATION + 0);
          end;
      end;
    end;  

end;

//******************************************************************************
// Module d'impression des fichiers ZPL  sur l'imprimante active
function ImprimerFichierZPL(strNomFileZPL : string): boolean;
var                                                                                         
 strLigne       : string;
 strFile        : TextFile;
 strFileToPrint : TextFile;

begin
  result := false;

  // Imprimante s�lectionn�
  Printer.PrinterIndex := rPrint.IndexPrinter;

  AssignPrn(strFileToPrint);
  Rewrite(strFileToPrint);

   AssignFile(strFile,strNomFileZPL);
    try
      try
        Reset(strFile);
        While not EOF(strFile)Do
          begin
            Readln(strFile,strLigne);
            Writeln(strFileToPrint,strLigne);
          end;
         result := true;
      except
        result := false;
        //fMain.lblInfoColor('ERREUR: Probl�me rencontr� lors de l''impression de l''�tiquette ,R');
      end;
    finally
     CloseFile(strFile);
     CloseFile(strFileToPrint);
    end;

end;



//******************************************************************************
// Effacer le fichier Zpl Pr�par� suite � une erreur
function DeleteFileZpl(strDelFile: string): boolean;
begin
  if FileExists(strDelFile) then
    begin
      result := DeleteFile(strDelFile);
      if not result then
        //fMain.lblInfoColor('ERREUR: Probl�me rencontr� lors de l''effacement du fichier ZPL,R');
    end;

end;

//******************************************************************************
// Effacer le fichier ZPl et remettre le compteur � -1 suite � une erreur
function InitialiseDataZPL: boolean;
begin
  result := DeleteFileZpl(rPrint.PathNameFichierZPL); // and RestaurerWeekCompteur;
end;



end.
