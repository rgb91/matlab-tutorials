function output = my_mean(vec)
summation = 0;
n = length(vec);

for i = 1:n
    summation = summation + vec(i);
end
output = summation / n;
end