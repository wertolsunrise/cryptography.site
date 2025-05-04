unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    Memo2: TMemo;
    CheckBox: TCheckBox;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    BitBtn2: TBitBtn;
    Button1: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
 const Buk:array[0..65] of char = ('А','Б','В','Г','Д','Е','Ё','Ж','З','И','Й', 'К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ъ','Ы','Ь','Э','Ю','Я', 'а','б','в','г','д','е','ё','ж','з','и','й','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы', 'ь','э','ю','я');
var
  Form1: TForm1;
  b:array[0..65] of char;
  i, j, k: byte;
  s, s2:string;
implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
For i:=0 to 65 do
  begin                        //Формирование нового массива
    b[i]:= Buk[(i+1) mod 66];
  end;

  if CheckBox.Checked = false then begin
    k := StrToInt(MaskEdit1.Text);
    s := Memo1.Lines.Text;
    for i := 1 to length(s) do
      for j := 0 to 65 do
        if s[i] = b[j] then s2 := s2+b[(j+(k-1)) mod 66];
    Memo2.Lines.Text := s2;
    s2 := '';
  end;

  if CheckBox.Checked = true then begin
    k := StrToInt(MaskEdit1.Text);
    s := Memo1.Lines.Text;
    for i := 1 to length(s) do
      for j := 0 to 65 do
        if s[i] = b[j] then s2 := s2+b[(j-(k-1)) mod 66];
    Memo2.Lines.Text := s2;
    s2 := '';
  end;


end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
   Form2.ShowModal;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
memo1.Clear;
memo2.Clear;
end;

end.



