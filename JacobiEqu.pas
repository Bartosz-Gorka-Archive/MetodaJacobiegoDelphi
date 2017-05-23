unit JacobiEqu;

interface

uses
  MyVarType;

procedure Jacobi(n: Integer; var a: matrix; var b: vector; mit: Integer;
  eps: Extended; var x: vector; var it, st: Integer);

implementation

procedure Jacobi(n: Integer; var a: matrix; var b: vector; mit: Integer;
  eps: Extended; var x: vector; var it, st: Integer);
{ --------------------------------------------------------------------------- }
{                                                                             }
{ The procedure Jacobi solves a system of linear equations by Jacobi's        }
{ iterative method.                                                           }
{ Data:                                                                       }
{ n   - number of equations = number of unknowns,                             }
{ a   - a two-dimensional array containing elements of the matrix of the      }
{ system (changed on exit),                                                   }
{ b   - a one-dimensional array containing free terms of the system           }
{ (changed on exit),                                                          }
{ mit - maximum number of iterations in Jacobi's method,                      }
{ eps - relative accuracy of the solution,                                    }
{ x   - an array containing an initial approximation to the solution          }
{ (changed on exit).                                                          }
{ Results:                                                                    }
{ x  - an array containing the solution,                                      }
{ it - number of iterations.                                                  }
{ Other parameters:                                                           }
{ st - a variable which within the procedure Jacobi is assigned the           }
{ value of:                                                                   }
{ 1, if n<1,                                                                  }
{ 2, if the matrix of the system is singular,                                 }
{ 3, if the desired accuracy of the solution is not achieved in               }
{ mit iteration steps,                                                        }
{ 0, otherwise.                                                               }
{ Note: If st=1 or st=2, then the elements of array x are not                 }
{ changed on exit. If st=3, then x contains the last                          }
{ approximation to the solution.                                              }
{ Unlocal identifiers:                                                        }
{ vector - a type identifier of extended array [q1..qn], where q1<=1 and      }
{ qn>=n,                                                                      }
{ matrix - a type identifier of extended array [q1..qn,q1..qn], where         }
{ q1<=1 and qn>=n.                                                            }
{                                                                             }
{ --------------------------------------------------------------------------- }
var
  i, ih, k, kh, khh, lz1, lz2: Integer;
  max, r: Extended;
  cond: Boolean;
  x1: vector;
begin
  if n < 1 then
    st := 1
  else
  begin
    SetLength(x1, n + 1);
    st := 0;
    cond := true;
    for k := 1 to n do
      x1[k] := 0;
    repeat
      lz1 := 0;
      khh := 0;
      for k := 1 to n do
      begin
        lz2 := 0;
        if a[k, k] = 0 then
        begin
          kh := k;
          for i := 1 to n do
            if a[i, k] = 0 then
              lz2 := lz2 + 1;
          if lz2 > lz1 then
          begin
            lz1 := lz2;
            khh := kh
          end
        end
      end;
      if khh = 0 then
        cond := false
      else
      begin
        max := 0;
        for i := 1 to n do
        begin
          r := abs(a[i, khh]);
          if (r > max) and (x1[i] = 0) then
          begin
            max := r;
            ih := i
          end
        end;
        if max = 0 then
          st := 2
        else
        begin
          for k := 1 to n do
          begin
            r := a[khh, k];
            a[khh, k] := a[ih, k];
            a[ih, k] := r
          end;
          r := b[khh];
          b[khh] := b[ih];
          b[ih] := r;
          x1[khh] := 1
        end
      end
      until not cond or (st = 2);
      if not cond then
      begin
        it := 0;
        repeat
          it := it + 1;
          if it > mit then
          begin
            st := 3;
            it := it - 1
          end
          else
          begin
            for i := 1 to n do
            begin
              r := b[i];
              for k := 1 to n do
                if k <> i then
                  r := r - a[i, k] * x[k];
              x1[i] := r / a[i, i]
            end;
            cond := true;
            i := 0;
            repeat
              i := i + 1;
              max := abs(x[i]);
              r := abs(x1[i]);
              if max < r then
                max := r;
              if max <> 0 then
                if abs(x[i] - x1[i]) / max >= eps then
                  cond := false until (i = n) or not cond;
              for i := 1 to n do
                x[i] := x1[i]
            end
            until (st = 3) or cond
          end
        end;

        SetLength(x1, 0);
      end;
end.
