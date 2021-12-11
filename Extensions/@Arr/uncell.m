function content = uncell(celled, lvl)
    if nargin < 2
        maxtries = 10;
    else
        maxtries = lvl;
    end
    
    content = celled;
    itry = 1;
    while iscell(content) && itry <= maxtries
        if iscellstr(content)
            content = string(content);
        else
            content = [content{:}];
        end
        itry = itry + 1;
    end
end