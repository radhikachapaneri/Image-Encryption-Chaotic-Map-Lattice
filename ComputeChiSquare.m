function ChiSquareVal = ComputeChiSquare(InputImage)

InputImage = double(InputImage);
[height, width] = size(InputImage);

MaxVal = 256;
Expected = 256;

% Find the probabilites of each pixel value occurence
Freq = zeros(1, MaxVal);
for i=1:MaxVal
    Freq(i)=0;
end

for i=1:height
    for j=1:width
        Freq(InputImage(i,j)+1) = Freq(InputImage(i,j)+1) + 1;
    end
end

sum = 0;
for i=1:MaxVal
    sum = sum + (Freq(i) - Expected)^2;
end
ChiSquareVal = sum/Expected;
