%% ----------------------ADD README FILE ---------------
%clear all; clc; close all;
%syms t real

%alpha__, beta_, gamma_ and delta_ time functions
%syms alpha_(t) beta_(t) gamma_(t) delta_(t)

%% Importing Measurements

%% Measuremeants (in m)

h_rod = 87/1000;  % 93 - 2*3 % maybe include the little shperes.
H_rot = 59/1000; % 65  - 2*R_min_V_tor
R_sph = 2/1000; % 4 accros but 3 high. (R is half)
R_maj_V_tor = (59/2 + 1.5)/1000; % h_rot / 2 + R_min_V_tor
R_maj_H_tor = 64/1000; % = 68 - 2*R_min_H_tor % IS THIS MEANT TO BE /2 SO 32? OR /2 of 68 then the subtraction
r_rot = 2/1000;
R_min_H_tor = 1/1000; % maybe 2 for radius
R_min_V_tor = 1.5/1000; % maybe 3
R_maj_rotor = (27-3.5)/1000; % maybe 28 subtract out the inner radius

% r_rot specified in other view above
R_min_rotor = 3.5/1000;

%% Mass (in kg)
m_rotor = 45/1000; 
m_frame = 23/1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up measurements (symbolic in part    1)
% Constants
g = 9.81   ;                                                   % gravity [ms^-2]
% Frame Measurements
L = h_rod/2 + R_sph     ;                                       % Distance from O to G [m]
% syms h_rod                                                  % Height of vertical rod [m]
% syms R_min_H_tor                                            % Horizontal torus minor radius [m]
% syms R_maj_H_tor                                            % Horizontal torus marjor radius[m]
% syms R_min_V_tor                                            % Vertical torus minor radius [m]
% syms R_maj_V_tor                                            % Vertical torus major radius [m]
% 
% % Rotor measurements
% syms m_frame                                                % Mass of frame [kg] (Measured)
% syms m_rotor                                                % Mass of rotor [kg] (Measured)
% syms H_rot                                                  % Rotor rod height [m]
% syms r_rot                                                  % Rotor rod radius [m] (Vertical rod)
% syms R_min_rotor                                            % Minor radius of rotor torus [m]
% syms R_maj_rotor                                            % Major radius of rotor torus [m]

% % Top and bottom spheres (For animation only, DO NOT MODEL THEM AS A PART OF THE FRAME)
% syms R_sph       

%Symbolic variables for reaction Forces and Moments
% syms F_Ox F_Oy F_Oz real
% syms F_Gx F_Gy F_Gz realr
% syms M_Gx M_Gy M_Gz real
% syms M_Ox M_Oy M_Oz real

% reaction forces
% Reaction force to the rotor at Point G
% Frotor_4 = [F_Gx; F_Gy; F_Gz];
% % Reaction moment to the rotor
% Mrotor_4 = [M_Gx; M_Gy; M_Gz];
% % Reaction force to the frame at Point O
% Fframe_3 = [F_Ox; F_Oy; F_Oz];
% % Reaction moment to the frame
% Mframe_3 = [M_Ox; M_Oy; M_Oz];

%zero equations for the reaction forces/moments that don't exist
% variable name: zero_reaction
%zero_reaction = ([M_Gz;M_Ox;M_Oy;M_Oz]==0);

%lin_NE_rotor = [F_Gx == (2*R_maj_rotor*R_min_rotor^2*g*m_rotor*pi^2*sin(beta_(t))*(cos(delta_(t))*sin(gamma_(t)) + cos(gamma_(t))*sin(delta_(t))))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(L*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t)) - L*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t)))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); F_Gy == (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(L*(- cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t)) - L*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t)))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) + (2*R_maj_rotor*R_min_rotor^2*g*m_rotor*pi^2*sin(beta_(t))*(cos(delta_(t))*cos(gamma_(t)) - sin(delta_(t))*sin(gamma_(t))))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); F_Gz == (2*R_maj_rotor*R_min_rotor^2*g*m_rotor*pi^2*cos(beta_(t)))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(L*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))^2 + L*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))^2)*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)];
%lin_NE_frame = [F_Ox == F_Gx*cos(delta_(t)) - (L*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) - L*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t)))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)) - F_Gy*sin(delta_(t)) + g*sin(beta_(t))*sin(gamma_(t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)); F_Oy == F_Gy*cos(delta_(t)) - (L*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + L*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t)))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)) + F_Gx*sin(delta_(t)) + g*cos(gamma_(t))*sin(beta_(t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)); F_Oz == F_Gz - (L*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))^2 + L*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))^2)*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)) + g*cos(beta_(t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2)/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) + (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))];
%ang_NE_rotor = [M_Gx == (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2 + (3*R_min_rotor^2)/4)*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(- cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); M_Gy == (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2 + (3*R_min_rotor^2)/4)*(cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2) - (R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2/2 + (5*R_min_rotor^2)/8)*(cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t))*2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2); M_Gz == (2*R_maj_rotor*R_min_rotor^2*m_rotor*pi^2*(R_maj_rotor^2 + (3*R_min_rotor^2)/4)*(cos(beta_(t))*diff(alpha_(t), t, 2) - sin(beta_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + diff(delta_(t), t, 2) + diff(gamma_(t), t, 2)))/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)];
%ang_NE_frame = [M_Ox == ((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2))*(cos(gamma_(t))*diff(beta_(t), t, 2) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, 2) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + M_Gx*cos(delta_(t)) - F_Oy*L - M_Gy*sin(delta_(t)) + (sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2 + (3*R_min_V_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) - (sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2 + (3*R_min_H_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (r_rot^2*((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)))/2 + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)); M_Oy == M_Gy*cos(delta_(t)) - ((2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2 + (3*R_min_V_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2))*(sin(gamma_(t))*diff(beta_(t), t, 2) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, 2) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + F_Ox*L + M_Gx*sin(delta_(t)) - (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2 + (3*R_min_H_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (r_rot^2*((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)))/2 + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) + (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)); M_Oz == M_Gz + (cos(beta_(t))*diff(alpha_(t), t, 2) - sin(beta_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + diff(gamma_(t), t, 2))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2 + (3*R_min_H_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (r_rot^2*((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2)))/2 + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) - (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*((2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2 + (3*R_min_V_tor^2)/4))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2)) + (cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*((2*R_maj_H_tor*R_min_H_tor^2*m_frame*pi^2*(R_maj_H_tor^2/2 + (5*R_min_H_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - ((pi*m_frame*r_rot^2*(H_rot - h_rod))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2) - (pi*H_rot*m_rotor*r_rot^2)/(2*R_maj_rotor*pi^2*R_min_rotor^2 + H_rot*pi*r_rot^2))*(h_rod^2/12 + r_rot^2/4) + (2*R_maj_V_tor*R_min_V_tor^2*m_frame*pi^2*(R_maj_V_tor^2/2 + (5*R_min_V_tor^2)/8))/(2*R_maj_H_tor*pi^2*R_min_H_tor^2 + 2*R_maj_V_tor*pi^2*R_min_V_tor^2 - pi*(H_rot - h_rod)*r_rot^2))];

% syms al be ga de % is this g conflicting with gravity - not anymore, changed g for gravity to "gravity"
% syms al_d be_d ga_d de_d
% syms al_dd be_dd ga_dd de_dd

% forces and moments with meaSurements subbed in. need to re get these if
% measurement changes. Find a more automated way!
% F_Gx = 0.0398*(0.0455*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - 0.0455*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))*(de_d + ga_d + al_d*cos(be)) - 0.0018*sin(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 0.0018*cos(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) + 0.3905*sin(be)*(cos(de)*sin(ga) + cos(ga)*sin(de)) - 0.0018*de_d*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) + 0.0018*de_d*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be));
% F_Gy = 0.0018*sin(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) - 0.0018*cos(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 0.0398*(0.0455*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 0.0455*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))*(de_d + ga_d + al_d*cos(be)) - 0.3905*sin(be)*(sin(de)*sin(ga) - cos(de)*cos(ga)) + 0.0018*de_d*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 0.0018*de_d*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga));
% F_Gz = 0.3905*cos(be) - 0.0018*(cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))^2 - 0.0018*(cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))^2;
%  
% F_Ox = 0.2766*sin(be)*sin(ga) + F_Gx*cos(de) - F_Gy*sin(de) - 0.0013*be_dd*sin(ga) + 0.0282*(0.0455*be_d*cos(ga) + 0.0455*al_d*sin(be)*sin(ga))*(ga_d + al_d*cos(be)) + 0.0013*al_dd*cos(ga)*sin(be) - 0.0013*be_d*ga_d*cos(ga) + 0.0013*al_d*be_d*cos(be)*cos(ga) - 0.0013*al_d*ga_d*sin(be)*sin(ga);
% F_Oy = 0.2766*cos(ga)*sin(be) + F_Gy*cos(de) + F_Gx*sin(de) - 0.0013*be_dd*cos(ga) - 0.0282*(0.0455*be_d*sin(ga) - 0.0455*al_d*cos(ga)*sin(be))*(ga_d + al_d*cos(be)) + 0.0013*be_d*ga_d*sin(ga) - 0.0013*al_dd*sin(be)*sin(ga) - 0.0013*al_d*be_d*cos(be)*sin(ga) - 0.0013*al_d*ga_d*cos(ga)*sin(be);
% F_Oz = F_Gz + 0.2766*cos(be) - 0.0013*(be_d*cos(ga) + al_d*sin(be)*sin(ga))^2 - 0.0013*(be_d*sin(ga) - al_d*cos(ga)*sin(be))^2;
% 
% % these are all used i below M on frame
% M_Gx = 1.1296e-05*cos(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 1.1296e-05*sin(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) - 3.1134e+05*(7.1782e-11*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 7.1782e-11*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))*(de_d + ga_d + al_d*cos(be)) + 3.1134e+05*(3.6283e-11*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 3.6283e-11*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))*(de_d + ga_d + al_d*cos(be)) - 1.1296e-05*de_d*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) - 1.1296e-05*de_d*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga));
% M_Gy = 3.1134e+05*(3.6283e-11*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - 3.6283e-11*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))*(de_d + ga_d + al_d*cos(be)) - 1.1296e-05*sin(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 3.1134e+05*(7.1782e-11*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - 7.1782e-11*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))*(de_d + ga_d + al_d*cos(be)) - 1.1296e-05*cos(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) - 1.1296e-05*de_d*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) + 1.1296e-05*de_d*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be));
% M_Gz = 2.2349e-05*de_dd + 2.2349e-05*ga_dd + 2.2349e-05*al_dd*cos(be) - 2.2349e-05*al_d*be_d*sin(be);
% 
% M_Ox = M_Gx*cos(de) - 9.8274e-06*(ga_d + al_d*cos(be))*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) - 0.0455*F_Oy - M_Gy*sin(de) + 2.9985e-05*be_dd*cos(ga) - 2.9985e-05*be_d*ga_d*sin(ga) + 2.9985e-05*al_dd*sin(be)*sin(ga) + 2.9985e-05*al_d*be_d*cos(be)*sin(ga) + 2.9985e-05*al_d*ga_d*cos(ga)*sin(be);
% M_Oy = 0.0455*F_Ox - 1.4916e-05*(ga_d + al_d*cos(be))*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) + M_Gy*cos(de) + M_Gx*sin(de) - 3.5074e-05*be_dd*sin(ga) + 3.5074e-05*al_dd*cos(ga)*sin(be) - 3.5074e-05*be_d*ga_d*cos(ga) + 3.5074e-05*al_d*be_d*cos(be)*cos(ga) - 3.5074e-05*al_d*ga_d*sin(be)*sin(ga);
% M_Oz = M_Gz + 4.4901e-05*ga_dd - 5.0885e-06*(be_d*cos(ga) + al_d*sin(be)*sin(ga))*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 4.4901e-05*al_dd*cos(be) - 4.4901e-05*al_d*be_d*sin(be);
%  
% subbing in = 0  here.
eqn1 = simplify(M_Gz==0);
eqn2 = simplify(M_Ox==0);
eqn3 = simplify(M_Oy==0);
eqn4 = simplify(M_Oz==0);

% eqn1 = simplify(M_Gz);
% eqn2 = simplify(M_Ox);
% eqn3 = simplify(M_Oy);
% eqn4 = simplify(M_Oz);

equations = [eqn1; eqn2; eqn3; eqn4];
vars = [al_dd, be_dd, ga_dd, de_dd];

[A,b] = equationsToMatrix(equations, vars);
X = simplify(A\b);

al_dd = X(1);
be_dd = X(2);
ga_dd = X(3);
de_dd = X(4);

% f_Gx = 0.0398*(0.0455*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - 0.0455*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))*(de_d + ga_d + al_d*cos(be)) - 0.0018*sin(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 0.0018*cos(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) + 0.3905*sin(be)*(cos(de)*sin(ga) + cos(ga)*sin(de)) - 0.0018*de_d*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) + 0.0018*de_d*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be));
% f_Gy = 0.0018*sin(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) - 0.0018*cos(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 0.0398*(0.0455*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 0.0455*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))*(de_d + ga_d + al_d*cos(be)) - 0.3905*sin(be)*(sin(de)*sin(ga) - cos(de)*cos(ga)) + 0.0018*de_d*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 0.0018*de_d*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga));
% f_Gz = 0.3905*cos(be) - 0.0018*(cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))^2 - 0.0018*(cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))^2;
%  
% f_Ox = 0.2766*sin(be)*sin(ga) + F_Gx*cos(de) - F_Gy*sin(de) - 0.0013*be_dd*sin(ga) + 0.0282*(0.0455*be_d*cos(ga) + 0.0455*al_d*sin(be)*sin(ga))*(ga_d + al_d*cos(be)) + 0.0013*al_dd*cos(ga)*sin(be) - 0.0013*be_d*ga_d*cos(ga) + 0.0013*al_d*be_d*cos(be)*cos(ga) - 0.0013*al_d*ga_d*sin(be)*sin(ga);
% f_Oy = 0.2766*cos(ga)*sin(be) + F_Gy*cos(de) + F_Gx*sin(de) - 0.0013*be_dd*cos(ga) - 0.0282*(0.0455*be_d*sin(ga) - 0.0455*al_d*cos(ga)*sin(be))*(ga_d + al_d*cos(be)) + 0.0013*be_d*ga_d*sin(ga) - 0.0013*al_dd*sin(be)*sin(ga) - 0.0013*al_d*be_d*cos(be)*sin(ga) - 0.0013*al_d*ga_d*cos(ga)*sin(be);
% f_Oz = F_Gz + 0.2766*cos(be) - 0.0013*(be_d*cos(ga) + al_d*sin(be)*sin(ga))^2 - 0.0013*(be_d*sin(ga) - al_d*cos(ga)*sin(be))^2;
%  
%     % these are all used i below M on frame   
% m_Gx = 1.1296e-05*cos(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 1.1296e-05*sin(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) - 3.1134e+05*(7.1782e-11*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 7.1782e-11*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))*(de_d + ga_d + al_d*cos(be)) + 3.1134e+05*(3.6283e-11*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 3.6283e-11*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)))*(de_d + ga_d + al_d*cos(be)) - 1.1296e-05*de_d*cos(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) - 1.1296e-05*de_d*sin(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga));
% m_Gy = 3.1134e+05*(3.6283e-11*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - 3.6283e-11*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))*(de_d + ga_d + al_d*cos(be)) - 1.1296e-05*sin(de)*(be_dd*cos(ga) - be_d*ga_d*sin(ga) + al_dd*sin(be)*sin(ga) + al_d*be_d*cos(be)*sin(ga) + al_d*ga_d*cos(ga)*sin(be)) - 3.1134e+05*(7.1782e-11*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) - 7.1782e-11*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be)))*(de_d + ga_d + al_d*cos(be)) - 1.1296e-05*cos(de)*(be_dd*sin(ga) - al_dd*cos(ga)*sin(be) + be_d*ga_d*cos(ga) - al_d*be_d*cos(be)*cos(ga) + al_d*ga_d*sin(be)*sin(ga)) - 1.1296e-05*de_d*cos(de)*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) + 1.1296e-05*de_d*sin(de)*(be_d*sin(ga) - al_d*cos(ga)*sin(be));
% m_Gz = 2.2349e-05*de_dd + 2.2349e-05*ga_dd + 2.2349e-05*al_dd*cos(be) - 2.2349e-05*al_d*be_d*sin(be);
% 
% m_Ox = M_Gx*cos(de) - 9.8274e-06*(ga_d + al_d*cos(be))*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) - 0.0455*F_Oy - M_Gy*sin(de) + 2.9985e-05*be_dd*cos(ga) - 2.9985e-05*be_d*ga_d*sin(ga) + 2.9985e-05*al_dd*sin(be)*sin(ga) + 2.9985e-05*al_d*be_d*cos(be)*sin(ga) + 2.9985e-05*al_d*ga_d*cos(ga)*sin(be);
% m_Oy = 0.0455*F_Ox - 1.4916e-05*(ga_d + al_d*cos(be))*(be_d*cos(ga) + al_d*sin(be)*sin(ga)) + M_Gy*cos(de) + M_Gx*sin(de) - 3.5074e-05*be_dd*sin(ga) + 3.5074e-05*al_dd*cos(ga)*sin(be) - 3.5074e-05*be_d*ga_d*cos(ga) + 3.5074e-05*al_d*be_d*cos(be)*cos(ga) - 3.5074e-05*al_d*ga_d*sin(be)*sin(ga);
% m_Oz = M_Gz + 4.4901e-05*ga_dd - 5.0885e-06*(be_d*cos(ga) + al_d*sin(be)*sin(ga))*(be_d*sin(ga) - al_d*cos(ga)*sin(be)) + 4.4901e-05*al_dd*cos(be) - 4.4901e-05*al_d*be_d*sin(be);
%  

% Sub forces into ang_NE_rotor

%Sub forces and rotor moments into ang_NE_frame
% [actually think this is automatic if we define them above with one
% equals.
% lin_NE_rotor = subs(lin_NE_rotor, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
%     [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);
% lin_NE_frame = subs(lin_NE_frame, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
%     [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);
% ang_NE_rotor = subs(ang_NE_rotor, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
%     [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);
% ang_NE_frame = subs(ang_NE_frame, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
%     [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

%The equations combined and simplified by Matlab
% eqn1 = ang_NE_rotor(3); % solve for M_Gz
% eqn2 = ang_NE_frame(1); % solve for M_Ox
% eqn3 = ang_NE_frame(2); % solve for M_Oy
% eqn4 = ang_NE_frame(3); % % solve for M_Oz
% 
% 
% eqn1 = subs(eqn1, [F_Gx, F_Gy, F_Gz, F_Ox, F_Oy, F_Oz, M_Gx, M_Gy, M_Gz, M_Ox, M_Oy, M_Oz], ...
%      [f_Gx, f_Gy, f_Gz, f_Ox, f_Oy, f_Oz, m_Gx, m_Gy, 0, m_Ox, m_Oy, m_Oz]);
%  
% eqn2 = subs(eqn2, [F_Gx, F_Gy, F_Gz, F_Ox, F_Oy, F_Oz, M_Gx, M_Gy, M_Gz, M_Ox, M_Oy, M_Oz], ...
%      [f_Gx, f_Gy, f_Gz, f_Ox, f_Oy, f_Oz, m_Gx, m_Gy, m_Gz, 0, m_Oy, m_Oz]);
%  
% eqn3 = subs(eqn3, [F_Gx, F_Gy, F_Gz, F_Ox, F_Oy, F_Oz, M_Gx, M_Gy, M_Gz, M_Ox, M_Oy, M_Oz], ...
%      [f_Gx, f_Gy, f_Gz, f_Ox, f_Oy, f_Oz, m_Gx, m_Gy, m_Gz, m_Ox, 0, m_Oz]);
%  
% eqn4 = subs(eqn4, [F_Gx, F_Gy, F_Gz, F_Ox, F_Oy, F_Oz, M_Gx, M_Gy, M_Gz, M_Ox, M_Oy, M_Oz], ...
%      [f_Gx, f_Gy, f_Gz, f_Ox, f_Oy, f_Oz, m_Gx, m_Gy, m_Gz, m_Ox, m_Oy, 0]);
%  
% 
% equations = [eqn1; eqn2; eqn3; eqn4];
% 
% vars = [al_dd, be_dd, ga_dd, de_dd];


% equations(1) = subs(equations, [F_Gx, F_Gy, F_Gz, F_Ox, F_Oy, F_Oz, M_Gx, M_Gy, M_Gz, M_Ox, M_Oy, M_Oz], ...
%     [f_Gx, f_Gy, f_Gz, f_Ox, f_Oy, f_Oz, m_Gx, m_Gy, m_Gz, m_Ox, m_Oy, m_Oz]);
% 
% [A,b] = equationsToMatrix(equations, vars);
% X = A\b;

