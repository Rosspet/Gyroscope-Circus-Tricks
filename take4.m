clear all; clc
syms t real

%alpha__, beta_, gamma_ and delta_ time functions
syms alpha_(t) beta_(t) gamma_(t) delta_(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up measurements (symbolic in part 1)
% Constants
h_rod = 87/1000;  % 93 - 2*3 % maybe include the little shperes.
H_rot = 59/1000; % 65  - 2*R_min_V_tor
R_sph = 2/1000; % 4 accros but 3 high. (R is half)
R_maj_V_tor = (59/2 + 1.5)/1000; % h_rot / 2 + R_min_V_tor
R_maj_H_tor = 64/1000; % = 68 - 2*R_min_H_tor % IS THIS MEANT TO BE /2 SO 32? OR /2 of 68 then the subtraction
r_rot = 2/1000;
R_min_H_tor = 1/1000; % maybe 2 for radius
R_min_V_tor = 1.5/1000; % maybe 3
R_maj_rotor = (27-3.5)/1000; % maybe 28 subtract out the inner radius
g=9.81;
% r_rot specified in other view above
R_min_rotor = 3.5/1000;

%% Mass (in kg)
m_rotor = 45/1000; 
m_frame = 23/1000;     

%Symbolic variables for reaction Forces and Moments
syms F_Ox F_Oy F_Oz real
syms F_Gx F_Gy F_Gz real
syms M_Gx M_Gy M_Gz real
syms M_Ox M_Oy M_Oz real

L = h_rod/2 + R_sph;

syms al be ga de 
syms al_d be_d ga_d de_d
syms al_dd be_dd ga_dd de_dd

% reaction forces
% Reaction force to the rotor at Point G
Frotor_4 = [F_Gx; F_Gy; F_Gz];
% Reaction moment to the rotor
Mrotor_4 = [M_Gx; M_Gy; M_Gz];
% Reaction force to the frame at Point O
Fframe_3 = [F_Ox; F_Oy; F_Oz];
% Reaction moment to the frame
Mframe_3 = [M_Ox; M_Oy; M_Oz];

%zero equations for the reaction forces/moments that don't exist
% variable name: zero_reaction
zero_reaction = ([M_Gz;M_Ox;M_Oy;M_Oz]==0);

lin_NE_rotor = [F_Gx == (2*R_maj_rotor*R_min_rotor^2*g*m_rotor*pi^2*sin(beta_(t))*(cos(delta_(t))*sin(gamma_(t)) + cos(gamma_(t))*sin(delta_(t))))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(L*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t)) - L*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t)))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); F_Gy == (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(L*(- cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t)) - L*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t)))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) + (2*R_maj_rotor*R_min_rotor^2*g*m_rotor*pi^2*sin(beta_(t))*(cos(delta_(t))*cos(gamma_(t)) - sin(delta_(t))*sin(gamma_(t))))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); F_Gz == (2*R_maj_rotor*R_min_rotor^2*g*m_rotor*pi^2*cos(beta_(t)))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(L*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))^2 + L*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))^2)*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)];
lin_NE_frame = [F_Ox == F_Gx*cos(delta_(t)) - (L*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) - L*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t)))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)) - F_Gy*sin(delta_(t)) + g*sin(beta_(t))*sin(gamma_(t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)); F_Oy == F_Gy*cos(delta_(t)) - (L*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + L*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t)))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)) + F_Gx*sin(delta_(t)) + g*cos(gamma_(t))*sin(beta_(t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)); F_Oz == F_Gz - (L*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))^2 + L*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))^2)*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)) + g*cos(beta_(t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))];
ang_NE_rotor = [M_Gx == (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2 + (3*R_min_rotor^2)/4)*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(- cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); M_Gy == (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2 + (3*R_min_rotor^2)/4)*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); M_Gz == (2*R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2 + (3*R_min_rotor^2)/4)*(cos(beta_(t))*diff(alpha_(t), t, 2) - sin(beta_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + diff(delta_(t), t, 2) + diff(gamma_(t), t, 2)))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)];
ang_NE_frame = [M_Ox == ((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + M_Gx*cos(delta_(t)) - F_Oy*L - M_Gy*sin(delta_(t)) + (sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2 + (3*R_min_V_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) - (sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2 + (3*R_min_H_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (r_rot^2*((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)))/2 + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)); M_Oy == M_Gy*cos(delta_(t)) - ((2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2 + (3*R_min_V_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + F_Ox*L + M_Gx*sin(delta_(t)) - (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2 + (3*R_min_H_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (r_rot^2*((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)))/2 + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) + (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)); M_Oz == M_Gz + (cos(beta_(t))*diff(alpha_(t), t, 2) - sin(beta_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + diff(gamma_(t), t, 2))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2 + (3*R_min_H_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (r_rot^2*((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)))/2 + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) - (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*((2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2 + (3*R_min_V_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) + (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2))];

lin_NE_rotor = subs(lin_NE_rotor, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);
lin_NE_frame = subs(lin_NE_frame, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);
ang_NE_rotor = subs(ang_NE_rotor, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);
ang_NE_frame = subs(ang_NE_frame, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);



%The equations combined and simplified by Matlab
equations = [zero_reaction; lin_NE_rotor; lin_NE_frame; ang_NE_rotor; ang_NE_frame];
vars = [F_Ox, F_Oy, F_Oz, F_Gx, F_Gy, F_Gz, M_Gx, M_Gy, M_Gz, M_Ox, M_Oy, M_Oz, al_dd, be_dd, ga_dd, de_dd];
    


[A,b] = equationsToMatrix(equations, vars);
X = A\b;

al_dd = X(13);
be_dd = X(14);
ga_dd = X(15);
de_dd = X(16);

