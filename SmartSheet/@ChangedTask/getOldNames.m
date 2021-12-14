function self = getOldNames(self)
    old = self.Log.log.old.name;
    new = self.Log.log.new.name;
    prevName = getPrevName(self.name, old, new);
end

function prevName = getPrevName(curName, old, new)
    
end