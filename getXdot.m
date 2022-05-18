%% This function claculates the state of the gyroscope at a particular time instance.
function Xdot = getXdot(t, X)

    %% Extract values for iteration
    al = X(1);
    be = X(2);
    ga = X(3);
    de = X(4);
    al_d = X(5);
    be_d = X(6);
    ga_d = X(7);
    de_d = X(8);
    

    %% Friction
    damp = 0.014; %damping between rotor and frame. responsible for slowing rotor down and over all time of animation.
    frition_g =  0.6; % friction constant of proportionality. This encompasses the friciton coefficient, mass/gravity etc. set to something that looks good.
    friction_a = 0.1; % friction coefficient between stand and frame


     %% No friction
%     damp = 0.0; %damping between rotor and frame. responsible for slowing rotor down and over all time of animation.
%     frition_g =  0; % friction constant of proportionality. This encompasses the friciton coefficient, mass/gravity etc. set to something that looks good.
%     friction_a = 0; % friction coefficient between stand and frame
    

    %% EOMS found in part 1.
    al_dd = -al_d*friction_a +(0.0312*(4.5787e+69*be_d*ga_d*cos(ga)^2 + 3.8448e+69*be_d*ga_d*sin(ga)^2 + 6.5419e+70*cos(ga)*sin(be)*sin(ga) + 9.2364e+70*cos(de)^2*cos(ga)*sin(be)*sin(ga) + 9.2364e+70*cos(ga)*sin(be)*sin(de)^2*sin(ga) - 1.3499e+70*al_d*be_d*cos(be)*cos(ga)^2 - 1.4233e+70*al_d*be_d*cos(be)*sin(ga)^2 + 2.0470e+69*be_d*de_d*cos(de)^2*cos(ga)^2 + 2.2113e+69*be_d*de_d*cos(de)^4*cos(ga)^2 + 6.9932e+69*be_d*ga_d*cos(de)^2*cos(ga)^2 + 2.2113e+69*be_d*ga_d*cos(de)^4*cos(ga)^2 + 2.1583e+69*be_d*de_d*cos(de)^2*sin(ga)^2 + 2.0470e+69*be_d*de_d*cos(ga)^2*sin(de)^2 + 2.2113e+69*be_d*de_d*cos(de)^4*sin(ga)^2 + 2.2113e+69*be_d*de_d*cos(ga)^2*sin(de)^4 + 6.0975e+69*be_d*ga_d*cos(de)^2*sin(ga)^2 + 6.9932e+69*be_d*ga_d*cos(ga)^2*sin(de)^2 + 2.2113e+69*be_d*ga_d*cos(de)^4*sin(ga)^2 + 2.2113e+69*be_d*ga_d*cos(ga)^2*sin(de)^4 + 2.1583e+69*be_d*de_d*sin(de)^2*sin(ga)^2 + 2.2113e+69*be_d*de_d*sin(de)^4*sin(ga)^2 + 6.0975e+69*be_d*ga_d*sin(de)^2*sin(ga)^2 + 2.2113e+69*be_d*ga_d*sin(de)^4*sin(ga)^2 - 3.1057e+70*al_d*be_d*cos(be)*cos(de)^2*cos(ga)^2 - 1.7797e+70*al_d*be_d*cos(be)*cos(de)^4*cos(ga)^2 - 3.1953e+70*al_d*be_d*cos(be)*cos(de)^2*sin(ga)^2 - 3.1057e+70*al_d*be_d*cos(be)*cos(ga)^2*sin(de)^2 - 1.7797e+70*al_d*be_d*cos(be)*cos(de)^4*sin(ga)^2 - 1.7797e+70*al_d*be_d*cos(be)*cos(ga)^2*sin(de)^4 - 3.1953e+70*al_d*be_d*cos(be)*sin(de)^2*sin(ga)^2 - 1.7797e+70*al_d*be_d*cos(be)*sin(de)^4*sin(ga)^2 + 7.3389e+68*al_d^2*cos(be)*cos(ga)*sin(be)*sin(ga) + 7.3389e+68*al_d*ga_d*cos(ga)*sin(be)*sin(ga) + 4.4225e+69*be_d*de_d*cos(de)^2*cos(ga)^2*sin(de)^2 + 4.4225e+69*be_d*ga_d*cos(de)^2*cos(ga)^2*sin(de)^2 + 4.4225e+69*be_d*de_d*cos(de)^2*sin(de)^2*sin(ga)^2 + 4.4225e+69*be_d*ga_d*cos(de)^2*sin(de)^2*sin(ga)^2 - 3.5594e+70*al_d*be_d*cos(be)*cos(de)^2*cos(ga)^2*sin(de)^2 - 3.5594e+70*al_d*be_d*cos(be)*cos(de)^2*sin(de)^2*sin(ga)^2 + 8.9567e+68*al_d^2*cos(be)*cos(de)^2*cos(ga)*sin(be)*sin(ga) + 8.9567e+68*al_d^2*cos(be)*cos(ga)*sin(be)*sin(de)^2*sin(ga) - 1.1129e+68*al_d*de_d*cos(de)^2*cos(ga)*sin(be)*sin(ga) + 8.9567e+68*al_d*ga_d*cos(de)^2*cos(ga)*sin(be)*sin(ga) - 1.1129e+68*al_d*de_d*cos(ga)*sin(be)*sin(de)^2*sin(ga) + 8.9567e+68*al_d*ga_d*cos(ga)*sin(be)*sin(de)^2*sin(ga)))/((7.0725e+34*cos(de)^2 + 7.0725e+34*sin(de)^2 + 6.5471e+34)*(4.3144e+33*cos(ga)^2*sin(be) + 4.3144e+33*sin(be)*sin(ga)^2 + 4.4203e+33*cos(de)^2*cos(ga)^2*sin(be) + 4.4203e+33*cos(de)^2*sin(be)*sin(ga)^2 + 4.4203e+33*cos(ga)^2*sin(be)*sin(de)^2 + 4.4203e+33*sin(be)*sin(de)^2*sin(ga)^2));
    be_dd = -(0.0312*(3.8448e+69*al_d*ga_d*cos(ga)^2*sin(be) - 1.2033e+72*sin(be)*sin(ga)^2 - 3.0912e+72*cos(de)^2*cos(ga)^2*sin(be) - 1.8353e+72*cos(de)^4*cos(ga)^2*sin(be) - 2.9988e+72*cos(de)^2*sin(be)*sin(ga)^2 - 3.0912e+72*cos(ga)^2*sin(be)*sin(de)^2 - 1.8353e+72*cos(de)^4*sin(be)*sin(ga)^2 - 1.8353e+72*cos(ga)^2*sin(be)*sin(de)^4 - 2.9988e+72*sin(be)*sin(de)^2*sin(ga)^2 - 1.8353e+72*sin(be)*sin(de)^4*sin(ga)^2 - 1.2687e+72*cos(ga)^2*sin(be) + 4.5787e+69*al_d*ga_d*sin(be)*sin(ga)^2 - 3.6706e+72*cos(de)^2*cos(ga)^2*sin(be)*sin(de)^2 - 3.6706e+72*cos(de)^2*sin(be)*sin(de)^2*sin(ga)^2 + 7.3389e+68*be_d*ga_d*cos(ga)*sin(ga) - 5.1941e+69*al_d^2*cos(be)*cos(ga)^2*sin(be) - 4.4602e+69*al_d^2*cos(be)*sin(be)*sin(ga)^2 - 1.1129e+68*be_d*de_d*cos(ga)*sin(de)^2*sin(ga) + 8.9567e+68*be_d*ga_d*cos(ga)*sin(de)^2*sin(ga) - 1.2928e+70*al_d^2*cos(be)*cos(de)^2*cos(ga)^2*sin(be) - 7.7929e+69*al_d^2*cos(be)*cos(de)^4*cos(ga)^2*sin(be) - 1.2032e+70*al_d^2*cos(be)*cos(de)^2*sin(be)*sin(ga)^2 - 1.2928e+70*al_d^2*cos(be)*cos(ga)^2*sin(be)*sin(de)^2 - 7.7929e+69*al_d^2*cos(be)*cos(de)^4*sin(be)*sin(ga)^2 - 7.7929e+69*al_d^2*cos(be)*cos(ga)^2*sin(be)*sin(de)^4 - 1.2032e+70*al_d^2*cos(be)*sin(be)*sin(de)^2*sin(ga)^2 - 7.7929e+69*al_d^2*cos(be)*sin(be)*sin(de)^4*sin(ga)^2 + 2.1583e+69*al_d*de_d*cos(de)^2*cos(ga)^2*sin(be) + 2.2113e+69*al_d*de_d*cos(de)^4*cos(ga)^2*sin(be) + 6.0975e+69*al_d*ga_d*cos(de)^2*cos(ga)^2*sin(be) + 2.2113e+69*al_d*ga_d*cos(de)^4*cos(ga)^2*sin(be) + 2.0470e+69*al_d*de_d*cos(de)^2*sin(be)*sin(ga)^2 + 2.1583e+69*al_d*de_d*cos(ga)^2*sin(be)*sin(de)^2 + 2.2113e+69*al_d*de_d*cos(de)^4*sin(be)*sin(ga)^2 + 2.2113e+69*al_d*de_d*cos(ga)^2*sin(be)*sin(de)^4 + 6.9932e+69*al_d*ga_d*cos(de)^2*sin(be)*sin(ga)^2 + 6.0975e+69*al_d*ga_d*cos(ga)^2*sin(be)*sin(de)^2 + 2.2113e+69*al_d*ga_d*cos(de)^4*sin(be)*sin(ga)^2 + 2.2113e+69*al_d*ga_d*cos(ga)^2*sin(be)*sin(de)^4 + 2.0470e+69*al_d*de_d*sin(be)*sin(de)^2*sin(ga)^2 + 2.2113e+69*al_d*de_d*sin(be)*sin(de)^4*sin(ga)^2 + 6.9932e+69*al_d*ga_d*sin(be)*sin(de)^2*sin(ga)^2 + 2.2113e+69*al_d*ga_d*sin(be)*sin(de)^4*sin(ga)^2 + 7.3389e+68*al_d*be_d*cos(be)*cos(ga)*sin(ga) - 1.1129e+68*be_d*de_d*cos(de)^2*cos(ga)*sin(ga) + 8.9567e+68*be_d*ga_d*cos(de)^2*cos(ga)*sin(ga) - 1.5586e+70*al_d^2*cos(be)*cos(de)^2*cos(ga)^2*sin(be)*sin(de)^2 - 1.5586e+70*al_d^2*cos(be)*cos(de)^2*sin(be)*sin(de)^2*sin(ga)^2 + 4.4225e+69*al_d*de_d*cos(de)^2*cos(ga)^2*sin(be)*sin(de)^2 + 4.4225e+69*al_d*ga_d*cos(de)^2*cos(ga)^2*sin(be)*sin(de)^2 + 4.4225e+69*al_d*de_d*cos(de)^2*sin(be)*sin(de)^2*sin(ga)^2 + 4.4225e+69*al_d*ga_d*cos(de)^2*sin(be)*sin(de)^2*sin(ga)^2 + 8.9567e+68*al_d*be_d*cos(be)*cos(de)^2*cos(ga)*sin(ga) + 8.9567e+68*al_d*be_d*cos(be)*cos(ga)*sin(de)^2*sin(ga)))/((7.0725e+34*cos(de)^2 + 7.0725e+34*sin(de)^2 + 6.5471e+34)*(4.3144e+33*cos(ga)^2 + 4.3144e+33*sin(ga)^2 + 4.4203e+33*cos(de)^2*cos(ga)^2 + 4.4203e+33*cos(de)^2*sin(ga)^2 + 4.4203e+33*cos(ga)^2*sin(de)^2 + 4.4203e+33*sin(de)^2*sin(ga)^2));
    ga_dd = -ga_d*frition_g +(de_d-ga_d)*damp -(4.7161e-18*(3.0340e+85*be_d*ga_d*cos(be)*cos(ga)^2 + 2.5477e+85*be_d*ga_d*cos(be)*sin(ga)^2 + 6.7876e+84*al_d^2*cos(ga)*sin(be)^3*sin(ga)^3 + 6.7876e+84*al_d^2*cos(ga)^3*sin(be)^3*sin(ga) - 8.9449e+85*al_d*be_d*cos(be)^2*cos(ga)^2 - 9.4312e+85*al_d*be_d*cos(be)^2*sin(ga)^2 - 5.9894e+85*al_d*be_d*cos(ga)^2*sin(be)^2 + 6.7876e+84*al_d*be_d*cos(ga)^4*sin(be)^2 - 5.9894e+85*al_d*be_d*sin(be)^2*sin(ga)^2 - 6.7876e+84*al_d*be_d*sin(be)^2*sin(ga)^4 + 4.3348e+86*cos(be)*cos(ga)*sin(be)*sin(ga) - 6.7876e+84*be_d^2*cos(ga)*sin(be)*sin(ga)^3 - 6.7876e+84*be_d^2*cos(ga)^3*sin(be)*sin(ga) - 1.4287e+85*be_d^2*cos(de)^2*cos(ga)*sin(be)*sin(ga)^3 - 1.4287e+85*be_d^2*cos(de)^2*cos(ga)^3*sin(be)*sin(ga) - 7.5124e+84*be_d^2*cos(de)^4*cos(ga)*sin(be)*sin(ga)^3 - 7.5124e+84*be_d^2*cos(de)^4*cos(ga)^3*sin(be)*sin(ga) - 1.4287e+85*be_d^2*cos(ga)*sin(be)*sin(de)^2*sin(ga)^3 - 1.4287e+85*be_d^2*cos(ga)^3*sin(be)*sin(de)^2*sin(ga) - 7.5124e+84*be_d^2*cos(ga)*sin(be)*sin(de)^4*sin(ga)^3 - 7.5124e+84*be_d^2*cos(ga)^3*sin(be)*sin(de)^4*sin(ga) + 1.3564e+85*be_d*de_d*cos(be)*cos(de)^2*cos(ga)^2 + 1.4652e+85*be_d*de_d*cos(be)*cos(de)^4*cos(ga)^2 + 4.6338e+85*be_d*ga_d*cos(be)*cos(de)^2*cos(ga)^2 + 1.4652e+85*be_d*ga_d*cos(be)*cos(de)^4*cos(ga)^2 + 1.4301e+85*be_d*de_d*cos(be)*cos(de)^2*sin(ga)^2 + 1.3564e+85*be_d*de_d*cos(be)*cos(ga)^2*sin(de)^2 + 1.4652e+85*be_d*de_d*cos(be)*cos(de)^4*sin(ga)^2 + 1.4652e+85*be_d*de_d*cos(be)*cos(ga)^2*sin(de)^4 + 4.0403e+85*be_d*ga_d*cos(be)*cos(de)^2*sin(ga)^2 + 4.6338e+85*be_d*ga_d*cos(be)*cos(ga)^2*sin(de)^2 + 1.4652e+85*be_d*ga_d*cos(be)*cos(de)^4*sin(ga)^2 + 1.4652e+85*be_d*ga_d*cos(be)*cos(ga)^2*sin(de)^4 + 1.4301e+85*be_d*de_d*cos(be)*sin(de)^2*sin(ga)^2 + 1.4652e+85*be_d*de_d*cos(be)*sin(de)^4*sin(ga)^2 + 4.0403e+85*be_d*ga_d*cos(be)*sin(de)^2*sin(ga)^2 + 1.4652e+85*be_d*ga_d*cos(be)*sin(de)^4*sin(ga)^2 + 1.4287e+85*al_d^2*cos(de)^2*cos(ga)*sin(be)^3*sin(ga)^3 + 1.4287e+85*al_d^2*cos(de)^2*cos(ga)^3*sin(be)^3*sin(ga) + 7.5124e+84*al_d^2*cos(de)^4*cos(ga)*sin(be)^3*sin(ga)^3 + 7.5124e+84*al_d^2*cos(de)^4*cos(ga)^3*sin(be)^3*sin(ga) + 1.4287e+85*al_d^2*cos(ga)*sin(be)^3*sin(de)^2*sin(ga)^3 + 1.4287e+85*al_d^2*cos(ga)^3*sin(be)^3*sin(de)^2*sin(ga) + 7.5124e+84*al_d^2*cos(ga)*sin(be)^3*sin(de)^4*sin(ga)^3 + 7.5124e+84*al_d^2*cos(ga)^3*sin(be)^3*sin(de)^4*sin(ga) - 2.0579e+86*al_d*be_d*cos(be)^2*cos(de)^2*cos(ga)^2 - 1.1793e+86*al_d*be_d*cos(be)^2*cos(de)^4*cos(ga)^2 - 2.1173e+86*al_d*be_d*cos(be)^2*cos(de)^2*sin(ga)^2 - 2.0579e+86*al_d*be_d*cos(be)^2*cos(ga)^2*sin(de)^2 - 1.2607e+86*al_d*be_d*cos(de)^2*cos(ga)^2*sin(be)^2 - 1.1793e+86*al_d*be_d*cos(be)^2*cos(de)^4*sin(ga)^2 - 1.1793e+86*al_d*be_d*cos(be)^2*cos(ga)^2*sin(de)^4 + 1.4287e+85*al_d*be_d*cos(de)^2*cos(ga)^4*sin(be)^2 - 6.6290e+85*al_d*be_d*cos(de)^4*cos(ga)^2*sin(be)^2 + 7.5124e+84*al_d*be_d*cos(de)^4*cos(ga)^4*sin(be)^2 - 2.1173e+86*al_d*be_d*cos(be)^2*sin(de)^2*sin(ga)^2 - 1.2607e+86*al_d*be_d*cos(de)^2*sin(be)^2*sin(ga)^2 - 1.2607e+86*al_d*be_d*cos(ga)^2*sin(be)^2*sin(de)^2 - 1.1793e+86*al_d*be_d*cos(be)^2*sin(de)^4*sin(ga)^2 - 1.4287e+85*al_d*be_d*cos(de)^2*sin(be)^2*sin(ga)^4 - 6.6290e+85*al_d*be_d*cos(de)^4*sin(be)^2*sin(ga)^2 - 6.6290e+85*al_d*be_d*cos(ga)^2*sin(be)^2*sin(de)^4 + 1.4287e+85*al_d*be_d*cos(ga)^4*sin(be)^2*sin(de)^2 - 7.5124e+84*al_d*be_d*cos(de)^4*sin(be)^2*sin(ga)^4 + 7.5124e+84*al_d*be_d*cos(ga)^4*sin(be)^2*sin(de)^4 + 4.8630e+84*al_d^2*cos(be)^2*cos(ga)*sin(be)*sin(ga) + 6.1203e+86*cos(be)*cos(de)^2*cos(ga)*sin(be)*sin(ga) - 1.2607e+86*al_d*be_d*sin(be)^2*sin(de)^2*sin(ga)^2 - 1.4287e+85*al_d*be_d*sin(be)^2*sin(de)^2*sin(ga)^4 - 6.6290e+85*al_d*be_d*sin(be)^2*sin(de)^4*sin(ga)^2 - 7.5124e+84*al_d*be_d*sin(be)^2*sin(de)^4*sin(ga)^4 + 6.1203e+86*cos(be)*cos(ga)*sin(be)*sin(de)^2*sin(ga) - 1.5025e+85*be_d^2*cos(de)^2*cos(ga)*sin(be)*sin(de)^2*sin(ga)^3 - 1.5025e+85*be_d^2*cos(de)^2*cos(ga)^3*sin(be)*sin(de)^2*sin(ga) + 4.8630e+84*al_d*ga_d*cos(be)*cos(ga)*sin(be)*sin(ga) + 2.9305e+85*be_d*de_d*cos(be)*cos(de)^2*cos(ga)^2*sin(de)^2 + 2.9305e+85*be_d*ga_d*cos(be)*cos(de)^2*cos(ga)^2*sin(de)^2 + 2.9305e+85*be_d*de_d*cos(be)*cos(de)^2*sin(de)^2*sin(ga)^2 + 2.9305e+85*be_d*ga_d*cos(be)*cos(de)^2*sin(de)^2*sin(ga)^2 + 1.5025e+85*al_d^2*cos(de)^2*cos(ga)*sin(be)^3*sin(de)^2*sin(ga)^3 + 1.5025e+85*al_d^2*cos(de)^2*cos(ga)^3*sin(be)^3*sin(de)^2*sin(ga) - 2.3585e+86*al_d*be_d*cos(be)^2*cos(de)^2*cos(ga)^2*sin(de)^2 - 2.3585e+86*al_d*be_d*cos(be)^2*cos(de)^2*sin(de)^2*sin(ga)^2 - 1.3258e+86*al_d*be_d*cos(de)^2*cos(ga)^2*sin(be)^2*sin(de)^2 + 1.5025e+85*al_d*be_d*cos(de)^2*cos(ga)^4*sin(be)^2*sin(de)^2 + 5.9349e+84*al_d^2*cos(be)^2*cos(de)^2*cos(ga)*sin(be)*sin(ga) - 1.3258e+86*al_d*be_d*cos(de)^2*sin(be)^2*sin(de)^2*sin(ga)^2 - 1.5025e+85*al_d*be_d*cos(de)^2*sin(be)^2*sin(de)^2*sin(ga)^4 + 5.9349e+84*al_d^2*cos(be)^2*cos(ga)*sin(be)*sin(de)^2*sin(ga) - 7.3741e+83*al_d*de_d*cos(be)*cos(de)^2*cos(ga)*sin(be)*sin(ga) + 5.9349e+84*al_d*ga_d*cos(be)*cos(de)^2*cos(ga)*sin(be)*sin(ga) - 7.3741e+83*al_d*de_d*cos(be)*cos(ga)*sin(be)*sin(de)^2*sin(ga) + 5.9349e+84*al_d*ga_d*cos(be)*cos(ga)*sin(be)*sin(de)^2*sin(ga)))/((7.0725e+34*cos(de)^2 + 7.0725e+34*sin(de)^2 + 6.5471e+34)*(4.3144e+33*cos(ga)^2*sin(be) + 4.3144e+33*sin(be)*sin(ga)^2 + 4.4203e+33*cos(de)^2*cos(ga)^2*sin(be) + 4.4203e+33*cos(de)^2*sin(be)*sin(ga)^2 + 4.4203e+33*cos(ga)^2*sin(be)*sin(de)^2 + 4.4203e+33*sin(be)*sin(de)^2*sin(ga)^2));
    de_dd = -(de_d-ga_d)*damp + 0.1133*al_d*be_d*cos(ga)^2*sin(be) - 0.1133*be_d^2*cos(ga)*sin(ga) - 0.1133*al_d*be_d*sin(be)*sin(ga)^2 + 0.1133*al_d^2*cos(ga)*sin(be)^2*sin(ga);
    
    % Store output
    Xdot = [
        al_d;
        be_d;
        ga_d;
        de_d;
        al_dd;
        be_dd;
        ga_dd;
        de_dd;
        ];

end



% first good one 
% damp = 0.017; %damping between rotor and frame. responsible for slowing rotor down and over all time of animation.
%     damp_air_g =  0.3; % damping between frame and air.
%     damp_air_a = 0.1;
%     efficiency = 0.17; 

% same as first good but with more efficiency to try and get gamma rotation
% late
% damp = 0.017; %damping between rotor and frame. responsible for slowing rotor down and over all time of animation.
%     damp_air_g =  0.3; % damping between frame and air.
%     damp_air_a = 0.1;
%     efficiency = 0.25; 

% same as first but less damping in g for trying to get more gamma rotaiton
% at end
% damp = 0.017; %damping between rotor and frame. responsible for slowing rotor down and over all time of animation.
%     damp_air_g =  0.1; % damping between frame and air.
%     damp_air_a = 0.1;
%     efficiency = 0.17; %MAYBE ALSP TRY W MORE EFFICIENCY


% damp = 0.017; %damping between rotor and frame. responsible for slowing rotor down and over all time of animation.
%     damp_air_g =  0.1; % damping between frame and air.
%     damp_air_a = 0.1;
%     efficiency = 0.25;  % too fast gamma.

%fairly fast rotation of gamma.
%    damp = 0.017; %damping between rotor and frame. responsible for slowing rotor down and over all time of animation.
%     damp_air_g =  0.6; % damping between frame and air.
%     damp_air_a = 0.1;
%     efficiency = 0.28; % loss between energy transfer from rotor to frame.
%     % 0.1 an % 2.5