classdef Frmt
    properties (Constant)
        key = Frmt.loadKey()
    end
        
    methods (Static)
        formSpec = getSpec(tbl)
        [val, arg2] = str(raw, ~)
        [val, arg2] = num(raw, ~)
        [val, arg2] = cat(raw, ~)
        [val, arg2] = log(raw, ~)
        [val, arg2] = clock(raw, style)
        [val, arg2] = cell(raw, ~)
        [val, arg2] = table(raw, ~)
        
        [val, arg2] = catTF(log, ~)
        [val, arg2] = logcat(raw, ~)
        [val, isAllLog] = lognan(raw, ~)
    end
    
    methods (Static, Access = private)
        key = loadKey()
    end
end