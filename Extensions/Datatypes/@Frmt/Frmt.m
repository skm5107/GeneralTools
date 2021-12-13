classdef Frmt
    % Static methods for formatting datatypes
    % These are called by function handles in the FormatKey key.
    % They're called with the same handle structure and thus have the same nargin
    
    properties (Constant)
        noType = "X"; %finalID that indicates datatype should be ignored
        defaultTableVar = "Var"
        
        key = Frmt.loadKey()
        durKey = Frmt.loadDurKey()
        
        numSep = ','
        numGrp = 3
        
        decSep = '.'
        decGrp = 2
    end
    
    methods (Static)
        val = parse(raw, parseChar)   
    end
    
    methods (Static)     
        [val, arg2] = num(raw, ~)        
        [val, arg2] = str(raw, ~)        
        [val, arg2] = cat(raw, ~)        
        [val, arg2] = cell(raw, ~)       
        [val, arg2] = table(raw, ~)       
        [val, arg2] = clock(raw, style)        
        [val, isAllLog] = lognan(raw, ~)
        [val, arg2] = log(raw, ~)
        [val, arg2] = catTF(log, ~)
        [val, arg2] = logcat(raw, ~)
        [val, arg2] = hndl(raw, ~)
    end
    
    methods (Static)
        wCommas = delimNum(num, numSep, numGrp)
        wDecs = addDecimal(num)
    end
    
    methods (Static, Access = private)
        key = loadKey()
        durKey = loadDurKey()
    end
end