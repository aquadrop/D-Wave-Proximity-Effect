function conductance_2D=Self_Conductance_2D(energy,life,energygap_factor,z_factor)
NTHETA=128;

step=pi/2/NTHETA;
theta=0:step:pi/2;
conductance_1D=zeros(1,length(theta));
control=2.5;
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
for i=1:length(energy_center)
    fprintf('*****************energy integral %d of %d **************\n',i,length(energy_center));
    parfor j=1:length(theta)
        fprintf('~~~~~~~~~~~~~~~~~~~energy at %d of %d,theta at %d of %d ~~~~~~~~~~~~~~~~~~~~~\n',i,length(energy_center),j,length(theta));
        conductance_1D(j)=quadgk(@(phi) sin(2*theta(j)).*Conductance1D(energy_center(i),far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor,z_factor,theta(j),phi),0,2*pi,'AbsTol',1e-4);
    end
      center(i)=trapz(theta,conductance_1D);
     
end

factor=center(length(energy_center));%2*pi*(1-z_factor.^2*log(1+1./z_factor.^2));%

left=factor.*ones(1,length(energy_left));
right=factor.*ones(1,length(energy_right)); 
conductance_2D=[left,center,right];
% integral_conductance_N=quadgk(@(beta) 2.*pi.*sin(2*beta).*Conductance_N(beta,z_factor),0,pi/2);
% conductance_2D=conductance_2D./integral_conductance_N;










% function lamda=Lamda(theta,lamda_factor)
% lamda=real(lamda_factor.*sqrt(1-(sin(theta)./lamda_factor).^2)./cos(theta));


