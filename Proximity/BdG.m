function du=BdG(energy,x,u,gx,gap,beta)
du=zeros(2,1);
gap=interp1(gx,gap,x);
du(1)=1i./beta*(energy.*u(1)-gap.*u(2));
du(2)=-1i./beta*(energy.*u(2)-gap.*u(1));
