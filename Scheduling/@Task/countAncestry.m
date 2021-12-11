function indent = countAncestry(JTask, indent)
    if ~isempty(JTask.Parent)
        indent = Task.countAncestry(JTask.Parent, indent+1);
    end
end