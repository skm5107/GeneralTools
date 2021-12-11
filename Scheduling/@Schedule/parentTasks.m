function self = parentTasks(self)
    for itask = 1:length(self.Tasks)
        JTask = self.Tasks(itask);
        iparent = JTask.parentID;
        if ~isnan(iparent)
            JParent = self.Tasks(iparent);
            JTask.Parent = JParent;
            JParent.Childs = [JParent.Childs, JTask];
        else
            JTask.Parent = Task();
        end
    end
    
    for itask = 1:length(self.Tasks)
        JTask = self.Tasks(itask);
        JTask.indent = Task.countAncestry(JTask,0);
    end
end