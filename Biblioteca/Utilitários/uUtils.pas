unit uUtils;

interface

uses
  Classes, IdHashMessageDigest, Rtti, DBXJSON, DBXJSONReflect, SysUtils, System.JSON, uEntidade, Data.DB, uAtributosTabelas;

type
  TUtils = class
  public
    class function JsonEncode<T: class>(aObjeto: T): TJSonValue;
    class function JsonDecode<T: class>(aJsonValue: TJSonValue): T;

    class function MontaEntidade<T: TEntidade, constructor>(ADataSet: TDataSet): T;
  end;

implementation

class function TUtils.JsonEncode<T>(aObjeto: T): TJSonValue;
var
  m: TJSONMarshal;
begin
  if Assigned(aObjeto) then
  begin
    m := TJSONMarshal.Create(TJSONConverter.Create);
    Result := m.Marshal(aObjeto as T);
  end
  else
    Result := TJSONNull.Create;
end;

class function TUtils.MontaEntidade<T>(ADataSet: TDataSet): T;
var
  vObjeto: TObject;
  vValor: TValue;
  vClasse: TRttiType;
  vAtributo: TCustomAttribute;
  vContexto: TRttiContext;
  vPropriedade: TRttiProperty;
  vDataSetField: TField;
begin
  vObjeto := T.Create;
  vContexto := TRttiContext.Create;
  try
    vClasse := vContexto.GetType(T.ClassInfo);
    for vPropriedade in vClasse.GetProperties do
    begin
      vDataSetField := nil;

      for vAtributo in vPropriedade.GetAttributes do
      begin
        if vAtributo is CampoChavePrimariaAttribute then
        begin
          vDataSetField := ADataSet.FindField((vAtributo as CampoChavePrimariaAttribute).Nome);
          Break;
        end
        else if vAtributo is CampoAttribute then
        begin
          vDataSetField := ADataSet.FindField((vAtributo as CampoAttribute).Nome);
          Break;
        end;
      end;

      if Assigned(vDataSetField) then
      begin
        case vPropriedade.PropertyType.TypeKind of
          tkInteger:
          begin
            vValor := vDataSetField.AsInteger;
          end;

          tkInt64:
          begin
            vValor := vDataSetField.AsLargeInt;
          end;

          tkFloat:
          begin
            vValor := vDataSetField.AsFloat;
          end;

          tkString, tkUString, tkWChar, tkLString, tkWString:
          begin
            vValor := vDataSetField.AsString;
          end;

          tkEnumeration:
          begin
            vValor := vDataSetField.AsBoolean;
          end
        else
          Continue;
        end;

        vPropriedade.SetValue(vObjeto, vValor);
      end;
    end;
  finally
    vContexto.Free;
  end;
  Result := T(vObjeto);
end;

class function TUtils.JsonDecode<T>(aJsonValue: TJSonValue): T;
var
  unm: TJSONUnMarshal;
begin
  if aJsonValue is TJSONNull then
    exit(nil);

  unm := TJSONUnMarshal.Create;
  try
    exit(unm.Unmarshal(aJsonValue) as T);
  finally
    unm.Free;
  end;
end;

                  {
class function TUtils.JsonEncode2<T>(aObjeto: T): String;
var
  vRTTIContext: TSuperRttiContext;
  vSO: ISuperObject;
begin
  vRTTIContext := TSuperRttiContext.Create;

  vSO := vRTTIContext.AsJson<T>(aObjeto);
  Result := vSO.AsJson(False, True);
end;

class function TUtils.JsonDecode2<T>(aString: String): T;
var
  vRTTIContext: TSuperRttiContext;
  vSO: ISuperObject;
  vRttiValue: TValue;
begin
  vRTTIContext := TSuperRttiContext.Create;

  vSO := SO(aString);
  vRttiValue := TValue.Empty;
  vRttiContext.FromJson(TypeInfo(T), vSO, vRttiValue);

  Result := vRttiValue.AsType<T>;
end;               }

  (*
  vm: TJSONMarshal;
  unm: TJSONUnMarshal;

var
  person, newperson: TPerson;
  kid: TPerson;
  JSONString: String;

begin
  m := TJSONMarshal.Create(TJSONConverter.Create);
  unm := TJSONUnMarshal.Create;


JSONString := m.Marshal(person).ToString;
  Memo1.Lines.Clear;
  Memo1.Lines.Add(JSONString);
  Memo1.Lines.Add('-----------------------');

  { Unmarshal the JSONString to a TPerson class }

  newperson := unm.Unmarshal(TJSONObject.ParseJSONValue(JSONString)) as TPerson;
  Memo1.Lines.Add(newperson.FName);
  Memo1.Lines.Add(IntToStr(newperson.FHeight));
   *)


end.
