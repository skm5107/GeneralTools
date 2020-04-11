function writeComp(self, tfHeaders)
    toprint = self.comp;
    if tfHeaders
        headers = extractHeads(toprint, self.fillerChar);
    end
    if Val.isFull(self.printPath)
        writetable(headers, printPath);
        writetable(self.comp, printPath, 'WriteMode', 'append');
    end
end

function heads = extractHeads(raw, fillChar)
    props = raw.Properties;
    wid = width(raw);
    formSpec = Frmt.getSpec(raw);
    varUnits = Arr.pad(props.VariableUnits, [1 wid], fillChar);
    varDescs = Arr.pad(props.VariableDescriptions, [1 wid], fillChar);
    desc = Arr.pad(props.Description, [1 wid], fillChar);
    heads = [orig.Properties.VariableNames; formSpec; varUnits; varDescs; desc];
end