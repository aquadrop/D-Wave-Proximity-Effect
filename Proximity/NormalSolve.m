function [X,U]=NormalSolve(energy,Initial,gap,x_N,beta)

% far_super_gap_factor=1;
% a_N=1;
% epsilon_N=1;
%zero_normal_gap_factor=gap_factor(3);
gx=linspace(0,-x_N,1000);
% gap_vector=NormalGap(gap,gx,beta);
gap_vector=NormalParabolic(gap,gx,x_N);
Xspan=[0 -x_N];
% Initial=[1 1];
%beta=beta*gap(1);
options = odeset('RelTol',1e-6,'AbsTol',[1e-8 1e-8]);
[X,U]=ode45(@(x,u) BdG(energy,x,u,gx,gap_vector,beta),Xspan,Initial,options);
%U=interp1(X,U,gx);