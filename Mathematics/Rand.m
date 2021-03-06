classdef Rand
    methods (Static)
        function tf = log(frac_true)
            if nargin < 1
                frac_true = 0.5;
            end
            if rand() < frac_true
                tf = true;
            else
                tf = false;
            end
        end
        
        function [selection, inds] = select(choices, num)
            inds = Rand.btwn(1:length(choices), [1 num], 0);
            selection = choices(inds);
            
        end
        
        function shuffled = shuffled(rows)
            inds = randperm(height(rows));
            shuffled = rows(inds,:);
        end
        
        function nums = btwn(bounds, sz, decimals)            
            if nargin < 2 || isempty(sz)
                sz = [1 1];
            end
            if nargin < 3
                decimals = 0;
            end
            
            upper = max(bounds);
            lower = min(bounds);
            nums = (upper-lower).*rand(sz) + lower;
            
            if ~isempty(decimals)
                nums = round(nums, decimals);
            end
        end
    end
end