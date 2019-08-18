classdef ConstFile < handle
    % Tables with metadata from a standard constant CSV file.
    
    properties (SetAccess = immutable, GetAccess = private)
        csvPath string
        Header KeyedHeader
    end
    
    properties (Access = private)
        list
    end
    
    properties (SetAccess = private)
        const
    end
    
    %% Constructor & Autogetter
    methods
        function self = ConstFile(Header, csvPath)
            if nargin > 0
                self.Header = Header;
            end
            if nargin > 1
                self.csvPath = csvPath;
            end
        end
    end
    
    methods
        function [const, self] = run(self)
            FileName = FullPath(self.csvPath).run;
            self.list = AutoImportKeyed(self.Header, FileName).run;
            const = table();
            for irow = 1:height(self.list)
                const = Tbl.nested_horzcat(const, ConstFile.row2const(self.list(irow,:)));
            end
            self.const = const;
        end
    end
    
    %% Internal Methods
    methods (Static, Access = private)
        function [const, varName] = row2const(row)
            varName = char(row.varName);
            FormatVar = FormatSpec(row.valType);
            [~, ~, frmtHndl] = Key.lookup(FormatKey.key, FormatVar.idVect, "finalID", "fcnHndl");
            frmtHndl = frmtHndl{:};
            value = Frmt.parse(row.value{:}, FormatVar.parseVect);
            value = frmtHndl(value, FormatVar.styleVect);
            
            const = Tbl.nested_name(varName, value);
            const.Properties.VariableUnits = cellstr(row.valUnits);
            const.Properties.VariableDescriptions = cellstr(row.valDesc);
        end
    end
end