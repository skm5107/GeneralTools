function [text, start_ind, end_ind] = inds_find(text, btwn_chars)
    text = char(text);
    start_ind = find(Str.get_ind(text, btwn_chars{1}));
    end_ind = find(Str.get_ind(text, btwn_chars{2}));
end