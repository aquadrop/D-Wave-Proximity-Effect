function resonance=Resonance(z,u_a,v_a,k_N,x_T,x_N)
a_e=(u_a.*v_a.*exp(-2*1i.*k_N.*x_N))./(u_a.^2+z.^2.*(u_a.^2-v_a.^2.*exp(4*1i.*k_N.*(x_T-x_N))));
b_e=(-1i.*(1./z-1i).*(u_a.^2-v_a.^2.*exp(4*1i.*k_N.*(x_T-x_N))))./(u_a.^2./z.^2+(u_a.^2-v_a.^2.*exp(4*1i.*k_N.*(x_T-x_N))));
resonance=(1+abs(a_e).^2-abs(b_e).^2);
% resonance=1+2.*real((v_a.^2.*exp(4*1i*k_N.*(x_T-x_N)))./(u_a.^2-v_a.^2.*exp(4*1i*k_N.*(x_T-x_N))));