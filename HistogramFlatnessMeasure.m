function HistFlatnessMeasure = HistogramFlatnessMeasure(InputImage)

InputImage = double(InputImage);
[height, width] = size(InputImage);
ImageSize = width*height;

numBins = 256; % assuming grayscale image
Freq = zeros(1, numBins);

% Find the frequency of each pixel value occurence
for i=1:numBins
    Freq(i)=0;
end

for i=1:height
    for j=1:width
        value = InputImage(i,j);
        Freq(value+1) = Freq(value+1) + 1;
    end
end

stem(Freq);

meanFreq = mean(Freq);

sum = 0.0;
for i=1:numBins
    sum = sum + (((Freq(i) - meanFreq)/(ImageSize/numBins)).^2);
end

HistFlatnessMeasure = sum/numBins;


