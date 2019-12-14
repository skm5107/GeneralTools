function cast_test(tester)
    tester.verifyClass(...
        Obj.cast(2, "string"), "string");
    
    tester.verifyClass(...
        Obj.cast("NaN", "double"), "double");
    
    tester.verifyClass(...
        Obj.cast("missing", "categorical"), "categorical");
end