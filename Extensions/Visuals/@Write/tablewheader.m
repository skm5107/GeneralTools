function writee = tablewheader(tbl, path)
    varNames = tbl.Properties.VariableNames;
    
    varClasses = Tbl.cellfun(@class, tbl(1,:), false);
    varClasses = [varClasses{1,:}];
    
    varUnits = tbl.Properties.VariableUnits;
    varDescs = tbl.Properties.VariableDescriptions;
    
    tblDesc = tbl.Properties.Description;
    tblDesc = [tblDesc, repmat({''}, [1, size(varNames,2)-1])];
    
    head = [varNames; varClasses; varUnits; varDescs; tblDesc];
    head(head == "") = {'#'};
    writee = Tbl.emptyCols(size(head, 1), tbl.Properties.VariableNames, "string");
    
    writee{:,:} = head;
    writee = [writee; tbl];
    writetable(writee, path);
end