    %%
%     key = Frmt.durKey;
%     str = "2months 1wk 660d";
%     
%     numInds = regexpi(str, "[0-9+]");
%     letInds = regexpi(str, "[A-Z+]");
%     nonInds = true(1, strlength(str));
%     
%     % nonInds(numInds) = false;
%     % nonInds(letInds) = false;
%     % splitInds = find(nonInds);
%     % indsPre = splitInds - 1;
%     % indsPost = splitInds + 1;
%     % parseInds = sort([indsPre, indsPost]);
%     % parseInds = [1 parseInds strlength(str)];
%     % txt = char(str);
%     %
%     % %%
%     % for irow = 1:height(key)
%     %     row = key.txtID{irow};
%     %     for itxt = 1:length(row)
%     %         jtxt = row{itxt};
%     %         new = getVal(str, jtxt)
%     %     end
%     % end
%     %
%     % function new = getVal(str, jtxt)
%     %     len = length(jtxt);
%     %     new = regexpi(str, jtxt);
%     %
%     % end