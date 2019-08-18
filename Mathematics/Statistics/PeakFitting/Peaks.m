classdef Peaks
    % Information from peak fitting a spectrum
    properties (SetAccess = immutable)
        DataX Data1D
        DataY Data1D
        FitterInfo
    end
    
    properties (SetAccess = private)
        PeakArray
        TopPeak
    end
    
    properties (Access = private)
        raw
    end
    
    %% Constructor
    methods
        function self = Peaks(DataX, DataY, fitterEnum)
            if nargin > 0
                self.DataX = DataX;
            end
            
            if nargin > 1
                self.DataY = DataY;
            end
            
            if nargin > 2
                self.FitterInfo = PeakFitInfo(fitterEnum);
            end
        end
    end
    
    %% Getters
    methods
        function PeakArray = get.PeakArray(self)
            for ipeak = 1:size(self.raw,1)
                self.PeakArray = [self.PeakArray, Peak(self.raw(ipeak,:))];
            end
            PeakArray = self.PeakArray;
        end
        
        function TopPeak = get.TopPeak(self)
            [~, top_ind] = max([self.PeakArray.ampY]);
            TopPeak = self.PeakArray(top_ind);
        end
    end
    
    %% Call Peak Fitting
    methods
        function raw = get.raw(self)
            argOrder = {self.FitterInfo.slopeThres, self.FitterInfo.ampThres, ...
            self.FitterInfo.smoothWidth, self.FitterInfo.peakGroup, self.FitterInfo.smoothType};
            try
                raw = fitGauss(self, argOrder);
                Prnt.iprintf("Install curvefit toolbox to get correct FWHM.", 10)
            catch
                raw = fitG(self, argOrder);
            end
        end
    end
    
    methods
        function raw = fitGauss(self, argOrder)
            raw = findpeaks_gauss(self.ThisDataXY.DataX.elems, self.ThisDataXY.DataY.elems, argOrder{:});
        end
        
        function raw = fitG(self, argOrder)
            raw = findpeaksG(self.ThisDataXY.DataX.elems, self.ThisDataXY.DataY.elems, argOrder{:});
                
        end
    end
end