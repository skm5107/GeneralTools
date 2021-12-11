classdef Time
    methods (Static)        
        function dur = secs(str)
            dur = seconds(str);
        end
        
        function dur = mins(str)
            dur = minutes(str);
        end
        
        function dur = hrs(str)
            dur = hours(str);
        end
        
        function dur = days(str)
            dur = days(str);
        end
        
        function dur = wks(str)
            dur = days(str)/7;
        end
        
        function dur = mths(str)
            dur = years(str)/12;
        end
        
        function dur = yrs(str)
            dur = years(str);
        end
    end
end