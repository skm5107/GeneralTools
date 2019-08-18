classdef FormatConverter
    % Methods for converting datatypes
    
    methods (Static)
        function formatted = format(input, datatype, style)
            switch datatype %%TODO: allow more than just these finalIDs %%TODO: use in FormattedTable
                case "d"
                    formatted = str2double(input);
                case "L"
                    formatted = logical(input);
                case "q"
                    formatted = string(input);
                case "C"
                    formatted = categoric(input);
                case "D"
                    formatted = datetime(input, 'InputFormat', style);
                case "r"
                    formatted = {input};
                case "t"
                    formatted = table(input);
                otherwise
                    assert(false, "Invalid datatype ID.")
            end
        end
    end    
end