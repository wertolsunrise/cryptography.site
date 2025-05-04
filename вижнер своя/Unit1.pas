unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Memo2: TMemo;
    Label4: TLabel;
    Button3: TButton;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
     private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mas_alf: array[1..32] of char = ('А','Б','В','Г','Д','Е','Ж','З','И','Й','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ь','Ы','Ъ','Э','Ю','Я');
  tab_Vig: array[1..32,1..32] of Char;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i,j,k,n:integer;
begin
 k:=0;
 n:=k;

 for i:=Ord('А')-191 to Ord('Я')-191 do
 begin
   k:=n+1;
   for j:=Ord('А')-191 to Ord('Я')-191 do
    begin
     if k = 33 then
        k:=1;
     tab_vig[i][j]:=mas_alf[k];
     k:=k+1;
    end;
    n:=n+1;
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  key : array [0..255] of Char;
  s:char;
  k:Boolean;
  length_key,length_text,i,j,c,stroka,stolbec: integer;
begin
  Label5.Caption:='';//
  Memo2.Clear;//
  length_key:=Edit1.GetTextLen;
  Edit1.GetTextBuf(key,sizeof(key));
  length_text:=Memo1.GetTextLen;

 for i:=Ord('А')-191 to Ord('Я')-191 do
 begin
    for j:=Ord('А')-191 to Ord('Я')-191 do
    begin
      Label5.Caption:= Label5.Caption +'  '+ tab_Vig[i][j];
    end;
    Label5.Caption := Label5.Caption + #13+#10;
 end;

 j:=1;
 c:=0;
 k:=false;
 Memo2.Lines.Add('Зашифрованный текст:');
 Memo2.Lines.Add('------------------------');
  for i:= 0 to Memo1.Lines.Count-1 do
  begin

     s:=Memo1.Lines[i][j];
     if ((s <> #0) or (s <> #13)) then
     while k = false do
     begin
       if Ord(key[c])>223 then
         stolbec:=Ord(key[c])-32-191
       else
         stolbec:=Ord(s)-191;
       if Ord(s)>223 then
         stroka:=Ord(s)-32-191
       else
         stroka:=Ord(s)-191;
       Memo2.Text:=Memo2.Text+tab_Vig[stroka][stolbec];
       if(c < length_key-1)then
         c:=c+1
       else
         c:=0;
       j:=j+1;
       s:=Memo1.Lines[i][j];
       if(s = #0) then
         k:=true;
     end;
     k:=false;
     j:=1;
  end;
 Memo2.Lines.Add('------------------------');
end;


procedure TForm1.Button3Click(Sender: TObject);
var
  key : array [0..255] of Char;
  s:char;
  k:Boolean;
  length_key,length_text,i,j,c,stroka,stolbec,q: integer;
begin
  Label5.Caption:='';//
  Memo2.Clear;//
  length_key:=Edit1.GetTextLen;
  Edit1.GetTextBuf(key,sizeof(key));
  length_text:=Memo1.GetTextLen;
  j:=1;
  c:=0;
  k:=false;
  Memo2.Lines.Add('Расшифрованный текст:');
  Memo2.Lines.Add('------------------------');
  for i:= 0 to Memo1.Lines.Count-1 do
  begin

     s:=Memo1.Lines[i][j];
     if ((s <> #0) or (s <> #13)) then
     while k = false do
     begin
       if Ord(key[c])>223 then
         stolbec:=Ord(key[c])-32-191
       else
         stolbec:=Ord(s)-191;
       //if Ord(s)>223 then
         //stroka:=Ord(s)-32-191
       //else
         //stroka:=Ord(s)-191;
       for q:=1 to 32 do
       begin
         if tab_Vig[q][stolbec] = s then
         begin
           Memo2.Text:=Memo2.Text+Chr(q+191);
            break;
         end;
       end;

       if(c < length_key-1)then
         c:=c+1
       else
         c:=0;
       j:=j+1;
       s:=Memo1.Lines[i][j];
       if(s = #0) then
         k:=true;
     end;
     k:=false;
     j:=1;
  end;
 Memo2.Lines.Add('------------------------');
end;
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
   Form2.ShowModal;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
memo1.Clear;
memo2.Clear;
end;

end.

