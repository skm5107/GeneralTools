function pausePrompt
    dispTxt = "Press Any Key...";
    dispPrompt = annotation('textbox', [0.15 0.9 0 0], 'String', dispTxt, 'FitBoxToText','on', 'EdgeColor', 'none');
    Plt.sdf()
    pause;
    delete(dispPrompt);
end