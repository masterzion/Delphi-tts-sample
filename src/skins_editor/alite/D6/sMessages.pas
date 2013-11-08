unit sMessages;
{$I sDefs.inc}
interface

uses Windows, Messages, Graphics, Controls, ExtCtrls, sConst;

var
  SM_ALPHACMD                   : LongWord;
{
const // Billenium Effects messages
  BE_ID           = $41A2;
  BE_BASE         = CM_BASE + $0C4A;
  CM_BEPAINT      = BE_BASE + 0; // Paint client area to Billenium Effects' DC
  CM_BENCPAINT    = BE_BASE + 1; // Paint non client area to Billenium Effects' DC
  CM_BEFULLRENDER = BE_BASE + 2; // Paint whole control to Billenium Effects' DC
  CM_BEWAIT       = BE_BASE + 3; // Don't execute effect yet
  CM_BERUN        = BE_BASE + 4; // Execute effect now!
}
const
  AC_SETNEWSKIN                 = 1;
  AC_REMOVESKIN                 = 2;
  AC_REFRESH                    = 3;
  AC_GETPROVIDER                = 4;
  AC_GETCACHE                   = 5;
  AC_ENDPARENTUPDATE            = 6;
  AC_CTRLHANDLED                = 7;
  AC_UPDATING                   = 8;
  AC_URGENTPAINT                = 9;
  AC_PREPARING                  = 10;
  AC_GETHALFVISIBLE             = 11;
  AC_SETTRANSBGCHANGED          = 12;  // Can be removed?
  AC_UPDATESECTION              = 13;
  AC_DROPPEDDOWN                = 14;
  AC_SETGRAPHCONTROL            = 15;  // Can be removed?
  AC_STOPFADING                 = 16;
  AC_SETBGCHANGED               = 17;  // v4.41
  AC_INVALIDATE                 = 18;
  AC_CHILDCHANGED               = 19;
  AC_SETCHANGEDIFNECESSARY      = 20;  // Defines BgChanged to True if required, with repainting if WParamLo = 1
  AC_GETCONTROLCOLOR            = 21;  // Returns color for the filling of children
  AC_SETHALFVISIBLE             = 22;
  AC_PREPARECACHE               = 23;
  AC_DRAWANIMAGE                = 24;
  AC_CONTROLLOADED              = 25;
//  AC_UPDATERGN                  = 26;
  AC_GETDISKIND                 = 26;

  AC_UPDATESCROLLS              = 50;
  AC_BEFORESCROLL               = 51;
  AC_AFTERSCROLL                = 52;
//  AC_BEFORERECREATING           = 22;  // Notification about beginning of window recreating
//  AC_AFTERRECREATING            = 23;  // Notification about finish of window recreating

  WM_DRAWMENUBORDER       = CN_NOTIFY + 101;
  WM_DRAWMENUBORDER2      = CN_NOTIFY + 102;

implementation

uses acUtils, Dialogs, SysUtils;

initialization
  SM_ALPHACMD := RegisterWindowMessage('SM_ALPHACMD');
  if True or (SM_ALPHACMD < $C000) then SM_ALPHACMD := $A100; // ShowError('Window Message Registration failed!');

finalization

end.
