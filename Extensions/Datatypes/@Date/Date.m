classdef Date
    properties (Constant, Access = private)
        days2mth = 30;
        labels = ["years", "months", "days", "hours", "minutes", "seconds"];
        days = table((1:7)', ["Sun"; "Mon"; "Tue"; "Wed"; "Thu"; "Fri"; "Sat"], 'VariableNames', {'dayNum', 'dayName'});
        today = "-1";
    end
    
    methods (Static)
        dats = read(strs, varargin)
    end
    
    methods (Static)
        nearest = nearest(orig, weekday, dirFlag)
    end
    
    methods (Static)       
        function finish = findFinish(startApprox, startDay, dur)
            start = Date.nearest(startApprox, startDay, 1);
            finish = start + dur;
        end
        
        function dur = duration(datestr)
             dates = Date.read(datestr);
             dur = max(dates) - min(dates);
        end
        
        dur = str2dur(str)
        
        function dur = vect2dur(timevect)
            timecell = num2cell(timevect);
            [yr, mth, d, hr, min, sec] = deal(timecell{:});
            dur = years(yr) + days(d + mth * Date.days2mth) + hours(hr) + minutes(min) + seconds(sec);
        end
        
        function dates = distribute(start_date, total, qty)
            start_date = Date.read(start_date);
            interval = total/(qty+1);
            add_days = (1:qty) * interval;
            dates = start_date + add_days;
        end
        
        function str = dispdur(timevect, lowestVal)
            lowestLoop = find(ismember(Date.labels, lowestVal), 1, 'last');
            str = string.empty;
            ielem = 1;
            for ival = 1:lowestLoop
                if timevect(ival) ~= 0
                    str(ielem) = timevect(ival) + " " + Date.labels(ival);
                    ielem = ielem + 1;
                end
            end
        end
    end
end