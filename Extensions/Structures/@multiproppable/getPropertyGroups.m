function propgrp = getPropertyGroups(self)
    props = properties(self);
    
    propList = struct();
    for jprop = props'
        propList.(jprop{:}) = getval(self(1).(jprop{:}));
    end
    propgrp = matlab.mixin.util.PropertyGroup(propList);
end

function val = getval(prop)
    if ismember("multi", Obj.allclasses(prop))
        val = prop.get;
    else
        try
            val = prop.clsDisp;
        catch
            val = prop;
        end
    end
end