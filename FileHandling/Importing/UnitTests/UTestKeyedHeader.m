classdef UTestKeyedHeader < UTest
    %% Headcodes of Outputs
    properties (Constant)%, Access = private)
        Key = ImportKey("UTest").run;
        flds = {'varNames', 'varUnits', 'varDescs', ...
            'isSaved', 'varMult', 'varNcol', ...
            'notes', 'tblDesc', ...
            'formatSpec'}; %%TODO: choose if headers are singular or plural
        
        fake0 = { {'col3var', 'mult05'}, {'%' 'unitsHere'}, {'%' 'descHere'}, ...
            [true; true], [5; 1], [3; 1], ...
            {'%' '%'}, "fake # delimited file with no subname", ...
            ["f" "q"] };
        
        fake1 = { {'firstSavedVar', 'unsaved', 'lastSavedVar'}, {'unitsHere' '%' '%'}, {'descHere' '%' '%'} ...
            [true; false; true], [1; 1; 1], [2; 3; 4], ...
            {'%' '%' '%'}, "fake ; delimited file with no subname and no aliases", ...
            ["C" "q" "C"] };
        
        fake2 = { {'onlySavedVar', 'unsaved'}, {'%' '%'}, {'%' '%'} ...
            [true; false], [1; 1], [2; 1] ...
            {'%' '%'}, "fake | delimited file with 2 subnames and no default subname", ...
            ["C" "q"] };
        
        real1 = { {'name1', 'Name2', 'name3', 'Name4', 'name5', 'Name6', 'name7', 'name8Last'}, ...
            {'g/ft' 'N*m' 'km' 'slugs' 'keV' 'NextIsBlank' '' 'lastunits'}, ...
            {'NextIsBlank' '%' 'DescC Lorem Ipsum' 'descD' '!@#$%^&*()_+DescE' 'descF !@#$^&*())_+'  'DescG; g'  '"descLast, with comma"'}, ...
            [true false true false true false true true]', [1 1 5 1 1 1 1 1]', ones([8 1]), ...
            cellstr(repmat("%", [1 8])), "TableDescription here", ...
            ["{;}C" "q" "g" "L" "{dd-M;}D", "L" "{|}r" "{;}t"] };
        
        none = { {cell.empty(1,0)}, {cell.empty(1,0)}, {cell.empty(1,0)}, ...
            {logical.empty(0,1)}, {double.empty(0,1)}, {double.empty(0,1)}, ...
            {cell.empty(1,0)}, {"TableDescription here"} };
    end
    
    %% Check Other Properties
    methods (Test)
        function prop_fake0(props)
            actual = KeyedHeader(UTestKeyedHeader.Key, "fake0").run;
            for ifld = 1:length(UTestKeyedHeader.flds)-1
                fld = UTestKeyedHeader.flds{ifld};
                props.verifyEqual(actual.(fld), UTestKeyedHeader.fake0{ifld});
            end
            props.verifyEqual(actual.ConvertVect.formatVect, UTestKeyedHeader.fake0{end});
        end
        
        function prop_fake0alias(props)
            actual = KeyedHeader(UTestKeyedHeader.Key, "fake0alias").run;
            for ifld = 1:length(UTestKeyedHeader.flds)-1
                fld = UTestKeyedHeader.flds{ifld};
                props.verifyEqual(actual.(fld), UTestKeyedHeader.fake0{ifld});
            end
            props.verifyEqual(actual.ConvertVect.formatVect, UTestKeyedHeader.fake0{end});
        end
        
        function prop_fake1(props)
            actual = KeyedHeader(UTestKeyedHeader.Key, "fake1").run;
            for ifld = 1:length(UTestKeyedHeader.flds)-1
                fld = UTestKeyedHeader.flds{ifld};
                props.verifyEqual(actual.(fld), UTestKeyedHeader.fake1{ifld});
            end
            props.verifyEqual(actual.ConvertVect.formatVect, UTestKeyedHeader.fake1{end});
        end
        
        function prop_fake2a(props)
            actual = KeyedHeader(UTestKeyedHeader.Key, "fake2", "A").run;
            for ifld = 1:length(UTestKeyedHeader.flds)-1
                fld = UTestKeyedHeader.flds{ifld};
                props.verifyEqual(actual.(fld), UTestKeyedHeader.fake2{ifld});
            end
            props.verifyEqual(actual.ConvertVect.formatVect, UTestKeyedHeader.fake2{end});
        end
        
        function prop_real1(props)
            actual = KeyedHeader(UTestKeyedHeader.Key, "real1").run;
            for ifld = 1:length(UTestKeyedHeader.flds)-1
                fld = UTestKeyedHeader.flds{ifld};
                props.verifyEqual(actual.(fld), UTestKeyedHeader.real1{ifld});
            end
            props.verifyEqual(actual.ConvertVect.formatVect, UTestKeyedHeader.real1{end});
        end
    end
end