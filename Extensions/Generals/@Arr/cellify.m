function celled = cellify(content)
    if iscell(content)
        celled = content;
    elseif ischar(content)
        celled = num2cell(string(content));
    else
        celled = num2cell(content);
    end
end