function self = parseDetails(self)
    typeExp = ChangeDetail.const.typeExp;
    for idetail = 1:length(self.details)
        type = regexp(self.details(idetail), typeExp, 'match');
    
    %     for jtype = ChangeDetail.types
    %         jexp = sprintf(ChangeDetail.detExp, jtype);
    %         [match, endInd] = regexp(self.remainder, jexp, 'match', 'end');
    %         if ~isempty(endInd)
    %             self.old.(jtype) = match;
    %             break
    %         end
    %     end
    %     self = self.getRemainder(endInd, ChangeDetail.detRem);
    %     self.remainder
    %     new = getNew(self)
    % end
    %
    % function new = getNew(self)
    %     if
    % end
end