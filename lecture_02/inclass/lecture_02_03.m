%% Loops

clc
clearvars

% freq = 1;
% t = linspace(0, 1, 1000);
% signal = sin(2*pi*t*freq);

% Without for loop
% i = 1:10;  % `i` is a list of numbers // vector // array
% disp(i)


% For Loop 
for i = 1:10  % `i` is an individual number going from 1 to 10
    disp(i);

    remainder = mod(i, 2);
    if remainder == 0
        disp("EVEN")
    end
end


