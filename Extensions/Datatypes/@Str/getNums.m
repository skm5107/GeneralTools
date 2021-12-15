function nums = getNums(str)
    strNums = regexp(string(str), '[\d]+.*[\d]+','match');
    nums = cellfun(@str2double, strNums, 'UniformOutput', false);
    
    if isempty(nums)
        nums = NaN;
    end
end
