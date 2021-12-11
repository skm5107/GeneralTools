function position = datatip_select
    dcm_obj = datacursormode(gcf);
    set(dcm_obj,'DisplayStyle','datatip', 'SnapToDataVertex','off','Enable','on')
    
    cursor = []; tries = 0;
    while ~isfield(cursor, "Position") && tries < 10
        pause
        cursor = getCursorInfo(dcm_obj);
        tries = tries + 1;
    end
    position = cursor.Position;
    clear cursor
end