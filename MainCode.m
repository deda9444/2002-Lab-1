clear;
clc;

%Atmospheric conditions:
[temp, mach, pres, rho] = atmoscoesa(25000);

%Variables
R_h = 8.24978430917;

%Equations
%press_he = rho_he * temp * R_he;
rho_h = pres/(temp*R_h);

radius = 15.1428;
%Pressure:
    
%Density:

%Temperature:
