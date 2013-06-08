function [X_a1,wave_a1,X_a2,wave_a2,X_b2,wave_b2,conductance]=Conductance1D(energy,super,reduced,induced,z_factor,theta,phi)

% x_T=control_T*beta;
%k_F=1;
% a_S=1;
% epsilon_S=0.5;
% a_N=0.5;
% epsilon_N=10;
%%%%%%%%%%%%%%%%%%%%%%%%%gap_factor=[far_super_gap_factor,zero_super_gap_factor,zero_normal_gap_factor];
% conductance=zeros(1,length(energy));

z=Z(theta,z_factor);
far_super_gap=EnergyGap(phi,super);
zero_super_gap=EnergyGap(phi,reduced);
zero_normal_gap=EnergyGap(phi,induced);

energy=abs(energy);
%     fprintf('%d of %d\n',i,length(energy));
conductance=zeros(1,length(phi));
for i=1:length(phi)
    gap=[far_super_gap(i),zero_super_gap(i),zero_normal_gap(i)];
    control_S=6;
control_N=control_S;
% control_T=1.5;
beta=1;
x_S=control_S*beta;
x_N=control_N*beta;
   % fprintf('##phi at %d of %d##\n',i,length(phi));
k_S=(sqrt(energy.^2-far_super_gap(i).^2))./(beta.*far_super_gap(i));
% k_N=energy./(beta.*far_super_gap(i));
u0=sqrt(0.5.*(1+(sqrt(energy.^2-far_super_gap(i).^2))./energy));
v0=sqrt(1-(u0).^2);

% beta=beta*far_super_gap;
Initial_Super_a=[(u0).*exp(1i.*k_S.*x_S) (v0).*exp(1i.*k_S.*x_S)];

% Initial_Super_a1=Initial_Super_a;
% Initial_Super_b=[0 0];
[X_a,wave_a]=SuperSolve(energy,Initial_Super_a,gap,x_S,beta);
%[X_b,wave_b]=SuperSolve(energy(i),Initial_Super_b,gap_factor,x_S);%%%values are of decreasing sequence;
%fprintf('length %d %d\n',length(X_a),length(X_b));
X_a1=X_a;
wave_a1=wave_a;
tail_a=length(X_a);
%tail_b=length(X_b);
u_a0=wave_a(tail_a,1);
v_a0=wave_a(tail_a,2);
% u_b0=wave_b(1,1);
% v_b0=wave_b(1,2);
Initial_Super_a=[u_a0 v_a0];
% Initial_Super_a=[u_a0 v_a0];
Initial_Super_b=[v_a0 u_a0];
[X_a,wave_a]=NormalSolve(energy,Initial_Super_a,gap,x_N,beta);
[X_b,wave_b]=NormalSolve(energy,Initial_Super_b,gap,x_N,beta);
X_a2=X_a;
X_b2=X_b;
wave_a2=wave_a;
wave_b2=wave_b;


tail_a=length(X_a);
tail_b=length(X_b);
u_a=wave_a(tail_a,1);
v_a=wave_a(tail_a,2);
u_b=wave_b(tail_b,1);
v_b=wave_b(tail_b,2);

% tail_a=length(X_a);
% u_a=wave_a(tail_a,1);
% v_a=wave_a(tail_a,2);
conductance(i)=Transmission(z,u_a,v_a,u_b,v_b).*(1+z_factor.^2);
% conductance(i)=Resonance(z,u_a,v_a,k_N,x_T,x_N).*(1+z_factor.^2);
end


% conductance=conductance;
