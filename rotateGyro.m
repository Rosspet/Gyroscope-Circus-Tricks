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


% Raquels function.
function [Xf,Yf,Zf]=rotation(Xi,Yi,Zi,R)

    I=size(Xi,1);
    J=size(Xi,2);

    Xf=zeros(I,J);
    Yf=zeros(I,J);
    Zf=zeros(I,J);

    for ii=1:I
        for jj=1:J
            vector=[Xi(ii,jj);Yi(ii,jj);Zi(ii,jj)];
            vector=R*vector;
                Xf(ii,jj)=vector(1);
                Yf(ii,jj)=vector(2);
                Zf(ii,jj)=vector(3);
        end
    end

end