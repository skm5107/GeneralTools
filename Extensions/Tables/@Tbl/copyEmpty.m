function emp = copyEmpty(src, hgt)
    emp = src;
    for jvar = string(emp.Properties.VariableNames)
        cls = class(emp.(jvar));
        missVal = Obj.cast(missing, cls);
        emp.(jvar) = repmat(missVal,height(emp), 1);
    end
    
    if nargin > 1
        emp = repmat(emp, hgt, 1);
    end
end