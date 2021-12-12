function self = checkActions(self)
    acts = cellfun(@getAction, self.log.Action, 'UniformOutput', 0);
    self.allActions = unique(acts);
end

function action = getAction(actionStr)
    action = extractBefore(actionStr, Changelog.actionSuff);
    if isempty(action)
        action = actionStr;
    end
end
