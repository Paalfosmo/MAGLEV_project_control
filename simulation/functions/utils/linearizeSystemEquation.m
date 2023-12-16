function [M1,M2] = linearizeSystemEquation(f,x_lp,u_lp)
    M1 = zeros(length(f(x_lp,u_lp)),length(x_lp));
    M2 = zeros(length(f(x_lp,u_lp)),length(u_lp));
    
    n = length(x_lp);
    m = length(u_lp);
    
    delta = 1e-5;
    for k = 1:n
        M1(:,k) = (f(x_lp+delta*(k==1:n)',u_lp)-f(x_lp-delta*(k==1:n)',u_lp))/(2*delta);
    end
    M1 = round(M1,5);
    
    for k = 1:m
        M2(:,k) = (f(x_lp,u_lp+delta*(k==1:m)')-f(x_lp,u_lp-delta*(k==1:m)'))/(2*delta);
    end
    M2 = round(M2,5);
end