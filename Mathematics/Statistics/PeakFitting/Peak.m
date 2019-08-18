classdef Peak
    % Information about a spectral peak
    properties
        locX
        ampY
        areaXY
        fwhm_chan
    end
    
    methods
        function self = Peak(raw)
            self.locX = raw(:,2);
            self.ampY = raw(:,3);
            self.areaXY = raw(:,5);
            self.fwhm_chan = raw(:,4); 
        end
    end    
end