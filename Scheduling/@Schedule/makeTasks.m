function self = makeTasks(self)
    for irow = 1:height(self.raw)
        self.Tasks(irow) = Task(self.raw(irow,:)).run;
    end
end