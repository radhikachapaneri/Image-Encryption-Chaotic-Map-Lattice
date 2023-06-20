clc;

K = round(rand(1,256));
% If needed in Hex, then use the following:
for i = 1:8
    KHex((i-1)*8+1:i*8) = dec2hex(bi2de(K((i-1)*32+1:i*32)),8);
end
transFrac = @(K,st,ed) sum(K(st:ed).*2.^(-(1:(ed-st+1))));

% Secret parameters
% numCycles (atleast 5) (5 to 10) (more will increase the computation time
% paramPWLCM for PWLCM between 0+ and 0.5- => for CML
% numIterPWLCM (atleast 25) (25 to 40) => for CML
% p for PWLCM between 0+ and 0.5- => for Diffusion
% numIterPWLCM (atleast 25) (25 to 40) => for Diffusion
% valDiffusion between 0 and 255 => initial value for Diffussion

% 32 - numCycles 1 32
% 32 - numIterPWLCM 33 64
% 32 - paramPWLCM 65 96
% 32 - numIterPWLCMDiffusion1 97 128
% 32 - paramPWLCMDiffusion1 129 160
% 32 - numIterPWLCMDiffusion2 161 192
% 32 - paramPWLCMDiffusion2 193 224
% 16 - valDiffusion1 225 240
% 16 - valDiffusion2 241 256

numCycles = ceil(transFrac(K,1,32)*5 + 5);
numIterPWLCM = ceil(transFrac(K,33,64)*15 + 25);
paramPWLCM = transFrac(K,65,96)*0.4999;
numIterPWLCMDiffusion1 = ceil(transFrac(K,97,128)*15 + 25);
paramPWLCMDiffusion1 = transFrac(K,129,160)*0.4999;
numIterPWLCMDiffusion2 = ceil(transFrac(K,161,192)*15 + 25);
paramPWLCMDiffusion2 = transFrac(K,193,224)*0.4999;
valDiffusion1 = transFrac(K,225,240);
valDiffusion2 = transFrac(K,241,256);

InputImage=imread('cameraman.tif');
[EncryptedImage] = ModifiedCMLEncrypt2014(InputImage, numCycles, numIterPWLCM, paramPWLCM, numIterPWLCMDiffusion1, paramPWLCMDiffusion1, valDiffusion1, numIterPWLCMDiffusion2, paramPWLCMDiffusion2, valDiffusion2);

[DecryptedImage] = ModifiedCMLDecrypt2014(EncryptedImage, numCycles, numIterPWLCM, paramPWLCM, numIterPWLCMDiffusion1, paramPWLCMDiffusion1, valDiffusion1, numIterPWLCMDiffusion2, paramPWLCMDiffusion2, valDiffusion2);
imshow(InputImage);figure;imshow(EncryptedImage);figure;imshow(DecryptedImage);

HValInput = ComputeEntropy(InputImage)
HValEncrypted = ComputeEntropy(EncryptedImage)

[corrvalueHInput, corrvalueVInput] = ComputeCorrelation(InputImage)
[corrvalueHEncrypted, corrvalueVEncrypted] = ComputeCorrelation(EncryptedImage)

ChiSquareValInput = ComputeChiSquare(InputImage)
ChiSquareValEncrypted = ComputeChiSquare(EncryptedImage)

% % Differential Analysis
% 
disp('Change of 1 pixel in Original Image');
InputImage2 = InputImage;
InputImage2(1, 1) = 255;
[EncryptedImage2] = ImprovedModifiedEncryptCML5(InputImage2, seed, numCycles, numIterPWLCM, paramPWLCM, numIterPWLCMDiffusion, paramPWLCMDiffusion, valDiffusion, numIterBaker);
figure;imshow(InputImage2);figure;imshow(EncryptedImage2);
% [NPCR_PixelChange] = ComputeNPCR(EncryptedImage, EncryptedImage2)
% [UACI_PixelChange] = ComputeUACI(EncryptedImage, EncryptedImage2)
results_1pixelchange = NPCR_and_UACI( EncryptedImage, EncryptedImage2 );

disp('Change of one bit of key');
[EncryptedImage3] = ImprovedModifiedEncryptCML5(InputImage, seed+1, numCycles, numIterPWLCM, paramPWLCM, numIterPWLCMDiffusion, paramPWLCMDiffusion, valDiffusion, numIterBaker);
figure;imshow(EncryptedImage3);
% [NPCR_KeyChange] = ComputeNPCR(EncryptedImage, EncryptedImage3)
% [UACI_KeyChange] = ComputeUACI(EncryptedImage, EncryptedImage3)
results_1bitkeychange = NPCR_and_UACI( EncryptedImage, EncryptedImage3 );
