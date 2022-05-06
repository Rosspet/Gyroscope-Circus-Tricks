
equations = [zero_reaction; lin_NE_rotor; lin_NE_frame; ang_NE_rotor; ang_NE_frame];


% this doesnt work. for example, the last moments, M_Ox, has other
% symbolics in their expression which should be expanded.
% [F_Gx F_Gy F_Gz] = solve(lin_NE_rotor, [F_Gx F_Gy F_Gz]); % Frotor_4 = [F_Gx; F_Gy; F_Gz];
% [F_Ox F_Oy F_Oz] = solve(lin_NE_frame, [F_Ox F_Oy F_Oz]); % Fframe_3 = [F_Ox; F_Oy; F_Oz];
% [M_Gx M_Gy M_Gz] = solve(ang_NE_rotor, [M_Gx M_Gy M_Gz]); % Mrotor_4 = [M_Gx; M_Gy; M_Gz];
% [M_Ox M_Oy M_Oz] = solve(ang_NE_frame, [M_Ox M_Oy M_Oz]); %Mframe_3 = [M_Ox; M_Oy; M_Oz];

[F_Gx, F_Gy, F_Gz] = solve(m_rotor*rOG_4_dotdot == FGrotor_4 + Frotor_4, [F_Gx, F_Gy, F_Gz]); % Frotor_4 = [F_Gx; F_Gy; F_Gz];
frotor_4 = [expand(F_Gx); expand(F_Gy); expand(F_Gz)]; % we solve for this but isnt used in the equation below as we take angular moment about point this force act on, on the frame.

[F_Ox, F_Oy, F_Oz] = solve(Fframe_3 + FGframe_3 - Frotor_3 == m_frame*rOG_3_dotdot, [F_Ox, F_Oy, F_Oz]); % Fframe_3 = [F_Ox; F_Oy; F_Oz];
fGframe_3 = [expand(F_Ox); expand(F_Oy); expand(F_Oz)];

[M_Gx, M_Gy, M_Gz] = solve(hGrotor_4_dot == Mrotor_4, [M_Gx, M_Gy, M_Gz]); % Mrotor_4 = [M_Gx; M_Gy; M_Gz];
mrotor_4 = [expand(M_Gx); expand(M_Gy); expand(M_Gz)];
mrotor_3=R34*mrotor_4;
[M_Ox, M_Oy, M_Oz] = solve(hGframe_3_dot == Mframe_3 - mrotor_3 + cross(rGO_3, fGframe_3), [M_Ox, M_Oy, M_Oz]); %Mframe_3 = [M_Ox; M_Oy; M_Oz];


% back up 2
[F_Gx, F_Gy, F_Gz] = solve(Frotor_4 == m_rotor*rOG_4_dotdot-FGrotor_4, [F_Gx, F_Gy, F_Gz]); % Frotor_4 = [F_Gx; F_Gy; F_Gz];
frotor_4 = [simplify(F_Gx); simplify(F_Gy); simplify(F_Gz)]; % we solve for this but isnt used in the equation below as we take angular moment about point this force act on, on the frame.
frotor_3 = R34*frotor_4;

[F_Ox, F_Oy, F_Oz] = solve(Fframe_3 == m_frame*rOG_3_dotdot-FGframe_3+frotor_3, [F_Ox, F_Oy, F_Oz]); % Fframe_3 = [F_Ox; F_Oy; F_Oz];
fframe_3 = [simplify(F_Ox); simplify(F_Oy); simplify(F_Oz)];

[M_Gx, M_Gy, M_Gz] = solve(Mrotor_4 == hGrotor_4_dot, [M_Gx, M_Gy, M_Gz]); % Mrotor_4 = [M_Gx; M_Gy; M_Gz];
mrotor_4 = [simplify(M_Gx); simplify(M_Gy); simplify(M_Gz)];
mrotor_3=R34*mrotor_4;

[M_Ox, M_Oy, M_Oz] = solve(Mframe_3 == hGframe_3_dot + mrotor_3 - cross(rGO_3, fframe_3), [M_Ox, M_Oy, M_Oz]); %Mframe_3 = [M_Ox; M_Oy; M_Oz];
mframe_3 = [simplify(M_Ox), simplify(M_Oy), simplify(M_Oz)];
    
% RECALL - zero_reaction = [M_Gz; M_Ox; M_Oy; M_Oz] == 0 give our 4 eom's;
eom1 = mrotor_4(3)==0;
eom2 = mframe_3(1)==0;
eom3 = mframe_3(2)==0;
eom4 = mframe_3(3)==0;
EOMS = [eom1; eom2; eom3; eom4];

syms al be ga de 
syms al_d be_d ga_d de_d
syms al_dd be_dd ga_dd de_dd

EOMS(1) = subs(EOMS(1), [alpha_, beta_, gamma_, delta_,  diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

EOMS(2) = subs(EOMS(2), [alpha_, beta_, gamma_, delta_, diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

EOMS(3) = subs(EOMS(3), [alpha_, beta_, gamma_, delta_, diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

EOMS(4) = subs(EOMS(4), [alpha_, beta_, gamma_, delta_, diff(alpha_,t), diff(beta_,t), diff(gamma_, t), diff(delta_,t), diff(alpha_,t, t), diff(beta_,t, t), diff(gamma_, t, t), diff(delta_,t, t) ], ...
    [al, be, ga, de, al_d, be_d, ga_d, de_d, al_dd, be_dd, ga_dd, de_dd]);

vars = [al_dd, be_dd, ga_dd, de_dd];

[A,b] = equationsToMatrix(EOMS, vars);
X = A\b;