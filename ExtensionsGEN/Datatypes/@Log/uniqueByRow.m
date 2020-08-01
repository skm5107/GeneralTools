function uniqued = uniqueByRow(input)
    uniqued = cell(size(input, 1), 1);
    for irow = 1:size(input,1)
        crow = input(irow,:);
        crow = Num.keepFirstNan(crow);
        uniqued{irow, 1} = unique(crow);
    end
end