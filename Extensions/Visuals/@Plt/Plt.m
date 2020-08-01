classdef Plt
    properties (Constant, Access = private)
        defInc = 50;
    end
    
    methods (Static)
        sdf
        figfull
    end
    
    methods (Static)
        function position = datatip_select
            dcm_obj = datacursormode(gcf);
            set(dcm_obj,'DisplayStyle','datatip', 'SnapToDataVertex','off','Enable','on')
            
            cursor = []; tries = 0;
            while ~isfield(cursor, "Position") && tries < 10
                pause
                cursor = getCursorInfo(dcm_obj);
                tries = tries + 1;
            end
            position = cursor.Position;
            clear cursor
        end
    end
    
    
    methods (Static)
        function closeIfopen(hndl)
            try close(hndl); end %#ok<TRYNC>
        end
        
        function hndl = vert(val, varargin)
            hndl = plot([val val], ylim, varargin{:});
        end
        
        function hndl = horz(val, varargin)
            hndl = plot(xlim, [val val], varargin{:});
        end
        
        function hndl = circle(centerXY, radius, inc, varargin)
            if nargin < 3 || isempty(inc)
                inc = Plt.defInc;
            end
            theta = 0:pi/inc:2*pi;
            x = radius * cos(theta) + centerXY(1);
            y = radius * sin(theta) + centerXY(2);
            hndl = plot(x,y, varargin{:});
        end
        
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
        
        function holdtf(requestedStatus)
            if requestedStatus
                hold on
            else
                hold off
            end
        end
        
        function pausePrompt
            dispTxt = "Press Any Key...";
            dispPrompt = annotation('textbox', [0.15 0.9 0 0], 'String', dispTxt, 'FitBoxToText','on', 'EdgeColor', 'none');
            Plt.sdf()
            pause;
            delete(dispPrompt);
        end
    end
end