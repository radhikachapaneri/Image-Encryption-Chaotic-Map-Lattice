function [UACI] = ComputeUACI(C1, C2)

% C1 and C2 are two cipher images, they should be of same size

[height, width] = size(C1);
C1 = double(C1);
C2 = double(C2);

sum = 0.0;

for i = 1:height
    for j = 1:width
        sum = sum + abs(C1(i,j) - C2(i,j));
    end
end

UACI = (sum*100)/(width*height*255);



