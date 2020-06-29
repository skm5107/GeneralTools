function multed = multify(input)
    if ~ismember("multi", Obj.allclasses(input))
        multed = multi(input);
    else
        multed = input;
    end
end