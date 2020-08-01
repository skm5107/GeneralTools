function buffered = buffer(bounds, buff)
    buffered(1) = min(bounds) - buff;
    buffered(2) = max(bounds) + buff;
end