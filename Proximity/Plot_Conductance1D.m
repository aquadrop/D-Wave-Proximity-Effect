far_super_gap_factor=1;
zero_super_gap_factor=1;
zero_normal_gap_factor=0;
z_factor=0.1;
theta=0;
phi=0;
energy=0:0.05:3.5;
conductance1D=zeros(1,length(energy));
for i=1:length(energy)
     [X_a1,wave_a1,X_a2,wave_a2,X_b2,wave_b2,conductance1D(i)]=Conductance1D(energy(i),far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor,z_factor,theta,phi);
%     conductance1D(i)=Faster_Conductance1D(energy(i),far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor,z_factor,phi);
    fprintf('*****%d of %d*******\n',i,length(energy));
end
plot(energy,conductance1D);
% legend('Z=%fR=%fI=%f',z_factor,zero_super_gap_factor,zero_normal_gap_factor);
hold on;clc
