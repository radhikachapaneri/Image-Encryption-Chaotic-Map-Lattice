function scramblingDegree = ComputeScramblingDegree(InputImage, ScrambledImage)

InputImage = double(InputImage);
ScrambledImage = double(ScrambledImage);

% calculate E(GD)
EGDI = CalculateEGD(InputImage);
EGDS = CalculateEGD(ScrambledImage);

scramblingDegree = (EGDS-EGDI)/(EGDS+EGDI);

end


function EGD = CalculateEGD(Image)

[height width] = size(Image);
EGD = 0.0;
for i=2:height-1
    for j=2:width-1
        GD = (Image(i,j)-Image(i-1,j))^2;
        GD = GD + (Image(i,j)-Image(i+1,j))^2;
        GD = GD + (Image(i,j)-Image(i,j-1))^2;
        GD = GD + (Image(i,j)-Image(i,j+1))^2;
        GD = GD/4;
        EGD = EGD + GD;
    end
end
EGD = EGD/((height-2)*(width-2));

end