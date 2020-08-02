function cleaned = cleanPath(path)
    cleaned = strip(path, "/");
    cleaned = strip(cleaned, "\");
end