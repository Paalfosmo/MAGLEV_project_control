function H = plotMagnet(eta,params)
    % Colors
    gray = [0.5,0.5,0.5];
    
    % Points along circle
    [x,y,z] = cyl(params.magnet.r, 100);
    x = x(1,:); y = y(1,:); z = z(1,:);
    
    % Rotation matrix
    R = rot(eta(4),eta(5),eta(6));

    % Coordinates top and bottom
    Ptop   = R*[x;y;z+params.magnet.l/2] + eta(1:3);
    Pbot   = R*[x;y;z-params.magnet.l/2] + eta(1:3);

    X = [Ptop(1,:); Pbot(1,:)];
    Y = [Ptop(2,:); Pbot(2,:)];
    Z = [Ptop(3,:); Pbot(3,:)];

    H = gobjects(0);
    H(end+1) = patch( ...
          'XData', X(1,:), ...
          'YData', Y(1,:), ...
          'ZData', Z(1,:), ...
          'EdgeColor', 'k',...
          'LineWidth', 1.5,...
          'FaceColor', gray, ...
          'FaceAlpha', 1);
    
    H(end+1) = patch( ...
          'XData', X(2,:), ...
          'YData', Y(2,:), ...
          'ZData', Z(2,:), ...
          'EdgeColor', 'k',...
          'LineWidth', 1.5,...
          'FaceColor', gray, ...
          'FaceAlpha', 1);
    
     H(end+1) = surf( ...
          'XData', X, ...
          'YData', Y, ...
          'ZData', Z, ...
          'EdgeColor', 'none', ...
          'LineWidth', 1,      ...
          'FaceColor', gray, ...
          'FaceAlpha', 1);
end