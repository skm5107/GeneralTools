function [req, reqs] = checkReqd(self, id)
    reqs = false(1,length(self.Tasks));
    LastTask = self.Tasks(id);
    
    reqs = checkPreds(self, LastTask, reqs);
    req = all(reqs);
end

function reqs = checkPreds(self, JTask, reqs)
    predIDs = [JTask.Preds.id];
    for jid = predIDs
        JPred = self.Tasks(jid);
        reqs(jid) = true;
        reqs = checkPreds(self, JPred, reqs);
    end
end