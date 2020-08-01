function sub = makeSub(orig, wantVars)
    wantInds = Tbl.isVar(orig, wantVars);
    sub = orig(:, wantInds);
    sub.Properties.Description = orig.Properties.Description;
    sub = movevars(sub, cellstr(wantVars), 'Before', 1);
end