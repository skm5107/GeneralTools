function key = loadKey
    raw = [{{'q'}, @Frmt.str, @isstring, "string"}; ...
        {{'C'}, @Frmt.cat, @iscategorical, "categorical"}; ...
        {{'L'}, @Frmt.log, @islogical, "logical"}; ...
        {{'t'}, @Frmt.table, @istable, "table"}; ...
        {{'r'}, @Frmt.cell, @iscell, "cell"}; ...
        {{'D', 'T'}, @Frmt.clock, @isdatetime, "datetime"}; ...
        {{'d', 'f', 'I', 'u', 'n', 'o', 'x', 'e', 'E', 'g', 'G'}, @Frmt.num, @isnumeric, "double"}];
    key = cell2table(raw, 'VariableNames', {'typeID', 'convertHndl', 'checkHndl', 'className'});
    key.Properties.VariableDescriptions = {'type identifier (primarily from textscan)', ...
        'string to datatype conversion function', ...
        'check datatype function', ...
        'answer to @class'};
    key.Properties.RowNames = string(key.className)';
end