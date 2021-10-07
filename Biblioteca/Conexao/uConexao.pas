unit uConexao;

interface

uses
  FireDAC.Comp.Client;

var
  vgConexao: TFDConnection;

procedure InicializaConexao(ANomeBase: string);

implementation

uses
  System.IOUtils, System.SysUtils;

procedure InicializaConexao(ANomeBase: string);
var
  vCaminho: string;
begin
  vgConexao := TFDConnection.Create(nil);
  vgConexao.DriverName := 'SQLite';
  vgConexao.Params.Add('DriverID=SQLite');
  vgConexao.Params.Add('OpenMode=ReadWrite');
  {$IFDEF ANDROID}
  vCaminho := 'DataBase=' + GetHomePath + PathDelim + ANomeBase;
  {$ELSE}
  vCaminho := 'Database=' + Copy(GetCurrentDir, 1, Pos('Win', GetCurrentDir)-1) + 'Dados\'+ANomeBase;
  {$ENDIF}
  vgConexao.Params.Add(vCaminho);
  vgConexao.LoginPrompt:= False;
  vgConexao.Connected := True;
end;

end.
