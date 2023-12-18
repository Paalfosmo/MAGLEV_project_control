function B = field(phi,rho,z,R,l,I,mu0,N)
    % This function compute the field produced by a single solenoid wire on
    % a single point (equation 2a and 2b from the model description).

    %% rho ~= 0 (2a)
    k2 = 4*R*rho./((R+rho).^2+z.^2);
    c = mu0*N*I./(4*pi*sqrt(R.*rho));

    [K,E] = ellipke(k2);

    Brho = -(z./rho).*c.*sqrt(k2).*(K-(rho.^2+R^2+z.^2)./((rho-R).^2+z.^2).*E);
    Bz   =            c.*sqrt(k2).*(K-(rho.^2-R^2+z.^2)./((rho-R).^2+z.^2).*E);
 
    B = [
        phi;
        Brho;
        Bz;
    ];

    %% rho = 0 (2b)
    id = 1:length(rho);
    id(rho ~=0) = [];

    B(1,id) = 0;
    B(2,id) = 0;
    B(3,id) = mu0*R^2*N*I./(2*(R^2+z(id).^2).^(3/2));
end
