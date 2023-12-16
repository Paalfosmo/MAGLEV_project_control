%{
### Parameters for the maglev system ####
The geometrical parameters are based on the actual maglev system. The
physical parameters are taken from sources online, and could be incorrect
w.r.t., the real system.
%}

%% Parameters
% Solenoids
params.solenoids.x  = 0.03*[1,0,-1,0];
params.solenoids.y  = 0.03*[0,1,0,-1];
params.solenoids.z  = [0, 0, 0, 0];
params.solenoids.r  = 0.01*ones(1,4);                                      % Radius [m]
params.solenoids.l  = 0.005*ones(1,4);                                     % Thickness [m]
params.solenoids.nw = 100;                                                 % Number of windings

% Permanent magnets
params.permanent.x  = 0.010*[1,-1,1,-1];
params.permanent.y  = 0.010*[1,1,-1,-1];
params.permanent.z  = zeros(1,4);
params.permanent.r  = 0.01*ones(1,4)*0.6;                                  % Radius [m] (final value include radius correction for thin wire)
params.permanent.l  = 0.005*ones(1,4);                                     % Thickness [m]
params.permanent.J  = 1.3;                                                 % Magnet strength [T]

% Levitating magnet
params.magnet.r     = 0.025;                                               % Radius [m]
params.magnet.l     = 0.005;                                               % Thickness [m]
params.magnet.J     = 1.3;                                                 % Magnet strength [T]
params.magnet.m     = 0.117;                                               % Mass [kg]
params.magnet.I     = params.magnet.m*params.magnet.r^2*[0.25;0.25;0.5];   % Moment of inertia [kg*m^2]
params.magnet.n     = 50;                                                 % Number of discretizations

% Sensors
params.sensors.x  = 0.015*[0, 1,-1,1,-1];
params.sensors.y  = 0.015*[0, 1,1,-1,-1];
params.sensors.z  = 0.005*ones(1,5);

% Physical constants
params.physical.g   = 9.81;                                                % Gravitational acceleration [m/s^2]
params.physical.mu0 = 4*pi*1e-7;                                           % Permeability of free space (air) [N/A^2]
