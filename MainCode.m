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
ys = 9*10^6; %[MPa]
FoS = 1.5;
%Equations

r = (((6 / pi) ^ (1 / 3) * ys * (k ^ (1/3))) / ((8 * (ys ^ 3) * (rho - rho_h)) - ((rho_mat * p_gage * FoS) * ((p_gage ^ 2) * (FoS ^ 2) + (6 * p_gage *FoS * ys) + (12 * (ys ^ 2))))) ^ (1 / 3));

v = 4/3 * pi * r^3;
thickness = r*FoS*p_gage/(2*ys);
m_mat = (4/3 * pi * (thickness + r)^3 - v)*rho_mat;
m_h = v * rho_h;
m = k + m_mat + m_h;
Fb = rho*9.8065*v;
Fg = m * 9.8065;

