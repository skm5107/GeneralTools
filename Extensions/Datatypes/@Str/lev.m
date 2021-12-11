function dist = lev(str1, str2)
% Levenshtein distance between strings or char arrays.
% lev(s,t) is the number of deletions, insertions,
% or substitutions required to transform s to t.
% https://en.wikipedia.org/wiki/Levenshtein_distance

    str1 = char(str1);
    str2 = char(str2);
    m = length(str1);
    n = length(str2);
    x = 0:n;
    y = zeros(1,n+1);   
    for i = 1:m
        y(1) = i;
        for j = 1:n
            c = (str1(i) ~= str2(j)); % c = 0 if chars match, 1 if not.
            y(j+1) = min([y(j) + 1
                          x(j+1) + 1
                          x(j) + c]);
        end
        % swap
        [x,y] = deal(y,x);
    end
    dist = x(n+1);
end