function du = myode(x,u,gx,gap)
%du=zeros(2,1);
gap=interp1(gx,gap,x);
%du(1)=1i*(u(1)-gap.*u(2));
%du(2)=-1i*(u(2)-gap.*u(1));
du=1i*(u-gap.*u);