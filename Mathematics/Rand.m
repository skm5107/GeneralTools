classdef Rand
    % Static methods for randomization
    methods (Static)
        function selection = select(choices, num)
            scramble = randperm(length(choices));
            selection = choices(scramble(1:num));
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