function fileName = getCallingFile(priorNth)
    traceback = struct2table(dbstack);
    if height(traceback) < 2
        fileName = "";
    else
        reqRow = traceback(priorNth+1, :);
        fileName = string(reqRow.file);
        fileName = erase(fileName, Warn.mExt);
    end
end
