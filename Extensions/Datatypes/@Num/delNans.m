function noNans = delNans(withNans)
    noNans = withNans;
    noNans(isnan(noNans)) = [];
end