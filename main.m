%% Setup Workspace
% Code snippets inspired by two_dof_animation.m from lectures

clc;
clear all;
close all;

%% User Inputs

REC = 0;
%Positions
al = pi/1200;
be = deg2rad(1.8);
ga = pi/1200;
de = pi/1200;

% Velocities
al_d = 0.00;
be_d = 0.00;
ga_d = 0.00;
de_d = -20*2*pi*3;
 
%% Generate Simulation

X_init = [al,be,ga,de,al_d,be_d,ga_d,de_d]; 
tspan = [0 70]; % simulation period

% Use findEOMs to setup getXdot
options = odeset('RelTol',1e-7,'AbsTol',1e-7'); % ode45 options
sol = ode45(@getXdot, tspan, X_init, options);  % solve gyro sim

dt = 0.03;                  % time step
t = tspan(1):dt:tspan(2);   % time vector
X = deval(sol, t);          % isolate X

%% Plot Simulation
info = figure;
sgtitle("Gyroscope Simulation");
hold on;

% Set size of figure
sz = get(groot, 'Screensize');
set(info, 'Position', [sz(3)/4, sz(4)/4, sz(3)/2, sz(4)/2]);

subplot(4, 2, 1);
plot(t, X(1,:), "Color", "red");
xlabel("Time (s)");
ylabel("Angular Position (rads)");
h1 = legend('$\alpha$');
set(h1,'Interpreter','latex');
t1 = title("Angular Position");
set(t1,'Interpreter','latex');

subplot(4, 2, 3);
plot(t, X(2,:), "Color", "magenta");
xlabel("Time (s)");
ylabel("Angular Position (rads)");
h1 = legend('$\beta$');
set(h1,'Interpreter','latex');

subplot(4, 2, 5);
plot(t, X(3,:), "Color", "green");
xlabel("Time (s)");
ylabel("Angular Position (rads)");
h1 = legend('$\gamma$');
set(h1,'Interpreter','latex');

subplot(4, 2, 7);
plot(t, X(4,:));
xlabel("Time (s)");
ylabel("Angular Position (rads)");
h1 = legend('$\delta$');
set(h1,'Interpreter','latex');

subplot(4, 2, 2);
plot(t, X(5,:), "Color", "red");
xlabel("Time (s)");
ylabel("Angular Velocity (rads/s)");
h2 = legend('$\dot{\alpha}$');
set(h2,'Interpreter','latex');
t2 = title("Angular Velocity");
set(t2,'Interpreter','latex');

subplot(4, 2, 4);
plot(t, X(6,:), "Color", "magenta");
xlabel("Time (s)");
ylabel("Angular Velocity (rads/s)");
h2 = legend('$\dot{\beta}$');
set(h2,'Interpreter','latex');

subplot(4, 2, 6);
plot(t, X(7,:), "Color", "green");
xlabel("Time (s)");
ylabel("Angular Velocity (rads/s)");
h2 = legend('$\dot{\gamma}$');
set(h2,'Interpreter','latex');

subplot(4, 2, 8);
plot(t, X(8,:));
xlabel("Time (s)");
ylabel("Angular Velocity (rads/s)");
h2 = legend('$\dot{\delta}$');
set(h2,'Interpreter','latex');

%% Display Animation
% View without recording
ANI = 0;

if REC == 1 || ANI == 1

    % Can be Top, Side, Isometric or All
    s_view = "Top";
    
    vtitle = "videos\GyroSim - ["+string(al)+", "+string(be)+", "+string(ga)...
        +", "+string(de)+", "+string(al_d)+", "+string(be_d)+", "+string(ga_d)...
        +", "+string(de_d)+", "+s_view+"]"+string(now);
    
    animateGyro(t, X, dt, info, REC, vtitle, s_view);
end
