function checksTypes = verifyConstructorErrs(classHndl)
    % Check that constructor of a classHndl throws an exception if any argument is the wrong class
    actual = classHndl();
    props = properties(actual);

    nArgs = nargin(classHndl);
    argins = repmat({[]}, [1 nArgs]);
    
    checksTypes = false([1 nArgs]);
    for iprop = 1:nArgs
        errVal = getOtherClass(actual.(props{iprop}));
        argins{iprop} = errVal;
        try
            actual = classHndl(argins{:});
        catch
            checksTypes(iprop) = true;
        end
    end
end

function errVal = getOtherClass(value)
    classes = Fcn.allclasses(value);
    otherInds = UTest.builtinClasses ~= classes;
    errClass = Rand.select(UTest.builtinClasses(otherInds));
    errFcn = str2func(errClass + UTest.emptyVal);
    errVal = errFcn();
end