classdef Arr
    methods (Static)
        content = uncell(celled, lvl)
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
        
        function buffered = buffer(bounds, buff)
            buffered(1) = min(bounds) - buff;
            buffered(2) = max(bounds) + buff;
        end
    end
end