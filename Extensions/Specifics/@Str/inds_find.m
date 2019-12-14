function [text, start_ind, end_ind] = inds_find(text, btwn_chars)
    text = char(text);
    start_ind = find(get_ind(text, btwn_chars{1}));
    end_ind = find(get_ind(text, btwn_chars{2}));
end
function ind = get_ind(text, reqChar)
    ind = text == reqChar;
    assert(sum(ind) <= 1, "Character appears more than once");
end