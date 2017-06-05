unit FormStart;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  System.Actions, FMX.ActnList, iORM.MVVM.Components.ViewContextProvider,
  iORM.DB.Components.ConnectionDef;

type
  TStartForm = class(TForm)
    SQLIteConn: TioSQLiteConnectionDef;
    VCProviderMaster: TioViewContextProvider;
    ActionList1: TActionList;
    TabControl: TTabControl;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    procedure VCProviderMasterioOnRequest(const Sender: TObject;
      const AView: TComponent; out ResultViewContext: TComponent);
    procedure VCProviderMasterioOnAfterRequest(const Sender: TObject;
      const AView, AViewContext: TComponent);
    procedure VCProviderMasterioOnRelease(const Sender: TObject; const AView,
      AViewContext: TComponent);
    procedure SQLIteConnAfterRegister(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StartForm: TStartForm;

implementation

uses
  U.SampleData, V.Interfaces, iORM;

{$R *.fmx}

procedure TStartForm.FormCreate(Sender: TObject);
begin
  io.di.LocateView<IArticleListView>.Show;
end;

procedure TStartForm.SQLIteConnAfterRegister(Sender: TObject);
begin
  TSampleData.CheckForSampleData;
end;

procedure TStartForm.VCProviderMasterioOnAfterRequest(const Sender: TObject;
  const AView, AViewContext: TComponent);
begin
  NextTabAction1.Execute;
end;

procedure TStartForm.VCProviderMasterioOnRelease(const Sender: TObject;
  const AView, AViewContext: TComponent);
begin
  TabControl.Delete((AViewContext as TTabItem).Index);
end;

procedure TStartForm.VCProviderMasterioOnRequest(const Sender: TObject;
  const AView: TComponent; out ResultViewContext: TComponent);
begin
  ResultViewContext := TabControl.Add;
end;

end.
