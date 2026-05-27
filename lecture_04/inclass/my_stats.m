function [avg, std_dev, max_val, peak] = my_stats(vec)

avg = mean(vec);
std_dev = std(vec);
max_val = max(vec);
peak = max(abs(vec));

end