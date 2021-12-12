function tf = loop(str, patVect, hndl)
    tf = false(size(patVect));
    for ipat = 1:length(patVect)
        tf(ipat) = hndl(str, patVect(ipat)) || hndl(patVect(ipat), str);
    end
end