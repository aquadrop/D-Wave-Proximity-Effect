function conductance_N=Conductance_N(theta,z_factor)
% lamda=Lamda(theta);
z=Z(theta,z_factor);
conductance_N=1./(1+z.^2);%4*lamda./((1+lamda).^2+z.^2);