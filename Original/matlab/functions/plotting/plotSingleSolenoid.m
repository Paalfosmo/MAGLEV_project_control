function H = plotSingleSolenoid(x,y,z,r,l,c)
    [X,Y,Z] = cyl(r,100);
    Z = (Z-0.5)*l;
    X = X + x;
    Y = Y + y;
    Z = Z + z;

    H = gobjects(0);
    H(end+1) = patch( ...
          'XData', X(1,:), ...
          'YData', Y(1,:), ...
          'ZData', Z(1,:), ...
          'EdgeColor', 'k',...
          'LineWidth', 1.5,...
          'FaceColor', c, ...
          'FaceAlpha', 1);
    
    H(end+1) = patch( ...
          'XData', X(2,:), ...
          'YData', Y(2,:), ...
          'ZData', Z(2,:), ...
          'EdgeColor', 'k',...
          'LineWidth', 1.5,...
          'FaceColor', c, ...
          'FaceAlpha', 1);
    
     H(end+1) = surf( ...
          'XData', X, ...
          'YData', Y, ...
          'ZData', Z, ...
          'EdgeColor', 'none', ...
          'LineWidth', 1,      ...
          'FaceColor', c, ...
          'FaceAlpha', 1);
end
