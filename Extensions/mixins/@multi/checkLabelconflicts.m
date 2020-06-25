function checkLabelconflicts(self)
    tf = cellfun(@(jlabel) Log.anyequaln(jlabel, properties(self)), self.labels, 'uni', false);
    namedProp = any(Arr.uncell(tf), 'all');
    Warn.warnIf(namedProp, "multi:labels", "At least one type element shares a name with a multi property. This will disallow dot indexing into the type element")
end