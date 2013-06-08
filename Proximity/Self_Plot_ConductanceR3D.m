main=0.90;barrier=0.46;life=0.50;gap=5.36;che=-4.11;
index=12;

[temperature,imp_voltage,imp_conductance]=Readxls(index,0.2*1000);%%%imp_voltage is in V;

voltage=imp_voltage;


% DataSheets = {'10K', '13K', '15K', '21K', '25K', '30K', '35K', '40K', '45K', '50K', '55K', '65K', '70K'};



tic;


conductance=Self_Conductance_3D(voltage,temperature,main,life,gap,barrier,che);

mark={'m-','y-','c-','r-','g-','k-'};

plot(voltage,conductance,mark{1});

hold on;
plot(voltage,imp_conductance,mark{3});
legend(sprintf('T=%4.2f\n gap=%4.2f\n life=%4.2f\n barrier=%4.2f\n',temperature,gap,life,barrier),sprintf('measure'));
hold off;
toc;