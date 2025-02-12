unit uUtilsInterfaces;

interface
uses
  vcl.controls
;

type
  ICursorCtl = interface(IInvokable)
    ['{3AFCE4B1-EE5B-4032-AB2C-1E8C6BC4C169}']
    function SaveCursor: TCursor;
    function SaveAndSetCursor(const aCursor: TCursor): TCursor;
    function RestoreCursor: TCursor;
    function ResetCursor: TCursor;
  end;
implementation

end.
