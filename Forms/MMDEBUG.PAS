{========================================================================}
{=                (c) 1995-97 SwiftSoft Ronald Dittrich                 =}
{========================================================================}
{=                          All Rights Reserved                         =}
{========================================================================}
{=  D 01099 Dresden             = Tel.: +0351-8012255                   =}
{=  Loewenstr.7a                = CIS : 100666,154, AOL: swiftsoft      =}
{========================================================================}
{=  Actual versions on http://members.aol.com/swiftsoft/mmtools.html    =}
{========================================================================}
{=  This code is for reference purposes only and may not be copied or   =}
{=  distributed in any format electronic or otherwise except one copy   =}
{=  for backup purposes.                                                =}
{=                                                                      =}
{=  No Delphi Component Kit or Component individually or in a collection=}
{=  subclassed or otherwise from the code in this unit, or associated   =}
{=  .pas, .dfm, .dcu, .asm or .obj files may be sold or distributed     =}
{=  without express permission from SwiftSoft.                          =}
{=                                                                      =}
{=  For more licence informations please refer to the associated        =}
{=  HelpFile.                                                           =}
{========================================================================}
unit MMDebug;

{$D-,L-}

interface

uses
{$IFDEF WIN32}
  Windows,
{$ELSE}
  WinTypes,
  WinProcs,
{$ENDIF}
  Messages,
  SysUtils,
  Variants;

function  DB_Open: Boolean;             { open the debug terminal     }
procedure DB_Clear;                     { clear the debug terminal    }
procedure DB_Close;                     { close the debug terminal    }

procedure DB_Level(Level: integer);     { set the general debug level }
procedure DB_Enable(Enable: Boolean);   { enable the debug output     }
procedure DB_Numerate(Enable: Boolean); { numerate messages or not    }

{ assertion: raise a exception and display string if condition False }
procedure DB_Assert(Condition: Boolean; const S: String);

{ some debug output functions }
procedure DB_Format(Level: integer; const Format: String; const Args: array of const);
procedure DB_FormatLn(Level: integer; const Format: string; const Args: array of const);
procedure DB_WriteBool(Level: integer; B: Boolean);
procedure DB_WriteBoolLn(Level: integer; B: Boolean);
procedure DB_WriteChar(Level: integer; C: Char);
procedure DB_WriteCharLn(Level: integer; C: Char);
procedure DB_WriteHex(Level: integer; L: LongInt);
procedure DB_WriteHexLn(Level: integer; L: LongInt);
procedure DB_WriteHexBuffer(Level: integer; const Buffer; BufLen: Cardinal);
procedure DB_WriteHexBufferLn(Level: integer; const Buffer; BufLen: Cardinal);
procedure DB_WriteInt(Level: integer; I: Longint);
procedure DB_WriteIntLn(Level: integer; I: Longint);
procedure DB_WriteLn;
procedure DB_WritePChar(Level: integer; Buf: PChar);
procedure DB_WritePCharLn(Level: integer; Buf: PChar);
procedure DB_WritePtr(Level: integer; P: Pointer);
procedure DB_WritePtrLn(Level: integer; P: Pointer);
procedure DB_WriteFloat(Level: integer; E: Extended);
procedure DB_WriteFloatLn(Level: integer; E: Extended);
procedure DB_WriteStr(Level: integer; Str: String);
procedure DB_WriteStrLn(Level: integer; Str: String);
{$IFDEF WIN32}
procedure DB_WriteVar(Level: integer; V: Variant);
procedure DB_WriteVarLn(Level: integer; V: Variant);
{$ENDIF}

implementation

var
   MM_CLOSE    : integer;
   MM_LOGGIT   : integer;
   MM_Clear    : integer;

   DBEnabled   : Boolean;
   DBLevel     : integer;
   DBNumerate  : Boolean;
   MsgNumber   : Longint;

{------------------------------------------------------------------------}
function DB_Open: Boolean;
var
   {$IFDEF WIN32}
   StartupInfo: TStartupInfo;
   ProcessInfo: TProcessInformation;
   {$ELSE}
   hAppInstance: THandle;
   {$ENDIF}

begin
   {$IFNDEF WIN32}
   Result := (WinExec('MMDEBUG.EXE', SW_NORMAL) >= HINSTANCE_ERROR);
   {$ELSE}
   FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
   with StartupInfo do
   begin
      cb := SizeOf(TStartupInfo);
      dwFlags := STARTF_USESHOWWINDOW;
      wShowWindow := SW_NORMAL;
   end;
   Result := CreateProcess(nil,'MMDEBUG.EXE',nil,nil,False,NORMAL_PRIORITY_CLASS,
                           nil,nil,StartupInfo,ProcessInfo);
   {$ENDIF}
end;

{------------------------------------------------------------------------}
procedure DB_CLose;
var
   Wnd: HWND;
begin
   Wnd := FindWindow('TDebugForm',nil);
   if (Wnd <> 0) then
      SendMessage(Wnd, MM_CLOSE, 0, 0);
end;

{------------------------------------------------------------------------}
procedure DB_Clear;
var
   Wnd: HWND;
begin
   Wnd := FindWindow('TDebugForm',nil);
   if (Wnd <> 0) then
      SendMessage(Wnd, MM_CLEAR, 0, 0);
   MsgNumber := 0;
end;

{------------------------------------------------------------------------}
procedure DB_Enable(Enable: Boolean);
begin
   DBEnabled := Enable;
end;

{------------------------------------------------------------------------}
procedure DB_Level(Level: integer);
begin
   if (Level < 0) then DBLevel := 0
   else DBLevel := Level;
end;

{------------------------------------------------------------------------}
procedure DB_Numerate(Enable: Boolean);
begin
   DBNumerate := Enable;
end;

{------------------------------------------------------------------------}
procedure Loggit(Level: integer; s: String; LF: Boolean);
var
   Buf: array[0..255] of Char;
   aAtom: TAtom;
   Wnd: HWND;
begin
   if DBEnabled and (Level <= DBLevel) then
   begin
      Wnd := FindWindow('TDebugForm',nil);
      if (Wnd <> 0) then
      begin
         if DBNumerate and (s <> ' ') then
         begin
            s := IntToStr(MsgNumber)+': '+s;
            inc(MsgNumber);
         end;
         if LF then s := s+#13#10;
         aAtom := GlobalAddAtom(StrPLCopy(Buf,s,sizeOf(Buf)-1));
         SendMessage(Wnd, MM_LOGGIT, aAtom, 0);
         GlobalDeleteAtom(aAtom);
      end;
   end;
end;

{$IFNDEF WIN32}
function ConvertAddr(Address: Pointer): Pointer; assembler;
{ Convert physical address to logical address }
asm
        MOV     AX,Address.Word[0]
        MOV     DX,Address.Word[2]
        MOV     CX,DX                   { Don't convert 0000:0000 }
        OR      CX,AX
        JE      @@1
        CMP     DX,0FFFFH               { Don't convert FFFF:xxxx }
        JE      @@1
        MOV     ES,DX
        MOV     DX,ES:Word[0]
@@1:
end;
{$ENDIF}

{------------------------------------------------------------------------}
procedure DB_Assert(Condition: Boolean; const S: String);
var
   Address: Pointer;
begin
   if not Condition then
   begin
      asm
         {$IFDEF WIN32}
         mov   eax, [ebp+04]
         dec   eax
         mov   [Address], eax
         {$ELSE}
         mov   ax, [bp+02]
         mov   word ptr [Address], ax
         mov   ax, [bp+04]
         mov   word ptr [Address+2], ax
         {$ENDIF}
      end;
      {$IFNDEF WIN32}
      Address := ConvertAddr(Address);
      {$ENDIF}
      raise Exception.CreateFmt('Assertion at address $%p'#10#13'%s', [Address,S]);
   end;
end;

{------------------------------------------------------------------------}
procedure DB_Format(Level: integer; const Format: String; const Args: array of const);
begin
   Loggit(Level,Sysutils.Format(Format,Args),False);
end;

{------------------------------------------------------------------------}
procedure DB_FormatLn(Level: integer; const Format: string; const Args: array of const);
begin
   Loggit(Level,Sysutils.Format(Format,Args),True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteBool(Level: integer; B: Boolean);
begin
   if B then
      Loggit(Level,'True',False)
   else
      Loggit(Level,'False',False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteBoolLn(Level: integer; B: Boolean);
begin
   if B then
      Loggit(Level,'True',True)
   else
      Loggit(Level,'False',True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteChar(Level: integer; C: Char);
begin
   Loggit(Level,C,False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteCharLn(Level: integer; C: Char);
begin
   Loggit(Level,C,True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteHex(Level: integer; L: LongInt);
begin
   Loggit(Level,Format('%.8x',[L]),False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteHexLn(Level: integer; L: LongInt);
begin
   Loggit(Level,Format('%.8x',[L]),True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteHexBuffer(Level: integer; const Buffer; BufLen: Cardinal);
var
   s: String;
   i: integer;
begin
   s := '';
   for i := 0 to BufLen-1 do s := s+Format('%.2x',[PByte(PChar(@Buffer)+i)^]);
   Loggit(Level,s,False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteHexBufferLn(Level: integer; const Buffer; BufLen: Cardinal);
var
   s: String;
   i: integer;
begin
   s := '';
   for i := 0 to BufLen-1 do s := s+Format('%.2x',[PByte(PChar(@Buffer)+i)^]);
   Loggit(Level,s,True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteInt(Level: integer; I: Longint);
begin
   Loggit(Level,IntToStr(I),False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteIntLn(Level: integer; I: Longint);
begin
   Loggit(Level,IntToStr(I),True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteLn;
begin
   Loggit(0,'',True);
end;

{------------------------------------------------------------------------}
procedure DB_WritePChar(Level: integer; Buf: PChar);
begin
   Loggit(Level,StrPas(Buf),False);
end;

{------------------------------------------------------------------------}
procedure DB_WritePCharLn(Level: integer; Buf: PChar);
begin
   Loggit(Level,StrPas(Buf),True);
end;

{------------------------------------------------------------------------}
procedure DB_WritePtr(Level: integer; P: Pointer);
begin
   Loggit(Level,Format('%p',[P]),False);
end;

{------------------------------------------------------------------------}
procedure DB_WritePtrLn(Level: integer; P: Pointer);
begin
   Loggit(Level,Format('%p',[P]),True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteFloat(Level: integer; E: Extended);
begin
   Loggit(Level,Format('%g',[E]),False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteFloatLn(Level: integer; E: Extended);
begin
   Loggit(Level,Format('%g',[E]),True);
end;

{------------------------------------------------------------------------}
procedure DB_WriteStr(Level: integer; Str: String);
begin
   Loggit(Level,Str,False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteStrLn(Level: integer; Str: String);
begin
   Loggit(Level,Str,True);
end;

{$IFDEF WIN32}
{------------------------------------------------------------------------}
procedure DB_WriteVar(Level: integer; V: Variant);
var
   vTyp: integer;
begin
   vTyp := VarType(V);
   if (vTyp = varBoolean) then
      DB_WriteBool(Level,VarAsType(V, varBoolean))
   else
      Loggit(Level,VarAsType(V, varString),False);
end;

{------------------------------------------------------------------------}
procedure DB_WriteVarLn(Level: integer; V: Variant);
var
   vTyp: integer;
begin
   vTyp := VarType(V);
   if vTyp = varBoolean then
      DB_WriteBoolLn(Level,VarAsType(V, varBoolean))
   else
      Loggit(Level,VarAsType(V, varString),True);
end;
{$ENDIF}

{------------------------------------------------------------------------}
initialization
  MM_CLOSE  := RegisterWindowMessage('MM_CLOSE');
  MM_LOGGIT := RegisterWindowMessage('MM_LOGGIT');
  MM_CLEAR  := RegisterWindowMessage('MM_CLEAR');
  DBEnabled := True;
  DBLevel   := 0;
  DBNumerate:= False;
  MsgNumber := 0;
end.

