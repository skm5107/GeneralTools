function nan1 = keepFirstNan(allNans)
    nanInds = find(isnan(allNans));
    nan1 = allNans;
    nan1(nanInds(2:end)) = [];
end