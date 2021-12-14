classdef UTestWarn < UTest
    methods (Test, ParameterCombination ='sequential')
        function test_false(tester)
            act = tester.verifyWarningFree(@(noin) Warn.warnIf(false));
            tester.verifyFalse(act);
        end
        
        function test_true(tester)
            act = verifyWarning(tester, @(noin) Warn.warnIf(true), char());
            tester.verifyTrue(act);
        end
        
        function test_msg(tester)
            expMsg = 'Msg';
            tester.verifyWarning(@(noin) Warn.warnIf(true, expMsg), '');
            actMsg = lastwarn();
            tester.verifyEqual(actMsg, expMsg);
        end
        
        function test_idMsg(tester)
            expMsg = 'msg-msg';
            expID = 'ID22:id333';
            tester.verifyWarning(@(noin) Warn.warnIf(true, expID, expMsg), expID);
            [actMsg, actID] = lastwarn();
            tester.verifyEqual(actMsg, expMsg);
            tester.verifyEqual(actID, expID);
        end
        
        function test_sprintf(tester)
            inMsg = 'MSG %s MSG';
            inStr = 'STR STR';
            expMsg = sprintf(inMsg, inStr);
            expID = 'ID4444:id55555';
            
            tester.verifyWarning(@(noin) Warn.warnIf(true, expID, inMsg, inStr), expID);
            [actMsg, actID] = lastwarn();
            tester.verifyEqual(actMsg, expMsg);
            tester.verifyEqual(actID, expID);
        end
    end
end
