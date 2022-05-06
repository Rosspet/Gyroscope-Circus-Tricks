%% Setup Workspace
% Code snippets inspired by two_dof_animation.m from lectures

clc;
clear all;
close all;

%% User Inputs

REC = 0;

al = pi/4;
be = pi/4;
ga = pi/4;
de = 0;
al_d = 3;
be_d = 6;
ga_d = 7;
de_d = 10*pi;

%% Generate Simulation

X_init = [al,be,ga,de,al_d,be_d,ga_d,de_d]; 
tspan = [0 1]; % simulation period

% Use findEOMs to setup getXdot
options = odeset('RelTol',1e-7,'AbsTol',1e-7'); % ode45 options
sol = ode45(@getXdot, tspan, X_init, options);  % solve gyro sim

dt = 0.01;                  % time step
t = tspan(1):dt:tspan(2);   % time vector
X = deval(sol, t);          % isolate X

%% Plot Simulation
info = figure;
sgtitle("Gyroscope Simulation");
hold on;

% Set size of figure
sz = get(groot, 'Screensize');
set(info, 'Position', [sz(3)/4, sz(4)/4, sz(3)/2, sz(4)/2]);

pos = subplot(2, 3, 1);
plot(t, X(1:4,:));
xlabel("Time (s)");
ylabel("Angular Position (rads)");
h1 = legend('$\alpha$','$\beta$','$\gamma$','$\delta$');
set(h1,'Interpreter','latex');

vel = subplot(2, 3, 4);
plot(t, X(5:end,:));
xlabel("Time (s)");
ylabel("Angular Velocity (rads/s)");
h2 = legend('$\dot{\alpha}$','$\dot{\beta}$','$\dot{\gamma}$','$\dot{\delta}$');
set(h2,'Interpreter','latex');

%% Display Animation

if REC
    sim = subplot(2, 3, [1,2,3,4,5,6]);
else
    sim = subplot(2, 3, [2,3,5,6]);
end

vtitle = "videos\GyroSim - ["+string(al)+", "+string(be)+", "+string(ga)...
    +", "+string(de)+", "+string(al_d)+", "+string(be_d)+", "+string(ga_d)...
    +", "+string(de_d)+"]";

animateGyro(t, X, dt, info, REC, vtitle);
