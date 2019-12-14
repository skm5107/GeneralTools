function writee = tblupdate(newTbl, path)
    HeadInfo = HeaderImporter(path);
    rawHead = ImportedRaw(HeadInfo).run;
    rawHead = rawHead(2:end, :);
    
    writee = Tbl.emptyCols(size(rawHead, 1), newTbl.Properties.VariableNames, "string");
    writee{:,:} = rawHead;
    writee = [writee; newTbl];
    
    writetable(writee, path);
end
