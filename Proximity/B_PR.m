function B=B_PR(z,u_a,v_a,u_b,v_b)
B=abs((1i.*(1./z-1i).*(u_b.*v_a-u_a.*v_b))./((1./z.^2+1).*u_a.^2-u_b.^2)).^2;