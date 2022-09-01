unit uPortCom;

interface

uses
  Windows, SysUtils, Classes, CPort, Forms, StrUtils, Dialogs,
  AfComPort, AfDataDispatcher;

type
  TmlePortCOM = class(TDataModule)
    ComPort1: TComPort;
    ComPort: TAfComPort;
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);

  private

  public
    function ParametragePortCom: boolean;
    function InPut1: boolean;
    function InPut2: boolean;
    function InPut3: boolean;
    function InPut4: boolean;
    function InPut5: boolean;
    procedure OutPut1(Status: boolean);
    procedure OutPut2(Status: boolean);

    procedure DeconnexionPortCom;
    procedure ViderBufferPortCom1;

  end;

var
  mlePortCOM: TmlePortCOM;



implementation

{$R *.dfm}

uses
  uGlobale, uReadWriteIni, uPrincipale, uSmema_Carte;


//******************************************************************************
// Paramétrage des ports Coms
function TmlePortCOM.ParametragePortCom: boolean;
var
  strCom        : string;
  intPortSmema  : integer;
begin
  result := true;
  try
    strCom := 'PORTCOM_A';
    with ComPort1 do
      begin
        Port            := 'COM' + LitString(strCom,'Port');
        BaudRate        := StrToBaudRate(LitString(strCom,'BaudRate'));
        DataBits        := StrToDataBits(LitString(strCom,'DataBit'));
        StopBits        := StrToStopBits(LitString(strCom,'StopBit'));
        Parity.Bits     := StrToParity(LitString(strCom,'Parite'));
        Connected       := LitBoolean(strCom,'Actif');
      end;

    //Définir la Com à Activer pour le module communication SMEMA
    strCom := 'PORTCOM_B';  //(afComport)
    blnDIO_USB := LitBoolean(strCom,'USB_SMEMA');

    if blnDIO_USB then
      begin
        // N° de port à activer
        intPortSmema := LitInteger(strCom,'PORT_SMEMA');
        // Activation du port com Virtuel pour l'utilisation de la DIO SMEMA
        if not SMEMA_Open(intPortSmema) then
          begin
            MessageBoxA(0,Pchar('ERREUR LORS DE L''OUVERTURE DU SMEMA !'+#13+'  '),
                      Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
            exit;
          end;
      end
    else
      begin
        with ComPort do
          begin
            ComNumber       := LitInteger(strCom,'Port');
            UserBaudRate    := LitInteger(strCom,'BaudRate');
            //DataBits        :=  StrToafDataBits(LitString(strCom,'DataBit'));
            //StopBits        := (LitString(strCom,'StopBit'));
            //Parity.Bits     := StrToParity(LitString(strCom,'Parite'));

            // Ouverture du port de communication avec l'automate
            if LitBoolean(strCom,'Actif') then
              begin
                DTR := false;
                RTS := false;
                Open;
              end;

          end;
      end;


  except
    on E: Exception do
      begin
        MessageBoxA(0,Pchar('ERREUR AU NIVEAU DE LA CONFIGURATION DU PORT COM !'+#13+ '('+ E.Message  +')' +#13+'  '),
                      Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
        DeconnexionPortCom;
        result := false;
      end;
  end;
end;

//******************************************************************************
// Reception des datas sur le port com1 Lecture du buffer d'entrée du port série
procedure TmlePortCOM.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  strRead, strLeBuffer: String;

begin
  if not blnEtatLecteurCB then
    begin
      ViderBufferPortCom1;
    end
  else
    begin
      strLeBuffer :='';
      strRead :='';
      repeat
        ComPort1.ReadStr(strRead,1);
        strLeBuffer := strLeBuffer + strRead;
        Application.ProcessMessages;
      until RightStr(strLeBuffer,2) = #13+#10;

        ComPort1.ClearBuffer(True, True);
        // Retirer #13+#10 de la lecture
        strLeBuffer := LeftStr(strLeBuffer,Length(strLeBuffer)- 2) ;

        // Data vers la fiche principale
        frmMain.DataDuPortCom(strLeBuffer)
    end;
end;

//******************************************************************************
// Vide le buffer du port com1
procedure TmlePortCOM.ViderBufferPortCom1;
begin
  mlePortCOM.ComPort1.ClearBuffer(True, false);
end;

//******************************************************************************
//
function TmlePortCOM.InPut1: boolean;
begin
  if blnDIO_USB then
    Result := SMEMA_In(0)
  else
    Result := Comport.RING;
end;

//******************************************************************************
//
function TmlePortCOM.InPut2: boolean;
begin
  if blnDIO_USB then
    Result := SMEMA_In(1)
  else
    Result := Comport.CTS ;
end;

//******************************************************************************
//
function TmlePortCOM.InPut3: boolean;
begin
  if blnDIO_USB then
    Result := SMEMA_In(2)
  else
   Result := Comport.DSR;
end;

//******************************************************************************
//
function TmlePortCOM.InPut4: boolean;
begin
  if blnDIO_USB then
    Result := SMEMA_In(3)
  else
    Result := Comport.RLSD;
end;

//******************************************************************************
//
function TmlePortCOM.InPut5: boolean;
begin
  if blnDIO_USB then
    Result := SMEMA_In(4)
  else
    Result := Comport.RLSD;
end;

//******************************************************************************
//
procedure TmlePortCOM.OutPut1(Status: boolean);
begin
  if blnDIO_USB then
    SMEMA_Out (0,Status)
  else
    Comport.DTR := Status;
end;

//******************************************************************************
//
procedure TmlePortCOM.OutPut2(Status: boolean);
begin
  if blnDIO_USB then
    SMEMA_Out (1,Status)
  else
    Comport.RTS := Status;
end;

//******************************************************************************
// Déconnexion du ou des ports Coms
procedure TmlePortCOM.DeconnexionPortCom;
begin
  ComPort1.Close;
  if blnDIO_USB then
    SMEMA_Close
  else
    Comport.Close;
end;


end.
