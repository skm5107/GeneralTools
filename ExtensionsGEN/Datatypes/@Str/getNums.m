function nums = getNums(str)
    nums = str2double(regexp(string(str),'\d*','Match'));
    
    if isempty(nums)
        nums = NaN;
    end
end
