function self = getDetails(self)
    parsed = ChangeDetail.empty(0, length(self.log.Details));
    erred = [];
    for idet = 1:length(self.log.Details)
        jdet = self.log.Details{idet};
        try
            parsed(idet) = ChangeDetail(jdet).run;
        catch
            self.erred = [erred, {idet, jdet}];
        end
    end
    self.deets = parsed;
end