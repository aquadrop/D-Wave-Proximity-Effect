function conductance_seq=Dab_Faster_Conductance1D(energy,far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor,z_factor,theta)
control_S=6;
control_N=control_S;
beta_S_factor=38;
beta_N_factor=16.4;
x_S=300;%control_S*beta_S;
x_N=150;%control_N*beta_N;
% control_T=1.5;
alpha=0;
% x_T=control_T*beta;
%k_F=1;
% a_S=1;
% epsilon_S=0.5;
% a_N=0.5;
% epsilon_N=10;
%%%%%%%%%%%%%%%%%%%%%%%%%gap_factor=[far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor];
% conductance=zeros(1,length(energy));


%phi=0.02;
beta_S=beta_S_factor.*ones(1,length(theta));%*cos(theta)./cos(2*theta);
beta_N=beta_N_factor.*ones(1,length(theta));%cos(theta)./cos(2*theta);%./EnergyGap(phi,1);
theta_S=theta-alpha;
far_super_gap_S=EnergyGap(theta_S,far_super_gap_factor);
zero_super_gap_S=EnergyGap(theta_S,zero_super_gap_factor);
zero_normal_gap_S=EnergyGap(theta_S,zero_normal_gap_factor);
theta_N=theta+alpha;
far_super_gap_N=EnergyGap(theta_N,far_super_gap_factor);
zero_super_gap_N=EnergyGap(theta_N,zero_super_gap_factor);
zero_normal_gap_N=EnergyGap(theta_N,zero_normal_gap_factor);
energy=abs(energy);
if (energy<1e-6)
    energy = 1e-6;
end
% %     fprintf('%d of %d\n',i,length(energy));
conductance_seq=zeros(1,length(theta));
for i=1:length(theta)
    

%    fprintf('##phi at %d of %d## %f***\n',i,length(phi),phi(i));
   gap_S=[far_super_gap_S(i),zero_super_gap_S(i),zero_normal_gap_S(i)];
   gap_N=[far_super_gap_N(i),zero_super_gap_N(i),zero_normal_gap_N(i)];
   gap_S=abs(gap_S);
   gap_N=abs(gap_N);
%    beta_S(i)=beta_S(i)*gap_S(1);
%    beta_N(i)=beta_N(i)*gap_N(1);
   k_S=(sqrt(energy.^2-far_super_gap_S(i).^2))./(beta_S(i));
   % k_N=energy./(beta.*far_super_gap(i));
   u0=sqrt(0.5.*(1+(sqrt(energy.^2-far_super_gap_S(i).^2))./energy));
   v0=sqrt(1-(u0).^2);

   % beta=beta*far_super_gap;
   Initial_Super_a=[(u0).*exp(1i.*k_S.*x_S) (v0).*exp(1i.*k_S.*x_S)];
   % Initial_Super_a1=Initial_Super_a;
   % Initial_Super_b=[0 0];
   [X_a,wave_a]=SuperSolve(energy,Initial_Super_a,gap_S,x_S,beta_S(i).*cos(theta(i)));
   %[X_b,wave_b]=SuperSolve(energy(i),Initial_Super_b,gap_factor,x_S);%%%values are of decreasing sequence;
   %fprintf('length %d %d\n',length(X_a),length(X_b));
   % X_a1=X_a;
   % wave_a1=wave_a;
   tail_a=length(X_a);
   %tail_b=length(X_b);
   u_a0=wave_a(tail_a,1);
   v_a0=wave_a(tail_a,2);
   % u_b0=wave_b(1,1);
   % v_b0=wave_b(1,2);
   Initial_Super_a=[u_a0 v_a0];
   % Initial_Super_a=[u_a0 v_a0];
   Initial_Super_b=[v_a0 u_a0];
   [X_a,wave_a]=NormalSolve(energy,Initial_Super_a,gap_N,x_N,beta_N(i).*cos(theta(i)));
   [X_b,wave_b]=NormalSolve(energy,Initial_Super_b,gap_N,x_N,beta_N(i).*cos(theta(i)));
   % X_a2=X_a;
   % X_b2=X_b;
   % wave_a2=wave_a;
   % wave_b2=wave_b;


   tail_a=length(X_a); 
   tail_b=length(X_b);
   u_a=wave_a(tail_a,1);
   v_a=wave_a(tail_a,2);
   u_b=wave_b(tail_b,1);
   v_b=wave_b(tail_b,2);

   % tail_a=length(X_a);
   % u_a=wave_a(tail_a,1);
   % v_a=wave_a(tail_a,2);

   % z=Z(theta,z_factor);
   % conductance(i)=trapz(theta,sin(2*theta).*Transmission(z,u_a,v_a,u_b,v_b);%*(1+z_factor.^2));
   % z=Z(theta,z_factor);
   
   conductance_seq(i)=cos(theta(i)).*Transmission(Z(theta(i),z_factor),u_a,v_a,u_b,v_b);
%    fprintf('conductance: %f\n',conductance(i));
   % conductance(i)=Resonance(z,u_a,v_a,k_N,x_T,x_N).*(1+z_factor.^2);

end
% conductance=trapz(phi,conductance_seq);

% conductance=conductance;
