unit mRecon;

{
  Monster Speech 1.1.0
  written by Chen Yu (monster)

  E-Mail: mftp@21cn.com   ICQ UIN: 6740755
  Homepage: http://homepages.msn.com/RedmondAve/mftp/

  Suggestions and bug reports are warm welcomed.

  This file used a Delphi translation of Speech API from
  Project JEDI, and full package of this translation can
  be found on JEDI's web page: http://www.delphi-jedi.org/
}

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ComObj, ActiveX, Speech;

{$include mspeech.msg}

type
   EMRecognitionException = class(Exception);

   TMRecognition = class(TComponent)
   private
      FEngines:                TStrings;
      FEngineStarted:          Boolean;
      FIAMD:                   IAudioMultimediaDevice;
      FIEnumSRShare:           IEnumSRShare;
      FInit:                   Boolean;
      FISRCentral:             ISRCentral;
      FISREnum:                ISREnum;
      FVersion, DummyS:        String;
      PModeInfo:               PSRModeInfo;

      procedure Init;
      procedure BeforeSelectEngine;
      procedure PostSelectEngine;
   protected
   public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure SelectEngine(EngineName: String); overload;
      procedure SelectEngine(EngineMode: SRModeInfo); overload;

      property Engines: TStrings read FEngines;
   published
      property Version: String read FVersion write DummyS;
   end;

implementation

{ TMRecognition: implementation of DirectSpeechRecognition }

{ construction/deconstruction }

constructor TMRecognition.Create(AOwner: TComponent);
begin
   inherited;

   FEngines := TStringList.Create;

   FVersion := 'Monster Speech 1.1.0';

   Init;
end;

destructor TMRecognition.Destroy;
begin
   FInit := False;
   FEngines.Free;

   if Assigned(PModeInfo) then Dispose(PModeInfo);

   inherited;
end;

procedure TMRecognition.Init;
var ModeInfo: SRModeInfo;
    EngineCount: Integer;
begin
   FInit := True;
   FEngineStarted := False;

   try
      { Enumerate engines }
      OleCheck(CoCreateInstance(CLSID_SREnumerator, Nil, CLSCTX_ALL, IID_ISREnum, FISREnum));
      OleCheck(CoCreateInstance(CLSID_SRShare, Nil, CLSCTX_ALL, IID_IEnumSRShare, FIEnumSRShare));
      OleCheck(FISREnum.Reset);
      OleCheck(FISREnum.Next(1, ModeInfo, @EngineCount));

      while EngineCount > 0 do
      begin
         FEngines.Add(String(ModeInfo.szModeName));
         OleCheck(FISREnum.Next(1, ModeInfo, @EngineCount));
      end;
   except
      FInit := False;
   end;
end;

procedure TMRecognition.BeforeSelectEngine;
begin
   { Check if audio device is available }
   OleCheck(CoCreateInstance(CLSID_MMAudioSource, nil, CLSCTX_ALL,
            IID_IAudioMultiMediaDevice, FIAMD));
end;

procedure TMRecognition.SelectEngine(EngineName: String);
var Index, EngineCount: Integer;
    ModeInfo: SRModeInfo;
begin
   if not FInit then
      raise EMRecognitionException.Create(msgRENotInited);

   Index := Engines.IndexOf(EngineName);
   if Index < 0 then
      raise EMRecognitionException.Create(msgRENotFound);

   BeforeSelectEngine;

   { Select Engine }
   FEngineStarted := True;
   try
      OleCheck(FISREnum.Reset);
      OleCheck(FISREnum.Skip(Index));
      OleCheck(FISREnum.Next(1, ModeInfo, @EngineCount));

      if Assigned(PModeInfo) then Dispose(PModeInfo);
      New(PModeInfo);
      PModeInfo^ := ModeInfo;

      OleCheck(FISREnum.Select(PModeInfo^.gModeID,
               FISRCentral, IUnknown(FIAMD)));

      PostSelectEngine;
   except
      FEngineStarted := False;
   end;
end;

procedure TMRecognition.SelectEngine(EngineMode: SRModeInfo);
var FISRFind: ISRFind;
    ModeInfo: SRModeInfo;
begin
   if not FInit then
      raise EMRecognitionException.Create(msgRENotInited);

   BeforeSelectEngine;
   FEngineStarted := True;

   { Find and Select Engine }
   try
      try
         OleCheck(CoCreateInstance(CLSID_SREnumerator, Nil, CLSCTX_ALL, IID_ISRFind, FISRFind));
         OleCheck(FISRFind.QueryInterface(IID_ISREnum, FISREnum));
         OleCheck(FISRFind.Find(EngineMode, nil, ModeInfo));

         if Assigned(PModeInfo) then Dispose(PModeInfo);
         New(PModeInfo);
         PModeInfo^ := ModeInfo;

         OleCheck(FISRFind.Select(PModeInfo^.gModeID,
                  FISRCentral, IUnknown(FIAMD)));

         PostSelectEngine;
      except
         FEngineStarted := False;
      end;
   finally
      FISRFind._Release;
   end;
end;

procedure TMRecognition.PostSelectEngine;
begin

end;

end.
