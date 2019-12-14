function [isMatch, start_inds, nextChars] = findNextChar(txt, patterns)
    if ~Val.isFull(txt)
        txt = "";
    end

    cellTxt = num2cell(char(txt + " "));
    patt_lens = cellfun(@length, cellstr(patterns));
    start_inds = Str.strfind(txt, patterns);
    isMatch = ~isnan(start_inds);
    
    end_inds = min(start_inds(:) + patt_lens(:), length(cellTxt));    
    nextChars = cellTxt(end_inds);
end