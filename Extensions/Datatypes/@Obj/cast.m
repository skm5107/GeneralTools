function converted = cast(origVal, reqClass)
    if string(class(origVal)) == reqClass
        converted = origVal;
        return
    end
    
    try
        fcn = reqClass + "(origVal)";
        converted = eval(fcn);
    catch
        converted = autoFail(origVal, reqClass);
    end
end

function converted = autoFail(origVal, reqClass)
    try
        converted = specialCast(origVal, reqClass);
    catch
        if ismissing(origVal)
            converted = getMissVal(reqClass);
        else
            fprintf("Failed value:\n");
            disp(origVal);
            error("Ext:Obj:cast", "Unknown cast to %s", reqClass)
        end
    end
end

function converted = specialCast(origVal, reqClass)
    switch reqClass
        case "cell"
            converted = {origVal};
    end
end

    
function converted = getMissVal(reqClass)
    switch reqClass
        case "logical"
            converted = false;
            warning("Ext:Obj:cast:missing:logical", "Logical missing converted to false");
        otherwise
            error("Ext:Obj:cast:missing", "Unknown cast for missing of class %s", reqClass)
    end
end