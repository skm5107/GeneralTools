function [tf_all, tf_vect] = isnum(str)
    if isnumeric(str)
        tf_all = true;
        tf_vect = true(size(str));
    else
        vect = char(str);
        num = Str.getNums(vect);
        tf_vect = ~isnan(num);
        tf_all = all(tf_vect);
    end
end