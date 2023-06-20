function [DecryptedImage] = ModifiedCMLDecrypt2014(EncryptedImage, numCycles, numIterPWLCM, paramPWLCM, numIterPWLCMDiffusion1, paramPWLCMDiffusion1, valDiffusion1, numIterPWLCMDiffusion2, paramPWLCMDiffusion2, valDiffusion2);

EncryptedImage = double(EncryptedImage);

[height, width] = size(EncryptedImage);
ImageSize = width*height;

% Convert 2D image to 1D vector in raster order
PImage = reshape(EncryptedImage,ImageSize,1);

for cycle = numCycles:-1:1
    
    PImage = eXORUnDiffuseImageMICML2014V2(PImage, valDiffusion1, numIterPWLCMDiffusion1, paramPWLCMDiffusion1, valDiffusion2, numIterPWLCMDiffusion2, paramPWLCMDiffusion2);
    
    for pixel = ImageSize:-1:1
        if (pixel == 1)
            X0 = PImage(ImageSize)/255;
        else
            X0 = PImage(pixel-1)/255;
        end
        % Get the value from chaotic map
        XN = PiecewiseChaoticMap(X0, paramPWLCM, numIterPWLCM);
            
        % Update the pixel value
%         PImage(pixel) = PImage(pixel) - round(XN*255);
        PImage(pixel) = PImage(pixel) - mod(floor(XN*(10^8)),255);
        
        % Check for boundaries
        if (PImage(pixel) < 0)
            PImage(pixel) = PImage(pixel) + 256;
        end
    end
end

% Convert 1D vector to 2D image in inverse zigzag direction
DecryptedImage = reshape(PImage, height, width);

DecryptedImage = uint8(DecryptedImage);