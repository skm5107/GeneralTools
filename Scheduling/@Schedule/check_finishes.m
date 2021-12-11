function [ok, fins] = check_finishes(self)
    fins = struct();
    for itask = 1:length(self.Tasks)
        JTask = self.Tasks(itask);
        if JTask.name == Schedule.finName
            fins.okDur(itask) = double(JTask.When.dur_bus == Schedule.finDur);
            fins.okDate(itask) = double(JTask.When.finish == JTask.Parent.When.finish);
        else
            fins.okDur(itask) = NaN;
            fins.okDate(itask) = NaN;
        end
    end
    
    okDur = all(fins.okDur);
    okDate = all(fins.okDate);
    ok = all(okDur, okDate);
end