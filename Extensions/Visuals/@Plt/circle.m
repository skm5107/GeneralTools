function hndl = circle(centerXY, radius, inc, varargin)
    if nargin < 3 || isempty(inc)
        inc = Plt.defInc;
    end
    theta = 0:pi/inc:2*pi;
    x = radius * cos(theta) + centerXY(1);
    y = radius * sin(theta) + centerXY(2);
    hndl = plot(x,y, varargin{:});
end