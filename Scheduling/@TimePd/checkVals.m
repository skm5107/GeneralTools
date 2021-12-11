function self = checkVals(self)
    business_days = busdays(self.start, self.finish);
    calcDur_bus = days(length(business_days));
    dur_bus.ismatch = self.dur_bus == calcDur_bus;
    dur_bus.diff = "Set non-working days"; %calcDur_bus - self.dur_bus;
    self.checked.dur_bus = dur_bus;
    
    failPrnt = sprintf("Duration is off by %s", dur_bus.diff);
    self.Verbose.prnt(dur_bus.ismatch, "Duration matches", failPrnt);
end