function [ xs, ys ] = smoothed_line( x, y, pts )
%SMOOTHED_LINE Returns a smoothed line by interpolating pts points between 
% samples.

    if nargin < 3
        pts = 50;
    end

    n = length(x);
    xs = linspace(x(1), x(end), n * pts);
    ys = spline(x, y, xs);

end

