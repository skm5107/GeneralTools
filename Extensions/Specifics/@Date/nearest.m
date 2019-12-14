function nearest = nearest(orig, wantDay, dirFlag)
    if nargin < 3
        dirFlag = 0;
    else
        Except(dirFlag).verifyBtwnIncld([-1 0 1], "Date:nearest");
    end
    
    origNum = weekday(orig);
    wantNum = getwantNums(wantDay);
    add_days = closestNum_find(origNum, wantNum, dirFlag);
    nearest = orig + add_days;
end

function wantNum = getwantNums(weekday)
    if isnumeric(weekday)
        Except(weekday).verifyBtwnIncld(Date.days.dayNum, "Date:nearest");
        wantNum = weekday;
    else
        dayNum = Key.lookup(Date.days, weekday, "dayName", "dayNum");
        wantNum = dayNum{:,:};
    end
end

function add_days = closestNum_find(origNum, wantNum, dirFlag)
    fwd_days = wantNum - origNum;
    rev_days = -(height(Date.days) - origNum + wantNum + 1);
    
    if dirFlag == 0
        add_days = Abs.signedmin([fwd_days, rev_days]);
    elseif ((dirFlag == 1) && origNum < wantNum) || ((dirFlag == -1) && (wantNum < origNum))
        add_days = fwd_days;
    elseif dirFlag == 1
        add_days = -rev_days-1;
    elseif dirFlag == -1
        add_days = -rev_days - 2*height(Date.days) - 1;
        if add_days == -height(Date.days)
            add_days = 0;
        end
    end
end