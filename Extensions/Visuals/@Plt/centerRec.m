function hndls = centerRec(centerXY, fullX, fullY, varargin)
    top = centerXY(2) + fullY/2;
    bottom = centerXY(2) - fullY/2;
    right = centerXY(1) + fullX/2;
    left = centerXY(1) - fullX/2;
    
    hldStatus = ishold();
    hold on
    hndls.top = plot([left right], [top top], varargin{:});
    hndls.bottom = plot([left right], [bottom bottom], varargin{:});
    hndls.right = plot([right right], [top bottom], varargin{:});
    hndls.left = plot([left left], [top bottom], varargin{:});
    Plt.holdtf(hldStatus);
end