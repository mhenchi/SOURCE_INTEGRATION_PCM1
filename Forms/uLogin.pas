unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;


type
    TLoginForm = class(TForm)
    LogInButton: TButton;
    pwdLabel: TLabel;
    passwordEdit: TEdit;
    MainMenu1: TMainMenu;
    Annuler1: TMenuItem;
    procedure LogInButtonClick(Sender: TObject);
    procedure passwordEditKeyPress(Sender: TObject; var Key: Char);
    procedure Annuler1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  
  private

  public
    class function Execute : boolean;

  end;

  


implementation

{$R *.dfm}
uses
  uGlobale, uPrincipale;

//******************************************************************************
//                        GESTION DU MOT DE PASSE
//******************************************************************************



procedure TLoginForm.FormPaint(Sender: TObject);
begin
  top := FMain.Top + 10;
  left:= FMain.Left+ 10;
end;


//******************************************************************************
// Valider pour autorisation reimpression
procedure TLoginForm.LogInButtonClick(Sender: TObject);
begin
  if (passwordEdit.Text = rPrint.pwdReprint) and (passwordEdit.Text <> '') then
    ModalResult := mrOK
  else
    ModalResult := mrAbort;
end;
procedure TLoginForm.passwordEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then LogInButtonClick(nil);
end;

//******************************************************************************
// Afficher la form
class function TLoginForm.Execute: boolean;
begin
  with TLoginForm.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;


//******************************************************************************
// Annuler
procedure TLoginForm.Annuler1Click(Sender: TObject);
begin
  ModalResult := mrAbort;
end;

end.


