function celled = cellify(content, varargin)
    if iscell(content)
        celled = content;
    elseif ischar(content)
        celled = num2cell(string(content), varargin{:});
    else
        celled = num2cell(content, varargin{:});
    end
end