unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type

  TCoord = Record
    x: Integer;
    y: Integer;
  End;

  TCoords = array of TCoord;

  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;

    procedure StringGrid1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function place(colx, rowx: Integer; g: TStringGrid; capx: TLabel): Boolean;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function isavail(sg: TStringGrid; x, y: Integer): Boolean;
    function GetCand(stg: TStringGrid): TCoords;
    function tryx(n: Int8; sgx: TStringGrid): Boolean;
    function qcount(s: TStringGrid): Integer;
    function totcx(sx: TStringGrid): Integer;
    procedure propfy();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  empty: Array [0 .. 7, 0 .. 7] of Boolean;
  tryused: Boolean;
  setused: Array [0 .. 96] of Boolean;
  steps: UInt64;

implementation

{$R *.dfm}

procedure Delay(msecs: Longint);
var
  targettime: Longint;
  Msg: TMsg;
begin
  targettime := GetTickCount + msecs;
  while targettime > GetTickCount do
    if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    begin
      if Msg.message = WM_QUIT then
      begin
        PostQuitMessage(Msg.wParam);
        Break;
      end;
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  pcx, totc, pcy, xc, yc, qc, exx, eyy: Int64;
  ret: Boolean;
begin
  propfy();
  if CheckBox2.Checked = True then
    Button2Click(Sender);
  if totcx(StringGrid1) = 64 then
    Button2Click(Sender);
  Delay(100);
  Screen.Cursor := crHourGlass;
  steps := 0;
  tryx(8 - StrToInt(Label1.Caption), StringGrid1);

  Label1.Caption := IntToStr(qcount(StringGrid1));
  if CheckBox2.Checked = False then
    if StrToInt(Label1.Caption) < 8 then
      showmessage
        ('The board is not solvable with the locations you specified. Please reset the board, or check the "Clear Before Simulation" button.');

  Screen.Cursor := crDefault;
  Label3.Caption := UIntToStr(steps);
  tryused := True;
  propfy();
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
  n: Integer;
begin
  for i := 0 to 7 do
    for n := 0 to 7 do
      StringGrid1.Cells[i, n] := '';
  Label1.Caption := '0';
  tryused := False;

end;

function TForm1.GetCand(stg: TStringGrid): TCoords;
var
  emi: Integer;
  emn, ex: Integer;
  al: TCoords;
begin
  ex := 0;
  for emi := 0 to 7 do
    for emn := 0 to 7 do
      if stg.Cells[emi, emn] = '' then
      begin
        empty[emi, emn] := True;
        SetLength(al, ex + 1);
        al[ex].x := emi;
        al[ex].y := emn;
        ex := ex + 1;
      end

      else
        empty[emi, emn] := False;
  result := al;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  showmessage('Thank you for using Palash Software' + Chr(39) + 's')
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  pcx, pcy: Int64;
begin
  StringGrid1.Font.Size := 40;
  Button1.Visible := True;
  CheckBox1.Checked := True;

end;

function TForm1.isavail(sg: TStringGrid; x, y: Integer): Boolean;
begin
  if sg.Cells[x, y] = '' then
    result := True
  else
    result := False;
end;

function TForm1.place(colx, rowx: Integer; g: TStringGrid;
  capx: TLabel): Boolean;
var
  xx, yy, i, c, r, countx: Integer;
begin
  c := colx;
  r := rowx;

  if g.Cells[c, r] = '' then
  begin
    g.Cells[c, r] := 'Q';
    // capx.Caption := inttostr(StrToInt(capx.Caption) + 1);

    for i := 0 to 7 do
    begin
      if (g.Cells[c, i] = '') then
        g.Cells[c, i] := 'X';
      if g.Cells[i, r] = '' then
        g.Cells[i, r] := 'X';
    end;
    for xx := 0 to 7 do
      for yy := 0 to 7 do
      begin
        if g.Cells[xx, yy] = '' then
          if (NOT(xx = c)) AND (NOT(yy = r)) then
            if ((xx + yy) = (r + c)) OR ((xx - yy) = (c - r)) then
              g.Cells[xx, yy] := 'X';

      end;

  end;
  countx := 0;
  for xx := 0 to 7 do
    for yy := 0 to 7 do
      if NOT(g.Cells[xx, yy] = '') then
        countx := countx + 1;

  // if countx = 64 then
  // begin
  // showmessage('Game Over!');
  // g.Enabled := False;
  // end;
  if countx = 8 then
    result := True
  else
    result := False;

end;

procedure TForm1.propfy;
begin
  Button1.Enabled := NOT(Button1.Enabled);
  CheckBox2.Enabled := NOT(CheckBox2.Enabled);
  Button2.Enabled := NOT(Button2.Enabled);
end;

function TForm1.qcount(s: TStringGrid): Integer;
var
  i: Integer;
  j: Integer;
  r: Integer;
begin
  r := 0;
  for i := 0 to 7 do
    for j := 0 to 7 do
      if s.Cells[i, j] = 'Q' then
        r := r + 1;
  result := r;
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
var
  qcx, xx, yy, i, c, r, countx: Integer;

begin
  c := StringGrid1.Col;
  r := StringGrid1.Row;
  if StringGrid1.Cells[c, r] = '' then
  begin
    StringGrid1.Cells[c, r] := 'Q';
    Label1.Caption := IntToStr(StrToInt(Label1.Caption) + 1);

    for i := 0 to 7 do
    begin
      if (StringGrid1.Cells[c, i] = '') then
        StringGrid1.Cells[c, i] := 'X';
      if StringGrid1.Cells[i, r] = '' then
        StringGrid1.Cells[i, r] := 'X';
    end;
    for xx := 0 to 7 do
      for yy := 0 to 7 do
      begin
        if StringGrid1.Cells[xx, yy] = '' then
          if (NOT(xx = c)) AND (NOT(yy = r)) then
            if ((xx + yy) = (r + c)) OR ((xx - yy) = (c - r)) then
              StringGrid1.Cells[xx, yy] := 'X';

      end;

  end;
  countx := 0;
  qcx := 0;
  for xx := 0 to 7 do
    for yy := 0 to 7 do
    begin
      if NOT(StringGrid1.Cells[xx, yy] = '') then
        countx := countx + 1;
      if StringGrid1.Cells[xx, yy] = 'Q' then
        qcx := qcx + 1;
    end;

  if countx = 64 then
  begin
    if qcx < 8 then
      if tryused = False then
        showmessage('Game Over!')
      else
        showmessage('You Won!');

  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  co, cx, cy: Int64;
begin
  co := 0;
  for cx := 0 to 7 do
    for cy := 0 to 7 do
      if StringGrid1.Cells[cx, cy] = 'Q' then
        co := co + 1;

  for cx := 0 to 7 do
    for cy := 0 to 7 do
      StringGrid1.Cells[cx, cy] := '';
end;

function TForm1.totcx(sx: TStringGrid): Integer;
var
  i, t, ix: Integer;
begin
  t := 0;
  for i := 0 to 7 do
    for ix := 0 to 7 do
      if NOT(sx.Cells[i, ix] = '') then
        t := t + 1;
  result := t;

end;

function TForm1.tryx(n: Int8; sgx: TStringGrid): Boolean;
var
  pc: TCoords;
  tix: Integer;
  rx: Boolean;
  data: TStringList;
  nix: Integer;
  it, nt: Integer;
  cbs: Array [0 .. 7, 0 .. 7] of String;
  rdx: Integer;
  trdx: Integer;
begin
  steps := steps + 1;
  Label3.Caption := UIntToStr(steps);
  Label1.Caption := IntToStr(qcount(StringGrid1));
  data := TStringList.Create;
  pc := GetCand(StringGrid1);
  rdx := Random(Length(pc));
  result := False;
  if n = 0 then
    result := True
  else
  begin
    for it := 0 to 7 do
      for nt := 0 to 7 do
        cbs[it, nt] := sgx.Cells[it, nt];

    for tix := 0 to Length(pc) - 1 do
    begin
      trdx := (tix + rdx) mod Length(pc);

      if CheckBox1.Checked = True then
        Delay(1);
      place(pc[trdx].x, pc[trdx].y, StringGrid1, Label1);
      rx := tryx(n - 1, StringGrid1);
      if NOT(rx) then
      begin
        for it := 0 to 7 do
          for nt := 0 to 7 do
            sgx.Cells[it, nt] := cbs[it, nt];
      end
      else
      begin
        result := True;
        exit;
      end;

    end;

  end;

end;

end.
