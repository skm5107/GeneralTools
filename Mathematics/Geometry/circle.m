function circ = circle(x,y,r)
    onhold = ishold();
    hold on
    
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    circ = plot(xunit, yunit);
    
    if ~onhold
        hold off
    end
end