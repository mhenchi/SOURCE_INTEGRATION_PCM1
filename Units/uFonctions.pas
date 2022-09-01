unit uFonctions;

interface

uses
  Windows, Classes, Forms, SysUtils, StrUtils, Printers, uReadWriteIni, uGlobale;
  
  function VersionIni: string;
  function UserName: string;
  function ComputerName: string;
  function NomData1(strDataProduit : string):string;
  function NomData2(strDataProduit : string):string;
  function ExtractionData(strChaine:string ; strLimite:string) : string;
  function IndexImprimante(strNomPrinter: string):integer;
  function HauteurBarreDeTache : integer ;
  function ExtractionString(strChaine:string ; strLimite:string) : string;
  function IntToBoolean(i: Integer): Boolean;
  function BoolToInteger(b: Boolean): Integer;
  procedure ReadPositionForm(strSection: string;frmFiche: TForm);
  procedure WritePositionForm(strSection: string;frmFiche: TForm);
  function SeptDernierDigits(NumSerie: string):string;
  function CreatePath(strPath: string): boolean;
  function LogLine(const FileLog, AMessage: string): boolean;
  
implementation


//******************************************************************************
// Lire Position Fiche (Top et Left)
procedure ReadPositionForm(strSection: string;frmFiche: TForm);
begin
  if LaSectionExiste(strSection) then
    begin
      if LitInteger(strSection,'Top') <> 8888 then frmFiche.Top   := LitInteger(strSection,'Top');
      if LitInteger(strSection,'Left')<> 8888 then frmFiche.Left  := LitInteger(strSection,'Left');
      if LitInteger(strSection,'Height') <> 8888 then frmFiche.Height:= LitInteger(strSection,'Height');
      if LitInteger(strSection,'Width') <> 8888 then frmFiche.Width := LitInteger(strSection,'Width');
    end;
  
end;

//******************************************************************************
// Ecrire Position Fiche (Top et Left)  (La section portera le nom de la Form)
procedure WritePositionForm(strSection: string;frmFiche: TForm);
begin
  EcritInteger(strSection,'Top',frmFiche.Top);
  EcritInteger(strSection,'Left',frmFiche.Left);
  EcritInteger(strSection,'Height',frmFiche.Height);
  EcritInteger(strSection,'Width',frmFiche.Width);
end;


//******************************************************************************
//Voir la version du fichier .ini sans la lettre L
function VersionIni: string;
begin
  result := MidStr(LitString('APROPOS','LVersionExe'),2,15);
end;

//******************************************************************************
// Debut d'une liste de deux datas separe par une virgule   : data1,data2
function NomData1(strDataProduit : string):string;
begin
  result := Trim(MidStr(strDataProduit,1,Length(MidSTR(strDataProduit,1,(pos(',',strDataProduit)-1)))));
end;

//******************************************************************************
// Fin d'une liste de deux datas separe par une virgule   : data1,data2
function NomData2(strDataProduit : string) :string;
begin
  result := Trim(RightStr(strDataProduit,Length(strDataProduit)- pos(',',strDataProduit)));
end;

//***************************************************************************************************
// Extraction de donnée dans une chaine pour récupérer le code index ou autre type d'info
function ExtractionData(strChaine:string ; strLimite:string) : string;
var
 strTemp : string;
 intDebut,intFin,intRight,intLeft : Byte;
begin
  result := '';
  intDebut := 0;
  intFin := 0;
  intRight := 0;
  intLeft := 0;


   //Utilisation de MID
   begin
      if pos('M',strLimite) = 1 then
       begin
        //Chiffre du debut
        strTemp := (MidStr(strLimite,2,Length(MidSTR(strLimite,1,(pos(',',strLimite)-2)))));
        intdebut:= StrToInt(strTemp);
        //Chiffre de fin
        strTemp := RightStr(strLimite,Length(strLimite)- pos(',',strLimite));
        intFin := StrToInt(strTemp);

        result := MidStr(strChaine,intdebut,intFin);
        exit;
        //showmessage(result);
       end;
   end;

         //Utilisation de Right
         begin
            if pos('R',strLimite) = 1 then
             begin
              strTemp := RightStr(strLimite,Length(strLimite)- 1);
              intRight := StrToInt(strTemp);

              result := RightStr(strChaine,intRight);
              //showmessage(result);
              exit;
             end;
         end;


    //Utilisation de Left
    begin
      if pos('L',strLimite) = 1 then
       begin
        strTemp := RightStr(strLimite,Length(strLimite)- 1);
        intLeft := StrToInt(strTemp);

        result := LeftStr(strChaine,intLeft);
        exit;
       end;
    end;

end;

//******************************************************************************
// Nom de l'utilisateur connecté
function UserName: string;
var 
  buffer: array[0..80] of Char; 
  len: DWORD;
begin 
  len := Sizeof(buffer);
  GetUsername(buffer, len); 
  Result := buffer; 
end; 

//******************************************************************************
// nom de l'ordinateur
function ComputerName: string;
var
  lpBuffer: array[0..MAX_COMPUTERNAME_LENGTH] of char;
  nSize: dword;
begin
  nSize:= Length(lpBuffer);
  if GetComputerName(lpBuffer, nSize) then
    result:= lpBuffer
  else
    result:= '';
end;


//******************************************************************************
// Definir l'index de l'imprimante à partir du nom,  888 = Imprimante non trouvé
function IndexImprimante(strNomPrinter: string):integer;
var
  lstPrinter: TStringList;
  intIndex: integer;

begin
  result := -1;
  lstPrinter := TStringList.Create;
  lstPrinter.AddStrings(Printer.Printers);
  try
    for intIndex := 0 to lstPrinter.Count -1 do
      begin
        if strNomPrinter = (lstPrinter.Strings[intIndex]) then
          begin
            result := intIndex;
            break;
          end;;
      end;
  finally
    lstPrinter.Free;
  end;

end;

//******************************************************************************
//Récupérer la hauteur de la barre de taches
function HauteurBarreDeTache : integer ;
var
  hBarreDeTache : HWND  ;
  R             : TRect ;
begin
  Result := -1 ;
  // Recherche de la fenêtre dont le nom de classe est "Shell_TrayWnd"
  //  c'est à dire la barre des tâches.
  hBarreDeTache := FindWindow( 'Shell_TrayWnd', '' ) ;
  // Vérification que le handle est valide
  if ( hBarreDeTache <> 0 ) then
  begin
    // Récupération du rectangle représentant la totalité de la barre des tâches
    GetWindowRect( hBarreDeTache, R ) ;
    // Bottom - Top car le 0 se trouve en haut de l'écran
    Result := R.Bottom - R.Top;
  end ;
end ;

//******************************************************************************
// Extraction de donnée dans une chaine pour récupérer le code index ou autre type d'info
function ExtractionString(strChaine:string ; strLimite:string) : string;
var
 strTemp : string;
 intDebut,intFin,intRight, intLeft : Byte;
begin
  result := '';
  intDebut := 0;
  intFin := 0;
  intRight := 0;
  intLeft := 0;

   //Utilisation de MID
   begin
      if pos('M',strLimite) = 1 then
       begin
        //Chiffre du debut
        strTemp := (MidStr(strLimite,2,Length(MidSTR(strLimite,1,(pos(',',strLimite)-2)))));
        intdebut:= StrToInt(strTemp);
        //Chiffre de fin
        strTemp := RightStr(strLimite,Length(strLimite)- pos(',',strLimite));
        intFin := StrToInt(strTemp);

        result := MidStr(strChaine,intdebut,intFin);
        exit;
        //showmessage(result);
       end;
   end;

         //Utilisation de Right
         begin
            if pos('R',strLimite) = 1 then
             begin
              strTemp := RightStr(strLimite,Length(strLimite)- 1);
              intRight := StrToInt(strTemp);

              result := RightStr(strChaine,intRight);
              //showmessage(result);
              exit;
             end;
         end;


    //Utilisation de Left
    begin
      if pos('L',strLimite) = 1 then
       begin
        strTemp := RightStr(strLimite,Length(strLimite)- 1);
        intLeft := StrToInt(strTemp);

        result := LeftStr(strChaine,intLeft);
        exit;
       end;
    end;

end;

//******************************************************************************
// Convertir un integer en boolean
function IntToBoolean(i: Integer): Boolean;
begin
  Result := i <> 0;
end;
// Convertir un boolean en integer
function BoolToInteger(b: Boolean): Integer;
begin
  if b then Result := 1 else Result := 0;
end;
//******************************************************************************



//******************************************************************************
// Retourne le n° de série d'un SFC visim(7 derniers digits) ou de la codification Actia(Digits aprés la derniere '/') 
function SeptDernierDigits(NumSerie: string):string;
var
  i         : integer;
  blnBarre, blnW : boolean;

begin
  result := '';
  blnW     := (Pos('W',NumSerie) > 0);
  blnBarre := (Pos('/',NumSerie) > 0);

  // SFC Visim avec ou sans le 9 devant sans W et /
  if ((length(NumSerie)= 14) or (length(NumSerie)= 15))and (not blnBarre) and (not blnW) then
    begin
      result := RightStr(NumSerie,7);
      exit;
    end;

  // N° de série ACTIA de plus de 15 digits avec un 'W' et deux '/' le n° de série peut faire plus ou moins de 7 digits
  if (length(NumSerie)> 15) and (blnBarre) and (blnW) then
    begin
      for i := Length(NumSerie) downto 1  do
          if (NumSerie[i] <> '/') then
            Result := NumSerie[i]+ Result
          else break;
    end;

  //if result = '' then
  // MessageBoxA(0,Pchar('ERREUR rencontré lors de la recherche des derniers digits du n° de série : " ' + NumSerie + ' "'+#13+'  '),
  //                  Pchar('Création nouveau n° de série'),0 + MB_ICONEXCLAMATION + 0);
end;

// Vérifier l'initialisation du chemin d'un répertoire
function CreatePath(strPath: string): boolean;
begin
  result := true;
  if not ForceDirectories(strPath) then result := false;
end;


//******************************************************************************
// Enregistrer dans un fichier texte
function LogLine(const FileLog, AMessage: string): boolean;
var
  F: TextFile;
begin
  result := false;
  AssignFile(F, FileLog);

  if FileExists(FileLog) then
    Append(F)
  else
    Rewrite(F);

  try
    WriteLn(F, Format('%s: %s', [DateTimeToStr(Now), AMessage]));
  finally
    CloseFile(F);
    result := true;
  end;
end;


end.


