%% Constants
g = 9.81;

%% Frame Measurements
h_rod = 87/1000;  % 93 - 2*3 % maybe include the little shperes.
R_min_H_tor = 1/1000; % maybe 2 for radius
R_maj_H_tor = 64/1000; % = 68 - 2*R_min_H_tor % IS THIS MEANT TO BE /2 SO 32? OR /2 of 68 then the subtraction
R_min_V_tor = 1.5/1000; % maybe 3
R_maj_V_tor = (59/2 + 1.5)/1000; % h_rot / 2 + R_min_V_tor

%% Rotor Measurements
m_frame = 23/1000;
m_rotor = 45/1000; 
H_rot = 59/1000; % 65  - 2*R_min_V_tor
r_rot = 2/1000;
R_min_rotor = 3.5/1000;
R_maj_rotor = (27-3.5)/1000; % maybe 28 subtract out the inner radius

%% Top and Bottom Spheres
R_sph = 2/1000; % 4 accros but 3 high. (R is half)

%% L
L = h_rod/2 + 2*R_sph;