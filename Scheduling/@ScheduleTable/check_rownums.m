function self = check_rownums(self)
    tomatch = [1:height(self.tbl)]';
    rows.ismatch = tomatch == self.tbl.row;
    rows.allmatch = all(rows.ismatch);
    self.checked.rownums = rows;
    
    passPrnt = "All row numbers are correct.\n";
    wrongRows = find(~rows.ismatch);
    wrongStr = join(string(wrongRows),",");
    failPrnt = "The following row numbers are incorrect: ["+wrongStr+"]\n";
    
    self.Verbose.prnt(rows.allmatch, passPrnt, failPrnt);
end