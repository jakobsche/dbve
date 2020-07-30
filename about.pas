unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileInfo;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    FileInfoListBox: TListBox;
    AuthorLabel: TLabel;
    VersionLabel: TLabel;
    procedure FormCreate(Sender: TObject);
  private

  public
    VersionInfo: TFileVersionInfo;
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.lfm}

{ TAboutBox }

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  Caption := Format('Über %s', [Application.Title]);
  VersionInfo := TFileVersionInfo.Create(Self);
  try
    VersionInfo.FileName := Application.ExeName;
    VersionInfo.ReadFileInfo;
    VersionLabel.Caption := Format('Version %s', [VersionInfo.VersionStrings.Values['FileVersion']]);
    AuthorLabel.Caption := Format('Autor: %s', [VersionInfo.VersionStrings.Values['CompanyName']]);
    FileInfoListBox.Items := VersionInfo.VersionStrings;
  except
    on E: Exception do begin
      ShowMessageFmt('%s: %s', [E.ClassName, E.Message])
    end;
  end;
end;

end.

