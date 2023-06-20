% ## -*- texinfo -*-
% ## @deftypefn {Function File} {@var{b} = } de2bi (@var{d})
% ## @deftypefnx {Function File} {@var{b} = } de2bi (@var{d},@var{n})
% ## @deftypefnx {Function File} {@var{b} = } de2bi (@var{d},@var{n},@var{p})
% ## @deftypefnx {Function File} {@var{b} = } de2bi (@var{d},@var{n},@var{p},@var{f})
% ##
% ## Convert a non-negative integer to bit vector.
% ##
% ## The variable @var{d} must be a vector of non-negative integers. @dfn{de2bi}
% ## then returns a matrix where each row represents the binary representation
% ## of elements of @var{d}. If @var{n} is defined then the returned matrix
% ## will have @var{n} columns. This number of columns can be either larger
% ## than the minimum needed and zeros will be added to the msb of the
% ## binary representation or smaller than the minimum in which case the  
% ## least-significant part of the element is returned.
% ##
% ## If @var{p} is defined then it is used as the base for the decomposition
% ## of the returned values. That is the elements of the returned value are
% ## between '0' and 'p-1'.
% ##
% ## The variable @var{f} defines whether the first or last element of @var{b}
% ## is considered to be the most-significant. Valid values of @var{f} are
% ## 'right-msb' or 'left-msb'. By default @var{f} is 'right-msb'.
% ## @end deftypefn
% ## @seealso{bi2de}

function b = de2bi2(d, n)
  p = 2;
  d = d(:);
  if ( any (d < 0) || any (d ~= floor (d)) )
    error ('de2bi: only handles non-negative integers');
  end

  power = ones (length (d), 1) * (p .^ [0 : n-1] );
  d = d * ones (1, n);
  b = floor (rem (d, p*power) ./ power);
  b = b(:,length(b):-1:1);
end
