unit u1PortCom;

interface

uses
  Windows, SysUtils, Classes, CPort, Forms, StrUtils, Dialogs,
  AfComPort, AfDataDispatcher;


type
    TmlePortCOM = class(TDataModule)
    ComPort: TAfComPort;
    ComPort1: TAfComPort;
    //procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure DataModuleDestroy(Sender: TObject);
    
  private
    function ParametragePortCom(APort: TComport; strCom: string): boolean;

  public
    function ConnectLECTEUR: boolean;
  //  function ConnectAUTOMATE: boolean;
    function ConnectLECTEURReimp: boolean;
  end;

var
  mlePortCOM: TmlePortCOM;



implementation

{$R *.dfm}

uses
  uReadWriteIni, uGlobale, uPrincipale, uSmema_Carte, MMDebug;

//******************************************************************************
// Connexion du lecteur port com   // PORT_COM_A
function TmlePortCOM.ConnectLECTEUR: boolean;
var
  portCom: integer;
begin
  if LitBoolean('PORT_COM_A','Activer') then
    begin
      with Comport1 do
        begin
          Close;
          ComNumber    := rLecteurCom.NumPort;
          UserBaudRate := rLecteurCom.BaudRate;
          case rLecteurCom.Databit of
            8: DataBits := db8;
            7: DataBits := db7;
          end;

          case rLecteurCom.Parite of
            'N' : Parity := paNone;
            'O' : Parity := paOdd;
            'E' : Parity := paEven;
            // 'M': 'S':
          end;

          case rLecteurCom.StopBit of
            1 : Stopbits := sbOne;
            2 : Stopbits := sbTwo;
          end;

            try
              Open;
            except
              begin
                result := false;
                MessageBoxA(0,Pchar('ERREUR LORS DE L''OUVERTURE DU PORT lECTEUR FIXE COM ' +  IntToStr(ComNumber) +#13+'  '),
                        Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
                exit;
              end;
            end;
        end;
    end;
  result := true;
end;


//******************************************************************************
// Connexion du lecteur port com REIMP  // PORT_COM_B
function TmlePortCOM.ConnectLECTEURReimp: boolean;
var
  portCom: integer;
begin
  if LitBoolean('PORT_COM_B','Activer') then
    begin
      with Comport do
        begin
          Close;
          ComNumber    := rLecteurComReimp.NumPort;
          UserBaudRate := rLecteurComReimp.BaudRate;
          case rLecteurCom.Databit of
            8: DataBits := db8;
            7: DataBits := db7;
          end;

          case rLecteurComReimp.Parite of
            'N' : Parity := paNone;
            'O' : Parity := paOdd;
            'E' : Parity := paEven;
            // 'M': 'S':
          end;

          case rLecteurComReimp.StopBit of
            1 : Stopbits := sbOne;
            2 : Stopbits := sbTwo;
          end;

            try
              Open;
            except
              begin
                result := false;
                MessageBoxA(0,Pchar('ERREUR LORS DE L''OUVERTURE DU PORT LECTEUR REIMP COM ' +  IntToStr(ComNumber) +#13+'  '),
                        Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
                exit;
              end;
            end;
        end;
    end;
  result := true;
end;

//******************************************************************************
// Paramétrage des ports Coms
function TmlePortCOM.ParametragePortCom(APort: TComport; strCom: string): boolean;
begin
  result := true;
  try
    with APort do
      begin
        Port            := 'COM' + LitString(strCom,'Port');
        BaudRate        := StrToBaudRate(LitString(strCom,'BaudRate'));
        DataBits        := StrToDataBits(LitString(strCom,'DataBit'));
        StopBits        := StrToStopBits(LitString(strCom,'StopBit'));
        Parity.Bits     := StrToParity(LitString(strCom,'Parite'));
        Connected       := True;
      end;
      except
      on E: Exception do
      begin
        MessageBoxA(0,Pchar('ERREUR AU NIVEAU DE LA CONFIGURATION DU : " '+ strCom  + ' "  ' +#13+ '('+ E.Message  +')' +#13+'  '),
                      Pchar('  ARRET DE L''APPLICATION'),0 + MB_ICONEXCLAMATION + 0);
        result := false;
      end;
  end;
end;

{
//******************************************************************************
// Reception des datas sur le port com1 Lecture du buffer d'entrée du port série
procedure TmlePortCOM.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  strRead, strLeBuffer: String;

begin
  // Si la lecture de code barre n'est pas autorisé vider le buffer sinon le lire
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

        FMain.DataDuPortCom(strLeBuffer)


    end;
end;

}


procedure TmlePortCOM.DataModuleDestroy(Sender: TObject);
begin
  // ComPort1.Close;
end;



end.
