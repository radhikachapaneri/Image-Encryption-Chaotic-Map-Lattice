function corrvalue = InternalComputeCorrelation(P, Q, NumPairs)

% Make sure P and Q are of size NumPairs

% MeanValue for P
MeanValP = 0;
for i=1:NumPairs
    MeanValP = MeanValP + P(i);
end
MeanValP = MeanValP/NumPairs;

% MeanValue for Q
MeanValQ = 0;
for i=1:NumPairs
    MeanValQ = MeanValQ + Q(i);
end
MeanValQ = MeanValQ/NumPairs;

% Deviation for P
DevP = 0;
for i=1:NumPairs
    DevP = DevP + (P(i)-MeanValP)^2;
end
DevP = DevP/NumPairs;

% Deviation for Q
DevQ = 0;
for i=1:NumPairs
    DevQ = DevQ + (Q(i)-MeanValQ)^2;
end
DevQ = DevQ/NumPairs;

% Compute covariance
CovPQ = 0;
for i=1:NumPairs
    CovPQ = CovPQ + (P(i)-MeanValP)*(Q(i)-MeanValQ);
end
CovPQ = CovPQ/NumPairs;

% Finally, the correlation coefficient
corrvalue = CovPQ/(sqrt(DevP)*sqrt(DevQ));
