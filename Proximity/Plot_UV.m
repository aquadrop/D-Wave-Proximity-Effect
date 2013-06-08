energy = 2;
super = 1;
reduced = 0.8;
induced = 0.2;
theta = 0;
phi = 0;
z_factor = 0.3;
[X_a1,wave_a1,X_a2,wave_a2,X_b2,wave_b2,conductance]=Conductance1D(energy,super,reduced,induced,z_factor,theta,phi);
hold all;
plot(X_a1,abs(wave_a1(:,1)));
plot(X_a1,abs(wave_a1(:,2)));
plot(X_a2,abs(wave_a2(:,1)));
plot(X_a2,abs(wave_a2(:,2)));
plot(X_a2,abs(wave_b2(:,1)));
plot(X_a2,abs(wave_b2(:,2)));

legend('abs(U_r)','abs(V_r)','abs(U_ia)','abs(V_ia)','abs(U_ib)','abs(V_ib)');

