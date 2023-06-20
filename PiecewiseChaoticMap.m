function [XN] = PiecewiseChaoticMap(X0, p, n)

% p = map parameter
% n = number of iterations for the chaotic map
X = zeros(1,n+1);
X(1) = X0;
for i=2:n+1
    if (X(i-1) >= 0 && X(i-1) < p)
        X(i) = X(i-1)/p;
    else if (X(i-1) >= p && X(i-1) < 0.5)
            X(i) = (X(i-1)-p)/(0.5-p);
        else if (X(i-1) >= 0.5 && X(i-1) < (1-p))
                X(i) = (1-X(i-1)-p)/(0.5-p);
            else if (X(i-1) >= (1-p) && X(i-1) < 1)
                    X(i) = (1-X(i-1))/p;
                end
            end
        end
    end
end

XN = X(i);
