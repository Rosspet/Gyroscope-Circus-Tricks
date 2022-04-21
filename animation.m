clc
clear all 
close all



%% Measuremeants (in mm)
h_rod = 87;  % 93 - 2*3 % maybe include the little shperes.
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
% maybe inverse direction of roation? 
R34 = [cos(delta) -sin(delta) 0; sin(delta) cos(delta) 0 ; 0 0 1]; 

R43 = R34.';
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
w3_4 = R43*w3_3;

w43_4 = [0;0;diff(delta,t)];
w43_3 = w43_4;
w4_4 = w43_4 + w3_4;

%% NE Equations

%% ROTOR FORCES.

% FORCES
L = (h_rod-H_rot)/2 + H_rot/2; % Looking at canvas diagram.
rOG_4 = [0 0 L]; % z3,4 are aligneedd.
rOG_dot_4 = diff(rOG_4,t) + cross(w4_4, rOG_4);
rOG_dot_dot_4 = diff(rOG_dot_4,t) + cross(w4_4, rOG_dot_4);
p_rotor_dot_4 = m_rotor*rOG_dot_dot_4; % shares G with frame.
Fg_rotor_0 = [0;0;-g*m_rotor];
Fg_rotor_3 = R30*Fg_rotor_0;

p_rotor_dot_3 = R34*p_rotor_dot_4; %  into {3} as usin {3} for gyroscope frame
F2_3 = [Fx3; Fy3; Fz3]; %force of frame on rotor in {3}
% SOLVE BELOW
p_rotor_dot_3 == Fg_rotor_3 + F2_3; % solve this

%% ROTOR MOMENTS 
rotor_h = R_min_rotor*2; % height of rotor as we are modelling as cylinder not torus.
Irotor_G_4 = [
    (1/12)*m_rotor*(3*R_maj_rotor^2+rotor_h^2) 0 0;
    0 (1/12)*m_rotor*(3*R_maj_rotor^2+rotor_h^2) 0;
    0 0 (1/2)*m_rotor*R_maj_rotor^2;
    ];
hrotor_G_4 = Irotor_G_4*w4_4;
hrotor_G_dot_4 = diff(hrotor_G_4,t) + cross(w4_4, hrotor_G_4);
hrotor_G_dot_3 = R34*hrotor_G_dot_4;

% 3 more eqns
% SOLVE BELOW
M_frame_on_rotor_3 = [Mx3; My3; 0];

% 3 more eqns
% SOLVE BELOW
hrotor_G_dot_3 == M_frame_on_rotor_3;


%% FRAME FORCES
%volume_frame_horizontal_ring = 2*pi^2*r*2*R_o; 
%volume_frame_vertical_ring = 2*pi^2*r*2*R_o;
%volume_frame = volume_frame_vertical_ring + volume_frame_horizontal_ring;

rOG_3 = [0 0 L];
rOG_dot_3 = diff(rOG_3,t) + cross(w3_3, rOG_3);
rOG_dot_dot_3 = diff(rOG_dot_3,t) + cross(w3_3, rOG_dot_3);
p_frame_dot_3 = m_frame*rOG_dot_dot_3; % RHS

%LHS - do everything in {3} as p and most forces in 3 except Fg which is
%only 1 component to convert.
F1_3 = [Fx1_3; Fy1_3; Fz1_3]; % stand on frame 
%recall F2_3 is frame on rotor, so negate to get rotor on frame.
Fg_frame_0 = [0;0;-g*m_frame]; % gravity on frame.
Fg_frame_3 = R30*Fg_frame_0; % gravity of frame in {3}

%summation (3 Equations)
F1_3 + Fg_frame_3 - F2_3 == p_frame_dot_3; % solve this

%% FRAME MOMENTS
% going to do about G which is assume COM due to it being in the centre
% of both rings and the pole. and wont need to use parallel axis thm.



%perfect cylinder of height H (h_rod), radius, r_rot
%(currently omitting the 2 small spheres in Height for simplicity but can add later 
% if deemed significant, i.e., non negligible.)
vol_pole = h_rod*pi*r_rot^2;
m_pole = rho*vol_pole;
Ipole_G_3 = [(1/12)*m_pole*(3*r_rot^2+h_rod^2) 0 0; 
            0 (1/12)*m_pole*(3*r_rot^2+h_rod^2) 0 
            0 0 (1/2)*m_pole*r_rot^2 
            ];
        
% the ring which goes horizontally - modeled as a torus
% rho % density of rings and pole.
vol_ring_H= (pi*R_min_H_tor^2)*(2*pi*R_maj_H_tor); %google
m_ring_H = rho*vol_ring_H;    
IhoriRing_G_3 = [
    (1/8)*m_ring_H*(4*R_maj_H_tor^2 + 5*R_min_H_tor^2) 0 0;
    0 (1/8)*m_ring_H*(4*R_maj_H_tor^2 + 5*R_min_H_tor^2) 0;
    0 0 (1/4)*m_ring_H*(4*R_maj_H_tor^2 + 3*R_min_H_tor^2);
    ];

vol_ring_V = (pi*R_min_V_tor^2)*(2*pi*R_maj_V_tor);
m_ring_V = rho*vol_ring_V;
IvertRing_G_3 = [
    (1/8)*m_ring_V*(4*R_maj_V_tor^2 + 5*R_min_V_tor^2) 0 0 ;
    0 (1/4)*m_ring_V*(4*R_maj_V_tor^2 + 3*R_min_V_tor^2) 0;
    0 0 (1/8)*m_ring_V*(4*R_maj_V_tor^2 + 5*R_min_V_tor^2);
    ];

% all in same frame and about same point, apply super pos.
Iframe_G_3 = IvertRing_G_3 + IhoriRing_G_3 + Ipole_G_3;

hframe_G_3 = Iframe_G_3*w3_3;
hframe_G_3_dot = diff(hframe_G_3,t) + cross(w3_3, hframe_G_3);
rGO_3 = -rOG_3;

% sumM of Frame about G - 3 eqns - all 3 EOM once put in values for F1_3
cross(rGO_3, F1_3) - M_frame_on_rotor_3 == hframe_G_3_dot; % solve this






















