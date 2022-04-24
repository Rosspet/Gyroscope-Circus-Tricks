function animateGyro(t, X, dt, fig, REC, vtitle)
    %% Create Gyro Shapes
    
    % Load measurements
    measurements
    
    % Frame
    H = h_rod;
    R0 = R_maj_V_tor;
    r = R_min_V_tor;
    
    % Rotor
    h = 2*R_min_rotor;
    Ri = R_maj_rotor;
    
    offset = H/2+R_sph;
    
    % Generate frame toruses
    % https://stackoverflow.com/questions/10655393/visualizing-a-toroidal-surface-in-matlab
    theta = -pi:pi/64:pi;
    phi = 0:pi/64:2*pi;
    
    [theta, phi] = meshgrid(phi, theta);
    
    x_htor = (R0+r.*cos(phi)).*cos(theta);
    y_htor = (R0+r.*cos(phi)).*sin(theta);
    z_htor = r.*sin(phi)+offset;
    
    x_vtor = (R0+r.*cos(phi)).*sin(theta);
    y_vtor = r.*sin(phi);
    z_vtor = (R0+r.*cos(phi)).*cos(theta)+offset;
    
    % Generate frame rod 
    [x_rod, y_rod, z_rod] = cylinder(r, 100);
    z_rod = z_rod*H-H/2+offset;
    
    % Generate frame rod sphere caps
    [x_tsph, y_tsph, z_tsph] = sphere;
    
    x_tsph = R_sph.*x_tsph;
    y_tsph = R_sph.*y_tsph;
    z_tsph = R_sph.*z_tsph+H/2+offset;
    
    x_bsph = x_tsph;
    y_bsph = y_tsph;
    z_bsph = z_tsph-H;
    
    % Generate rotor outside 
    [x_rot, y_rot, z_rot] = cylinder(Ri, 100);
    z_rot = z_rot*h-h/2+offset;
    
    % Generate rotor top and bottom
    % https://au.mathworks.com/matlabcentral/answers/308311-how-to-surf-over-a-circular-domain
    theta = 0:pi/64:2*pi;
    Ri_m = 0:0.001:Ri;
    
    [theta, Ri_m] = meshgrid(theta, Ri_m);
    
    x_trot = Ri_m.*cos(theta);
    y_trot = Ri_m.*sin(theta);
    z_trot = h/2.*ones(size(x_trot))+offset;
    
    x_brot = x_trot;
    y_brot = y_trot;
    z_brot = -h/2.*ones(size(x_brot))+offset;
    
    %% SETUP VIDEO IF REQUIRED
    if REC
        GyroVid = VideoWriter(vtitle, 'MPEG-4');
        GyroVid.Quality = 95;
        GyroVid.FrameRate = 1/dt;
        open(GyroVid);
    end
    
    %% Animate Gyro
    hold on;
    grid on;
    
    for i = 1:length(t)
        % Stops plotting when figure is closed
        % https://au.mathworks.com/matlabcentral/answers/182605-how-to-stop-the-program-while-closing-the-figure-that-shows-an-animated-plot
        if ~ishghandle(fig)
            break;
        end

        cla % clear axis
    
        % Extract Angles
        al = X(1, i);
        be = X(2, i);
        ga = X(3, i);
        de = X(4, i);
    
        % Prepare Rotation Matrices
        R01 = [cos(al), -sin(al), 0; sin(al), cos(al), 0; 0, 0, 1];
        R12 = [1, 0, 0; 0, cos(be), -sin(be); 0, sin(be), cos(be)];
        R23 = [cos(ga), -sin(ga), 0; sin(ga), cos(ga), 0; 0, 0, 1];
        R34 = [cos(de), -sin(de), 0; sin(de), cos(de), 0; 0, 0, 1];
    
        R_frame = transpose(R23)*transpose(R12)*transpose(R01);
        R_rotor = transpose(R34)*R_frame;
    
        % Rotate Frame
        [x_htor_r, y_htor_r, z_htor_r] = rotateGyro(x_htor, y_htor, z_htor, R_frame);
        [x_vtor_r, y_vtor_r, z_vtor_r] = rotateGyro(x_vtor, y_vtor, z_vtor, R_frame);
        [x_rod_r, y_rod_r, z_rod_r] = rotateGyro(x_rod, y_rod, z_rod, R_frame);
        [x_tsph_r, y_tsph_r, z_tsph_r] = rotateGyro(x_tsph, y_tsph, z_tsph, R_frame);
        [x_bsph_r, y_bsph_r, z_bsph_r] = rotateGyro(x_bsph, y_bsph, z_bsph, R_frame);
    
        % Rotate Rotor
        [x_rot_r, y_rot_r, z_rot_r] = rotateGyro(x_rot, y_rot, z_rot, R_rotor);
        [x_trot_r, y_trot_r, z_trot_r] = rotateGyro(x_trot, y_trot, z_trot, R_rotor);
        [x_brot_r, y_brot_r, z_brot_r] = rotateGyro(x_brot, y_brot, z_brot, R_rotor);
    
        % Display Frame
        surf(x_htor_r, y_htor_r, z_htor_r, x_htor, 'EdgeColor','none','FaceColor','Interp', 'FaceLighting', 'gouraud');
        surf(x_vtor_r, y_vtor_r, z_vtor_r, x_vtor, 'EdgeColor','none', 'FaceColor','Interp', 'FaceLighting', 'gouraud');
        surf(x_rod_r, y_rod_r, z_rod_r, x_rod, 'EdgeColor','none','FaceColor','Interp', 'FaceLighting', 'gouraud');
        surf(x_tsph_r, y_tsph_r, z_tsph_r, x_tsph, 'EdgeColor','none','FaceColor','Interp', 'FaceLighting', 'gouraud');
        surf(x_bsph_r, y_bsph_r, z_bsph_r, x_bsph, 'EdgeColor','none','FaceColor','Interp', 'FaceLighting', 'gouraud');
    
        % Display Rotor
        surf(x_rot_r, y_rot_r, z_rot_r, x_rot, 'EdgeColor','none','FaceColor', 'Interp', 'FaceLighting', 'gouraud');
        surf(x_trot_r, y_trot_r, z_trot_r, x_trot, 'EdgeColor','none','FaceColor', 'Interp', 'FaceLighting', 'gouraud');
        surf(x_brot_r, y_brot_r, z_brot_r, x_brot, 'EdgeColor','none','FaceColor', 'Interp', 'FaceLighting', 'gouraud');
    
        % Display Settings
        light('Position',[1 1 2],'Style','local');   
        colormap("turbo");
        view(3); 
    
        % Figure Settings
        axis square;
        axis(offset*[-1 1 -1 1 0 2]);
    
        xlabel("X (m)");
        ylabel("Y (m)");
        zlabel("Z (m)");
        
        if REC
            writeVideo(GyroVid,getframe(fig));
        else
            pause(dt);
        end
    end

    if REC
        close(GyroVid);
    end
end