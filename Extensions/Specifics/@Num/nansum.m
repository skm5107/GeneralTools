function summed = nansum(vals, varargin)
    if all(isnan(vals), 'all')
        summed = NaN;
    else
        vals(isnan(vals)) = 0;
        summed = sum(vals, varargin{:});
    end
end