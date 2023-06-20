function LocalHval = ComputeLocalEntropy(InputImage, k, T)

%% Input parameters
% InputImage = 2D grayscale image
% k = number of non-overlapping blocks
% T = number of pixels in each block

%%
InputImage = double(InputImage);
[height, width] = size(InputImage);

% assuming square block size N x N
widthB = sqrt(T); % same as heightB of each block
heightB = widthB;

% get row coordinates randomly
rowidxB = zeros(1,k);
colidxB = zeros(1,k);
for p = 1:k
    rowidxB(p) = randi(height);
    while (rowidxB(p)+heightB > height)
        rowidxB(p) = randi(height);
    end
    colidxB(p) = randi(width);
    while (colidxB(p)+widthB > width)
        colidxB(p) = randi(width);
    end
end

% Determine local entropy of k blocks
Hval = zeros(1,k);
for p = 1:k
    
    % find entropy of each block p
    r = rowidxB(p):rowidxB(p)+heightB-1;
    c = colidxB(p):colidxB(p)+widthB-1;
    Hval(p) = ComputeEntropy(InputImage(r,c));
end

LocalHval = sum(Hval)/k;

%% P-value
% largest_allowed_val = 255;
% num_of_pix = numel( InputImage );
% LocalH_mu  = ( largest_allowed_val ) / ( largest_allowed_val+ 1 );
% LocalH_var =  ( ( largest_allowed_val) / ( largest_allowed_val+ 1 )^2 ) / num_of_pix;
% LocalH_pVal = normcdf( LocalHval, LocalH_mu, sqrt( LocalH_var ) )
% LocalH_dist = [ LocalH_mu, LocalH_var ]