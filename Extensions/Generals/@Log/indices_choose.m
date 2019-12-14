function [indsPass_ind, indsPass_tf] = indices_choose(acceptableInds, selectionsOfAcceptableSet)
    indsAll = find(acceptableInds);
    indsPass_ind = indsAll(logical(selectionsOfAcceptableSet));
    
    indsPass_tf = false(size(acceptableInds));
    indsPass_tf(indsPass_ind) = true;
end