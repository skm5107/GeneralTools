function self = mergeVars(self, uName, iraws)
    if sum(iraws) == 1
        return
    else
        delPrefix = uName + NestTable.nestDiv;
        subNames = Str.eraseStart(self.rawVars(iraws), delPrefix);

        self.out = mergevars(self.out, iraws, 'NewVariableName', uName, 'MergeAsTable', true);
        newInd = find(iraws, 1, 'first');

        subTable = self.out{:, newInd};
        subTable.Properties.VariableNames = subNames;
        superTable = table(subTable);
        superTable.Properties.VariableNames = uName;
        self.out = [self.out(:, 1:newInd-1), superTable, self.out(:, newInd+1:end)];
    end
end