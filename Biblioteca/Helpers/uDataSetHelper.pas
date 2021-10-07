unit uDataSetHelper;

interface

uses
  System.Classes, System.Rtti, System.Generics.Collections, System.TypInfo, System.SysUtils, Data.DB, uEntidade, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TDataSetHelper = class helper for TDataSet
  strict private
    class var ContextoRTTI: TRttiContext;
  public
    /// <summary> Cria uma entidade a partir do registro posicionado no dataset </summary>
    /// <returns> Entidade do tipo definido por T </returns>
    function ToEntidade<T: TEntidade, constructor>: T;

    /// <summary> Cria uma lista de entidade a partir do dataset </summary>
    /// <param name="AOwnsObject"> Indica que as entidades são destruídas ao destruir a lista </param>
    /// <returns> Lista de entidade do tipo definido por T </returns>
    function ToList<T: TEntidade, constructor>(const AOwnsObject: Boolean = True): TList<T>;

    /// <summary> Converte o dataset para KbmMemTable, com todos os fields e dados </summary>
    function ToMemTable: TFDMemTable;

    /// <summary> Limpa o valor dos campos do DataSet </summary>
    procedure ClearFieldsValues;
  end;

implementation

uses
  uAtributosTabelas;

procedure TDataSetHelper.ClearFieldsValues;
var
  vField: TField;
begin
  if Self.Fields.Count > 0 then
  begin
    for vField in Self.Fields do
    begin
      vField.Clear;
    end;
  end;
end;

function TDataSetHelper.ToEntidade<T>: T;
var
  vClasseRtti    : TRttiType;
  vPropriedade   : TRttiProperty;
  vPropriedades  : TArray<TRttiProperty>;
  vCampos        : TDictionary<String, String>;
  vAtributo      : TCustomAttribute;
  vCampoDataSet  : CampoAttribute;
  vNomeCampo     : String;
  vValor         : TValue;
  vPossuiAtributo: Boolean;
  vObjeto        : TObject;
  vDataSetField  : TField;
  vMetodo        : TRttiMethod;
  vEnumerado     : TRttiType;
  vNovoValue     : TValue;
begin
  Result := nil;
  if RecordCount > 0 then
  begin
    vDataSetField := nil;
    vCampos       := nil;
    try
      vObjeto       := T.Create;
      vClasseRtti   := ContextoRtti.GetType(vObjeto.ClassInfo);
      vPropriedades := vClasseRtti.GetProperties;
      vCampos       := TDictionary<String, String>.Create();

      for vPropriedade in vPropriedades do
      begin
        vPossuiAtributo := False;
        for vAtributo in vPropriedade.GetAttributes do
        begin
          if vAtributo is CampoAttribute then
          begin
            vCampoDataSet := CampoAttribute(vAtributo);
            vCampos.AddOrSetValue(vPropriedade.Name, vCampoDataSet.Nome);
          end;
        end;
      end;

      for vPropriedade in vPropriedades do
      begin
        if not vCampos.TryGetValue(vPropriedade.Name, vNomeCampo) then
        begin
          Continue;
        end;

        vDataSetField := FindField(vNomeCampo);
        if Assigned(vDataSetField) and (vPropriedade.IsWritable) then
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
              if SameText(String(vPropriedade.PropertyType.Handle.Name), 'TDate') then
              begin
                vValor := StrToDateTime(Copy(vDataSetField.AsString, 1, 10));
              end
              else if SameText(String(vPropriedade.PropertyType.Handle.Name), 'TDateTime') then
              begin
                vValor := vDataSetField.AsDateTime;
              end
              else
              begin
                vValor := vDataSetField.AsFloat;
              end;
            end;

            tkString, tkUString, tkWChar, tkLString, tkWString:
            begin
              vValor := vDataSetField.AsString;
            end;

            tkEnumeration:
            begin
              if SameText(String(vPropriedade.PropertyType.Handle.Name), 'Boolean') then
              begin
                vValor := vDataSetField.AsString = 'T';
              end;
            end;
          else
            Continue;
          end;

          vPropriedade.SetValue(vObjeto, vValor);
        end;
      end;
    except
      Result := nil;
      vObjeto.Free;
    end;
    vCampos.Free;
    Result := T(vObjeto);
  end;
end;

function TDataSetHelper.ToList<T>(const AOwnsObject: Boolean = True): TList<T>;
var
  vObjeto: T;
  vBookmark: TArray<Byte>;
begin
  Result := nil;
  DisableControls;
  try
    vBookmark := Bookmark;
    Result :=TList<T>(AOwnsObject).Create;

    First;
    while not Eof do
    begin
      vObjeto := ToEntidade<T>;
      Result.Add(vObjeto);
      Next;
    end;

    if ((RecordCount > 0) and BookmarkValid(vBookmark)) then
    begin
      Bookmark := vBookmark;
    end;
  finally
    EnableControls;
  end;
end;

function TDataSetHelper.ToMemTable: TFDMemTable;
begin
  Result := nil;
  if Active then
  begin
    Result := TFDMemTable.Create(nil);
    Result.CopyDataSet(Self, [coAppend]);
    Result.First;
  end;
end;

end.
