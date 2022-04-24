function [x_r, y_r, z_r] = rotateGyro(x, y, z, R)
    % Rotate 3D surface
    % https://au.mathworks.com/matlabcentral/answers/285009-rotating-a-3d-meshgrid-with-rotation-matrix

    xyz_r = [x(:),y(:),z(:)]*R.';
  
    x_r=reshape(xyz_r(:,1),size(x));
    y_r=reshape(xyz_r(:,2),size(y));
    z_r=reshape(xyz_r(:,3),size(z));
end