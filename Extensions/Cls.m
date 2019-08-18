classdef Cls
    methods (Static)
        function classes = allclasses(value)
            class1 = string(class(value));
            classes = [class1; superclasses(class1)];
        end
        
        function [isMatch, matchVal] = propVals_match(obj1, obj2, propNames)
            isMatch = false(size(propNames));
            for iprop = 1:length(propNames)
                jprop = propNames{iprop};
                isMatch(iprop) = obj1.(jprop) == obj2.(jprop);
                if isMatch(iprop)
                    matchVal.(jprop) = obj1.(jprop);
                end
            end
        end
        
        function obj = table2class(tbl, obj, props)
            if nargin < 3
                props = intersect(tbl.Properties.VariableNames, string(properties(obj)));
            end
            
            for jprop = props(:)'
                try obj.(jprop{:}) = tbl.(jprop{:}); end %#ok<TRYNC>
            end
        end
    end
end