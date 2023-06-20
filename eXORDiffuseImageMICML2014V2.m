function [DiffusedVector] = eXORDiffuseImageMICML2014V2(InputVector, initMap1, numIter1, param1, initMap2, numIter2, param2)

InputVector = double(InputVector);
InputVectorSize = length(InputVector);

% Use compound chaotic map
% But for now just use PWLCM

Phi1 = zeros(1, InputVectorSize+1);
Phi2 = zeros(1, InputVectorSize+1);
Phi1(1) = initMap1; %0.395;
Phi2(1) = initMap2; %0.186;
for k=2:InputVectorSize+1
      Phi1(k) = PiecewiseChaoticMap(Phi1(k-1),param1,numIter1);
      Phi2(k) = PiecewiseChaoticMap(Phi2(k-1),param2,numIter2);
end

% Digitize the chaotic values 
for k=1:InputVectorSize+1
    Phi1(k) = mod(floor(Phi1(k)*(10^8)),512);
    Phi2(k) = mod(floor(Phi2(k)*(10^8)),512);
end

C0 = mod(Phi1(InputVectorSize+1)+Phi2(InputVectorSize+1),256);
C = zeros(1, InputVectorSize);
C(1) = mod(expandedXOR(InputVector(1),Phi1(1))+expandedXOR(C0,Phi2(1)),256);

for k=2:InputVectorSize
    C(k) = mod(expandedXOR(InputVector(k),Phi1(k))+expandedXOR(C(k-1),Phi2(k)),256);
end

DiffusedVector = C(1:InputVectorSize);
end
