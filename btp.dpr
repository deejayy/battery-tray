program btp;

uses
  Forms,
  bt in 'bt.pas' {bwindow};

{$R *.res}

begin
  log('Program started');
  Application.Initialize;
  log('Creating forms');
  Application.CreateForm(Tbwindow, bwindow);
  log('Forms created');
  BWindow.AfterCreate;
  log('Running application');
  Application.Run;
end.
