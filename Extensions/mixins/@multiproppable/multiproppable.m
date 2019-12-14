classdef (HandleCompatible) multiproppable < matlab.mixin.CustomDisplay
    methods (Access = protected)
        propgrp = getPropertyGroups(self)
    end
end