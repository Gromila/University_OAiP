unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

Type
  Tps = ^Ts;
  Ts = record
    inf: word;
    ps: Tps;
  end;
  TStack = class (TObject)
    constructor Create;
    procedure Add(var p:Tps; n:word);
    procedure From(var p:tps;var n:word);
    procedure Exchange(var p:Tps; var n:word);
    procedure Sort(var p:tps);
    procedure Even(var p,p1,p2:tps);
  end;

var p, p1, p2:Tps;
    n:byte;

implementation

constructor TStack.Create;
begin
  Inherited Create;
end;

procedure TStack.Add;
var pt:Tps;
begin
  New(pt);
  pt^.inf:=n;
  pt^.ps:=p;
  p:=pt;
end;

procedure TStack.From;
var pt:Tps;
begin
  if p<>nil then
    begin
      pt:=p;
      n:=p^.inf;
      p:=p^.ps;
      dispose(pt);
    end
    else n:=0;
end;

procedure TStack.Exchange;
var nt:word;
begin
  if p^.ps<>nil then
    begin
      if p^.inf>p^.ps^.inf then
        begin
          nt:=p^.inf;
          p^.inf:=p^.ps^.inf;
          p^.ps^.inf:=nt;
          Inc(n);
        end;
      exchange(p^.ps,n);
    end;
end;

procedure TStack.Sort;
var n:word;
begin
    repeat
      n:=0;
      exchange(p,n);
    until n = 0;
end;

procedure TStack.Even;
begin
  if p^.ps<>nil then
    begin
      if Odd(p^.inf) then
          Add(p1,p^.inf)
      else
          Add(p2,p^.inf);
      even(p^.ps,p1,p2);
      Sort(p1);
      Sort(p2);
    end
  else
    begin
      if Odd(p^.inf) then
          Add(p1,p^.inf)
      else Add(p2,p^.inf);
    end;
end;
end.
