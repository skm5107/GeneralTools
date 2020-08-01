function tf = strloop(strVect, str, hndl)
    tf = false(size(strVect));
    for istr = 1:length(strVect)
        tf(istr) = hndl(str, strVect(istr)) || hndl(strVect(istr), str);
    end
end