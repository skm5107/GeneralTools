function varargout = prop_add(prop)
    if size(prop, 2) == nargout
        for iout = 1:nargout
            varargout{iout} = prop(:, iout); %#ok<AGROW>
        end
    else
        Except(prop, "PropAdd").verifyDims([inf, 1]);
        varargout = deal(repmat(prop, [1, nargout]));
        varargout = num2cell(varargout, 1);
    end
end