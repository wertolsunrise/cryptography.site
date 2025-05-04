unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, Grids, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    XPManifest1: TXPManifest;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
    rot:string;
implementation

uses Unit2;

{$R *.dfm}
 //-------------------------Шифрование Плэйфера----------------------------------
function Playfair_Crypt(s,key:string):string;
const
//-----------------Размер ключевой матрицы:-------------------------------------
  MaxX = 8;//строки
  MaxY = 4;//столбцы
  //Наш алфавит. Размер должен быть MaxY*MaxX.
  //Поэтому в нашем случае убраны буква "ё"
  URusA = 'АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';

var i,j,t,x1,x2,y1,y2 :integer;
    M : array[1..MaxY,1..MaxX]of Char; //ключевая матрица
    temp :string;
    
//---Функция поиска символа "с" в ключевой матрице.-----------------------------
  //Возвращает строку "y" и столбец "x".
  Procedure SimbolPos(c:char;var x,y:integer);
  var i,j:integer;
  begin
  x:=0;
  y:=0;
  for i := 1 to MaxY do
    for j := 1 to MaxX do
      if c=M[i,j] then
        begin
        x:=j;
        y:=i;
        exit;
        end;
  end;

label M1;
begin
//---------переводим ключ и исходный текст в нижний регистр.--------------------
key:=AnsiUpperCase(key);
s:=AnsiUpperCase(s);
//----удаляем из строки все символы, не входящие в наш алфавит.-----------------
temp:='';
for i := 1 to length(s) do if pos(s[i],URusA)<>0 then temp:=temp+s[i];
s:=temp;
//----Создание ключевой матрицы, с использованием ключевого слова "key".--------
temp:='';
for i:=1 to length(key) do
 if pos(key[i],temp)=0 then temp:=temp+key[i];
for i:=1 to length(URusA) do
 if pos(URusA[i],temp)=0 then temp:=temp+URusA[i];
t:=0;
for i:=1 to 4 do
 for j:=1 to 8 do
 begin
 inc(t);
 M[i,j]:=temp[t];
 form1.StringGrid1.Cells[j,i]:=temp[t];
 end;


//----просмотр строки по парам символов и вставка разделяющего символа----------
        //"Ь" в случае когда в паре попались одинаковые символы.
M1:
for i:=1 to length(s)div 2 do
  begin
  if s[2*i-1]=s[2*i] then
    begin
    insert('Ф',s,2*i);
    goto M1;
    end;
  end;
//-------Добавляем символ в конец строки, если её длина нечётная.---------------
if length(s) MOD 2 = 1 then if s[length(s)]<>'Ф' then s:=s+'Ф'
                                                 else s:=s+'Я';
temp:='';
for i:=1 to length(s)div 2 do
  begin
  SimbolPos(s[2*i-1],x1,y1);
  SimbolPos(s[2*i],x2,y2);
//-------------------------------Правило 1--------------------------------------
  if y1 = y2 then
    begin
    inc(x1); inc(x2);
    if x1 > MaxX then x1:=x1-MaxX;
    if x2 > MaxX then x2:=x2-MaxX;
    temp:=temp+M[y1,x1]+M[y2,x2];
    end;
//-------------------------------Правило 2--------------------------------------
  if x1 = x2 then
    begin
    inc(y1); inc(y2);
    if y1 > MaxY then y1:=y1-MaxY;
    if y2 > MaxY then y2:=y2-MaxY;
    temp:=temp+M[y1,x1]+M[y2,x2];
    end;
//-------------------------------Правило 3--------------------------------------
  if (x1<>x2) and (y1<>y2) then temp:=temp+M[y1,x2]+M[y2,x1];
  end;
Playfair_Crypt:=temp;
rot:=temp;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Memo1.Text := Playfair_Crypt(Edit1.Text,Edit2.Text);

end;

//---------------------Дешифрование Плэйфера------------------------------------
function Playfair_DeCrypt(s,key:string):string;
const
  //Размер ключевой матрицы:
   MaxX = 8;//строки
   MaxY = 4;//столбцы
  //Наш алфавит. Размер должен быть MaxY*MaxX.
  //Поэтому в нашем случае убраны букву "ё".
  URusA = 'АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';

var i,j,t,x1,x2,y1,y2 :integer;
    M : array[1..MaxY,1..MaxX]of char; //ключевая матрица
    temp :string;

//---------Функция поиска символа "с" в ключевой матрице.-----------------------
              //Возвращает строку "y" и столбец "x".
  Procedure SimbolPos(c:char;var x,y:integer);
  var i,j:integer;
  begin
  x:=0;
  y:=0;
  for i := 1 to MaxY do
    for j := 1 to MaxX do
      if c=M[i,j] then
        begin
        x:=j;
        y:=i;
        exit;
        end;
  end;

label M1;
begin
//---------переводим ключ и исходный текст в нижний регистр.--------------------
key:=AnsiUpperCase(key);
s:=AnsiUpperCase(s);
//-------удаляем из строки все символы, не входящие в наш алфавит.--------------
temp:='';
for i := 1 to length(s) do
  begin
  if pos(s[i],URusA)<>0 then temp:=temp+s[i];
  end;
s:=temp;
//---Создание ключевой матрицы, с использованием ключевого слова "key".---------
temp:='';
for i:=1 to length(key) do
 if pos(key[i],temp)=0 then temp:=temp+key[i];
for i:=1 to length(URusA) do
 if pos(URusA[i],temp)=0 then temp:=temp+URusA[i];
t:=0;
for i:=1 to 4 do
 for j:=1 to 8 do
 begin
 inc(t);
 M[i,j]:=temp[t];
 end;

temp:='';
for i:=1 to length(s)div 2 do
  begin
  SimbolPos(s[2*i-1],x1,y1);
  SimbolPos(s[2*i],x2,y2);
//--------------Правило 1-------------------------------------------------------
  if y1 = y2 then
    begin
    dec(x1); dec(x2);
    if x1 <= 0 then x1:=x1+MaxX;
    if x2 <= 0 then x2:=x2+MaxX;
    temp:=temp+M[y1,x1]+M[y2,x2];
    end;
//-------------Правило 2--------------------------------------------------------
  if x1 = x2 then
    begin
    dec(y1); dec(y2);
    if y1 <= 0 then y1:=y1+MaxY;
    if y2 <= 0 then y2:=y2+MaxY;
    temp:=temp+M[y1,x1]+M[y2,x2];
    end;
//-------------Правило 3--------------------------------------------------------
  if (x1<>x2) and (y1<>y2) then temp:=temp+M[y1,x2]+M[y2,x1];
  end;
Playfair_DeCrypt:=temp;
end;

procedure TForm1.Button2Click(Sender: TObject);
 var

 z:string;
begin
 z:=Playfair_DeCrypt(Edit1.Text,Edit2.Text);
 Memo1.Text := z;
end;
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 Form2.ShowModal;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
edit1.Clear;
memo1.Clear;
end;

end.
