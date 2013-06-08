function gap=SuperParabolic(gap_factor,x,x_S)%is from -x_S to 0 to fid ode
far_super_gap_factor=gap_factor(1);
zero_super_gap_factor=gap_factor(2);
% factor=(zero_super_gap_factor-far_super_gap_factor)./(x_S.^2);
% gap=factor.*(x).^2+far_super_gap_factor;
factor=(zero_super_gap_factor-far_super_gap_factor)./(x_S.^2);
gap=factor.*(x-x_S).^2+far_super_gap_factor;