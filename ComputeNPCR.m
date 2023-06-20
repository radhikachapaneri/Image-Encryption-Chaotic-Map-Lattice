function [NPCR] = ComputeNPCR(C1, C2)

% C1 and C2 are two cipher images, they should be of same size
C1 = double(C1);
C2 = double(C2);
[height, width] = size(C1);

% Initialize D with values of 1
D = ones(height, width);

for i = 1:height
    for j = 1:width
        if (C1(i,j) == C2(i,j))
            D(i,j) = 0;
        end
    end
end

D = double(D);

NPCR = 0.0000;

for i = 1:height
    for j = 1:width
        NPCR = NPCR + D(i,j);
    end
end

NPCR = (NPCR*100)/(width*height);

