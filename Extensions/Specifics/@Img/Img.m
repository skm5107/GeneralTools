classdef Img
    methods (Static)
        function rescaled = scaleAndSave(origList, scaler)
            rescaled = cell([1, length(origList)]);
            for ifile = 1:length(origList)
                raw = imread(origList(ifile));
                rescaled{ifile} = imresize(raw, scaler);
                imwrite(rescaled{ifile}, origList(ifile), 'Transparency', [0 0 0]);
            end
        end
    end
end