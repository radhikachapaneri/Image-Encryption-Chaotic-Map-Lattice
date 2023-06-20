function [PlainVector] = eXORUnDiffuseImageMICML2014(DiffusedVector, initMap1, numIter1, param1, initMap2, numIter2, param2)

DiffusedVector = double(DiffusedVector);
InputVectorSize = length(DiffusedVector);

% Use compound chaotic map
% But for now just use PWLCM

Phi1 = zeros(1, InputVectorSize+3);
Phi2 = zeros(1, InputVectorSize+3);
Phi1(1) = initMap1; %0.395;
Phi2(1) = initMap2; %0.186;
for k=2:InputVectorSize+3
      Phi1(k) = PiecewiseChaoticMap(Phi1(k-1),param1,numIter1);
      Phi2(k) = PiecewiseChaoticMap(Phi2(k-1),param2,numIter2);
end

% Digitize the chaotic values 
for k=1:InputVectorSize+3
    Phi1(k) = mod(floor(Phi1(k)*(10^8)),512);
    Phi2(k) = mod(floor(Phi2(k)*(10^8)),512);
end

% Diffusion stage 2 first
M = zeros(1, InputVectorSize);
C = zeros(1, InputVectorSize+1);

C(1:InputVectorSize) = DiffusedVector;
C(InputVectorSize+1) = mod(Phi1(InputVectorSize+2),256);

for k=InputVectorSize:-1:1
    a = expandedXOR(C(k+1),Phi2(k));
    b = expandedXOR(mod(C(k)-a,256), Phi1(k));
    M(k) = mod(b, 256);
end

% Now, diffusion stage 1
M0 = mod(Phi1(InputVectorSize+1),256);
P = zeros(1, InputVectorSize);
a = expandedXOR(M0,Phi2(1));
b = expandedXOR(mod(M(1)-a,256),Phi1(1));
P(1) = mod(b, 256);

for k=2:InputVectorSize
    a = expandedXOR(M(k-1),Phi2(k));
    b = expandedXOR(mod(M(k)-a,256),Phi1(k));
    P(k) = mod(b, 256);
end

PlainVector = P(1:InputVectorSize);
end
