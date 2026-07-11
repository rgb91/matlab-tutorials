function output = classify_band(freq)
    if freq < 4
        output = 'Delta';
    elseif freq < 8
        output = 'Theta';
    elseif freq < 13
        output = 'Alpha';
    elseif freq < 30
        output = 'Beta';
    elseif freq < 80
        output = 'Gamma';
    else
        output = 'Unknown';
    end
end