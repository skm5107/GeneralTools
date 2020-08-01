function propadd_test(tester)
    sing = "single";
    [sing1, sing2, sing3] = Obj.prop_add(sing);
    
    tester.verifyEqual(sing1, sing);
    tester.verifyEqual(sing2, sing);
    tester.verifyEqual(sing3, sing);
    
    trip = categorical(["tripleA" "tripleB" "tripleC"]);
    [trip1, trip2, trip3] = Obj.prop_add(trip);
    tester.verifyEqual(trip1, trip(1));
    tester.verifyEqual(trip2, trip(2));
    tester.verifyEqual(trip3, trip(3));
    
    col = [1, 2; 3, 4; 5, 6];
    [col1, col2] = Obj.prop_add(col);
    tester.verifyEqual(col1, col(:, 1));
    tester.verifyEqual(col2, col(:, 2));
    
    tester.verifyError(@lessNargout, "PropAdd:IsSize")
    tester.verifyError(@moreNargout, "PropAdd:IsSize")
end

function [out1, out2] = lessNargout()
    [out1, out2] = Obj.prop_add(["1" "2" "3"]);
end

function [out1, out2, out3] = moreNargout()
    [out1, out2, out3] = Obj.prop_add([1 2; 3, 4]);
end