classdef Obj
    methods (Static)
        [uniqued, repeat_qty] = unique(rowsWcopies)
        isEqual = hndlEqual(ObjA, ObjB, props)
        tf = isempty(obj)
        
        varargout = prop_add(prop)
        tbl = row_make(obj, props)
        
        varNames = var_list(anyObj)
        obj = table2obj(tbl, obj, props)
    end
    
    methods (Static)
        function every = allclasses(value)
            base = string(class(value));
            every = [base; superclasses(base)];
        end
        
        function summed = struct_sum(struct)
            celled = struct2cell(struct);
            summed = sum([celled{:}]);
        end
        
        function converted = cast(origVal, reqClass) %#ok<INUSL>
            fcn = reqClass + "(origVal)";
            converted = eval(fcn);
        end
        
        function Destin = props_copy(Orig, Destin, props)
            if nargin < 3
                props = Obj.var_list(Orig);
            end
            props = intersect(props, Obj.var_list(Destin));
            for jprop = props
                Destin.(jprop{:}) = Orig.(jprop{:});
            end
        end

        function Made = repmat(input_qtys, classHndl)
            inputs = input_qtys(:,1);
            qtys = input_qtys(:,2);
            Made = cellfun(@(input, qty) objrepmat(input, qty, classHndl), inputs, qtys, 'uni', false);
            Made = Arr.uncell(Made);
        end
    end
end

function Made = objrepmat(input, qty, objHndl)
    Single = objHndl(input);
    Made = repmat(Single, [1 str2double(qty)]);
end