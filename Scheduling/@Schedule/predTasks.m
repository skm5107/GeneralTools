function self = predTasks(self)
    for itask = 1:length(self.Tasks)
        JTask = self.Tasks(itask);
        ipreds = JTask.predIDs;
        ipreds = num2cell(Arr.uncell(ipreds));
        JTask = cellfun(@(iprd) asgnPreds(self, JTask, iprd), ipreds);
    end
end

function JTask = asgnPreds(self, JTask, iprd)
    if ~isnan(iprd)
        JPred = self.Tasks(iprd);
        JTask.Preds = [JTask.Preds, JPred];
        JPred.Sucs = [JPred.Sucs, JTask];
    else
        JTask.Preds = Task.empty();
    end
end
    