function [ids, Hndls] = getHndls(self)
    ids = table();
    Hndls = table();
    [ids, Hndls] = addHndl(ids, Hndls, self.Parent, "parent");
    [ids, Hndls] = addHndl(ids, Hndls, self.Preds, "preds");
    [ids, Hndls] = addHndl(ids, Hndls, self.Childs, "childs");
    [ids, Hndls] = addHndl(ids, Hndls, self.Sucs, "sucs");
end

function [ids, Hndls] = addHndl(ids, Hndls, hndl, name)
    Hndls.(name) = {hndl};
    if ~isempty(hndl) || (isnumeric(hndl) && ~isnan(hndl))
        ids.(name) = {[hndl.id]};
    else
        ids.(name) = {NaN};
    end
end