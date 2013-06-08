function averageNormal = AverageNormal(Z)
% averageNormal=2*pi*(2-Z.^2./sqrt(1+Z.^2).*log((sqrt(1+Z.^2)+1)./(sqrt(1+Z.^2)-1)));
averageNormal=pi*(1-Z.^2.*log(1+1./(Z.^2)));