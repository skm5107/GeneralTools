function self = trimActions(self)
    act = table();
    [act.target, act.move] = cellfun(@(act) ChangeAction(act).runprops, self.log.Action);
    self.log.act = act;
    
    keepRows = any(string(act.move) == lower(self.keepMoves), 2);
    self.log(~keepRows,:) = [];
end