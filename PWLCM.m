
function fx=PWLCM(x,rParam)
%implementation of PWLCM map
%rParam= between 0 and 0.5 both exclusive for chaos

p = rParam;
fx=0;
if (x >= 0 && x < p)
    fx = x/p;
else if (x >= p && x < 0.5)
        fx = (x-p)/(0.5-p);
    else if (x >= 0.5 && x < (1-p))
            fx = (1-x-p)/(0.5-p);
        else if (x >= (1-p) && x < 1)
                fx = (1-x)/p;
            end
        end
    end
end
