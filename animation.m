clc
clear all 
close all



%% Measuremeants (in mm)
h_rod = 87;  % 93 - 2*3
H_rot = 59; % 65  - 2*R_min_V_tor
R_sph = 2; % 4 accros but 3 high. (R is half)
R_maj_V_tor = 59/2 + 1.5 ; % h_rot / 2 + R_min_V_tor

R_maj_H_tor = 64; % = 68 - 2*R_min_H_tor % IS THIS MEANT TO BE /2 SO 32? OR /2 of 68 then the subtraction
r_rot = 2 ;

R_min_H_tor = 1; % maybe 2 for radius
R_min_V_tor = 1.5; %  maybe 3
R_maj_rotor = 27; %maybe 28
% r_rot specified in other view above
R_min_rotor = 3.5;


m_rotor = 45; %grams
m_frame = 23; %grams

g = 9.81;

%% Rotation Matrices
R01 = [cos(alpha) -sin(alpha) 0; sin(alpha) cos(alpha) 0; 0 0 1];
R12 = [1 0 0; 0 cos(beta) -sin(beta); 0 sin(beta) cos(beta)];
R23 = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];

R21 = R12.';
R32 = R23.';
R03 = R01*R12*R23;
R30 = R03.';
%% Angular Velocities

w1_0 = [0;0;diff(alpha,t)];
w1_1 = w1_0; % rotating about the same axis
w1_2 = R21*w1_1;

w21_2 = [diff(beta,t);0;0];
w21_1 = w21_2; 
w2_2 = w21_2 + w1_2;
w2_3 = R32*w2_2;

w32_3 = [0;0;diff(gamma,t)];
w32_2 = w32_3;
w3_3 = w32_3 + w2_3;

%% NE Equations

% FRAME SUMF
%volume_frame_horizontal_ring = 2*pi^2*r*2*R_o; 
%volume_frame_vertical_ring = 2*pi^2*r*2*R_o;
%volume_frame = volume_frame_vertical_ring + volume_frame_horizontal_ring;
m_frame = 23; % GRAMS % (physically weighed this - dont need formula. rho*volume_frame;
rOG_3 = [0 0 L];
rOG_dot_3 = diff(rOG_3,t) + cross(w3_3, rOG_3);
rOG_dot_dot_3 = diff(rOG__dot_3,t) + cross(w3_3, rOG__dot_3);
p_frame_dot_3 = m_frame*rOG_dot_dot_3; % RHS

%LHS - do everything in {3} as both forces are in this and can convert
%gravity easily.
F1_3 = [Fx1_3; Fy1_3; Fz1_3]; % stand on frame 
F2_3 = [Fx2_3; Fy2_3; Fz2_3]; % rotor on frame @ G.

Fg_frame_0 = [0;0;-g]; % gravity on frame.
Fg_frame_3 = R30*Fg_frame_0;

%summation (3 Equations)
F1_3 + Fg_frame_3 + F2_3 = p_frame_dot_3;

% FRAME MOMENTS
% going to do about G which is assume COM due to it being in the centre
% of both rings and the pole. and wont need to use parallel axis thm.


rGO_3 = -rOG_3;

% hframe_G_3 angular momentum of frame about G in {3}.

Ipole_G_3 = 

Iframe_G_3 = IvertRing_G_3 + IhoriRing_G_3 + Ipole_G_3;

hframe_G_3 = Iframe_G_3*w3_3;

hframe_G_3_dot = diff(hframe_G_3,t) + cross(w3_3, hframe_G_3);
cross(rGO_3, F1_3) = hframe_G_3_dot;





%%