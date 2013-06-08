function A=A_PR(z,u_a,v_a,u_b,v_b)
A=abs(((1./z.^2+1).*u_a.*v_a-u_b.*v_b)./((1./z.^2+1).*u_a.^2-u_b.^2)).^2;