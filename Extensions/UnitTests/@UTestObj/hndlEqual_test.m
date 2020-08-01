function hndlEqual_test(tester)
    hndlA = DemoHndl(["sameVal" "sameVal"], "DiffVal1", false);
    hndlB = DemoHndl(["sameVal" "sameVal"], "DiffVal2", false);
    tester.verifyTrue(...
        Obj.hndlEqual(hndlA, hndlB, ["propA", "propC"]));
    
    tester.verifyFalse(...
        Obj.hndlEqual(hndlA, hndlB, ["propA", "propB"]));
    
    tester.verifyFalse(...
        Obj.hndlEqual(hndlA, hndlB, "propB"));
    
    tester.verifyFalse(...
        Obj.hndlEqual(hndlA, hndlB));
end