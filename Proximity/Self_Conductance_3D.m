function conductance_3D=Self_Conductance_3D(voltage,temperature,main,life,energygap_factor,z_factor,chemicalenergy)%return a vector, receive a vector of voltage
BOLZMAN=0.08629;
PEAK_EXTEND=max(0.5*energygap_factor,0.5);
FIRST_N=5;
RANGE_FACTOR=5;

delta_range=RANGE_FACTOR*BOLZMAN*temperature;
voltage_down=min(voltage);
voltage_up=max(voltage);
int_down=voltage_down-delta_range+chemicalenergy;
int_up=voltage_up+delta_range+chemicalenergy;
int_step=min(2*PEAK_EXTEND,2*delta_range)/FIRST_N;
energy=int_down:int_step:int_up;
length(energy);
conductance_3D=zeros(1,length(voltage));

conductance_2D=Self_Conductance_2D(energy,life,energygap_factor,z_factor);
%plot(energy,conductance_2D);hold on;
for i=1:length(voltage)
    %fprintf('core %d\n',i);
    diff=DifferentialFermi(energy,life,voltage(i),temperature,chemicalenergy);
    conductance_3D(i)=trapz(energy,conductance_2D.*diff);
end
integral_conductance_N=quadgk(@(theta) 2.*pi.*sin(2*theta).*Conductance_N(theta,z_factor),0,pi/2);
conductance_3D=main*conductance_3D./integral_conductance_N;
