function Xdot = getXdot(t, X)

a = x(1);
b = x(2);
g = x(3);
d = x(4);
alpha_dot = x(5);
beta_dot = x(6);
gamma_dot = x(7);
delta_dot = x(8);

h1 = (cos(d)*(beta_dot*cos(g) + alpha_dot*sin(b)*sin(g)) - sin(d)*(beta_dot*sin(g) - alpha_dot*cos(g)*sin(b)))*(8385*cos(d)*(beta_dot*sin(g) - alpha_dot*cos(g)*sin(b)) + 8385*sin(d)*(beta_dot*cos(g) + alpha_dot*sin(b)*sin(g))) - (cos(d)*(beta_dot*sin(g) - alpha_dot*cos(g)*sin(b)) + sin(d)*(beta_dot*cos(g) + alpha_dot*sin(b)*sin(g)))*(8385*cos(d)*(beta_dot*cos(g) + alpha_dot*sin(b)*sin(g)) - 8385*sin(d)*(beta_dot*sin(g) - alpha_dot*cos(g)*sin(b))) + 1.6402e+04*alpha_dot*beta_dot*sin(b);
h2 = (3.5985e+04*gamma_dot + 3.5985e+04*alpha_dot*cos(b))*(beta_dot*sin(g) - alpha_dot*cos(g)*sin(b)) - (2.8364e+04*beta_dot*sin(g) - 2.8364e+04*alpha_dot*cos(g)*sin(b))*(gamma_dot + alpha_dot*cos(b)) + 2.9018e+04*cos(g)*sin(b) + 2.4286e+04*beta_dot*gamma_dot*sin(g) + 1.6402e+04*beta_dot*delta_dot*cos(d)^2*sin(g) + 1.6402e+04*beta_dot*gamma_dot*cos(d)^2*sin(g) + 1.6402e+04*beta_dot*delta_dot*sin(d)^2*sin(g) + 1.6402e+04*beta_dot*gamma_dot*sin(d)^2*sin(g) + 4.3522e+04*alpha_dot^2*cos(b)*cos(g)*sin(b) - 1.1133e+05*alpha_dot*beta_dot*cos(b)*sin(g) - 2.4286e+04*alpha_dot*gamma_dot*cos(g)*sin(b) + 7.7134e+04*alpha_dot^2*cos(b)*cos(d)^2*cos(g)*sin(b) + 7.7134e+04*alpha_dot^2*cos(b)*cos(g)*sin(b)*sin(d)^2 - 170670*alpha_dot*beta_dot*cos(b)*cos(d)^2*sin(g) - 1.6402e+04*alpha_dot*delta_dot*cos(d)^2*cos(g)*sin(b) - 1.6402e+04*alpha_dot*gamma_dot*cos(d)^2*cos(g)*sin(b) - 170670*alpha_dot*beta_dot*cos(b)*sin(d)^2*sin(g) - 1.6402e+04*alpha_dot*delta_dot*cos(g)*sin(b)*sin(d)^2 - 1.6402e+04*alpha_dot*gamma_dot*cos(g)*sin(b)*sin(d)^2;
h3 = (3.5985e+04*gamma_dot + 3.5985e+04*alpha_dot*cos(b))*(beta_dot*cos(g) + alpha_dot*sin(b)*sin(g)) - (2.4286e+04*beta_dot*cos(g) + 2.4286e+04*alpha_dot*sin(b)*sin(g))*(gamma_dot + alpha_dot*cos(b)) - 2.9018e+04*sin(b)*sin(g) + 2.8364e+04*beta_dot*gamma_dot*cos(g) + 1.6402e+04*beta_dot*delta_dot*cos(d)^2*cos(g) + 1.6402e+04*beta_dot*gamma_dot*cos(d)^2*cos(g) + 1.6402e+04*beta_dot*delta_dot*cos(g)*sin(d)^2 + 1.6402e+04*beta_dot*gamma_dot*cos(g)*sin(d)^2 - 4.3522e+04*alpha_dot^2*cos(b)*sin(b)*sin(g) - 1.1541e+05*alpha_dot*beta_dot*cos(b)*cos(g) + 2.8364e+04*alpha_dot*gamma_dot*sin(b)*sin(g) + 1.6402e+04*alpha_dot*delta_dot*sin(b)*sin(d)^2*sin(g) + 1.6402e+04*alpha_dot*gamma_dot*sin(b)*sin(d)^2*sin(g) - 7.7134e+04*alpha_dot^2*cos(b)*cos(d)^2*sin(b)*sin(g) - 7.7134e+04*alpha_dot^2*cos(b)*sin(b)*sin(d)^2*sin(g) - 170670*alpha_dot*beta_dot*cos(b)*cos(d)^2*cos(g) - 170670*alpha_dot*beta_dot*cos(b)*cos(g)*sin(d)^2 + 1.6402e+04*alpha_dot*delta_dot*cos(d)^2*sin(b)*sin(g) + 1.6402e+04*alpha_dot*gamma_dot*cos(d)^2*sin(b)*sin(g);
h4 = (2.8364e+04*beta_dot*sin(g) - 2.8364e+04*alpha_dot*cos(g)*sin(b))*(beta_dot*cos(g) + alpha_dot*sin(b)*sin(g)) - (2.4286e+04*beta_dot*cos(g) + 2.4286e+04*alpha_dot*sin(b)*sin(g))*(beta_dot*sin(g) - alpha_dot*cos(g)*sin(b)) + 5.2388e+04*alpha_dot*beta_dot*sin(b);

Xdot = [
    alpha_dot;
    beta_dot;
    gamma_dot;
    delta_dot;
    h1;
    h2;
    h3;
    h4;
    ];

end