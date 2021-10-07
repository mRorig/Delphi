unit uEntidade;

interface

uses
  System.Rtti, Data.DB, System.Generics.Collections;

type
	TTipoAvisoErro = (aeAviso, aeErro);
  
  TEntidade = class abstract
  public
    function RetornaValorSQL(AProperty: TRttiProperty): String;
    function Valida: TArray<TPair<string,TTipoAvisoErro>>; virtual;
  end;

implementation

uses
  System.SysUtils;

function TEntidade.RetornaValorSQL(AProperty: TRttiProperty): String;
var
  vValor: TValue;
  vValorFormatado: String;
begin
  vValor          := AProperty.GetValue(Self);
  vValorFormatado := 'NULL';

  case vValor.Kind of
    tkInteger, tkInt64:
    begin
      if vValor.AsInteger > 0 then
        vValorFormatado := (IntToStr(vValor.AsInteger));
    end;

    tkFloat:
    begin
      if AProperty.PropertyType.Handle.Name = 'TDate' then
      begin
        vValorFormatado := QuotedStr(FormatDateTime('YYYY-MM-DD', vValor.AsExtended));
      end
   		{$IFDEF ANDROID}
      else if AProperty.PropertyType.Handle.Name.ToString = 'TDateTime' then
      {$ELSE}
      else if AProperty.PropertyType.Handle.Name = 'TDateTime' then
      {$ENDIF}
      begin
        vValorFormatado := QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', vValor.AsExtended));
      end
      else if AProperty.PropertyType.Handle.Name = 'TTime' then
      begin
        vValorFormatado := QuotedStr(FormatDateTime('hh:mm:ss.nnn', vValor.AsExtended));
      end
      else if vValor.AsExtended > 0 then
      begin
        vValorFormatado := (FloatToStr(vValor.AsExtended));
      end;
    end;

    tkChar, tkString, tkUString, tkWChar, tkLString, tkWString:
    begin
      if vValor.AsString <> EmptyStr then
        vValorFormatado := QuotedStr(vValor.AsString);
    end;

    tkEnumeration:
    begin
      vValorFormatado := QuotedStr('F');
      if vValor.AsBoolean then
        vValorFormatado := QuotedStr('T');
    end;
  end;     
  Result := vValorFormatado;
end;

function TEntidade.Valida: TArray<TPair<string, TTipoAvisoErro>>;
begin
 	SetLength(Result, 0);
end;

end.
