unit uHomManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JclSysInfo, ExtCtrls, Buttons,
  JvTrayIcon, Mask, JvExMask, JvSpin;, JvComponentBase

type
	TDirection = (drLeft, drTop, drRight, drBottom, drTopLeft, drTopRight, drBottomLeft, drBottomRight);


  TForm1 = class(TForm)
    cbWindowsList: TComboBox;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    cbFeedPet: TCheckBox;
    bGo: TButton;
    FeedTimer: TTimer;
    GroupBox2: TGroupBox;
    Shape1: TShape;
    rbPetFull: TRadioButton;
    rbPetHungry: TRadioButton;
    Button2: TButton;
    WalkTimer: TTimer;
    bStop: TButton;
    GroupBox3: TGroupBox;
    chbAutoloot: TCheckBox;
    Label2: TLabel;
    seLeftWidth: TJvSpinEdit;
    Label3: TLabel;
    seRightWidth: TJvSpinEdit;
    bTest: TButton;
    seTopHeight: TJvSpinEdit;
    seBottomHeight: TJvSpinEdit;
    JvTrayIcon1: TJvTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure bGoClick(Sender: TObject);
    procedure FeedTimerTimer(Sender: TObject);
    procedure cbWindowsListChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure bStopClick(Sender: TObject);
    procedure bTestClick(Sender: TObject);
    procedure WalkTimerTimer(Sender: TObject);
  private
    { Private declarations }
    fSelectedWindowHandle : THandle;
    fClientRORect : TRect;
    fScreenCenter : TPoint;
    fPosition : TPoint;
    procedure CollectROInfo;
    function GetColor(X, Y : integer) : TColor;
    function PetNeedFeed: boolean;
    procedure FeedPet;
    procedure MouseMove(x, y : integer);
    procedure MouseLeftClick(x, y: integer);
    procedure MoveToDirection(aDirection : TDirection; aCells : integer = 1);
    procedure MoveToPoint(aStart, aFinish : TPoint);
  public
    { Public declarations }
  end;
const
	CheckFullColorRelX = -175;
  CheckFullColorRelY = 169;

  FeedMouseClickRelX = -55;
  FeedMouseClickRelY = 185;

  FeedMouseConfirmRelX = -450;
  FeedMouseConfirmRelY = 445;
  BackgroundColor : TColor = clWhite;
var
  Form1: TForm1;

implementation

{$R *.dfm}

function RandomPeriod(aStartValue, aEndValue : integer) : integer;
begin
	if aStartValue > aEndValue then
  	Result := Random(aStartValue - aEndValue + 1) + aEndValue
  else
    Result := Random(aEndValue - aStartValue + 1) + aStartValue;

    
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	cbWindowsList.Items.Clear;
  GetTasksList(cbWindowsList.Items);
  Randomize;
end;

procedure TForm1.bGoClick(Sender: TObject);
begin
	cbWindowsList.Enabled := False;
  seLeftWidth.Enabled := False;
  seRightWidth.Enabled := False;
  seTopHeight.Enabled := False;
  seBottomHeight.Enabled := False;
  WindowState := wsMinimized;

  fPosition.X := 0;
  fPosition.Y := 0;

	FeedTimer.Enabled := cbFeedPet.Checked;
  WalkTimer.Enabled := chbAutoloot.Checked;
end;

procedure TForm1.FeedTimerTimer(Sender: TObject);
begin
//$00CE7B52 - цвет сытости
	if PetNeedFeed then
    FeedPet;
end;

function TForm1.PetNeedFeed: boolean;
var
  vPixelColor : TColor;
begin
	vPixelColor := GetColor(fClientRORect.Right + CheckFullColorRelX, fClientRORect.Top + CheckFullColorRelY);

  Result := ((vPixelColor <> Shape1.Brush.Color) and (rbPetFull.Checked)) or ((vPixelColor = Shape1.Brush.Color) and (rbPetHungry.Checked));
end;

function TForm1.GetColor(X, Y: integer): TColor;
var
	vROHandle : HDC;
begin
  vROHandle := GetDC(fSelectedWindowHandle);
  try
  	if vROHandle <> 0 then
			Result := Windows.GetPixel(vROHandle, X, Y)
    else
    	Exception.Create('Хэндл = 0');
	finally
    ReleaseDC(fSelectedWindowHandle, vROHandle);
  end;
end;

procedure TForm1.FeedPet;
begin
//Нажимаем кнопку "Кормить"

  MouseMove(fClientRORect.Right + FeedMouseClickRelX, fClientRORect.Top + FeedMouseClickRelY);
  Sleep(50);
  MouseLeftClick(fClientRORect.Right + FeedMouseClickRelX, fClientRORect.Top + FeedMouseClickRelY);

	while GetColor(fScreenCenter.X, fScreenCenter.Y) <> BackgroundColor do //доделать цикл нажатия кормить
   	Sleep(50);

//Нажимаем кнопку "ОК" в окне подтверждения
	MouseMove(fClientRORect.Right + FeedMouseConfirmRelX, fClientRORect.Top + FeedMouseConfirmRelY);
  Sleep(100);
  MouseLeftClick(fClientRORect.Right + FeedMouseConfirmRelX, fClientRORect.Top + FeedMouseConfirmRelY);

//
//
end;

procedure TForm1.cbWindowsListChange(Sender: TObject);
begin
	fSelectedWindowHandle := THandle(cbWindowsList.Items.Objects[cbWindowsList.ItemIndex]);
	CollectROInfo;
end;

procedure TForm1.CollectROInfo;
var
	vCaptionHeight : integer;
  vBorderWidth : integer;
  vRect : TRect;
begin
  BringWindowToTop(fSelectedWindowHandle);
  Sleep(500);
	fClientRORect := Rect(0, 0, 0, 0);
  vCaptionHeight := GetSystemMetrics(SM_CYCAPTION);
  vBorderWidth := GetSystemMetrics(SM_CXEDGE);
  GetWindowRect(fSelectedWindowHandle, fClientRORect);
  fClientRORect.Top := fClientRORect.Top - vCaptionHeight - vBorderWidth;
  fScreenCenter.X := (fClientRORect.Right - fClientRORect.Left) div 2;
  fScreenCenter.Y := (fClientRORect.Bottom - fClientRORect.Top) div 2;
  Shape1.Brush.Color := GetColor(fClientRORect.Right + CheckFullColorRelX, fClientRORect.Top + CheckFullColorRelY);


// 747, 201 - 1028, 23
// 849x172
// 280x180
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//  FeedPet;
end;

procedure TForm1.MouseMove(x, y: integer);
var
	vPoint : TPoint;
begin
	vPoint.X := X;
  vPoint.Y := Y;
  Windows.ClientToScreen(fSelectedWindowHandle, vPoint);
  SetCursorPos(vPoint.X, vPoint.Y);
end;

procedure TForm1.MouseLeftClick(x, y: integer);
begin
	mouse_event(MOUSEEVENTF_LEFTDOWN,X,Y,0,0);
  mouse_event(MOUSEEVENTF_LEFTUP,X,Y,0,0);
end;

procedure TForm1.bStopClick(Sender: TObject);
begin
	cbWindowsList.Enabled := True;
  seLeftWidth.Enabled := True;
  seRightWidth.Enabled := True;
  seTopHeight.Enabled := True;
  seBottomHeight.Enabled := True;
  WindowState := wsNormal;
	FeedTimer.Enabled := False;
  WalkTimer.Enabled := False;
end;

procedure TForm1.MoveToDirection(aDirection: TDirection; aCells : integer);
begin

	case aDirection of
  	drLeft : begin
    	MouseMove(fScreenCenter.X - (30*aCells), fScreenCenter.Y - 20);
      MouseLeftClick(fScreenCenter.X - (30*aCells), fScreenCenter.Y - 20);
    end;
    drTop : begin
    	MouseMove(fScreenCenter.X, fScreenCenter.Y - 20 - (30*aCells));
      MouseLeftClick(fScreenCenter.X, fScreenCenter.Y - 20 - (30*aCells));
    end;
    drRight : begin
    	MouseMove(fScreenCenter.X + (30*aCells), fScreenCenter.Y - 20);
      MouseLeftClick(fScreenCenter.X + (30*aCells), fScreenCenter.Y - 20);
    end;
    drBottom : begin
    	MouseMove(fScreenCenter.X, fScreenCenter.Y - 20 + (30*aCells));
      MouseLeftClick(fScreenCenter.X, fScreenCenter.Y - 20 + (30*aCells));
    end;
    drTopLeft :  begin
    	MouseMove(fScreenCenter.X - (30*aCells), fScreenCenter.Y - 20 - (30*aCells));
      MouseLeftClick(fScreenCenter.X - (30*aCells), fScreenCenter.Y - 20 - (30*aCells));
    end;
    drTopRight : begin
    	MouseMove(fScreenCenter.X + (30*aCells), fScreenCenter.Y - 20 - (30*aCells));
      MouseLeftClick(fScreenCenter.X + (30*aCells), fScreenCenter.Y - 20 - (30*aCells));
    end;
    drBottomLeft : begin
    	MouseMove(fScreenCenter.X - (30*aCells), fScreenCenter.Y - 20 + (30*aCells));
      MouseLeftClick(fScreenCenter.X - (30*aCells), fScreenCenter.Y - 20 + (30*aCells));
    end;
    drBottomRight :begin
    	MouseMove(fScreenCenter.X + (30*aCells), fScreenCenter.Y - 20 + (30*aCells));
      MouseLeftClick(fScreenCenter.X + (30*aCells), fScreenCenter.Y - 20 + (30*aCells));
    end;
  end;
end;

procedure TForm1.bTestClick(Sender: TObject);
begin
	WalkTimerTimer(Sender);	
end;

procedure TForm1.MoveToPoint(aStart, aFinish: TPoint);
begin
//	Memo1.Lines.Add(Format('(%D, %D) - (%D, %D)',[aStart.X, aStart.Y, aFinish.X, aFinish.Y]));
  MouseMove(fScreenCenter.X + (30 * (aFinish.X - aStart.X)), fScreenCenter.Y - 20 + (30 * (aFinish.Y - aStart.Y)));
  MouseLeftClick(fScreenCenter.X + (30 * (aFinish.X - aStart.X)), fScreenCenter.Y - 20 + (30 * (aFinish.Y - aStart.Y)));
end;

procedure TForm1.WalkTimerTimer(Sender: TObject);
var
	NewPos : TPoint;
begin
  NewPos := Point(RandomPeriod(Trunc(seLeftWidth.Value), Trunc(seRightWidth.Value)),
                  RandomPeriod(Trunc(seTopHeight.Value), Trunc(seBottomHeight.Value)));
  MoveToPoint(fPosition, NewPos);
  fPosition := NewPos;                
end;

end.
