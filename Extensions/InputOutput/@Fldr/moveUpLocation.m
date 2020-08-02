function [startLoc, wantLoc] = moveUpLocation(wantFolder)
    Except(wantFolder).verifyClass("string");
    
    startLoc = pwd;
    locVect = Fldr.unfullfile(startLoc);
    locVect = locVect{:};
    wantLevel = find(locVect == wantFolder);
    wantLoc = fullfile(locVect{1:wantLevel});
    cd(wantLoc)
end
