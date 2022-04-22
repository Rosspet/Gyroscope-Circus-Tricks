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


F2y3 = 
F1y3 = F2y3 - 23*(43.5000*sin(gamma_(t))*diff(beta_(t), t) - 43.5000*cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*(cos(beta_(t))*diff(alpha_(t), t) + diff(gamma_(t), t)) - 1.0005e+03*cos(gamma_(t))*diff(beta_(t), t, t) + 225.6300*cos(gamma_(t))*sin(beta_(t)) + 1.0005e+03*sin(gamma_(t))*diff(beta_(t), t)*diff(gamma_(t), t) - 1.0005e+03*sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, t) - 1.0005e+03*cos(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)*diff(beta_(t), t) - 1.0005e+03*cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)*diff(gamma_(t), t);
Mx3 = sin(delta_(t))*((cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(1.6402e+04*cos(beta_(t))*diff(alpha_(t), t) + 1.6402e+04*diff(delta_(t), t) + 1.6402e+04*diff(gamma_(t), t)) + 8385*cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, t) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, t) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + 8385*sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, t) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, t) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) - (8385*cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)) - 8385*sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t)) + 8385*cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t) - 8385*sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t)) - cos(delta_(t))*((cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(1.6402e+04*cos(beta_(t))*diff(alpha_(t), t) + 1.6402e+04*diff(delta_(t), t) + 1.6402e+04*diff(gamma_(t), t)) - 8385*cos(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t, t) - sin(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t, t) + cos(beta_(t))*sin(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + cos(gamma_(t))*sin(beta_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) + 8385*sin(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t, t) + cos(gamma_(t))*diff(gamma_(t), t)*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t, t) - cos(beta_(t))*cos(gamma_(t))*diff(beta_(t), t)*diff(alpha_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(gamma_(t), t)*diff(alpha_(t), t)) - (8385*cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t)) + 8385*sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t)))*(cos(beta_(t))*diff(alpha_(t), t) + diff(delta_(t), t) + diff(gamma_(t), t)) + 8385*cos(delta_(t))*(sin(gamma_(t))*diff(beta_(t), t) - cos(gamma_(t))*sin(beta_(t))*diff(alpha_(t), t))*diff(delta_(t), t) + 8385*sin(delta_(t))*(cos(gamma_(t))*diff(beta_(t), t) + sin(beta_(t))*sin(gamma_(t))*diff(alpha_(t), t))*diff(delta_(t), t));
h2 = 43.5000*F1y3 - Mx3 - (2.8364e+04*beta_dot*sin(g) - 2.8364e+04*alpha_dot*cos(g)*sin(b))*(gamma_dot + alpha_dot*cos(b)) + (3.5985e+04*gamma_dot + 3.5985e+04*alpha_dot*cos(b))*(beta_dot*sin(g) - alpha_dot*cos(g)*sin(b)) + 2.4286e+04*beta_dot*gamma_dot*sin(g) - 2.4286e+04*alpha_dot*beta_dot*cos(b)*sin(g) - 2.4286e+04*alpha_dot*gamma_dot*cos(g)*sin(b);

h3 = 




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