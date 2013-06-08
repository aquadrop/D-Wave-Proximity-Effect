function conductance_seq=Faster_Conductance1D(energy,far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor,z_factor,phi)

%%%use for BTK
control_S=6;
control_N=control_S;
beta_S_factor=38;
beta_N_factor=16.4;
x_S=50;%control_S*beta_S;
x_N=25;%control_N*beta_N;
% control_T=1.5;

% x_T=control_T*beta;
%k_F=1;
% a_S=1;
% epsilon_S=0.5;
% a_N=0.5;
% epsilon_N=10;
%%%%%%%%%%%%%%%%%%%%%%%%%gap_factor=[far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor];
% conductance=zeros(1,length(energy));


%phi=0.02;
beta_S=beta_S_factor.*ones(1,length(phi));%./EnergyGap(phi,1);
beta_N=beta_N_factor.*ones(1,length(phi));%/EnergyGap(phi,1);%./EnergyGap(phi,1);
far_super_gap=EnergyGap(phi,far_super_gap_factor);
zero_super_gap=EnergyGap(phi,zero_super_gap_factor);
zero_normal_gap=EnergyGap(phi,zero_normal_gap_factor);
energy=abs(energy);
if (energy<1e-6)
    energy = 1e-6;
end
% %     fprintf('%d of %d\n',i,length(energy));
conductance_seq=zeros(1,length(phi));
for i=1:length(phi)
    

%    fprintf('##phi at %d of %d## %f***\n',i,length(phi),phi(i));
   gap=[far_super_gap(i),zero_super_gap(i),zero_normal_gap(i)];
   gap=abs(gap);
   k_S=(sqrt(energy.^2-far_super_gap(i).^2))./(beta_S(i));
   % k_N=energy./(beta.*far_super_gap(i));
   u0=sqrt(0.5.*(1+(sqrt(energy.^2-far_super_gap(i).^2))./energy));
   v0=sqrt(1-(u0).^2);

   % beta=beta*far_super_gap;
   Initial_Super_a=[(u0).*exp(1i.*k_S.*x_S) (v0).*exp(1i.*k_S.*x_S)];
   % Initial_Super_a1=Initial_Super_a;
   % Initial_Super_b=[0 0];
   [X_a,wave_a]=SuperSolve(energy,Initial_Super_a,gap,x_S,beta_S(i));
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
   [X_a,wave_a]=NormalSolve(energy,Initial_Super_a,gap,x_N,beta_N(i));
   [X_b,wave_b]=NormalSolve(energy,Initial_Super_b,gap,x_N,beta_N(i));
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
   
   conductance_seq(i)=quadgk(@(theta) cos(theta).*Transmission(Z(theta,z_factor),u_a,v_a,u_b,v_b),-pi/2,pi/2);
%    fprintf('conductance: %f\n',conductance(i));
   % conductance(i)=Resonance(z,u_a,v_a,k_N,x_T,x_N).*(1+z_factor.^2);

end
% conductance=trapz(phi,conductance_seq);

% conductance=conductance;
