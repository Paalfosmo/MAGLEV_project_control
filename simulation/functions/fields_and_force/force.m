function [F_m,F_s,tau_m,tau_s] = force(x,params)
    % Computes the force and torque acting on the levitating magnet
    % (equation 9)
%     I_m = [params.permanent.J/params.physical.mu0*params.permanent.l(1);
%         params.permanent.J/params.physical.mu0*params.permanent.l(2);
%         params.permanent.J/params.physical.mu0*params.permanent.l(3);
%         params.permanent.J/params.physical.mu0*params.permanent.l(4);
%         ];
%     I_s = [u(1);
%            u(2);
%            u(3);
%            u(4);
%            ];
    R2 = params.magnet.r;
    l2 = params.magnet.l;
    K  = -params.magnet.J/params.physical.mu0;
  
    [PHI,Z] = meshgrid(linspace(0,2*pi,params.magnet.n),0);
    
    [px,py,pz] = pol2cart(PHI(:)',R2+0*PHI(:)',Z(:)');
    
    R = rot(x(4),x(5),x(6));
    p = R*[px;py;pz] + x(1:3);
    
    [B_m, B_s] = fieldBase(p(1,:),p(2,:),p(3,:),params);
    tangent = R*[
            cos(PHI(:)'+pi/2);
            sin(PHI(:)'+pi/2);
            0*PHI(:)'
        ];  
    %F_tot = zeros(3,400);
    F_m3 = zeros(3,4);
    F_s3 = zeros(3,4);
    K_cross = K*l2*tangent;
    for i = 1:(length(params.permanent.r))
     F_tot = cross(K_cross,B_m(:,1+(i-1)*50:i*50));
     fx1 = R2*trapz(PHI,F_tot(1,:));
     fy1 = R2*trapz(PHI,F_tot(2,:));
     fz1 = R2*trapz(PHI,F_tot(3,:));
     F_m3(:,i) = [fx1;fy1;fz1];
    end
    for i = 1:(length(params.solenoids.r))
     F_tot = cross(K_cross,B_s(:,1+(i-1)*50:i*50));
     fx1 = R2*trapz(PHI,F_tot(1,:));
     fy1 = R2*trapz(PHI,F_tot(2,:));
     fz1 = R2*trapz(PHI,F_tot(3,:));
     F_s3(:,i) = [fx1;fy1;fz1];
    end
 
%     F = cross(K*l2*tangent,b);
    
%     fx = R2*trapz(PHI,F(1,:));
%     fy = R2*trapz(PHI,F(2,:));
%     fz = R2*trapz(PHI,F(3,:));

    %F = [fx;fy;fz];
    F_m = F_m3;        %No I for simulink
    F_s = F_s3;

    nvec = R*[zeros(2,params.magnet.n); ones(1,params.magnet.n)];
    J_vec = K*l2*nvec;
    T_m3 = zeros(3,4);
    T_s3 = zeros(3,4);
    for i = 1:(length(params.permanent.r))
     T_tot = cross(J_vec,B_m(:,1+(i-1)*50:i*50));
     tx1 = trapz(PHI,R2*T_tot(1,:));
     ty1 = trapz(PHI,R2*T_tot(2,:));
     tz1 = trapz(PHI,R2*T_tot(3,:));
     T_m3(:,i) = [tx1;ty1;tz1];
    end
    for i = 1:(length(params.solenoids.r))
     T_tot = cross(J_vec,B_s(:,1+(i-1)*50:i*50));
     tx1 = trapz(PHI,R2*T_tot(1,:));
     ty1 = trapz(PHI,R2*T_tot(2,:));
     tz1 = trapz(PHI,R2*T_tot(3,:));
     T_s3(:,i) = [tx1;ty1;tz1];
    end
%     T = cross(K*l2*nvec,b);
%     
%     tx = trapz(PHI,R2*T(1,:));
%     ty = trapz(PHI,R2*T(2,:));
%     tz = trapz(PHI,R2*T(3,:));
    tau_m=T_m3;            %No I for simulink
    tau_s=T_s3;
    %tau = [tx;ty;tz];
end
