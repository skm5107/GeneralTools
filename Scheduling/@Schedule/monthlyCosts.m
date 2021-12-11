function mthly = monthlyCosts(self)
    mthly = table();
    for itask = 1:length(self.Tasks)
        mthly = doTask(mthly, self.Tasks(itask));
    end
    
    mthly = reorderRows(mthly);
end

function mthly = doTask(mthly, JTask)
    jfin = getPeriod(JTask.When.finish);
    for iprice = 1:length(JTask.Price)
        mthly = doPrice(mthly, jfin, JTask.Price(iprice));
    end
end

function mthly = doPrice(mthly, jfin, JPrice)
    jcost = JPrice.base;
    jtype = getType(JPrice.type);
    mthly = insertCost(mthly, jfin, jtype, jcost);
end

function jpd = getPeriod(jdate)
    if ~isnat(jdate)
        jmnth = string(month(jdate, 'shortname'));
        jyear = year(jdate);
        jyeartxt = char(string(jyear));
        jyr = string(jyeartxt(end-1:end));
        jpd = jmnth + jyr;
    else
        jpd = "missing";
    end
end

function type = getType(type)
    type = strrep(lower(string(type))," ", "_");
    type(ismissing(type)) = "undefined";
end

function mthly = insertCost(mthly, jfin, jtype, jcost)
    if ~isnan(jcost)
        try
            mthly{jfin, jtype} = mthly{jfin, jtype} + jcost;
        catch
            mthly{jfin, jtype} = jcost;
        end
    end
end

function mthly = reorderRows(mthly)
    rows = mthly.Properties.RowNames;
    dates = cellfun(@getDate, rows);
    [~, inds] = sort(dates);
    
    tmp = table();
    for irow = inds
        tmp = [tmp; mthly(irow, :)]; %#ok<AGROW>
    end
    mthly = tmp;
end

function ddate = getDate(txt)
    txt = char(txt);
    txt = [txt(1:end-2) '-' txt(end-1:end)];
    ddate = datetime(txt);
end