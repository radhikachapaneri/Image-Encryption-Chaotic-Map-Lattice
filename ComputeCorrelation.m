function [corrvalueH, corrvalueV, corrvalueD] = ComputeCorrelation(InputImage)

[height, width] = size(InputImage);
ImageSize = width*height;

% Convert 2D image to 1D vector
PImage = zeros(1,ImageSize);
k = 0;
for i = 1:height
    for j = 1:width
        k = k+1;
        PImage(k) = InputImage(i,j);
    end
end

NumPairs = 3000;

%%%%%%% HORIZONTAL %%%%%%%

% Randomly select NumPairs pairs of horizontal adjacent pixels
XH = zeros(1,NumPairs);
for i = 1:NumPairs
    %Avoid 0 since Matlab does not have this index; Avoid last column
    while ((XH(i) == 0) | (mod(XH(i),width)==0))
        XH(i) = floor(rand(1)*ImageSize);
    end
end

% Adjacent horizontal pixels are PImage(X(i)) and PImage(X(i)+1)
% Get two arrays of PH and QH i.e. (i,j) and (i,j+1)
PH=zeros(1,NumPairs);
QH=zeros(1,NumPairs);
for i = 1:NumPairs
    PH(i) = PImage(XH(i));
    QH(i) = PImage(XH(i)+1);
end

%%%%%%% VERTICAL %%%%%%%

% Randomly select NumPairs pairs of vertical adjacent pixels
XV = zeros(1,NumPairs);
for i = 1:NumPairs
    %Avoid 0 since Matlab does not have this index; Avoid last row
    while ((XV(i) == 0) | ((ImageSize-XV(i)) < width))
        XV(i) = floor(rand(1)*ImageSize);
    end
end

% Adjacent vertical pixels are PImage(X(i)) and PImage(X(i)+width)
% Get two arrays of PV and QV i.e. (i,j) and (i+1,j)
PV=zeros(1,NumPairs);
QV=zeros(1,NumPairs);
for i = 1:NumPairs
    PV(i) = PImage(XV(i));
    QV(i) = PImage(XV(i)+width);
end


%%%%%%% DIAGONAL %%%%%%%

% Randomly select NumPairs pairs of horizontal adjacent pixels
XD = zeros(1,NumPairs);
for i = 1:NumPairs
    %Avoid 0 since Matlab does not have this index; Avoid last column and
    %last row
    while ((XD(i) == 0) | (mod(XD(i),width)==0) | ((ImageSize-XD(i)) < width))
        XD(i) = floor(rand(1)*ImageSize);
    end
end

% Adjacent diagonal pixels are PImage(X(i)) and PImage(X(i)+width+1)
% Get two arrays of PD and QD i.e. (i,j) and (i+1,j+1)
PD=zeros(1,NumPairs);
QD=zeros(1,NumPairs);
for i = 1:NumPairs
    PD(i) = PImage(XD(i));
    QD(i) = PImage(XD(i)+width+1);
end


corrvalueH = InternalComputeCorrelation(PH, QH, NumPairs);

corrvalueV = InternalComputeCorrelation(PV, QV, NumPairs);

corrvalueD = InternalComputeCorrelation(PD, QD, NumPairs);

% figure;scatter(PH,QH,3);figure;scatter(PV,QV,3);figure;scatter(PD,QD,3);






