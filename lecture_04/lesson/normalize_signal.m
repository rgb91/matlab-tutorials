function z = normalize_signal(x)

z = (x - mean(x)) / std(x);

end