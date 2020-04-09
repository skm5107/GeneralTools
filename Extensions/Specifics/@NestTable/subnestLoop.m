function out = subnestLoop(out, loc)
    if ~isnan(loc)
        nested = NestTable(out{:, loc}).run;
        nestName = out(:,loc).Properties.VariableNames;
        nested = table(nested, 'VariableNames', nestName);
        out = Tbl.substituteCol(out, nested, loc);
    end
end