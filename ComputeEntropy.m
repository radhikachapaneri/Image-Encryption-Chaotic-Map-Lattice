function Hval = ComputeEntropy(InputImage)

InputImage = double(InputImage);
[height, width] = size(InputImage);
ImageSize = width*height;

MaxVal = 256;

% Find the probabilites of each pixel value occurence
for i=1:MaxVal
    Value(i) = i-1;
    Prob(i)=0;
end

for i=1:height
    for j=1:width
        Prob(InputImage(i,j)+1) = Prob(InputImage(i,j)+1) + 1;
    end
end

for i=1:MaxVal
    Prob(i) = Prob(i)/ImageSize;
end

%stem(Prob);

Hval = 0;
for i=1:MaxVal
    if (Prob(i) > 0)
        Hval = Hval - Prob(i)*log2(Prob(i));
    end
end











