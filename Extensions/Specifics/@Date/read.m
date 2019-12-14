function dats = read(strs, varargin)
    if all(class(strs) == "datetime")
        dats = strs;
    else
        dats = cellfun(@(jstr) doSingle(strs, varargin{:}), strs);
    end
end

function dat = doSingle(str, varargin)
    if ~Val.isFull(str) || ismember(str, ["NAT", "NaT", "nat", "", "[]", "NaN", "nan", "NAN", "#", "." "missing" "empty"])
        dat = NaT;
    else
        frmt = recognize_format(str);
        try
            dat = datetime(str, "InputFormat", frmt);
        catch
            dat = datetime(str);
        end
    end
end

function frmt = recognize_format(str)
    divOptions = [" ", "-" "/"];
    div_ind = Str.contains(divOptions, str);
    div = divOptions(div_ind);
    assert(length(div) <= 1, "Date:Delimiter", "Use only one delimiter type per date format");
    
    parsed = split(str, div);
    
    switch length(parsed)
        case 1
            frmt = recYear(parsed);
        case 2
            frmt = recognize2divs(parsed, div);
        case 3
            frmt = recognize3divs(parsed, div);
        otherwise
            assert(false, "Date:Format", sprintf("Unrecogonized Date Format: %s", str));
    end
end

function frmt = recognize2divs(parsed, div)
    isDayMth = Num.isnum(parsed(1));
    if isDayMth
        frmt = "dd";
        frmt = frmt + div + "MM";
    else
        frmt = "MM";
        frmt = frmt + div + recYear(parsed(2));
    end
end

function frmt = recognize3divs(parsed, div)
    isDayFirst = Num.isnum(parsed(1));
    if isDayFirst
        frmt = "dd";
        frmt = frmt + div + "MM";
    else
        frmt = "MM";
        frmt = frmt + div + "dd";
    end
    frmt = frmt + div + recYear(parsed(3));
end

function frmt = recYear(orig)
    if Str.length(orig) > 2
        frmt = "yyyy";
    else
        frmt = "yy";
    end
end