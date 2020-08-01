function ind = get_ind(text, reqChar)
    ind = text == reqChar;
    assert(sum(ind) <= 1, "Character appears more than once");
end