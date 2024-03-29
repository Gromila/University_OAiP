unit Unit2;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids;

Type  Tkey=LongWord;
      Tinf=record
        S:string[80];
        key:Tkey;
      end;
      TMs=array [1..50] of TInf;
      Ptree=^tree;
      Tree=record
        Inf:TInf;
        A1:Ptree;
        A2:Ptree;
      end;
      TTree=Class(TObject)
		    proot,p,q,v,w:Ptree;
		    constructor create;
        procedure AddB(Inf:TInf);
        procedure Make1B(a:Tms; N:word);
		    procedure View;
		    procedure WrtB;
        procedure BLns(a:Tms;N:word);
        procedure Delk(k:Tkey);
        function Poisk(k:Tkey):TInf;
        function Srkey(r:Ptree):extended;
        function FindNear(r:Ptree):TKey;
        procedure Delete(p:Ptree);
		    destructor Free;
      end;

var
   sredn,sum,n, dx, dmin: extended;
   dk: TKey;

implementation

uses Unit1;

constructor Ttree.create;
begin
  Inherited create;
  proot:=nil;
end;

procedure Ttree.AddB;
var bl:boolean;
begin
  New(w);
  w^.Inf:=Inf;
  w^.A1:=Nil;
  w^.A2:=Nil;
  if proot=Nil then
    proot:=w
  else
    begin
      p:=proot;
	    repeat
        q:=p;
		    bl:=Inf.key<p^.Inf.key;
        if bl then
          p:=p^.A1
        else
          p:=p^.A2;
      until p=Nil;
      if bl then
        q^.A1:=w
      else
        q^.A2:=w;
    end;
end;

function Ttree.Poisk;
begin
  p:=proot;
	while(p<>nil) and (p^.Inf.key<>k) do
	  if k<p^.Inf.key then
      p:=p^.A1
    else
      p:=p^.A2;
  if p<>Nil then
    Result:=p^.Inf
  else
    ShowMessage('����� ��� ����������');
end;

procedure Ttree.Make1B;
var i:integer;
begin
  for i:=1 to N do AddB(a[i]);
end;

procedure Ttree.View;
var kl:integer;
      procedure VW(p:ptree;Var kl:Integer);
      begin
      if  p<>Nil then
        with Form1.TreeView1.Items do
          begin
            if kl=-1 then
              AddFirst(Nil, p^.Inf.s+' '+IntToStr(p^.Inf.key))
            else
              AddChildFirst(Form1.TreeView1.Items[kl],
            p^.Inf.s+' '+IntToStr(p^.Inf.key));
            Inc(kl);
            VW(p^.A1,kl);
            VW(p^.A2,kl);
            Dec(kl);
          end;
      end;
begin
  Form1.TreeView1.Items.Clear;
  p:=proot;
    kl:=-1;
  VW(p,kl);
  Form1.TreeView1.FullExpand;
end;

procedure Ttree.Delete(p:Ptree);
begin
  if p=nil then
    Exit;
  Delete(p^.A1);
  Delete(p^.A2);
  Dispose(p);
  proot:=Nil;
end;

destructor Ttree.Free;
begin
  Delete(proot);
  Inherited Destroy;
end;

procedure Ttree.WrtB;
      procedure Wr(p:Ptree);
	    begin
		    if p<>nil then
		      begin
            Form1.Memo1.Lines.Add(p^.Inf.s+IntToStr(p^.Inf.key));
			      Wr(p^.A1);
			      Wr(p^.A2);
		      end;
      end;
begin
  p:=proot;
  Wr(p)
end;

function Ttree.Srkey;
  procedure Sr(r:Ptree);
	    begin
		    if r<>nil then
		      begin
            sum:=sum+r^.inf.key;
            n:=n+1;
			      Sr(r^.A1);
			      Sr(r^.A2);
		      end;
      end;
begin
  sum:=0; n:=0;
  Sr(r);
  Result:=sum/n;
end;

function TTree.FindNear;
  procedure dKey(r:Ptree);
	    begin
		    if r<>nil then
		      begin
            dx:=abs(r^.inf.key - sredn);
            if dx < dmin then
                          begin
                            dmin:=dx;
                            dk:=r^.Inf.key;
                          end;
			      dKey(r^.A1);
			      dKey(r^.A2);
		      end;
      end;
begin
  dmin:=abs(r^.Inf.key - sredn);
  dk:=r^.inf.key;
  dKey(r);
  Result:=dk;
end;

procedure Ttree.BLns;
	    procedure BL(i,j:word);
	    var m:word;
	    begin
		    if i<=j then
		      begin
			      m:=(i+j) div 2;
			      AddB(a[m]);
			      BL(i,m-1);
			      BL(m+1,j);
		      end;
	    end;
begin
  proot:=Nil;
  BL(1,n);
end;

procedure Ttree.Delk;
begin
  p:=proot;
  while (p<>Nil) and (p^.Inf.key<>k) do
		begin
      q:=p;
        if p^.Inf.key>k then
          p:=p^.A1
        else
          p:=p^.A2;
		end;
	if p<>Nil then
    begin
	    if p=proot then
        begin
          New(q);
          q^.A1:=p;
        end;
	    if (p^.A1=Nil) and (p^.A2=Nil) then
	      if q^.A1=P then
          q^.A1:=Nil
			  else
          q^.A2:=Nil
	    else
	      if P^.A1=Nil then
	        if q^.A1=P then
            q^.A1:=p^.A2
				  else
            q^.A2:=p^.A2
	      else
          if p^.A2=Nil then
	          if q^.A1=P then
              q^.A1:=p^.A1
				    else
              q^.A2:=p^.A1
	        else
		        begin
		          w:=p^.A1;
              if w^.A2=Nil then
                w^.A2:=p^.A2
		          else
                begin
			            Repeat
                    v:=w;
                    w:=w^.A2;
			            Until w^.A2=Nil;
			            v^.A2:=w^.A1;
			            w^.A1:=p^.A1;
			            w^.A2:=p^.A2;
			          end;
		          if q^.A1=P then
                q^.A1:=w
					    else
                q^.A2:=w;
		        end;
	    if p=proot then
        begin
          proot:=q^.A1;
          Dispose(q);
        end;
	    Dispose(p);
    end;
end;

end.


