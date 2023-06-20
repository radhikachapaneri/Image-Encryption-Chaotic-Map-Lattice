function K = RandomKey
%=============================================================
% FUNCTION: RandomKey
% -- Generates a 256-bit random key (in HEX) using MATLAB RNG
% Output:
%       K = a 256-bit random key in HEX
%=============================================================
% BSD licence 
%=============================================================
% By Yue (Rex) Wu (ywu03@tufts.ece.edu)
% ECE Department, Tufts University
% Mar 10, 2012
%=============================================================

r = round(rand(1,256));
for i = 1:8
    K((i-1)*8+1:i*8) = dec2hex(bi2de(r((i-1)*32+1:i*32)),8);
end