function rolling = stepped2cumsum(stepped, step_inc, sum_dist)
    value = stepped / step_inc;
    value(isnan(value)) = 0;
    rolling = cumsum(value, sum_dist / step_inc);
end