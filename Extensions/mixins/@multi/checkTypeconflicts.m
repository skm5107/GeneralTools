function checkTypeconflicts(self)
    tf = cellfun(@(jtype) Log.anyequaln(jtype, properties(self)), self.types, 'uni', false);
    namedProp = any(Arr.uncell(tf), 'all');
    Warn.warnIf(namedProp, "multi:types", "At least one type element shares a name with a multi property. This will disallow dot indexing into the type element")
end