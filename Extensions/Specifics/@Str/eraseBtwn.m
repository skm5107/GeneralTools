function str = eraseBtwn(str, startStr, endStr, boundaries)
    assert(all(size(startStr) == size(endStr)))
    
    for irmv = 1:length(startStr)
        str = eraseBetween(str, startStr(irmv), endStr(irmv), ...
            'Boundaries', boundaries);
    end
end