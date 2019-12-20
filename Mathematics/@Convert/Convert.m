classdef Convert
    properties (Constant, Access = private)
        topPath = fileparts(mfilename('fullpath'))
        keyPath = fullfile(Convert.topPath, "unit conversion.csv")
        key = Convert.key_load()
        unitExpr = join(string(Convert.key.unitA), "|")
        
        prePath = fullfile(Convert.topPath, "unit prefixes.csv")
        preKey = AutoImported(Convert.prePath).run
        preExpr = join(string(Convert.preKey.prefix), "|") 
        
        unit2unit_div = ">"
        iterative_tries = 5;
        keyFcnHndlClass = "Convert"
    end
    
    methods (Static)
        val_out = to(val_in, unit2unit)
    end
    
    methods (Static, Access = private)
        key = key_load()
        [base_in, base_out, presuffix_mult] = presuffix_parse(unit_in, unit_out)
        val_out = iterativeConvert(val_in, unit_in, unit_out, presuff_mult)
    end
    
    methods (Static, Access = private)
        function F = CtoF(C)
            F = C .* 9/5 + 32;
        end
        function C = FtoC(F)
            C = (F - 32) .* 5/9;
        end
        
        function K = CtoK(C)
            K = C + 273.15;
        end
        function C = KtoC(K)
            C = K - 273.15;
        end
    end
end