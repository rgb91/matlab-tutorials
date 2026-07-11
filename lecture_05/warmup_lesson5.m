%% ============================================================
%  WARM-UP  |  Lesson 5
%  Topic: Loops, Conditionals & Vectors
%  Duration: ~30 minutes
%  Run each section with Ctrl+Enter (Run Section)
% ============================================================

%% ---- TASK 1: Build a vector with a loop  (~ 5 min) ---------
% Create a vector called 'squares' where squares(k) = k^2
% for k = 1 to 10. Print the result.

disp('--- Task 1: Squares ---')

squares = zeros(1, 10);   % pre-allocate
for k = 1:10
    % YOUR CODE HERE:

end
disp(squares)

% Expected: 1  4  9  16  25  36  49  64  81  100


%% ---- TASK 2: Loop + Conditional  (~ 6 min) -----------------
% Loop through the numbers 1 to 30.
% Build two separate vectors:
%   evens  — numbers divisible by 2
%   odds   — numbers NOT divisible by 2
% Print how many values are in each.

disp('--- Task 2: Evens and Odds ---')

evens = [];
odds  = [];

for k = 1:30
    if mod(k, 2) == 0
        % YOUR CODE: append k to evens
        % Hint: evens = [evens, k];

    else
        % YOUR CODE: append k to odds

    end
end

fprintf('Evens: %d values\n', length(evens))
fprintf('Odds:  %d values\n', length(odds))


%% ---- TASK 3: While loop + accumulator  (~ 6 min) -----------
% Start with x = 1. Keep doubling x until it exceeds 1000.
% Count how many doublings it takes. Print x and the count.

disp('--- Task 3: Doubling ---')

x     = 1;
count = 0;

while x <= 1000
    % YOUR CODE: double x and increment count

end

fprintf('Final value: %d   Steps taken: %d\n', x, count)

% Expected: 1024 after 10 steps


%% ---- TASK 4: Nested loops  (~ 7 min) -----------------------
% Create a 5x5 matrix called M where M(i,j) = i * j
% (a multiplication table). Use a nested for-loop.
% Then plot it using imagesc(M) and add a colorbar.

disp('--- Task 4: Multiplication Table ---')

M = zeros(5, 5);

for i = 1:5
    for j = 1:5
        % YOUR CODE:

    end
end

disp(M)

figure;
imagesc(M);
colorbar;
title('Multiplication Table');
xlabel('j'); ylabel('i');


%% ---- TASK 5: Build a signal vector  (~ 6 min) --------------
% Create a sine signal using a loop:
%   Fs = 256, T = 2 seconds
%   signal(k) = sin(2*pi * 8 * t(k))   [8 Hz = alpha band]
% Pre-allocate signal as zeros before the loop.
% Plot the result.

disp('--- Task 5: Build a Sine Signal ---')

Fs = 256;
T  = 2;
t  = 0 : 1/Fs : T - 1/Fs;
N  = length(t);

signal = zeros(1, N);

for k = 1:N
    % YOUR CODE:

end

figure;
plot(t, signal, 'b', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amplitude');
title('8 Hz Alpha Wave');
grid on;

% BONUS: Change the frequency to 4 Hz (theta) and 20 Hz (beta).
%        What changes? What stays the same?
