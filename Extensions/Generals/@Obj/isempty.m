function tf = isempty(obj)
    empty = eval(class(obj)+".empty");
    origWarn = warning('off', 'MATLAB:structOnObject');
    try
        tf = isequaln(struct(obj), struct(empty));
    catch
        tf = isempty(obj);
    end
    if class(obj) == "string"
        tf = tf || obj == "";
    end
    warning(origWarn.state, 'MATLAB:structOnObject')
end