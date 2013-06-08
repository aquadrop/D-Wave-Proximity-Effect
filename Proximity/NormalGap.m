function gap_vector=NormalGap(gap,x,beta)
epsilon_N=beta/pi;
far_super_gap=gap(1);
zero_normal_gap=gap(3);
a_N=epsilon_N.*log(far_super_gap./zero_normal_gap-1);
gap_vector=far_super_gap./(1+exp(-(x-a_N)./epsilon_N));