clear;
clc;

%Atmospheric conditions:
[temp, mach, pres, rho] = atmoscoesa(25000);

%Variables
rho_he = 0.000178;
R_he = 2.7069;

%Equations
press_he = rho_he * temp * R_he;

%Pressure:

%Density:

%Temperature:
