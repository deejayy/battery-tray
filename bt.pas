unit bt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CoolTrayIcon, TextTrayIcon, Menus, ExtCtrls, registry;

type
  Tbwindow = class(TForm)
    tt: TTextTrayIcon;
    PopupMenu1: TPopupMenu;
    quit1: TMenuItem;
    Timer1: TTimer;
    Memo1: TMemo;
    Button1: TButton;
    stw: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure quit1Click(Sender: TObject);
    procedure ttDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure stwClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AfterCreate;
    { Public declarations }
  end;

var
  bwindow: Tbwindow;

procedure log(text: string);
function GetSystemTimes(lpIdleTime, lpKernelTime, lpUserTime: TFileTime): BOOL; stdcall;

implementation

{$R *.dfm}

const

  outfile = 'output.log';
  progname = 'batterymonitor';

var

  eperc: integer;
  reg: tregistry;

function GetSystemTimes; external 'kernel32.dll' name 'GetSystemTimes';

procedure log(text: string);
var
  f: textfile;
begin
  chdir(extractfilepath(paramstr(0)));
  assignfile(f, outfile);
  if fileexists(outfile) then append(f) else rewrite(f);
  writeln(f, format('%s'#09'%s', [datetimetostr(now), text]));
  closefile(f);
end;

function getcable(val: integer): string;
begin
  result := '?';
  if val = 0 then result := 'Nincs csatlakoztatva';
  if val = 1 then result := 'Csatlakoztatva van';
  if val = 255 then result := 'Ismeretlen';
end;

function getstate(val: integer): string;
begin
  result := '?';
  if val = 1 then result := 'Ok - 66%';
  if val = 2 then result := 'Figyelem - 33%';
  if val = 4 then result := 'Kritikus - 5%';
  if val = 8 then result := 'Töltés alatt';
  if val = 128 then result := 'Nincs akkumulátor';
  if val = 255 then result := 'Nincs információ';
end;

function bttime(val: integer): string;
begin
  result := '00:00:00';
  if val > 0 then
    result := format('%2.0f:%2.0f:%.2d', [val/60/60, val/60, val mod 60]);
end;

function getcolor(value: integer): tcolor;
begin
  result := $00000000;
  if value >  0 then result := $00FF0000;
  if value > 10 then result := $00DD6600;
  if value > 30 then result := $00FFFF00;
  if value > 50 then result := $0066DD00;
  if value > 80 then result := $0000FF00;
end;

procedure Tbwindow.Button1Click(Sender: TObject);
var ps: SYSTEM_POWER_STATUS;
    s: string;
    cpuusage: integer;
    it, kt, ut: TFileTime;
begin
  cpuusage := 0;
  GetSystemPowerStatus(ps);
//  GetSystemTimes(it, kt, ut);
  if ps.BatteryLifePercent > 99 then ps.BatteryLifePercent := 0;
  s := format(
    '220V: %s'#13#10+
    'Státusz: %s'#13#10+
    'Töltöttség: %d %%'#13#10+
    'Hátralévõ idõ: %s'#13#10,
    [getcable(ps.ACLineStatus), getstate(ps.BatteryFlag), ps.BatteryLifePercent, bttime(ps.BatteryLifeTime)]);

  memo1.Text := s;
  tt.Hint := s;
  tt.Text := inttostr(ps.BatteryLifePercent);
  tt.Font.Color := getcolor(ps.BatteryLifePercent);
//  cpuusage := kt.

  if eperc <> ps.BatteryLifePercent then begin
    log(format('* %d', [ps.BatteryLifePercent]));
  end;

  eperc := ps.BatteryLifePercent;
end;

procedure Tbwindow.quit1Click(Sender: TObject);
begin
  close;
end;

procedure Tbwindow.ttDblClick(Sender: TObject);
begin
  Application.Restore;
end;

procedure Tbwindow.AfterCreate;
begin
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKey('Software\Microsoft\Windows\Currentversion\Run', false);
  if reg.ValueExists(progname) then
    stw.checked := (reg.ReadString(progname) = paramstr(0))
  else stw.checked := false;
  reg.CloseKey;
end;

procedure Tbwindow.FormCreate(Sender: TObject);
begin
  reg := tregistry.create;
end;

procedure Tbwindow.stwClick(Sender: TObject);
begin
  reg.RootKey := HKEY_CURRENT_USER;
  reg.CloseKey;
  reg.OpenKey('Software\Microsoft\Windows\Currentversion\Run', false);
  if stw.checked then begin
    try
      reg.WriteString(progname, paramstr(0));
    except on e:exception do
      showmessage('Nem beállítható!');
    end;
  end else begin
    try
      reg.DeleteValue(progname)
    except on e:exception do
      showmessage('Nem törölhetõ a beállítás!');
    end;
  end;
end;


end.

