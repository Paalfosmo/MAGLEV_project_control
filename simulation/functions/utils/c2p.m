function [phi,rho,z] = c2p(x,y,z)
    %[phi,rho,z] = cart2pol(x,y,z);
    
    phi = atan2(y,x);
    rho = sqrt(x.^2 + y.^2);
end