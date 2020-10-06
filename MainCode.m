%% 2002 Zero-Pressure Balloon Project
% By Lucas Allen, Devin Davis, and Samantha Smith  

%% Clear Variables and Command Window
clear;
clc;

%% Atmospheric Conditions
[temp, mach, pres, rho] = atmoscoesa(25000);

%% Constants
R_h = 8.24978430917;               % Universal Gas Constant Divided by Molar Mass of H = 1.00784 [Pa*m^3/(g*K)]

rho_mat = 1500;                    % Density of LLDPE [kg/m^3]

p_gage = 10;                       % Assumed Gage Pressure Inside Balloon [Pa]

k = 500;                           % Mass of Payload [kg]

ys = 9*10^6;                       % Yield Strength of LLDPE [Pa]

FoS = 1.5;                         % Factor of Safety

alpha_sb = .6;                     % Absorptivity of Sun-Balloon System

alpha_eb = .8;                     % Absorptivity of Earth-Balloon System

epsilon_b = .8;                    % Emissivity

q_sun = 1353;                      % Solar Irradiance [W/m^2]

q_earth = 237;                     % Irradiance of Earth onto Balloon [W/m^2]

sigma_SB = 5.670*10^-8;            % Sephman-Boltzmann Constant

%% Calculate Day Temperature
T_b_d = sqrt(sqrt(((alpha_sb * q_sun * pi) + (alpha_eb * q_earth * pi))/(epsilon_b * sigma_SB * 4 * pi)));

%% Calculate Night Temperature
T_b_n = sqrt(sqrt(q_earth / (sigma_SB * 4)));

%% Calculate Radius of Balloon
rho_h = pres/(T_b_n*R_h)/1000;     % Density of H based on Atmospheric Conditions and P = pRT [kg/m^3]

% Equate mass to buoyant force, then solve for r
r = (((6 / pi) ^ (1 / 3) * ys * (k ^ (1/3))) / ((8 * (ys ^ 3) * (rho - rho_h)) - ((rho_mat * p_gage * FoS) * ((p_gage ^ 2) * (FoS ^ 2) + (6 * p_gage *FoS * ys) + (12 * (ys ^ 2))))) ^ (1 / 3));

%% Calculate Balloon Features (Volume, Thickness, Mass, Buoyant Force)
v = 4/3 * pi * r^3;                                     % Volume of Balloon Interior

thickness = r * FoS * p_gage / (2 * ys);                % Thickness of Balloon Skin

m_mat = (4/3 * pi * (thickness + r)^3 - v)*rho_mat;     % Mass of Balloon Material

m_h = v * rho_h;                                        % Mass of Hydrogen

m = k + m_mat + m_h;                                    % Total Mass of System

Fb = rho*9.8065*v;                                      % Buoyant Force on Balloon

Fg = m * 9.8065;                                        % Force of Gravity on System

%% Calculate How Much Mass to Vent During the Day
rho_h_d = pres / (T_b_d * R_h) / 1000;                                          % Density of H based on atmospheric conditions and P = pRT (kg/m^3)

m_h_vented = (m_mat + k + (v * rho_h_d) - (rho * v)) / (1 - (rho/rho_h_d));     % After equalizing to volume, the hydrogen vented

m_h_new = v * rho_h_d - m_h_vented;

v_new = m_h_new / rho_h_d;

m_new = m_mat + m_h_new + k;

f_g_new = 9.8065 * (m_new);

f_b_new = v_new * rho * 9.8065;
