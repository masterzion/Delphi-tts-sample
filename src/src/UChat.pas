{The user interface}
unit UChat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, IniFiles,shellapi,
  UBotloader,UUtils, mSpeech, sEdit, sButton, sPanel, sSkinProvider,
  sSkinManager, sComboBox, jpeg, sCheckBox;

type
  TChat = class(TForm)
    RichEdit1: TRichEdit;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    Button1: TsButton;
    sEdit1: TsEdit;
    sPanel2: TsPanel;
    Image1: TImage;
    chkSpeech: TsCheckBox;
    ComboBox1: TsComboBox;
    sButton1: TsButton;
    Timer1: TTimer;
    // the 'main' method, sends user input for matching & processing the result
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RichEdit1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure sEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure chkSpeechClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    _LoaderThread:TBotLoaderThread;
    _SentenceSplitter:TStringTokenizer;
    MSpeech1:TMSpeech;
    bSpeech, bLoading: boolean;
    sConfigFile: String;
    nDress : Integer;
    nBotAlone, nInative : Integer;
    Procedure Add(s:string);

    procedure GetCfgData;
    procedure SetCfgData;

    procedure StartSpeechDevice;
    procedure SpeechText(Text:string);
    procedure StopSpeechDevice;

    { Private declarations }
  public
    Procedure AddUserInput(s:string);
    Procedure AddBotReply(s:string);
    Procedure AddLogMessage(s:string);
    procedure InterativeText(Text:string);
    { Public declarations }
  end;

var
  Chat: TChat;

implementation
Uses
  UPatternMatcher,UTemplateProcessor,UVariables,ULogging,LibXMLParser, about;

  Procedure TChat.Add(s:string);
    begin
      RichEdit1.Lines.Add(s);
      RichEdit1.SelStart:=Length(RichEdit1.TExt);
      SendMessage(RichEdit1.Handle,EM_SCROLLCARET,0,0);
    end;
  Procedure TChat.AddUserInput(s:string);
    var name:string;
    begin

      RichEdit1.SelStart:=Length(RichEdit1.TExt);
      with RichEdit1.SelAttributes do begin
          Color := clMaroon;
          Style := [];
      end;
      Add('> '+s);
      name:=Memory.getVar('name');
      if name='' then name:='user';
      Log.chatlog(name,s);
    end;
  Procedure TChat.AddBotReply(s:string);
    begin
      if s='' then exit;
      RichEdit1.SelStart:=Length(RichEdit1.TExt);
      with RichEdit1.SelAttributes do begin
          Color := clBlack;
          Style := [];
      end;
      Add(s);
      SpeechText(s);

      Log.Chatlog(Memory.GetProp('name'),s);

    end;
  Procedure TChat.AddLogMessage(s:string);
    begin
      RichEdit1.SelStart:=Length(RichEdit1.TExt);
      with RichEdit1.SelAttributes do begin
          Color := clBlue;
          Style := [];
      end;
      if uppercase(ParamStr(1)) = 'DEBUG' then Add(s);
    end;
{$R *.DFM}

procedure TChat.InterativeText(Text:string);
begin
 RichEdit1.Lines.Add(Text);
 SpeechText(Text);
end;


procedure TChat.Button1Click(Sender: TObject);
var
  reply:string;
  Match:TMatch;
  input:String;
  i:integer;
begin
  input:=sEdit1.Text;
  nInative := 0;
  nBotAlone := 0;
  AddUserInput(input);
  Memory.setVar('input',input);
  input:=Trim(ConvertWS(Preprocessor.process(' '+input+' '),true));

  _SentenceSplitter.SetDelimiter(SentenceSplitterChars); {update, if we're still loading}
  _SentenceSplitter.Tokenize(input);

  for i:=0 to _SentenceSplitter._count-1 do begin
    input:=Trim(_SentenceSplitter._tokens[i]);
    Match:=PatternMatcher.MatchInput(input);
    reply:=TemplateProcessor.Process(match);
    match.free;
  end;

  AddBotReply(reply);
  //AddLogMessage('Nodes traversed: '+inttostr(PatternMatcher._matchfault));
  Add('');
  reply:=PreProcessor.process(reply);
  _SentenceSplitter.SetDelimiter(SentenceSplitterChars);
  _SentenceSplitter.Tokenize(reply);

  Memory.setVar('that',_SentenceSplitter.GetLast);
  sEdit1.Clear;
end;



procedure TChat.FormCreate(Sender: TObject);
begin
  sConfigFile :=  ExtractFilePath(Application.ExeName)+StringReplace(ExtractFileName(Application.ExeName), '.exe', '', [rfIgnoreCase]) +'.cfg';
  sSkinManager1.GetSkinNames(ComboBox1.Items);
  GetCfgData;
  //Preparing Theme
  bLoading := True;
  sSkinManager1.SkinName := ComboBox1.Text;
  bLoading := False;

  // Preparing Boot Engine
  Log.Log('Starting PASCALice v1.5');
  Log.Flush;
  _LoaderThread:=TBotLoaderThread.Create(true);
  //BotLoader.load('startup.xml');
  _LoaderThread.Resume;
  _SentenceSplitter:=TStringTokenizer.Create(SentenceSplitterChars);

  // Preparing Speech Engine
  bSpeech := False;
  if chkSpeech.Checked then  StartSpeechDevice;
  InterativeText('Hello. My name is Mercedes. Whats your name?');
  sEdit1.Enabled := True;



end;

procedure TChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  chkSpeechClick(Self);
  Application.TErminate;
end;


procedure TChat.RichEdit1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  SendMessage(RichEdit1.Handle,EM_LINESCROLL,0,-(WheelDelta div 120)*Mouse.WheelScrollLines);
  handled:=true;
end;

procedure TChat.sEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then Button1.Click;
end;

procedure TChat.ComboBox1Change(Sender: TObject);
begin
   if not bLoading then begin
       sSkinManager1.SkinName := ComboBox1.Text;
       nDress := nDress +1;

       if nDress > 8 then begin
           InterativeText('Hey! How many times you will change my dress?');
       end
       else
           case Random(4) of
              0: InterativeText('Cool. Now i have a new dress!');
              1: InterativeText('Do you like this color?');
              2: InterativeText('What you think?');
              3: InterativeText('Do you like this dress?');
              4: InterativeText('I like to change my dress sometimes!');
           end;
   end;

end;





procedure TChat.SpeechText(Text:string);
begin
  if chkSpeech.Checked then begin
    MSpeech1.Text.Text := Text;
    MSpeech1.Speak;
  end;
end;


procedure TChat.StartSpeechDevice;

  procedure RunProgram(ExecuteFile:String);
  var
     SEInfo: TShellExecuteInfo;
     ExitCode: DWORD;
  begin
     FillChar(SEInfo, SizeOf(SEInfo), 0) ;
     SEInfo.cbSize := SizeOf(TShellExecuteInfo) ;
     with SEInfo do begin
       fMask := SEE_MASK_NOCLOSEPROCESS;
       Wnd := Application.Handle;
       lpFile := PChar(ExecuteFile) ;

       nShow := SW_SHOWNORMAL;
     end;
     if ShellExecuteEx(@SEInfo) then begin
       repeat
         Application.ProcessMessages;
         GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;
       until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
     end
     else ShowMessage('Error on starting "'+ExecuteFile+'" !') ;
  end;


begin
  try
    MSpeech1:=TMSpeech.create(self);
    MSpeech1.SelectEngine('Mary');
    bSpeech := True;
  except
    MSpeech1.Destroy;
    if MessageDlg('Error on start Voice Server... Do you wanto to install SAPI Suite?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      Chat.Enabled := False;
      RunProgram(ExtractFilePath(Application.ExeName)+ 'msttsl.exe');
      RunProgram(ExtractFilePath(Application.ExeName)+ 'spchapi.exe');
      Chat.Enabled := True;
      StartSpeechDevice;
    end
    else begin
      bSpeech := False;
      chkSpeech.Checked := False;
    end;

    
  end;
end;

procedure TChat.StopSpeechDevice;
begin

  try
    MSpeech1.Stop;
    MSpeech1.Destroy;
    bSpeech := False;
  except
    ShowMessage('Error on close Speech Engine');
  end;

end;



procedure TChat.GetCfgData;
var
 strs : TStrings;
begin
  if FileExists(sConfigFile) then begin
     strs :=TStringList.Create;
     strs.LoadFromFile(sConfigFile);
     chkSpeech.Checked := (  strs.Strings[0] = 'Y' );
     ComboBox1.ItemIndex := StrToInt( strs.Strings[1] );
     strs.Free;
  end
  else begin
     chkSpeech.Checked := False;
     ComboBox1.ItemIndex := 0;
  end;


end;

procedure TChat.SetCfgData;
var
 s: string;
 strs : TStrings;
begin
   if chkSpeech.Checked then
     s := 'Y'
   else
     s := 'N';

  strs :=TStringList.Create;
  with strs do begin
    Add(S);
    Add( IntToStr(ComboBox1.ItemIndex ) );
    SaveToFile(sConfigFile);
  end;
  strs.Free;



end;



procedure TChat.chkSpeechClick(Sender: TObject);
begin
  if chkSpeech.Checked then
    StartSpeechDevice
  else
    if bSpeech then StopSpeechDevice;
  SetCfgData;
end;

procedure TChat.sButton1Click(Sender: TObject);
var
  frmAbout : TfrmAbout;
begin
  frmAbout := TfrmAbout.Create(self);
  frmAbout.ShowModal;
  frmAbout.Free;
  
end;

procedure TChat.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewWidth < 600 then   Resize := false;
  if NewHeight < 600 then   Resize := false;
end;

procedure TChat.Timer1Timer(Sender: TObject);
var
  reply:string;
  Match:TMatch;
  input:String;
  i:integer;
begin
nInative := nInative +1;
if nInative  > 120 then begin
  nBotAlone := nBotAlone + 1;
  nInative := 0;

  if nBotAlone > 3 then begin
    input:='BOTALONE';
    nBotAlone := 4;
  end
  else
    input:='INACTIVITY';

  Memory.setVar('input',input);
  input:=Trim(ConvertWS(Preprocessor.process(' '+input+' '),true));

  _SentenceSplitter.SetDelimiter(SentenceSplitterChars); {update, if we're still loading}
  _SentenceSplitter.Tokenize(input);

  for i:=0 to _SentenceSplitter._count-1 do begin
    input:=Trim(_SentenceSplitter._tokens[i]);
    Match:=PatternMatcher.MatchInput(input);
    reply:=TemplateProcessor.Process(match);
    match.free;
  end;
  AddBotReply(reply);
end;


end;

end.
