function multed = allLabel(values, label)
    labels = repmat(label, [1, length(values)]);
    multed = multi(values, labels);
end
