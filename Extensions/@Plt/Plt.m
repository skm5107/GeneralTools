classdef Plt
    %Static methods for plotting
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
        
        function vert(val, varargin)
            plot([val val], ylim, varargin{:})
        end
        
        function horz(val, varargin)
            plot(xlim, [val val], varargin{:})
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