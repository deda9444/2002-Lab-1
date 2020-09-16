clear;
clc;

%Atmospheric conditions:
[temp, mach, pres, rho] = atmoscoesa(25000);

%Variables

R_h = 8.24978430917; 
rho_mat = 1500;
p_gage = 10;
k = 500;
%Equations
rho_h = pres/(temp*R_h)/1000;
ys = 910^6; %[MPa]
FoS = 1.5;
rho_f = rho;
%Equations

r = (((6 / pi) ^ (1 / 3) * ys * (k ^ (1/3))) / ((8 * (ys ^ 3) * (rho_f - rho_h)) - ((rho_mat * p_gage * FoS) * ((p_gage ^ 2) * (FoS ^ 2) + (6 * p_gage *FoS * ys) + (12 * (ys ^ 2))))) ^ (1 / 3));

R_h = 8.24978430917;

%Equations
%press_he = rho_he * temp * R_he;
rho_h = pres/(temp*R_h);

%Pressure:

%Density:

%Temperature:
