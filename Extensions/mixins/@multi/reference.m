function [propName, requests] = reference(self, requests)
    [propName, requests] = pickProp(self, requests);
    requests = cellfun(@self.makeSubs, num2cell(requests));
end

function [prop, requests] = pickProp(self, requests)
    if requests(1).type == "." && ismember(requests(1).subs, properties(self))
        prop = requests(1).subs;
        requests = structRequest(requests);
    else
        prop = 'values';
    end
end

function requests = structRequest(requests)
    if length(requests) == 1
        requests = struct("type", '()', "subs", {{':'}});
    else
        requests = requests(2:end);
    end
end