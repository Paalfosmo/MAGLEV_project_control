function [x,y,z] = p2c(phi,rho,z)
    %[x,y,z] = pol2cart(phi,rho,z);
    
    x = rho.*cos(phi);
    y = rho.*sin(phi);
end