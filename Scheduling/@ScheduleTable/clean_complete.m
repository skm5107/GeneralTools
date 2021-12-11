function self = clean_complete(self)
    tmp = erase(self.tbl.complete_pcent,"%");
    self.tbl.complete_pcent = str2double(tmp);
end