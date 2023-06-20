function out = expandedXOR(valA, valB)
% expected: valA of 8 bits and valB of 9 bits

out = 0;
bin_valA = de2bi2(valA,8);
bin_valB = de2bi2(valB,9);
for k=1:8
    bin_out = ~bitxor(bitxor(bin_valA(k),bin_valB(k)),bin_valB(k+1));
    out = out + bin_out*(2^(8-k));
end

end