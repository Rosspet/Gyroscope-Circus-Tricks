clc; clear all; close all;

syms t real 
%alpha__, beta_, gamma_ and delta_ time functions
syms alpha_(t) beta_(t) gamma_(t) delta_(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up measurements (symbolic in part 1)
% Constants
syms g                                                      % gravity [ms^-2]
% Frame Measurements
syms L                                                      % Distance from O to G [m]
syms h_rod                                                  % Height of vertical rod [m]
syms R_min_H_tor                                            % Horizontal torus minor radius [m]
syms R_maj_H_tor                                            % Horizontal torus marjor radius[m]
syms R_min_V_tor                                            % Vertical torus minor radius [m]
syms R_maj_V_tor                                            % Vertical torus major radius [m]

% Rotor measurements
syms m_frame                                                % Mass of frame [kg] (Measured)
syms m_rotor                                                % Mass of rotor [kg] (Measured)
syms H_rot                                                  % Rotor rod height [m]
syms r_rot                                                  % Rotor rod radius [m] (Vertical rod)
syms R_min_rotor                                            % Minor radius of rotor torus [m]
syms R_maj_rotor                                            % Major radius of rotor torus [m]

% Top and bottom spheres (For animation only, DO NOT MODEL THEM AS A PART OF THE FRAME)
syms R_sph                                                  %radius of the top and bottom spheres [m]

%Calculated constants
%%%%%% Frame %%%%%

%Total frame density [kg/m^3] (Test).
% Variable Name: rho_T
vol_rod = h_rod*pi*r_rot^2;                          
vol_ring_H= (pi*R_min_H_tor^2)*(2*pi*R_maj_H_tor); %google
vol_ring_V = (pi*R_min_V_tor^2)*(2*pi*R_maj_V_tor);
v_frame = vol_rod + vol_ring_V + vol_ring_H;
rho_T = m_frame / v_frame;
                          
%%%%%% Rotor %%%%%

% Desity of the rotor [kg/m^3] (Pretest).
% Variable Name: rho_rotor
rotor_h = R_min_rotor*2; % height of rotor as we are modelling as cylinder not torus.
v_rotor = rotor_h*pi*R_maj_rotor^2;

rho_rotor = m_rotor / v_rotor;
      

% Central rod considered as a cylinder belonging to the frame

% Recalculated mass of frame [kg] (Test).
% Variable Name: m_frame 
m_frame = rho_T*v_frame;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Inertia tensor
% Inertia tensor of the 3 frame components in frame 3 

% Inertia tensor of horizontal torus about its center of mass expressed in frame 3 (Pretest). 
% Variable Name: IGtorH_3

m_ring_H = rho_T*vol_ring_H; % Taurus desnity
IGtorH_3 = [
    (1/8)*m_ring_H*(4*R_maj_H_tor^2 + 5*R_min_H_tor^2) 0 0;
    0 (1/8)*m_ring_H*(4*R_maj_H_tor^2 + 5*R_min_H_tor^2) 0;
    0 0 (1/4)*m_ring_H*(4*R_maj_H_tor^2 + 3*R_min_H_tor^2);
    ];

% Inertia tensor of vertical torus about its center of mass expressed in frame 3 (Test)
% Variable Name: IGtorV_3
m_ring_V = rho_T*vol_ring_V;
IGtorV_3 = [
    (1/8)*m_ring_V*(4*R_maj_V_tor^2 + 5*R_min_V_tor^2) 0 0 ;
    0 (1/4)*m_ring_V*(4*R_maj_V_tor^2 + 3*R_min_V_tor^2) 0;
    0 0 (1/8)*m_ring_V*(4*R_maj_V_tor^2 + 5*R_min_V_tor^2);
    ];

% Inertia tensor of the rod about its center of mass expressed in frame 3 
% Variable Name: IGrod_3
m_rod = rho_T*vol_rod;
IGrod_3 = [(1/12)*m_rod*(3*r_rot^2+h_rod^2) 0 0; 
            0 (1/12)*m_rod*(3*r_rot^2+h_rod^2) 0 
            0 0 (1/2)*m_rod*r_rot^2 
            ];

% Inertia tensor of the frame about its center of mass expressed in frame 3 (Test)
% Variable Name: IGframe_3
IGframe_3 = IGrod_3 + IGtorV_3 + IGtorH_3;

% Inertia tensor of rotor about its center of mass in frame 4 
% Variable Name: IGrotor_4

IGrotor_4 = [
    (1/12)*m_rotor*(3*R_maj_rotor^2+rotor_h^2) 0 0;
    0 (1/12)*m_rotor*(3*R_maj_rotor^2+rotor_h^2) 0;
    0 0 (1/2)*m_rotor*R_maj_rotor^2;
    ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up rotational matrices
R01 = [cos(alpha_) -sin(alpha_) 0; sin(alpha_) cos(alpha_) 0; 0 0 1];
R12 = [1 0 0; 0 cos(beta_) -sin(beta_); 0 sin(beta_) cos(beta_)];
R23 = [cos(gamma_) -sin(gamma_) 0; sin(gamma_) cos(gamma_) 0; 0 0 1];
R34 = [cos(delta_) -sin(delta_) 0; sin(delta_) cos(delta_) 0 ; 0 0 1]; 
R43 = R34.';
R21 = R12.';
R32 = R23.';
R03 = R01*R12*R23;
R30 = R03.';

%Rotation matrix from frame 4 to frame 0 (Pretest).
%Variable Name: R04
R04 = R03*R34;
R40 = R04.';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Kinematics
% Centers of mass positions from origin
% Center of mass position of the frame. Variable Name: rOG_3
rOG_3 = [0; 0; L];
% Center of mass position of the rotor. Variable Name: rOG_4
rOG_4 = [0; 0; L]; % z3,4 are aligneedd.

% Absolute Angular velocity of frame 1 represented in frame 1 
% Variable Name: w1_1
w1_0 = [0;0;diff(alpha_,t)];
w1_1 = w1_0;
w1_2 = R21*w1_1;
% Relative angular velocity of frame 2 relative to 1 represented in frame 2 
% Variable Name: w21_2
w21_2 = [diff(beta_,t);0;0];
w2_2 = w21_2 + w1_2;
w2_3 = R32*w2_2;
% Relative angular velocity of frame 3 relative to 2 represented in frame 3
% Variable Name: w32_2
w32_3 = [0;0;diff(gamma_,t)];
w32_2 = w32_3;

% Relative angular velocity of frame 4 relative to 3 represented in frame 4
% Variable Name: w43_4
w43_4 = [0;0;diff(delta_,t)];

% Absolute angular velocity of frame 3 represented in frame 3 (Test)
% Variable Name: w3_3
w3_3 = w32_3 + w2_3;
w3_4 = R43*w3_3;
% Velocity of center of mass of the frame represented in frame 3 (Test)
% Variable Name: rOG_3_dot
rOG_3_dot = diff(rOG_3,t) + cross(w3_3, rOG_3);
rOG_3_dotdot = diff(rOG_3_dot, t) + cross(w3_3, rOG_3_dot);

% Acceleration of center of mass of the rotor represented in frame 4 (Test)
% Variable Name: rOG_4_dotdot
w4_4 = w43_4 + w3_4;
rOG_4_dot = diff(rOG_4,t) + cross(w4_4, rOG_4);
rOG_4_dotdot = diff(rOG_4_dot,t) + cross(w4_4, rOG_4_dot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Newton-Euler Equation Setup
% Force due to gravity on the torus in frame zero %(ROTOR)
% Variable Name: FGrotor_0
FGrotor_0 = [0;0;-g*m_rotor];
FGrotor_4 = R40*FGrotor_0;
% Force due to gravity on the frame in frame zero
% Variable Name: FGframe_0
FGframe_0 = [0;0;-g*m_frame];
FGframe_3 = R30*FGframe_0;
% rotor angular momentum and its time derivative
% Variable Name: hGrotor_4
hGrotor_4 = IGrotor_4*w4_4;

% Variable Name: hGrotor_4_dot (Test)
hGrotor_4_dot = diff(hGrotor_4,t) + cross(w4_4, hGrotor_4);

% frame angular momentum and its time derivative
% Variable Name: hGframe_3
hGframe_3 = IGframe_3*w3_3;

% Variable Name: hGframe_3_dot (Test)
hGframe_3_dot = diff(hGframe_3,t) + cross(w3_3, hGframe_3);

%Symbolic variables for reaction Forces and Moments
syms F_Ox F_Oy F_Oz real
syms F_Gx F_Gy F_Gz real
syms M_Gx M_Gy M_Gz real
syms M_Ox M_Oy M_Oz real

% reaction forces
% Reaction force to the rotor at Point G
Frotor_4 = [F_Gx; F_Gy; F_Gz];
% Reaction moment to the rotor
Mrotor_4 = [M_Gx; M_Gy; M_Gz];
% Reaction force to the frame at Point O (stand)
Fframe_3 = [F_Ox; F_Oy; F_Oz];
% Reaction moment to the frame (from stand)
Mframe_3 = [M_Ox; M_Oy; M_Oz];

%zero equations for the reaction forces/moments components that don't exist (Prestest)
% variable name: zero_reaction
zero_reaction = [
                Mframe_3 == zeros(3,1);
                Mrotor_4(3) == 0;
                ];

%Linear NE Equations for the Rotor (Pretest)
% variable name: lin_NE_rotor
%Frotor_4 = solve(m_rotor*rOG_4_dotdot == FGrotor_4 + Frotor_4 , Frotor_4);
lin_NE_rotor = m_rotor*rOG_4_dotdot == FGrotor_4 + Frotor_4;

% %Linear NE Equations for the Frame (Test)
% variable name: lin_NE_frame
Frotor_3 = R34*Frotor_4;
lin_NE_frame = Fframe_3 + FGframe_3 - Frotor_3 == m_frame*rOG_3_dotdot;

% %Angular NE Equations for the Rotor (Test)
% variable name: ang_NE_rotor
ang_NE_rotor = hGrotor_4_dot == Mrotor_4; % maybe minus Mrotor_4

% %Angular NE Equations for the Frame (Test)
% variable name: ang_NE_frame
Mrotor_3 = R34*Mrotor_4; % maybe minus Mrotor_4
rGO_3 = -rOG_3;
ang_NE_frame = hGframe_3_dot == Mframe_3 - Mrotor_3 + cross(rGO_3, Fframe_3);

% By this point, we have 16 unknown.
% Make sure you have 16 equation in symbolic variable equations. From top to bottom
% in sequence of zero_reaction, rotor linear equation, frame linear equation
% rotor angular equation, frame angular equation
% The following variable is not tested, but it will help you with the rest of your modelling. 
% It is initially set to zeros for technical reasons. Change it accordingly.
% variable name: equations

syms al be ga de % is this g conflicting with gravity - not anymore, changed g for gravity to "gravity"
syms al_d be_d ga_d de_d
syms al_dd be_dd ga_dd de_dd

syms T

%ang_NE_rotor = ang_NE_rotor(T);

ang_NE_rotor_EQN = subs(ang_NE_rotor, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);
ang_NE_frame = subs(ang_NE_frame, [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);


% equations(1) = ang_NE_rotor(3);
% equations(2) = ang_NE_frame(1);
% equations(3) = ang_NE_frame(2);
% equations(4) = ang_NE_frame(3);
% 
% 
% vars = [al_dd, be_dd, ga_dd, de_dd];
% 
% [A,b] = equationsToMatrix(equations, vars);
% X = A\b;
% al_dd = simplify(X(1));
% be_dd = simplify(X(2));
% ga_dd = simplify(X(3));
% de_dd = simplify(X(4));
% %clearvars -except al_dd be_dd ga_dd de_dd X


%% ---------------- solviong EOMs after filling in template. ----------------
%forces on rotor
[F_Gx, F_Gy, F_Gz] = solve(m_rotor*rOG_4_dotdot == FGrotor_4 + Frotor_4,[F_Gx, F_Gy, F_Gz]) ;
frotor_4 = [expand(F_Gx); expand(F_Gy); expand(F_Gz)];
%forces on frame
frotor_3 = R34*frotor_4;

[F_Ox, F_Oy, F_Oz] = solve(Fframe_3 + FGframe_3 - frotor_3 == m_frame*rOG_3_dotdot, [F_Ox, F_Oy, F_Oz]);
fframe_3 = [expand(F_Ox); expand(F_Oy); expand(F_Oz)];
%moments on rotor % do in {3} - wait i dont think there are frame units if
%applying cancels to both sides to put both in 3 cancels.
[M_Gx, M_Gy, M_Gz] = solve(hGrotor_4_dot == Mrotor_4,[M_Gx, M_Gy, M_Gz]);
mrotor_4 = [expand(M_Gx); expand(M_Gy); expand(M_Gz)];

%moments on frame

mrotor_3 = R34*mrotor_4;
[M_Ox, M_Oy, M_Oz] = solve(hGframe_3_dot == ...
    Mframe_3 - mrotor_3 + cross(rGO_3, fframe_3), [M_Ox, M_Oy, M_Oz]);
mframe_3 = [expand(M_Ox); expand(M_Oy); expand(M_Oz)];
eom1 = mrotor_4(3)==0; 
eom2 = mframe_3(1)==0; 
eom3 = mframe_3(2)==0;
eom4 = mframe_3(3)==0;
equations = [eom1;eom2;eom3;eom4]; % 

equations(1) = subs(equations(1), [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

equations(2) = subs(equations(2), [alpha_, beta_, gamma_, delta_, diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

equations(3) = subs(equations(3), [alpha_, beta_, gamma_, delta_, diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

equations(4) = subs(equations(4), [alpha_, beta_, gamma_, delta_, diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

vars = [al_dd, be_dd, ga_dd, de_dd];
equations
[A,b] = equationsToMatrix(equations, vars);
X = A\b;
al_dd = simplify(X(1));
be_dd = simplify(X(2));
ga_dd = simplify(X(3));
de_dd = simplify(X(4));






%% EOF
