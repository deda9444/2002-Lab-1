clear;
clc;

%Atmospheric conditions:
[temp, mach, pres, rho] = atmoscoesa(25000);

%Variables
T_b_n = 179.79; % Temperature of balloon/system at night
T_b_d = 272.564; % Temperature of balloon/system during day
R_h = 8.24978430917; % universal gas constant divided by molar mass of H = 1.00784 (Pa*m^3/(g*K))
rho_mat = 1500; % Density of LLDPE (kg/m^3)
p_gage = 10; % Assumed gage pressure inside balloon (Pa)
k = 500; % Mass of payload (kg)
rho_h = pres/(T_b_n*R_h)/1000; % Density of H based on atmospheric conditions and P = pRT (kg/m^3)
ys = 9*10^6; % Yield strength of LLDPE (Pa)
FoS = 1.5; % Factor of safety


%Equations

% Equation for radius of balloon, set by equating mass to buoyant force and
% substituting wherever possible for radius, then solving
r = (((6 / pi) ^ (1 / 3) * ys * (k ^ (1/3))) / ((8 * (ys ^ 3) * (rho - rho_h)) - ((rho_mat * p_gage * FoS) * ((p_gage ^ 2) * (FoS ^ 2) + (6 * p_gage *FoS * ys) + (12 * (ys ^ 2))))) ^ (1 / 3));

% Volume of balloon interior
v = 4/3 * pi * r^3;
% thickness of balloon skin
thickness = r*FoS*p_gage/(2*ys);
% mass of balloon material
m_mat = (4/3 * pi * (thickness + r)^3 - v)*rho_mat;
% mass of hydrogen
m_h = v * rho_h;
% total mass of system
m = k + m_mat + m_h;
% Buoyant force on balloon
Fb = rho*9.8065*v;
% Force of gravity on system
Fg = m * 9.8065;

%---------------------------------------------------------------------

rho_h_d = pres/(T_b_d*R_h)/1000; % Density of H based on atmospheric conditions and P = pRT (kg/m^3)

m_h_vented = (m_mat + k + (v * rho_h_d) - (rho * v)) / (1 - (rho/rho_h_d));

m_h_new = v * rho_h_d - m_h_vented;

v_new = m_h_new / rho_h_d;

f_g_new = 9.8065 * (m_mat + m_h_new + k);

f_b_new = v_new * rho * 9.8065;


