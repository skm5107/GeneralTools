function [nums, cells] = getNums(str)
    nums = [];
    for ielem = 1:length(str(:))
        curStr = regexp(string(str(ielem)),'\d*','Match');
        cells{ielem} = str2double(curStr);
        
        curStr(isempty(curStr)) = NaN;
        nums(ielem) = str2double(join(curStr, ""));
    end
    
    nums = reshape(nums, size(str));
    
    if isempty(nums)
        nums = NaN;
    end
end