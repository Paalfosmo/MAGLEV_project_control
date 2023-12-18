function [F,tau] = force(x,u,params)
    % Computes the force and torque acting on the levitating magnet
    % (equation 9)

    R2 = params.magnet.r;
    l2 = params.magnet.l;
    K  = -params.magnet.J/params.physical.mu0;
  
    [PHI,Z] = meshgrid(linspace(0,2*pi,params.magnet.n),0);
    
    [px,py,pz] = pol2cart(PHI(:)',R2+0*PHI(:)',Z(:)');
    
    R = rot(x(4),x(5),x(6));
    p = R*[px;py;pz] + x(1:3);
    
    b = fieldBase(p(1,:),p(2,:),p(3,:),u,params);
 
    tangent = R*[
            cos(PHI(:)'+pi/2);
            sin(PHI(:)'+pi/2);
            0*PHI(:)'
        ];
    F = cross(K*l2*tangent,b);
    
    fx = R2*trapz(PHI,F(1,:));
    fy = R2*trapz(PHI,F(2,:));
    fz = R2*trapz(PHI,F(3,:));

    F = [fx;fy;fz];

    nvec = R*[zeros(2,params.magnet.n); ones(1,params.magnet.n)];

    T = cross(K*l2*nvec,b);
    
    tx = trapz(PHI,R2*T(1,:));
    ty = trapz(PHI,R2*T(2,:));
    tz = trapz(PHI,R2*T(3,:));
    
    tau = [tx;ty;tz];
end
