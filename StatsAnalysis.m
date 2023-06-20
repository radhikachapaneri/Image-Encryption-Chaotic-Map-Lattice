function [HVal, corrvalue, ChiSquareVal, Moments] = StatsAnalysis(InputImageColor)

% Red plane
PR = InputImageColor(:,:,1);

HValR = ComputeEntropy(PR);
[corrvalueHR, corrvalueVR, corrvalueDR] = ComputeCorrelation(PR);
ChiSquareValR = ComputeChiSquare(PR);

MeanR = mean2(double(PR));
StdDevR = std2(double(PR));
SkewnessR = mean(skewness(double(PR)));
KurtosisR = mean(kurtosis(double(PR)));


% Green plane
PG = InputImageColor(:,:,2);

HValG = ComputeEntropy(PG);
[corrvalueHG, corrvalueVG, corrvalueDG] = ComputeCorrelation(PG);
ChiSquareValG = ComputeChiSquare(PG);

MeanG = mean2(double(PG));
StdDevG = std2(double(PG));
SkewnessG = mean(skewness(double(PG)));
KurtosisG = mean(kurtosis(double(PG)));


% Blue plane
PB = InputImageColor(:,:,3);

HValB = ComputeEntropy(PB);
[corrvalueHB, corrvalueVB, corrvalueDB] = ComputeCorrelation(PB);
ChiSquareValB = ComputeChiSquare(PB);

MeanB = mean2(double(PB));
StdDevB = std2(double(PB));
SkewnessB = mean(skewness(double(PB)));
KurtosisB = mean(kurtosis(double(PB)));

HVal = [HValR, HValG, HValB];
corrvalueH = mean([corrvalueHR,corrvalueHG,corrvalueHB]);
corrvalueV = mean([corrvalueVR,corrvalueVG,corrvalueVB]);
corrvalueD = mean([corrvalueDR,corrvalueDG,corrvalueDB]);
corrvalue = [corrvalueH, corrvalueV, corrvalueD];
ChiSquareVal = [ChiSquareValR, ChiSquareValG, ChiSquareValB];
Moments = [mean([MeanR, MeanG, MeanB]), mean([StdDevR, StdDevG, StdDevB]), mean([SkewnessR, SkewnessG, SkewnessB]), mean([KurtosisR, KurtosisG, KurtosisB])];