classdef StatsNet
    % Net counting statistics for spectra a particular ROI
    
    properties (GetAccess = protected)
        spectra double
        Roi RoiInfo
        BkgRunner AbstBkg
    end
    
    properties (Access = private)
        gross
        gross_sigma
        
        bkg
        bkg_sigma
    end
    properties (SetAccess = private)
        net
        sigma
    end
    
    methods
        function self = StatsNet(BkgRunner)
            if nargin > 0
                self.BkgRunner = BkgRunner;
            end
        end
    
        function [net, sigma, self] = run(self, spectra, Roi)
            [self.gross, self.gross_sigma] = self.gross_calc(spectra, Roi);
            [self.bkg, self.bkg_sigma] = self.BkgRunner.run(spectra, Roi);
            [net, sigma] = self.net_calc();
            
            self.spectra = spectra;
            self.Roi = Roi;
            
            self.net = net;
            self.sigma = sigma; %%TODO: shorthand
        end
    end
    
    methods (Access = private)
        function [gross, sigma] = gross_calc(~, spectra, Roi)
            gross = sum(spectra(:, Roi.inds), 2);
            sigma = gross .^ 0.5;
        end
            
        function [net, sigma] = net_calc(self)
            net = max(0, self.gross - self.bkg);
            sigma = (self.gross_sigma .^ 2 + self.bkg_sigma .^ 2) .^ 0.5;
        end
    end
end