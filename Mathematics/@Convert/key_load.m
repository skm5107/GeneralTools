function key = key_load()
    raw = AutoImported(Convert.keyPath).run;
    
    AB = table();
    AB.unitA = raw.unitA;
    AB.unitB = raw.unitB;
    AB.AtoB_mult = raw.valB ./ raw.valA;
    AB.fcnHndl = raw.fcnHndl;
    
    BA = table();
    BA.unitA = AB.unitB;
    BA.unitB = AB.unitA;
    BA.AtoB_mult = 1 ./ AB.AtoB_mult;
    BA.fcnHndl(:) = "";
    
    key = [AB; BA];
end