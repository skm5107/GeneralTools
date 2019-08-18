classdef PeakFitInfo
    properties
        slopeThres;
        ampThres;
        smoothWidth;
        peakGroup;
        smoothType;
    end
    
    methods
        function self = PeakFitInfo(slopeThres, ampThres, smoothWidth, peakGroup, smoothType)
            if nargin > 0
                self.slopeThres = slopeThres;
                self.ampThres = ampThres;
                self.smoothWidth = smoothWidth;
                self.peakGroup = peakGroup;
                self.smoothType = smoothType;
            end
        end
    end
    
    enumeration
        PCAMS (11, 0.1, 1, 9, 2)
    end
end