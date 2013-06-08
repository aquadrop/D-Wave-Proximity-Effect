function conductance_2D=Faster_Conductance2D(energy,life,energygap_factor,z_factor)
NPHI=10000;
step_phi=2*pi/NPHI;
%  phi=0:step_phi:2*pi;
NTHETA=128;
step=pi/2/NTHETA;
theta=0:step:pi/2;
NPHI=1000;
% phi=0:pi*2/NPHI:2*pi;
control=2.6;
% interv=3000;
energy_down=min(energy);
energy_up=max(energy);
far_super_gap_factor=energygap_factor(1);
zero_super_gap_factor=energygap_factor(2);
zero_normal_gap_factor=energygap_factor(3);
if (energy_down<(-control*far_super_gap_factor))&&(energy_up>(control*far_super_gap_factor))
    energy_step=energy(2)-energy(1);
    flat_left_n=int32((-control*far_super_gap_factor-energy_down)/energy_step)+1;
    flat_2_n=int32((control*far_super_gap_factor-energy_down)/energy_step)+1;
%center_n=2*control*far_super_gap_factor/energy_step;
    energy_left=energy(1:flat_left_n-1);
    energy_center=energy(flat_left_n:flat_2_n);
    energy_right=energy(flat_2_n+1:length(energy));
    center=zeros(1,length(energy_center));
else
    energy_left=zeros(1,0);
    energy_center=energy;
    energy_right=zeros(1,0);
    center=zeros(1,length(energy_center));
end
% fprintf('length of left %d,length of right %d\n',length(left),length(right));
%fprintf('length of central energy %d\n',energy_center(1));
% fprintf('length of energy %d\n',length(energy));
energy_center_length=length(energy_center);
parfor i=1:length(energy_center)
    center(i)=quadgk(@(phi) Faster_Conductance1D(energy_center(i),far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor,z_factor,phi),0,2*pi);
%     conductance_seq=Faster_Conductance1D(energy_center(i),far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor,z_factor,phi);
%     center(i)=trapz(phi,conductance_seq);
    fprintf('*****************energy integral %d of %d complete**************\n',i,energy_center_length);
end

factor=center(length(energy_center));%2*pi*(1-z_factor.^2*log(1+1./z_factor.^2));%

left=factor.*ones(1,length(energy_left));
right=factor.*ones(1,length(energy_right)); 
conductance_2D=[left,center,right];
 integral_conductance_N=quadgk(@(beta) 2.*pi.*cos(beta).*Conductance_N(beta,z_factor),-pi/2,pi/2);
 conductance_2D=conductance_2D./integral_conductance_N;










% function lamda=Lamda(theta,lamda_factor)
% lamda=real(lamda_factor.*sqrt(1-(sin(theta)./lamda_factor).^2)./cos(theta));


