function gap=NormalParabolic(gap,x,x_N)
zero_normal_gap_factor=gap(3);
factor=zero_normal_gap_factor./(x_N.^2);
gap=factor*(x+x_N).^2;