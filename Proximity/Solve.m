xspan = [0 10];
ynot = [1 0];
[X,Y] = ode45(@exampleode,xspan,ynot);