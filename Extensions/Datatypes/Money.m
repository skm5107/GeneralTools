classdef Money
    properties
        raw
    end
    
    properties (Dependent)
        num
        symb
        prnt
    end
    
    properties (Constant, Access = private)
        symbols = ["[$]", "[¢]"]
        wrapper = ["[", "]"]
        clean = [" ", ","]
    end
    
    methods
        function self = Money(raw)
            if nargin > 0
                self.raw = string(raw);
            end
        end
    end
    
    methods
        function symb = get.symb(self)
            regInds = regexpi(self.raw, Money.symbols);
            regInds = cellfun(@isSymb, regInds);
            symb = Money.symbols(regInds);
            symb = erase(symb, Money.wrapper);
        end
        
        function num = get.num(self)
            num = erase(self.raw, Money.clean);
            num = erase(num, self.symb);
            num = double(num);
        end
        
        function prnt = get.prnt(self)
            wCommas = Frmt.delimNum(self.num);
            wDecs = Frmt.addDecimal(wCommas);
            prnt = sprintf("%s%s", self.symb, wDecs);
        end
    end
end

function tf = isSymb(a)
    tf = ~isempty(a);
end