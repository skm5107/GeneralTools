function content = uncell(celled)
    content = celled;
    itry = 1;
    while iscell(content) && itry <= 10
        if iscellstr(content)
            content = string(content);
        else
            content = [content{:}];
        end
        itry = itry + 1;
    end
end