function tf = equalClock(act, exp)
    if ismember(Obj.allclasses(act), "datetime") && ismember(Obj.allclasses(exp), "string")
        tf = all(isequaln(string(act), exp));
    else
        tf = all(isequaln(act, exp));
    end
end