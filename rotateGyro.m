%% Funciton to apply rotation to coordinate of points.
function [x_r, y_r, z_r] = rotateGyro(x, y, z, R) 
    % Recieve points x,y,z and rotate them a certain amount in the
    % intertial frame.
    % Rotate 3D surface
    % https://au.mathworks.com/matlabcentral/answers/285009-rotating-a-3d-meshgrid-with-rotation-matrix

    xyz_r = [x(:),y(:),z(:)]*R; % no longer transpose R.
    %xyz_r = R*[x(:); y(:); z(:)];
    x_r=reshape(xyz_r(:,1),size(x));
    y_r=reshape(xyz_r(:,2),size(y));
    z_r=reshape(xyz_r(:,3),size(z));
end
