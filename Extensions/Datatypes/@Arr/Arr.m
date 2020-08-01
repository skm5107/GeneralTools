classdef Arr
    methods (Static)
        content = uncell(celled)
        celled = cellify(content, varargin)
        
        [flat, origShape] = flatten(arr, horzORvert)
        padded = pad(arr, sz, padVal, leftORright)
        padded = centerPad(background, foreground, dims)
        
        [dim, val] = getDim(input, minORmax)
        
        setted = appendNoEmpty(current, new)
        [isSame, diff] = cellcomp(old, new, tolPos, tolNeg)
        
        function varargout = deal(arr)
            ascells = Arr.cellify(arr);
            varargout = ascells;
        end
    end
end