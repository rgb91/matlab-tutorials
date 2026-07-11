%% Task 1 - build a vector of squares
% 1 4 9 16 25 36 49 64 81 100

squares = zeros(1, 10);

for k = 1:10
    squares(k) = k^2;
end

disp(squares)


%% Task 2 - Loop 1 to 30, build two separate vectors.
% even vector
% odd vector

even = [];
odd = [];

for i = 1:30
    remainder = mod(i, 2);
    if remainder == 0
        even = [even, i];
    else 
        odd = [odd, i];
    end
end

disp(even)
disp(odd)


%% Task 3 - While loop test
% Start with x = 1. Keep doubling x until it exceeds 1000.
% Count how many doublings it takes. Print x and the count.
x = 1;
counter = 0;

while x <= 1000
    x = x * 2;
    counter = counter + 1;
end

disp("x " + x)
disp("counter " + counter)



%% Task 4 - multiplication table/matrix
% 5x5 table, each cell will have product of row_pos * col_pos

% 1  2  3  4  5    -> for 1:5
% 2  4  6  8  10   -> for 1:5
% 3  6  9  12 15   -> for 1:5
% 4  8 12  16 20   -> for 1:5
% 5 10 15  20 25   -> for 1:5

% for 1 -> 5 (iterate rows)
%   for 1 -> 5 (iterate columns)
%       do things
%   end
% end

mat = zeros(5, 5);
for row_pos = 1:5      % outer -> iterate row
    for col_pos = 1:5  % inner -> iterate cols
        mat(row_pos, col_pos) = row_pos * col_pos;
    end
end

disp(mat)

figure;
imagesc(mat);
colorbar;
title('Multiplication table');
xlabel('row');
ylabel('col');


%% Task 5 - build a signal vector
% Create a sine signal using a loop:
%   Fs = 256, T = 2 seconds
%   signal(k) = sin(2*pi * 8 * t(k))   [8 Hz = alpha band]
% Pre-allocate signal as zeros before the loop.
% Plot the result.


Fs = 256;  % sampling rate
T = 2;     % duration

% 256 steps = 1 sec
% 1 step = 1/256 sec

t = 0 : 1/Fs : T;  % start : step/jump : end
disp(t)

alpha_freq = 8;
N = length(t);


signal = zeros(1, N);
for i = 1:N
    signal(i) = sin(2*pi * alpha_freq * t(i));
end

figure;
plot(t, signal, 'b', 'LineWidth', 1.2);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Alpha band 8 Hz Wave');
grid on;

%% Task 6 - function double_it
% double_it(5) -->> 10

% res = double_it(5);
% disp(res)


% classify_band(10) -->> 'Alpha'
disp(classify_band(500))