unit JacobiEquInterval;

interface

uses
  MyIntervalType, IntervalArithmetic32and64;

procedure JacobiInterval(n: Integer; var a: intervalMatrix;
  var b: intervalVector; mit: Integer; eps: Extended; var x: intervalVector;
  var it, st: Integer);

implementation

procedure JacobiInterval(n: Integer; var a: intervalMatrix;
  var b: intervalVector; mit: Integer; eps: Extended; var x: intervalVector;
  var it, st: Integer);
{ --------------------------------------------------------------------------- }
{ The procedure JacobiInterval solves a system of linear equations            }
{ in interval arithmetic by Jacobi's iterative method.                        }
{                                                                             }
{ Data:                                                                       }
{   n   - number of equations = number of unknowns,                           }
{   a   - a two-dimensional array containing elements of the matrix of the    }
{         system (changed on exit),                                           }
{   b   - a one-dimensional array containing free terms of the system         }
{         (changed on exit),                                                  }
{   mit - maximum number of iterations in Jacobi's method,                    }
{   eps - relative accuracy of the solution,                                  }
{   x   - an array containing an initial approximation to the solution        }
{         (changed on exit).                                                  }
{                                                                             }
{ Results:                                                                    }
{   x   - an array containing the solution,                                   }
{   it  - number of iterations.                                               }
{                                                                             }
{ Other parameters:                                                           }
{   st  - a variable which within the procedure Jacobi is assigned the        }
{         value of:                                                           }
{   1, if n<1,                                                                }
{   2, if the matrix of the system is singular,                               }
{   3, if the desired accuracy of the solution is not achieved in             }
{       mit iteration steps,                                                  }
{   4, if division by an interval containing 0,                               }
{   0, otherwise.                                                             }
{                                                                             }
{ Note:                                                                       }
{   If st=1 or st=2, then the elements of array x are not changed on exit.    }
{   If st=3, then x contains the last approximation to the solution.          }
{                                                                             }
{ Unlocal identifiers:                                                        }
{   interval - a record type with var a, b : Extended;                        }
{   intervalVector - a type identifier of interval array [q1..qn],            }
{                    where q1<=1 and qn>=n,                                   }
{   intervalMatrix - a type identifier of interval array [q1..qn, q1..qn],    }
{                    where q1<=1 and qn>=n.                                   }
{ --------------------------------------------------------------------------- }
var
  i, ih, k, kh, khh, lz1, lz2: Integer;
  max, r: interval;
  cond: Boolean;
  x1: intervalVector;
begin
  if n < 1 then
    st := 1
  else
  begin
    SetLength(x1, n + 1);

    st := 0;
    cond := true;
    for k := 1 to n do
    begin
      x1[k].a := 0;
      x1[k].b := 0;
    end;
    repeat
      lz1 := 0;
      khh := 0;
      for k := 1 to n do
      begin
        lz2 := 0;
        if containtZero(a[k, k]) then
        begin
          kh := k;
          for i := 1 to n do
            if containtZero(a[i, k]) then
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
        max.a := 0;
        max.b := 0;

        for i := 1 to n do
        begin
          r := iabs(a[i, khh]);
          if (r > max) and containtZero(x1[i]) then
          begin
            max := r;
            ih := i
          end
        end;
        if containtZero(max) then
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
              if (not containtZero(a[i, i])) then
                x1[i] := r / a[i, i]
              else
              begin
                st := 4;
                break;
              end;
            end;
            cond := true;
            i := 0;

            if (st <> 4) then
              repeat
                i := i + 1;
                max := iabs(x[i]);
                r := iabs(x1[i]);
                if max < r then
                  max := r;
                if not containtZero(max) then
                  if iabs(x[i] - x1[i]) / max >= eps then
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
