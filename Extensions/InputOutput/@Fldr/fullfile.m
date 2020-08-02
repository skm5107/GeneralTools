function fullpath = fullfile(varargin)
    for iprt = 1:length(varargin)
        if isempty(varargin{iprt})
            varargin{iprt} = "";
        end
    end
    if isempty(varargin)
        varargin = {""};
    end
    fullpath = fullfile(varargin{:});
end