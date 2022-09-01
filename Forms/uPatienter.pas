unit uPatienter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TPatienter = class(TForm)
    lblInfo: TLabel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure PatienterChargement(blnAction: boolean);
    destructor Destroy;
  end;
type
  TAnimationThread = class(TThread)
  private 
    { private declarations } 
    FWnd: HWND; 
    FPaintRect: TRect; 
    FbkColor, FfgColor: TColor; 
    FInterval: integer; 
  protected 
    procedure Execute; override;

  public
    constructor Create(paintsurface : TWinControl; {Control to paint on } 
      paintrect : TRect;          { area for animation bar }
      bkColor, barcolor : TColor; { colors to use }
      interval : integer);        { wait in msecs between paints}
  end;


var
  Patienter: TPatienter;
  fredAnim : TAnimationThread;

implementation

{$R *.dfm}


//******************************************************************************
// GESTION DE l' ANIMATION
//******************************************************************************

//******************************************************************************
// D�marrer l'attente
procedure TPatienter.FormCreate(Sender: TObject);
begin
  visible := true;
  lblInfo.Caption := 'Chargement en cours';
  PatienterChargement(true);
end;

//******************************************************************************
// Faire patienter pendant le chargement de l'application
procedure TPatienter.PatienterChargement(blnAction: boolean);
var
  r : TRect;

begin
  if blnAction then
    begin
      r := Panel3.ClientRect;
      InflateRect(r, - Panel3.BevelWidth, - Panel3.BevelWidth);
      visible := true;
    fredAnim := TAnimationThread.Create(Panel3, r, Panel3.color, clblue, 25);
      Application.ProcessMessages;
    end
  else
    begin
      fredAnim.Terminate;
      visible := false;
    end;
end;

//******************************************************************************
// Destructeur de la connexion
destructor TPatienter.Destroy;
begin
  PatienterChargement(false);
  Inherited Destroy;
end;

//******************************************************************************
// THREAD ANIMATION
//******************************************************************************

constructor TAnimationThread.Create(paintsurface : TWinControl;
  paintrect : TRect; bkColor, barcolor : TColor; interval : integer); 
begin 
  inherited Create(True); 
  FWnd := paintsurface.Handle; 
  FPaintRect := paintrect; 
  FbkColor := bkColor; 
  FfgColor := barColor; 
  FInterval := interval; 
  FreeOnterminate := True; 
  Resume; 
end; { TAnimationThread.Create }

procedure TAnimationThread.Execute;
var 
  image : TBitmap; 
  DC : HDC; 
  left, right : integer; 
  increment : integer; 
  imagerect : TRect;
  state : (incRight, incLeft, decLeft, decRight); 
begin 
  Image := TBitmap.Create; 
  try 
    with Image do  
    begin 
     // Width := FPaintRect.Right - FPaintRect.Left;
     // Height := FPaintRect.Bottom - FPaintRect.Top;
     // imagerect := Rect(0, 0, Width, Height);
    end; { with } 
    left := 0; 
    right := 0; 
    increment := imagerect.right div 50;
    state := Low(State); 
    while not Terminated do  
    begin 
      with Image.Canvas do  
      begin 
        Brush.Color := FbkColor; 
        FillRect(imagerect);
        case state of 
          incRight:  
          begin 
            Inc(right, increment); 
            if right > imagerect.right then
            begin 
              right := imagerect.right;
              Inc(state); 
            end; { if } 
          end; { case incRight }
          incLeft:
          begin 
            Inc(left, increment); 
            if left >= right then  
            begin 
              left := right; 
              Inc(state); 
            end; { if } 
          end; { case incLeft } 
          decLeft:  
          begin 
            Dec(left, increment); 
            if left <= 0 then  
            begin 
              left := 0; 
              Inc(state); 
            end; { if } 
          end; { case decLeft } 
          decRight:  
          begin 
            Dec(right, increment); 
            if right <= 0 then  
            begin 
              right := 0; 
              state := incRight; 
            end; { if } 
          end; { case decLeft } 
        end; { case } 
        Brush.Color := FfgColor; 
        FillRect(Rect(left, imagerect.top, right, imagerect.bottom)); 
      end; { with } 
      DC := GetDC(FWnd); 
      if DC <> 0 then 
        try 
          BitBlt(DC, 
            FPaintRect.Left, 
            FPaintRect.Top, 
            imagerect.right,
            imagerect.bottom,
            Image.Canvas.handle, 
            0, 0, 
            SRCCOPY); 
        finally 
          ReleaseDC(FWnd, DC); 
        end; 
      Sleep(FInterval); 
    end; { while } 
  finally 
    Image.Free; 
  end; 
  InvalidateRect(FWnd, nil, True); 
end; { TAnimationThread.Execute }

end.







//============================ HOW to USE IT ============================
{
 Usage:
 Place a TPanel on a form, size it as appropriate.Create an instance of the
 TanimationThread call like this:
procedure TForm1.Button1Click(Sender : TObject);
var
  ani : TAnimationThread;
  r : TRect;
begin
  r := Panel1.ClientRect;
  InflateRect(r, - Panel1.BevelWidth, - Panel1.BevelWidth);
  ani := TAnimationThread.Create(Panel1, r, Panel1.color, clBlue, 25);
  Button1.Enabled := False;
  Application.ProcessMessages;

  Sleep(30000);  // replace with query.Open or such

  Button1.Enabled := True;
  ani.Terminate;
  ShowMessage('Done');

end;

}


end.


