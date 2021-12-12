function self = parseDetails(self)
    parseExp = ChangeDetail.const.parseExp;
    typeInd = ChangeDetail.const.typeInd;
    oldInd = ChangeDetail.const.oldInd;
    newInd = ChangeDetail.const.newInd;
    colNames = ChangeDetail.const.colNames;
    types = ChangeDetail.const.types;
    for idetail = 1:length(self.details)
        splits = regexp(self.details(idetail), parseExp, 'tokens');
        splits = splits{1};
        jtype = splits{typeInd};
        jcol = colNames(types == jtype);
        if jcol ~= ""
            jold = splits{oldInd};
            jnew = splits{newInd};
            self.old.(jcol) = jold;
            self.new.(jcol) = jnew;
        end
    end
end