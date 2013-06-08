function gap_vector=SuperGap(gap,x,beta)
epsilon_S=beta/pi;
far_super_gap=gap(1);
zero_super_gap=gap(2);
a_S=-epsilon_S*log(far_super_gap/zero_super_gap-1);
gap_vector=far_super_gap./(1+exp(-(x+a_S)./epsilon_S));