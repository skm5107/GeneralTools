function target = copyProps(target, new, onlyExistent)
    if nargin < 3
        onlyExistent = false;
    elseif onlyExistent
        targetProps = Tbl.getStructFlds(target);
    end
    
    for jprop = Tbl.getStructFlds(new)'
        if onlyExistent && any(targetProps == jprop)
            target.(jprop) = new.(jprop);
        elseif ~onlyExistent
            target.(jprop) = new.(jprop);
        end
    end
end