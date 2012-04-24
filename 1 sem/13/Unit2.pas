unit Unit2;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls;

Type
  TInfo = record
    PN:string[20];
    plane:string[20];
    NR,Tm:word;
  end;
  TSaS = class (TObject)
    LInf,SInf:file of TInfo;
    TInf:textfile;
    planes:array[1..15] of TInfo;
    FileNameS,FileNameL:string;

    procedure PCreate(SD: TSaveDialog);
    procedure POpen(OD: TOpenDialog; M1: TMemo);
    procedure PSave(SD, SD2: TSaveDialog);
    procedure PAdd(E1,E2,E3,E4:TEdit;M1:TMemo);
    procedure PLineSearch(E1:TEdit;M1:TMemo);
    procedure PPrChoice(M1:TMemo);
    procedure PQuickSort(M1:TMemo);
    procedure PDSearch(E1:TEdit;M1:TMemo);
  end;

  var
    num: word;
    k: string[20];

implementation

procedure TSaS.PCreate;
  begin
    if SD.Execute then
      begin
        FileNameL:=SD.FileName;
        AssignFile(LInf,FileNameL);
        Rewrite(LInf);
     end;
  end;
procedure TSaS.POpen;
  begin
    if OD.Execute then
   begin
    FileNameL:=OD.FileName;
    AssignFile(LInf,FileNameL);
    Reset(LInf);
  end;
  num:=0;
  while not eof(LInf) do
    begin
      Inc(num);
      Read(LInf,planes[num]);
      with planes[num] do
         M1.Lines.Add(IntToStr(num)+') ���� �'+IntToStr(NR)+', ����� ������: '+IntToStr(Tm)+' �����, ��� �������: '+plane+', ����� ����������: '+PN);
    end;
  end;

procedure TSaS.PSave;
var
  i:word;
begin
  if SD.Execute then
    begin
      FileNameS:=SD.FileName;
      AssignFile(SInf,FileNameS);
      Rewrite(SInf);
    end;
  for i:=1 to num do
    write(SInf,planes[i]);
  CloseFile(SInf);
  if SD2.Execute then
    begin
      FileNameS:=SD2.FileName;
      AssignFile(TInf,FileNameS);
      Rewrite(TInf);
    end;
  for i:=1 to num do
    with planes[i] do writeln(TInf,i:4,'.',' ������: ',NR,', ����� ����������: ',PN,', ����� �����������: ',Tm,', ��� �������: ',plane);
  CloseFile(TInf);
end;

procedure TSaS.PAdd;
begin
  num:=num+1;
  with planes[num] do
    begin
      PN:=E1.Text;
      plane:=E2.Text;
      NR:=StrToInt(E3.Text);
      Tm:=StrToInt(E4.Text);
      M1.Lines.Add('�'+IntToStr(num)+', ����� �����: '+IntToStr(NR)+', ����� ����������: '+PN+', ����� ������: '+IntToStr(Tm)+' �����, ��� �������: '+plane);
    end;
end;

procedure TSaS.PLineSearch;
  var
    i:byte;
  begin
    M1.Clear;
    k:=E1.Text;
    for i:=1 to num do
      if planes[i].PN = k then
        with planes[i] do
         M1.Lines.Add('����� �����: '+IntToStr(NR)+', ����� ����������: '+PN+', ����� ������: '+IntToStr(Tm)+' �����, ��� �������: '+plane);
  end;

Procedure TSaS.PPrChoice;
  var
    i,j,m:byte;
    r:TInfo;
  begin
    M1.Clear;
    for i:=1 to num do
      begin
        m:=i;
        for j:=i+1 to num do
          if planes[j].PN < planes[m].PN then
            m:=j;
        r:=planes[m];
        planes[m]:=planes[i];
        planes[i]:=r;
        with planes[i] do
          M1.Lines.Add('����� �����: '+IntToStr(NR)+', ����� ����������: '+PN+', ����� ������: '+IntToStr(Tm)+' �����, ��� �������: '+plane);
      end;
  end;

procedure TSaS.PQuickSort;
  var
    i,j,m:byte;
    x: string [20];
    r: TInfo;
  begin
    M1.Clear;
    if Odd(num) then  m:=num div 2 + 1
                else  m:=num div 2;
    i:=1;
    j:=num;
    x:=planes[m].PN;
    repeat
      while planes[i].PN < x do
        i:=i+1;
      while x < planes[j].PN do
        j:=j-1;
      if i<=j then
        begin
          r:=planes[i];
          planes[i]:=planes[j];
          planes[j]:=r;
          i:=i+1;
          j:=j-1;
        end;
    until i>j;
    for i:=1 to num do
            with planes[i] do
          M1.Lines.Add('����� �����: '+IntToStr(NR)+', ����� ����������: '+PN+', ����� ������: '+IntToStr(Tm)+' �����, ��� �������: '+plane);
  end;

procedure TSaS.PDSearch;
  function Del(L,R:word;y:string):word;
    var m:word;
    begin
      if R<=L then Del:=R
      else begin
            m:=(L+R) div 2;
            if planes[m].PN < y then Del:=Del(m+1,R,y)
                                else Del:=Del(L,m,y);
           end;
    end;
  var
    i,j:word;
    x:string[20];
  begin
    x:=E1.Text;
    j:=0;
   while j<=num do
    begin
      i:=Del(j,num,x);
      j:=i+1;
      if planes[i].PN = x then
        with planes[i] do
            M1.Lines.Add('����� �����: '+IntToStr(NR)+', ����� ����������: '+PN+', ����� ������: '+IntToStr(Tm)+' �����, ��� �������: '+plane);
    end;
  end;
end.

