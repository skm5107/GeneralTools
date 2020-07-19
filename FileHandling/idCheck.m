function corrected = idCheck(idList)
    corrected = cellfun(@(iid) Str.eraseAny(iid, [" ", "-"]), num2cell(idList));
    
    [~,indUni,] = unique(idList, 'stable');
    allInds = 1:length(idList);
    indRepeat = setxor(allInds, indUni);
    
    msg = sprintf("%d IDs are repeated: (#%d) %s", length(indRepeat), indRepeat, idList(indRepeat));
    Warn.warnIf(~isempty(indRepeat), "id:unique", msg);
end