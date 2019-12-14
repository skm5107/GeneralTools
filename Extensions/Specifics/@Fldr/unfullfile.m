function [pathVect, folderVect, fileName] = unfullfile(folders)
    folders = string(folders);
    folders = strip(folders, 'both', '\');
    folders = strip(folders, 'both', '/');
    
    pathVect = cell(size(folders));
    folderVect = cell(size(folders));
    fileName = strings(size(folders));
    for ifldr = 1:size(folders, 1)
        [pathVect{ifldr}, folderVect{ifldr}, fileName(ifldr)] = folder1_parse(folders(ifldr));
    end
end

function [pathVect, folderVect, fileName] = folder1_parse(folder)
    pathVect = strsplit(folder, ["/" "\"]);
    
    folderVect = pathVect(1:end-1);
    folderVect(isempty(folderVect)) = "";
    
    fileName = pathVect(:, end);
end