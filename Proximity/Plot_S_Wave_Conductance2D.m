plot_N=200;
Up=3;
energy=-Up:(2*Up)/plot_N:Up;

bulk = 2;
reduced = 0:0.05:2;
induced = 0.2;
conductance=zeros(length(energy),length(reduced));
theta = 0:0.1:pi;
phi = 0;
Z=0.3;
for i=1:length(energy); 
    fprintf('%d\n',i);
    for j=1:length(reduced)
    conductance(i,j) = Faster_Conductance1D(energy(i),bulk,reduced(j),induced,Z,phi);
    end
end
conductance=conductance./AverageNormal(Z);
% plot(energy,conductance)
 mesh(reduced,energy,conductance);