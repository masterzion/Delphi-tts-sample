unit mSpecReg;

interface

uses Classes, mSpeech;

procedure Register;

implementation

procedure Register;
begin
   RegisterComponents('Monster', [TMSpeech]);
end;

end.
