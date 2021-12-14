function self = trimActions(self)
    [self.log.act, isKeep] = cellfun(@(raw) makeAction(raw, self.keepMoves), self.log.Action);
    self.log(~isKeep,:) = [];
end

function [act, isKeep] = makeAction(raw, keepMoves)
    act = ChangeAction(raw).run;
    isKeep = any(string(act.move) == lower(keepMoves));
end