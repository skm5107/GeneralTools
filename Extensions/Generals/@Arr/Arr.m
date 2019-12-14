classdef Arr
    methods (Static)
        content = uncell(celled)
        celled = cellify(content)
        
        [flat, origShape] = flatten(arr, horzORvert)
        padded = pad(arr, sz, padVal, leftORright)
        
        [dim, val] = getDim(input, minORmax)
        
        setted = appendNoEmpty(current, new)
        
        function varargout = deal(arr)
            ascells = Arr.cellify(arr);
            varargout = ascells;
        end
    end
end