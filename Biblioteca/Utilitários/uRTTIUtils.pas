unit uRTTIUtils;

interface

uses
  Generics.Collections, Data.DB, system.Rtti, system.TypInfo;

type
  TRttiTypeHelper = class helper for TRttiType
  public
    function ObtemProperty<T: TCustomAttribute>: TRttiProperty; overload;
    function ObtemProperty(const AAtributo: TCustomAttribute): TRttiProperty; overload;
  end;

  TRttiPropertyHelper = class helper for TRttiProperty
  public
    function PossuiAtributo<T: TCustomAttribute>: Boolean; overload;
    function PossuiAtributo(const AAtributo: TCustomAttribute): Boolean; overload;
    function ObtemAtributo<T: TCustomAttribute>(out Atributo: T): Boolean;
  end;

implementation

{ TRttiTypeHelper }

function TRttiTypeHelper.ObtemProperty(const AAtributo: TCustomAttribute): TRttiProperty;
var
  vLista : TArray<TRttiProperty>;
  vPropriedade: TRttiProperty;
begin
Result := nil;

  vLista := Self.GetProperties;
  for vPropriedade in vLista do
  begin
    if vPropriedade.PossuiAtributo(AAtributo) then
    begin
      Result := vPropriedade;
      Break;
    end;
  end;
end;

function TRttiTypeHelper.ObtemProperty<T>: TRttiProperty;
var
  vLista : TArray<TRttiProperty>;
  vIndice: Integer;
  vPropriedade: TRttiProperty;
begin
  Result := nil;

  vLista := Self.GetProperties;
  for vPropriedade in vLista do
  begin
    if vPropriedade.PossuiAtributo<T> then
    begin
      Result := vPropriedade;
      Break;
    end;
  end;
end;

{ TRttiPropertyHelper }

function TRttiPropertyHelper.ObtemAtributo<T>(out Atributo: T): Boolean;
var
  vLista: TArray<TCustomAttribute>;
  vAtributo: TCustomAttribute;
begin
  vLista := Self.GetAttributes;
  for vAtributo in vLista do
  begin
    if vAtributo is T then
    begin
      Atributo := T(vAtributo);
      Break;
    end;
  end;

  Result := Assigned(Atributo);
end;

function TRttiPropertyHelper.PossuiAtributo(const AAtributo: TCustomAttribute): Boolean;
var
  vLista: TArray<TCustomAttribute>;
  vAtributo: TCustomAttribute;
begin
  Result := False;

  vLista := Self.GetAttributes;
  for vAtributo in vLista do
  begin
    if AAtributo = vAtributo then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TRttiPropertyHelper.PossuiAtributo<T>: Boolean;
var
  vAtributo: T;
begin
  Result := Self.ObtemAtributo<T>(vAtributo);
end;

end.
