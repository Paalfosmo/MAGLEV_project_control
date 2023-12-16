% This is all using the Thin Wire approximation (Model 2 from the paper)
% This file shows how to initialize the system, plot an illustration of the
% system, and run an LQR controller.
clear all
close all
%% Initialization (always necessary)
%{
Setup so that:
    dx = f(x,u)
    y  = h(x,u)
%}

% Load the parameters "params"
parameters;

% Set up the system equation
f = @(x,u) maglevSystemDynamics(x,u,params);

% Set up the measurement equation
h = @(x,u) maglevSystemMeasurements(x,u,params);

%% System illustration
% figure(1);
% clf; grid on; hold on; daspect([1,1,1]); view([45,15])
% plotBase(params);
% plotMagnet([0,0,0.04,zeros(1,9)]',params);
% 
% delta = 0.01;
% plot3([params.solenoids.x(1), params.solenoids.x(1)+delta], [params.solenoids.y(1), params.solenoids.y(1)+delta], [params.solenoids.z(1), params.solenoids.z(1)+delta], 'k', 'linewidth', 2)
% plot3([params.permanent.x(2), params.permanent.x(2)+delta], [params.permanent.y(2), params.permanent.y(2)+delta], [params.permanent.z(2), params.permanent.z(2)+delta], 'k', 'linewidth', 2)
% plot3([params.sensors.x(1), params.sensors.x(1)+delta], [params.sensors.y(1), params.sensors.y(1)+delta], [params.sensors.z(1), params.sensors.z(1)+2*delta], 'k', 'linewidth', 2)
% 
% text(params.solenoids.x(1)+delta,params.solenoids.y(1)+delta,params.solenoids.z(1)+delta, 'Solenoid','BackgroundColor','white','EdgeColor','k')
% text(params.permanent.x(2)+delta,params.permanent.y(2)+delta,params.permanent.z(2)+delta, 'Permanent magnet','BackgroundColor','white','EdgeColor','k')
% text(params.sensors.x(1)  +delta,params.sensors.y(1)  +delta,params.sensors.z(1)  +2*delta, 'Sensor','BackgroundColor','white','EdgeColor','k')

%% Example LQR
% Find equilibrium point (x = 0, y = 0, z = zEq)
index = @(A,i) A(i);
foo = @(z) index(f([0,0,z,zeros(1,9)]',zeros(4,1)),9);

z_sample_points = linspace(0,0.06,1000);
dz = zeros(size(z_sample_points));
for i = 1:length(z_sample_points)
    dz(i) = foo(z_sample_points(i));
end

[~,I] = min(abs(dz(1:end-1))+sign(abs(diff(dz))));
z_eq = z_sample_points(I);

% Linearization
x_lp = [0,0,0.047,zeros(1,9)]';
%u_lp = zeros(length(params.solenoids.r),1);

%[A,B] = linearizeSystemEquation(f,x_lp,u_lp);
%[C,D] = linearizeSystemEquation(h,x_lp,u_lp); % (Not used in this example)

% LQR design
% - Two of the states are uncontrollable, so we need to reduce the system
% matrices to compute the LQR gain
%Ared = A([1:5,7:11],[1:5,7:11]);
%Bred = B([1:5,7:11],:);

% Cost matrices
% Q = diag([1e6,1e6,1e6, 1e1,1e1, 1e2,1e2,1e3, 1e2,1e2]);
%Q = diag([1e3,1e3,1e3, 1e1,1e1, 1e2,1e2,1e3, 1e2,1e2]);
%R = 1e-0*eye(length(params.solenoids.r));

% Computing LQR estimate
%Kred = round(lqr(Ared,Bred,Q,R),3); % Rounding can sometimes be dangerous!
%K = [Kred(:,1:5), zeros(4,1), Kred(:,6:end), zeros(4,1)];

% Simulation setup
x0 = x_lp+[0.01,0,0.02, zeros(1,9)]'; % Start away from the equilibrium
%t_span = linspace(0,0.5,100);

% Simulation
%tic;
%[t,x] = ode45(@(t,x) f(x,-K*(x-x_lp)-u_lp), t_span, x0);

%u = zeros(length(t_span), length(u_lp));
%y = zeros(length(t_span), length(h(x_lp,u_lp)));
% for i = 1:length(t_span)
%     u(i,:) = -K*(x(i,:)'-x_lp)-u_lp;
%     y(i,:) = h(x(i,:)',u(i,:)');
% end
% simulation_time = toc;
% 
% fprintf('Simulation time is: % .3f seconds\n', simulation_time)
% 
% % Figure of results
% figure(2);
% clf;
% 
% subplot(3,1,1)
% grid on; hold on;
% plot(t_span, x(:,1:3), 'linewidth', 2)
% ylabel('States (x/y/z)')
% title('Simulation of original system')
% 
% subplot(3,1,2)
% grid on; hold on;
% plot(t_span, y, 'linewidth', 2)
% ylabel('Measurements')
% 
% subplot(3,1,3)
% grid on; hold on;
% plot(t_span, u, 'linewidth', 2)
% ylabel('Inputs')
% 
% xlabel('Time [s]')
