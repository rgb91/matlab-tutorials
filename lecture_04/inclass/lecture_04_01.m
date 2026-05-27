%% IF condition

x = 20;

remainder_3 = mod(x, 3);   % 2
remainder_5 = mod(x, 5);   % 0

if remainder_3 == 0 && remainder_5 == 0
    disp("buzzfizz")
elseif remainder_3 == 0
    disp("buzz")
elseif remainder_5 == 0
    disp("fizz")
else
    disp(x)
end


%% Function part 1

data1 = [-3, 7, 2, -9, 4, 6, -1, 8];
data2 = [7, 6, 9, 4, 6];

[a, b, c, d] = my_stats(data1);
% [avg, std_dev, max_val, peak] = my_stats([1,2,3]);

disp("avg " + a)
disp("std dev " + b)
disp("max val " + c)
disp("peak " + d)


% disp("avg " + avg)
% disp("std dev " + std_dev)
% disp("max val " + max_val)
% disp("peak " + peak)

% avg1 = my_mean(data1);
% avg2 = my_mean(data2);
% 
% disp("average " + avg1)
% disp("average " + avg2)
