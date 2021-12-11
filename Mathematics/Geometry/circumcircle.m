function [diam, rec, circ, ax] = circumcircle(wid, hgt, plot_tf)
    diam = sqrt(wid^2 + hgt^2);
    if plot_tf
        ax = axes;
        hold on
        axis equal
        rec = rectangle(ax, 'Position', [-0.5*wid, -0.5*hgt, wid, hgt]);
        circ = circle(0, 0, diam/2);
    end
end