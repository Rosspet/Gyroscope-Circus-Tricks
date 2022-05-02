function Xdot = getXdot(t, X)

    % Extract values for iteration
    al = X(1);
    be = X(2);
    ga = X(3);
    de = X(4);
    al_d = X(5);
    be_d = X(6);
    ga_d = X(7);
    de_d = X(8);
    
    %Solve for second derivatives - equations from findEOMs
    al_dd = (2420581757352167*al_d*be_d*sin(be))/147573952589676412928;
    be_dd = (1450899*cos(ga)*sin(be))/50000000 + (2420581757352167*be_d*de_d*sin(ga))/147573952589676412928 + (891153834074247*be_d*ga_d*sin(ga))/18446744073709551616 + (32580100932079679845087*al_d^2*cos(be)*cos(ga)*sin(be))/288230376151711744000000000 - (39542240260784734532587*al_d*be_d*cos(be)*sin(ga))/144115188075855872000000000 - (2420581757352167*al_d*de_d*cos(ga)*sin(be))/147573952589676412928 - (891153834074247*al_d*ga_d*cos(ga)*sin(be))/18446744073709551616;
    ga_dd = (2420581757352167*be_d*de_d*cos(ga))/147573952589676412928 - (1450899*sin(be)*sin(ga))/50000000 + (4166419603654503*be_d*ga_d*cos(ga))/73786976294838206464 - (3925587746549629170089*al_d^2*cos(be)*sin(be)*sin(ga))/36028797018963968000000000 - (39542240260784734532587*al_d*be_d*cos(be)*cos(ga))/144115188075855872000000000 + (2420581757352167*al_d*de_d*sin(be)*sin(ga))/147573952589676412928 + (4166419603654503*al_d*ga_d*sin(be)*sin(ga))/73786976294838206464;
    de_dd = (601804267357515*be_d^2*cos(ga)*sin(ga))/147573952589676412928 + (7731034939951491*al_d*be_d*sin(be))/147573952589676412928 - (601804267357515*al_d*be_d*cos(ga)^2*sin(be))/147573952589676412928 + (601804267357515*al_d*be_d*sin(be)*sin(ga)^2)/147573952589676412928 - (601804267357515*al_d^2*cos(ga)*sin(be)^2*sin(ga))/147573952589676412928;

        %new ones after doing A\b
%     al_dd = 4.4337*cos(ga)*sin(ga) + (0.1017*be_d*de_d)/sin(be) + (0.2994*be_d*ga_d)/sin(be) - (1.7006*al_d*be_d*cos(be))/sin(be) - (0.0025*be_d*de_d*cos(ga)^2)/sin(be) + (0.0419*be_d*ga_d*cos(ga)^2)/sin(be) + 0.0419*al_d^2*cos(be)*cos(ga)*sin(ga) - 0.0025*al_d*de_d*cos(ga)*sin(ga) + 0.0419*al_d*ga_d*cos(ga)*sin(ga) + (0.0419*al_d*be_d*cos(be)*cos(ga)^2)/sin(be);
%     be_dd = 175.4174*sin(be) + 0.3293*al_d^2*sin(2*be) + 4.4337*cos(ga)^2*sin(be) + 0.0013*be_d*de_d*sin(2*ga) - 0.0210*be_d*ga_d*sin(2*ga) - 0.0992*al_d*de_d*sin(be) - 0.3413*al_d*ga_d*sin(be) - 0.0025*al_d*de_d*cos(ga)^2*sin(be) + 0.0419*al_d*ga_d*cos(ga)^2*sin(be) + 0.0419*al_d^2*cos(be)*cos(ga)^2*sin(be) - 0.0419*al_d*be_d*cos(be)*cos(ga)*sin(ga);
%     ga_dd = (1.6985e-61*(6.5547e+60*al_d*be_d + 3.4575e+60*al_d*be_d*cos(be)^2 - 1.3344e+60*al_d*be_d*cos(ga)^2 - 5.9853e+59*be_d*de_d*cos(be) - 1.7628e+60*be_d*ga_d*cos(be) + 1.4755e+58*be_d*de_d*cos(be)*cos(ga)^2 - 2.4682e+59*be_d*ga_d*cos(be)*cos(ga)^2 + 1.0876e+60*al_d*be_d*cos(be)^2*cos(ga)^2 - 6.6720e+59*al_d^2*cos(ga)*sin(be)*sin(ga) + 6.6720e+59*be_d^2*cos(ga)*sin(be)*sin(ga) - 2.6103e+61*cos(be)*cos(ga)*sin(be)*sin(ga) + 4.2038e+59*al_d^2*cos(be)^2*cos(ga)*sin(be)*sin(ga) + 1.4755e+58*al_d*de_d*cos(be)*cos(ga)*sin(be)*sin(ga) - 2.4682e+59*al_d*ga_d*cos(be)*cos(ga)*sin(be)*sin(ga)))/sin(be);
%     de_dd = 0.1133*al_d*be_d*cos(ga)^2*sin(be) - 0.1133*be_d^2*cos(ga)*sin(ga) - 0.1133*al_d*be_d*sin(be)*sin(ga)^2 + 0.1133*al_d^2*cos(ga)*sin(be)^2*sin(ga);
%     
    
    
    
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