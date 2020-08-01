function values = nan2zero(values)
    values(isnan(values)) = 0;
end