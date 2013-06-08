TEMPERATURE=27;%Temperature please be larger than 5K;
ENERGYGAP_FACTOR=[2,1,0.6];
Z_FACTOR=1;
CHEMICALENERGY=0;
LAMDA_FACTOR=1;
LIFE=0;
MAIN=1;

PLOT_N=25;
temperature=TEMPERATURE;
chemicalenergy=CHEMICALENERGY;
energygap_factor=ENERGYGAP_FACTOR;
z_factor=Z_FACTOR;
lamda_factor=LAMDA_FACTOR;
life=LIFE;
main=MAIN;


plot_factor=1.5;
range=plot_factor*energygap_factor(1);
plot_step=range/PLOT_N;
energy_positive=0:plot_step:range;%%%%%%%energy symmetry
energy_negative=-energy_positive(end:-1:2);
energy=[energy_negative,energy_positive];
clc
tic
%conductance=Faster_Conductance2D(energy,0,energygap_factor,z_factor);
%conductance_positive=Dab_Faster_Conductance2D(energy_positive,0,energygap_factor,z_factor);
conductance_positive=Dc_Faster_Conductance2D(energy_positive,0,energygap_factor,z_factor);
% conductance1=Self_Conductance_2D(energy,10,energygap_factor,z_factor);



conductance_negative=conductance_positive(end:-1:2);
conductance=[conductance_negative,conductance_positive];
plot(energy,conductance)%,energy,conductance1); 
toc
