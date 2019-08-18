classdef Fcn
    % Static methods as utilities for function calls
    
    methods (Static)
        function tf = isFull(val)
            tf = ~isempty(val) && ~ismissing(val);
            if isstring(val)
                tf = tf & val ~= "";
            end
        end
        
        function varNames = varlist(structORtbl)
            if ismember("table", Cls.allclasses(structORtbl))
                varNames = structORtbl.Properties.VariableNames;
            else
                varNames = fields(structORtbl);
            end
        end
        
        function varargout = empty_override(current, defaults)
            %Override empty cells with default values
            overriden = current;
            for iarg = 1:length(current)
                if isempty(current{iarg})
                    overriden{iarg} = defaults{iarg};
                end
            end
            
            [varargout{1:nargout}] = overriden{:};
        end
        
        function val = firstNotEmpty_select(varargin)
            shouldAgree = {};
            for iarg = varargin
                if ~isempty(iarg{:}) && ~ismissing(iarg{:})
                    shouldAgree = [shouldAgree, iarg];
                end
            end
            
            if length(shouldAgree) > 1
                valsAgree = isequal(shouldAgree{:});
                if ~valsAgree
                    warning("Two or more values non-empty and not equal.")
                end
            end
            
            val = shouldAgree{1};
        end
        
        function returnArg = byName_choose(reqName, varargin)
            % return only the argument whose input name matches the requested name
            
            argNames = strings([1 length(varargin)]); %This cannot be functionized due to the nature of varargin
            for iarg = 1:length(varargin)
                argNames(iarg) = inputname(1+iarg);
            end
            
            reqInd = strcmp(reqName, argNames);
            Except(reqName).verifyIsMember(argNames);
            returnArg = varargin{reqInd};
        end
    end
    properties (Constant)
        mExt = [".m", ".mlx"];
    end
    
    methods (Static)
        function fileName = getCallingFile(priorNth)
            traceback = struct2table(dbstack);
            if height(traceback) < 2
                fileName = "";
            else
                reqRow = traceback(priorNth+1, :);
                fileName = string(reqRow.file);
                fileName = erase(fileName, Fcn.mExt);
            end
        end
    end
    
    methods (Static)
        function orig = missing_delete(orig)
            orig(ismissing(orig)) = []; %provides a function handle for cellfun use
        end
        function content = uncell(cell1)
            content = cell1;
            itry = 1;
            while iscell(content) && itry <= 10
                if iscellstr(content)
                    content = string(content);
                else
                    content = [content{:}];
                end
                itry = itry + 1;
            end
        end
    end
end