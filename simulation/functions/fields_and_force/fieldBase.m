function [B_m, B_s] = fieldBase(x,y,z,params)
    % Compute the fild acting on a single point in cartesian coordinates
    % from all of the permanent magnets and solenoids in the system (equations 5 and 6)

    % Initialize field array
    B = zeros(3, length(x));   %8 columns for each calculation
    B_m = zeros(3,length(x)*4);
    B_s = zeros(3,length(x)*4);
    % Field from permanent magnets
    for i = 1:length(params.permanent.r)
        [phiLocal,rhoLocal,zLocal] = c2p(x-params.permanent.x(i),y-params.permanent.y(i),z-params.permanent.z(i));
        BpolLocal = field(phiLocal,rhoLocal,zLocal, ...
            params.permanent.r(i),params.permanent.l(i), ...
            params.physical.mu0, ...
            1);

        [bx,by,bz] = p2c(BpolLocal(1,:),BpolLocal(2,:),BpolLocal(3,:));

        %B = B + [bx;by;bz];
        B_m(:,1+(i-1)*length(x):i*length(x)) = [bx;by;bz];
    end

    % Field from solenoids
    for i = 1:length(params.solenoids.r)
        [phiLocal,rhoLocal,zLocal] = c2p(x-params.solenoids.x(i),y-params.solenoids.y(i),z-params.solenoids.z(i));
        
        BpolLocal = field(phiLocal,rhoLocal,zLocal,...
            params.solenoids.r(i),params.solenoids.l(i), ...
            params.physical.mu0, ...
            params.solenoids.nw);

        [bx,by,bz] = p2c(BpolLocal(1,:),BpolLocal(2,:),BpolLocal(3,:));

        %B = B + [bx;by;bz];
        B_s(:,1+(i-1)*length(x):i*length(x)) = [bx;by;bz];
    end
end