classdef AutoCompare
    % Generate and print difference tables for a table of new and otld of filePaths.
    
    properties (GetAccess = protected)
        filePaths table
        Importer ImportKey
        printDir string
    end
    
    properties (SetAccess = private)
        comp ComparedTable
        nonMatches table
    end
    
    properties (Access = private)
        newFlat
        oldFlat
        varNames
    end
    
    %% Constructor & Runner
    methods
        function self = AutoCompare(filePaths, Importer, printDir)
            if nargin > 0
                self.filePaths = filePaths;
            end
            if nargin > 1
                self.Importer = Importer;
            end
            if nargin > 2
                self.printDir = printDir;
            end
        end
        
        function self = run(self)
            for ifile = 1:height(self.filePaths)
                [newTable, oldTable] = MatchedFile(self.filePaths.new(ifile), self.filePaths.old(ifile), self.Importer).run;
                self.comp(ifile) = ComparedTable(newTable, oldTable).run;
            end
            self.nonMatches = vertcat(self.comp.nonMatches);
            
            if ~isempty(self.printDir)
                diffTables_print(self);
            end
        end
    end
    
    %% Printing
    methods (Access = private)
        function diffTables_print(self)
            mkdir(self.printDir);
            for ifile = 1:height(self.filePaths)
                bagfolder = fullfile(self.printDir, self.filePaths.name(ifile));
                Fldr.mkdirIfNone(bagfolder);
                
                diffName = Fldr.fileext(self.filePaths.new(ifile));
                printTable = Log.tf_tables(self.comp(ifile).diffTable);
                writetable(printTable, fullfile(bagfolder, diffName));
            end
        end
    end
end