function initsEmpty = verifyInitsEmpty(classHndl)
    % Check that a classHndl initializes without error and empty (for MATLAB fundamental classes) if called without arguments
    
    actual = classHndl();
    props = properties(actual);
    
    initsEmpty = false(size(props));
    for iprop = 1:length(props)
        try
            value = actual.(props{iprop});
        catch
            continue %getters are allowed to error (as well as be empty)
        end
        initsEmpty(iprop) = empty_check(value);
    end
end

function isEmpt = empty_check(value)
    classes = Fcn.allclasses(value);
    if any(classes == UTest.builtinClasses)
        isEmpt = isempty(value);
    else
        isEmpt = true;
    end
end