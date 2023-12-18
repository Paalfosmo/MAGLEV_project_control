function y = maglevSystemMeasurements(x,u,params)
    %{
    Computes the measurements for a magnetic levitation system.
    - x: current state
    - u: control input
    - params: system parameters
    %}

    % Initialize field array
    B = zeros(3, length(params.sensors.x));

    % Field from levitating magnet
    I = params.magnet.J/params.physical.mu0*params.magnet.l;

    [phiLocal,rhoLocal,zLocal] = c2p(params.sensors.x-x(1),params.sensors.y-x(2),params.sensors.z-x(3));
    BpolLocal = field(phiLocal,rhoLocal,zLocal, ...
        params.magnet.r,params.magnet.l, ...
        I, ...
        params.physical.mu0, ...
        1);

    [bx,by,bz] = p2c(BpolLocal(1,:),BpolLocal(2,:),BpolLocal(3,:));

    B = B + [bx;by;bz];

    % Field from permanent magnets
    for i = 1:length(params.permanent.r)
        I = params.permanent.J/params.physical.mu0*params.permanent.l(i);

        [phiLocal,rhoLocal,zLocal] = c2p(params.sensors.x-params.permanent.x(i),params.sensors.y-params.permanent.y(i),params.sensors.z-params.permanent.z(i));
        BpolLocal = field(phiLocal,rhoLocal,zLocal, ...
            params.permanent.r(i),params.permanent.l(i), ...
            I, ...
            params.physical.mu0, ...
            1);

        [bx,by,bz] = p2c(BpolLocal(1,:),BpolLocal(2,:),BpolLocal(3,:));

        B = B + [bx;by;bz];
    end

    % Field from solenoids
    for i = 1:length(params.solenoids.r)
        I = u(i);
        
        [phiLocal,rhoLocal,zLocal] = c2p(params.sensors.x-params.solenoids.x(i),params.sensors.y-params.solenoids.y(i),params.sensors.z-params.solenoids.z(i));
        
        BpolLocal = field(phiLocal,rhoLocal,zLocal,...
            params.solenoids.r(i),params.solenoids.l(i), ...
            I, ...
            params.physical.mu0, ...
            params.solenoids.nw);

        [bx,by,bz] = p2c(BpolLocal(1,:),BpolLocal(2,:),BpolLocal(3,:));

        B = B + [bx;by;bz];
    end
    
    y = B(:);
end
