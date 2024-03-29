unit UHesh;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, ComCtrls;

Type  Tkey=integer;
      TInf=record
        FIO:string;
        key:Tkey;
      end;
      PSel=^TSel;
      TSel=record
        Inf:TInf;
        A:PSel;
      end;
      TMas=array [0..1] of PSel;
      PMas=^TMas;

      TH=class(TObject)
        M,n:word;
        sp,sp1:PSel;
        H:PMas;
        constructor Create(M0:word);
        procedure Add(Inf:TInf);
        procedure Print(Memo:TMemo);
        destructor Free(var SG:TStringGrid);
        procedure Read(key:TKey; var Inf:TInf);
        procedure ReadDel(key:TKey; var Inf:TInf);
        procedure Srednee;
        procedure PrintSr(Memo:TMemo);
      end;

var sum,num,sr: extended;

implementation

constructor TH.Create;
var i:word;
begin
  M:=M0;
  n:=0;
  GetMem(H,M*4);
  for i:=0 to M-1 do
    H[i]:=Nil;
end;

destructor TH.Free;
var i,j:integer;
begin
  j:=-1;
  for i:=0 to M-1 do
    while H[i]<>Nil do
      begin
        Inc(j);
        sp:=H[i];
        SG.Cells[0,j]:=sp^.inf.Fio;
        SG.Cells[1,j]:=IntToStr(sp^.inf.key);
        H[i]:= sp^.A;
        Dispose(sp);
      end;
  FreeMem(H,4*M);
end;

procedure TH.Add;
var i:integer;
    p:PSel;
begin
  i:=inf.key mod M;
  New(p);
  Inc(n);
  p^.inf:=Inf;
  p^.A:=H[i];
  H[i]:=p;
end;

procedure TH.Read;
var i:integer;
begin
  i:=key mod M;
  sp:=H[i];
  while (sp<>Nil) and (sp^.inf.key<>key) do
    sp:=sp^.A;
  if sp<>Nil then
    inf:=sp^.inf
  else
    ShowMessage('���� �� ������');
end;

procedure TH.ReadDel;
var i:integer;
begin
  i:=key mod M;
  sp:=H[i];
  sp1:=sp;
  while (sp<>Nil) and (sp^.inf.key<>key) do
    begin
      sp1:=sp;
      sp:=sp^.A;
    end;
  if sp<>Nil then
    begin
      inf:=sp^.inf;
      if sp1=sp then
        H[i]:=sp^.A
      else
        sp1^.A:=sp^.A;
      Dispose(sp);
      Dec(n);
    end
  else
    ShowMessage('���� �� ������');
end;

procedure TH.Print;
      procedure PrintMemo(sp:PSel;M:TMemo);
      begin
        while sp<>Nil do
          begin
            M.Lines.Add(sp^.inf.FIO+' '+IntToStr(sp^.inf.key));
            sp:=sp^.A;
          end;
      end;
var i:integer;
begin
  for i:=0 to M-1 do
    if H[i]<>Nil then
      PrintMemo(H[i],Memo);
end;

procedure TH.Srednee;
  procedure sumnum(sp:PSel);
    begin
      while sp<>Nil do
        begin
          sum:=sum+sp^.Inf.key;
          num:=num+1;
          if sp^.A<>nil then sp:=sp^.A
          else exit;
        end;
    end;
var i,j: integer;
begin
  if H[0]=Nil then
    begin
      i:=0;
      while H[i]=Nil do
        Inc(i);
    end
  else
    i:=0;
  j:=i;
  sum:=0; num:=0;
  if j < M-1 then
    for i:=j to M-1 do
      if H[i]<>Nil then
        sumnum(H[i]);
end;

procedure TH.PrintSr;
      procedure PrintMemo(sp:PSel;M:TMemo);
      begin
        while sp<>Nil do
          begin
            if sp^.Inf.key <= sr then Memo.Lines.Add(sp^.inf.FIO+' '+IntToStr(sp^.inf.key));
            sp:=sp^.A;
          end;
      end;
var i:integer;
begin
  for i:=0 to M-1 do
    if H[i]<>Nil then
      PrintMemo(H[i],Memo);
end;

end.
