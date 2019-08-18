classdef ConstSet
    % Constants loaded from a directory map
    
    properties (SetAccess = private)
        map table
        Header KeyedHeader
    end
    
    properties
        const
    end
    
    %% Constructor
    methods
        function self = ConstSet(map, Header)
            if nargin > 0
                self.map = map;
            end
            if nargin > 1
                self.Header = Header;
            end
        end
    end
    
    %% Getters
    methods
        function [const, self] = run(self)
            const = table();
            for ifile = 1:height(self.map)
                path = Fldr.dirfullpath(self.map(ifile,:));
                current = ConstFile(self.Header, path).run;
                const = Tbl.nested_horzcat(const, current);
                %%TODO: format/style/error verification of constants CSV formats etc
            end
            self.const = const;
        end
    end
   
end