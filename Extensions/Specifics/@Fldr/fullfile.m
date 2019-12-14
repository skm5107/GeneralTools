function fullpath = fullfile(varargin)
    if isempty(varargin)
        fullpath = "";
    else
        varargin(cellfun(@isempty, varargin)) = "";
        fullpath = fullfile(varargin{:});
    end
end