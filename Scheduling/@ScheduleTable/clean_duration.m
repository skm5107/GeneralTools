function self = clean_duration(self)
    tmp = self.tbl.dur_bus;
    for itime = 1:size(self.dur2day,1)
        tmp = strrep(tmp, self.dur2day(itime, 1), "*"+self.dur2day(itime, 2));
    end
    tmp = cellfun(@evaldur, tmp);
    
    self.tbl.dur_bus = days(tmp);
end

function dur = evaldur(strDur)
    if ~isempty(strDur)
        try
            dur = eval(strDur);
        catch
            dur = NaN;
        end
    else
        dur = NaN;
    end
end