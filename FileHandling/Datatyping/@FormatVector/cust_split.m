function split = cust_split(elem, choice) %%TODO: unhack
    elem = char(elem);
    if elem == ""
        style = "";
        parser = "";
    elseif string(elem(end)) == Str.getLetts(elem(end))
        style = string(elem);
        parser = "";
    else
        style = string(elem(1:end-1));
        parser = string(elem(end));
    end
    
    if choice == "parser"
        split = parser;
    else
        split = style;
    end
end