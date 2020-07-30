unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, Menus,
  DBGrids, StdActns, DB;

type

  { TForm1 }

  TForm1 = class(TForm)
    AppInfo: TAction;
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    HelpAction1: THelpAction;
    HelpOnHelp1: THelpOnHelp;
    MainMenu1: TMainMenu;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog: TOpenDialog;
    TableOpenItem: TMenuItem;
    TableItem: TMenuItem;
    TableOpen: TAction;
    ActionList1: TActionList;
    procedure AppInfoExecute(Sender: TObject);
    procedure TableOpenExecute(Sender: TObject);
  private

  public
    DataSet: TDataSet;
  end;

var
  Form1: TForm1;

implementation

uses DBF, About;

{$R *.lfm}

{ TForm1 }

procedure TForm1.TableOpenExecute(Sender: TObject);

procedure LoadDBF;
begin
  (DataSet as TDbf).TableName := OpenDialog.FileName;
  DataSet.Open;
  DataSource.DataSet := DataSet;
  DBGrid.DataSource := DataSource;
  DBGrid.AutoAdjustColumns;
end;

begin
  with OpenDialog do
    if Execute then begin
      case FilterIndex of
        1: begin
            DataSet.Free;
            DataSet := TDbf.Create(Self);
            case MessageDlg('Soll die Datei geändert werden?', mtConfirmation, mbYesNoCancel, 0, mbNo) of
              mrYes: begin
                  (DataSet as TDbf).ReadOnly := False;
                  LoadDBF;
                end;
              mrNo: begin
                  (DataSet as TDbf).ReadOnly := True;
                  LoadDBF
                end;
              mrCancel:;
            end;
          end;
      end;
    end;
end;

procedure TForm1.AppInfoExecute(Sender: TObject);
begin
  AboutBox.ShowModal
end;

end.

