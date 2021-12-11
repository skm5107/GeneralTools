classdef Plt
    properties (Constant, Access = private)
        defInc = 50;
    end
    
    methods (Static)
        sdf
        figfull
        pausePrompt
        
        hndl = circle(centerXY, radius, inc, varargin)
        hndls = centerRec(centerXY, fullX, fullY, varargin)        
        
        hndl = copyUIAxes(varargin)
        position = datatip_select
    end
    
    
    methods (Static)
        function closeIfopen(hndl)
            try close(hndl); end %#ok<TRYNC>
        end
        
        function holdtf(requestedStatus)
            if requestedStatus
                hold on
            else
                hold off
            end
        end
    end
end