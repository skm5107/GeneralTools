function self = getDetails(self)
    for jdet = self.log.Details'
        try
            jparsed = ChangeDetail(jdet).run;
        catch
            error("ChangeDetail:unknown", "error in Detail %s", jdet{1});
        end
    end
    jparsed
end