classdef Task < handle
    properties (GetAccess = private)
        raw (1,:) table
    end
    
    properties (SetAccess = private)
        id (1,1) uint16
        name (1,1) string
        When (1,1) TimePd
        Price (1,:) Cost
        
        assignee (1,:) categorical
        comments (1,:) string
    end
    
    properties (SetAccess = {?Schedule})
        Parent {mustBeScalarOrEmpty(Parent)} = []
        Childs (1,:)
        indent
        
        Preds (1,:) = []
        Sucs (1,:) = []
    end
    
    properties (Access = {?Schedule})
        parentID
        predIDs
    end
    
    properties (Dependent, Hidden)
        indentName
        row
    end
    
    properties (Constant, Access = private)
        indent1 = '  ';
    end
    
    methods
        function self = Task(tblRow)
            if nargin > 0
                self.raw = tblRow;
            end
        end
        
        function self = run(self)
            if ~isempty(self.raw)
                self = self.assignVals();
            end
            self = self.clean();
        end
    end
    
    methods
        function tf = isempty(self)
            if min(size(self)) == 0
                tf = true;
            elseif all(size(self) == 1)
                tf = self.id == 0;
            else
                tf = false;
            end
        end
        
        function indentName = get.indentName(self)
            indentTot = repmat(Task.indent1, 1, self.indent);
            indentName = indentTot + self.name;
        end
        
        function row = get.row(self)
            row = table();
            row.id = self.id;
            row.name = self.indentName;
            row.time = self.When.row;
            [row.ids, Hndls] = self.getHndls();
            row.cost = Task.multiRow(self.Price);
            row.Hndls = Hndls;
        end
    end
    
    methods (Access = private)
        self = assignVals(self)
        self = clean(self)
        [ids, Hndls] = getHndls(self)
    end
    
    methods (Static, Access = {?Schedule})
        indent = countAncestry(JTask, indent)
    end
    
    methods (Static)
        function row = multiRow(JTasks)
            row = table();
            for jprop = properties(JTasks)'
                row.(jprop{:}) = {[JTasks.(jprop{:})]'};
            end
        end
    end
end