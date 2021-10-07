unit uHoraUtils;

interface

type
  THoraUtils = class
  public
    class function SomaHoras(AHora1, AHora2: string): string; overload;
    class function SomaHoras(AHora1, AHora2: TTime): string; overload;
  end;

implementation

uses
  System.Variants, System.SysUtils, System.Classes, Vcl.Forms;

{ THoraUtils }

class function THoraUtils.SomaHoras(AHora1, AHora2: TTime): string;
begin
  Result := SomaHoras(TimeToStr(AHora1), TimeToStr(AHora2));
end;


class function THoraUtils.SomaHoras(AHora1, AHora2: string): string;
var
  vHora: string;
  vHoras, vMinutos, vSegundos, vMiliSegundos: Word;
  vTime: TTime;
  vSomaH, vSomaM: Integer;
begin
  vSomaH := 0;
  vSomaM := 0;

  vHora := AHora1;
  if StrToIntDef(Copy(vHora, 1, 2), 0) > 23 then
  begin
    vSomaH := StrToIntDef(Copy(vHora, 1, 2), 0);
    vHora := '00' + Copy(vHora, 3, 6);
  end;

  vTime := StrToTime(vHora);
  DecodeTime(vTime, vHoras, vMinutos, vSegundos, vMiliSegundos);

  vSomaH := vSomaH + vHoras;
  vSomaM := vSomaM + vMinutos;

  vTime := StrToTime(AHora2);
  DecodeTime(vTime, vHoras, vMinutos, vSegundos, vMiliSegundos);

  vSomaH := vSomaH + vHoras;
  vSomaM := vSomaM + vMinutos;

  if vSomaM > 59 then
  begin
    vSomaH := vSomaH + Round(vSomaM/60);
    vSomaM := Round(vSomaM mod 60);
  end;

  Result := FormatFloat('00', vSomaH) + ':' + FormatFloat('00', vSomaM)+':00';
end;

end.
