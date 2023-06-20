function [EncryptedImage] = ModifiedCMLEncrypt2014(PlainImage, numCycles, numIterPWLCM, paramPWLCM, numIterPWLCMDiffusion1, paramPWLCMDiffusion1, valDiffusion1, numIterPWLCMDiffusion2, paramPWLCMDiffusion2, valDiffusion2)

PlainImage = double(PlainImage);

% % Probabilistic Encryption
M = round(rand(size(PlainImage)));
% Random masking
B = bitget(PlainImage,1);
X = xor(B,M);
PP = PlainImage-B+X;
PlainImage = PP;

[height, width] = size(PlainImage);
ImageSize = width*height;

% Convert 2D image to 1D vector in raster order
PImage = reshape(PlainImage,ImageSize,1);

for cycle = 1:numCycles
    for pixel = 1:ImageSize
        if (pixel == 1)
            X0 = PImage(ImageSize)/255;
        else
            X0 = PImage(pixel-1)/255;
        end
        
        % Get the value from chaotic map
        XN = PiecewiseChaoticMap(X0, paramPWLCM, numIterPWLCM);

        % Update the pixel value
%         PImage(pixel) = PImage(pixel) + round(XN*255);
        PImage(pixel) = PImage(pixel) + mod(floor(XN*(10^8)),255);
        if (PImage(pixel) > 255)
            PImage(pixel) = PImage(pixel) - 256;
        end
    end
    
    PImage = eXORDiffuseImageMICML2014V2(PImage, valDiffusion1, numIterPWLCMDiffusion1, paramPWLCMDiffusion1, valDiffusion2, numIterPWLCMDiffusion2, paramPWLCMDiffusion2);
end

% Convert 1D vector back to 2D image
EncryptedImage = reshape(PImage,height,width);

EncryptedImage = uint8(EncryptedImage);
