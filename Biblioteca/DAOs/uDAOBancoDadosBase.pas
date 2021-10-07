unit uDAOBancoDadosBase;

interface

uses
  Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FMX.Forms,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.SysUtils, System.Classes, uConexao;

type
  TDAOBancoDadosBase = class abstract
  private
    FCaminhoBaseDados: String;
  protected
    function CriaQuery: TFDQuery;
  public
    constructor Create; virtual;
    property CaminhoBaseDados: String read FCaminhoBaseDados write FCaminhoBaseDados;
  end;

implementation

uses
  system.IOUtils;

constructor TDAOBancoDadosBase.Create;
begin
  inherited;
end;

function TDAOBancoDadosBase.CriaQuery: TFDQuery;
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := vgConexao;

  Result := vQuery;
end;

end.
