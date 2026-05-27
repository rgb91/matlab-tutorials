%% ============================================================
%  MATLAB WARM-UP  |  Lesson 4  |  Loops & Conditionals
%  Duration: ~30 minutes
%  Work through each section top to bottom.
%  Run each block with Ctrl+Enter (Run Section).
% ============================================================

%% ---- TASK 1: Count & Print  (~ 5 min) ----------------------
% Print the numbers 1 to 10, each on its own line.
% Then modify the loop to print only EVEN numbers from 1 to 20.

disp('--- Task 1: Count & Print ---')

% Starter: print 1 to 10
for k = 1:10
    fprintf('%d\n', k);
end

% YOUR TURN: Change the loop above so it prints 2, 4, 6 ... 20
% Hint: think about the step value in start:step:stop


%% ---- TASK 2: Running Total  (~ 5 min) ----------------------
% Use a for-loop to compute the sum of numbers from 1 to 100.
% Compare your answer to MATLAB's built-in: sum(1:100)

disp('--- Task 2: Running Total ---')

total = 0;
for k = 1:100
    total = total + k;
end
fprintf('My loop sum: %d\n', total);
fprintf('Built-in sum: %d\n', sum(1:100));

% YOUR TURN: Change it to compute the sum of SQUARES: 1^2 + 2^2 + ... + 10^2


%% ---- TASK 3: While Loop Countdown  (~ 5 min) ---------------
% Use a WHILE loop to count DOWN from 10 to 1, then print 'Go!'

disp('--- Task 3: While Loop Countdown ---')

n = 10;
while n >= 1
    fprintf('%d...\n', n);
    n = n - 1;
end
disp('Go!')

% YOUR TURN: Modify the while loop so it stops early if n == 5
% (use break or an if statement inside the loop)


%% ---- TASK 4: Loops + Conditionals  (~ 8 min) ---------------
% For each number 1-20, print:
%   "buzz"  if divisible by 3
%   "fizz"  if divisible by 5
%   "buzzfizz" if divisible by both
%   the number itself otherwise

disp('--- Task 4: BuzzFizz ---')

for k = 1:20
    if mod(k, 3) == 0 && mod(k, 5) == 0
        disp('buzzfizz')
    elseif mod(k, 3) == 0
        disp('buzz')
    elseif mod(k, 5) == 0
        disp('fizz')
    else
        fprintf('%d\n', k)
    end
end

% YOUR TURN: Extend the range to 1-50. How many "buzzfizz" values are there?
% Store the count in a variable called buzzfizz_count.


%% ---- TASK 5: Building a Vector in a Loop  (~ 7 min) --------
% Create a vector called 'signal' where:
%   signal(k) = sin(k * 0.3)   for k = 1 to 50
% Then plot the result.

disp('--- Task 5: Build & Plot a Sine Signal ---')

N = 50;
signal = zeros(1, N);       % pre-allocate — good habit!

for k = 1:N
    signal(k) = sin(k * 0.3);
end

figure;
plot(signal, 'b-o', 'MarkerSize', 4);
xlabel('Sample index');
ylabel('Amplitude');
title('My first signal from a loop');
grid on;

% YOUR TURN: Change the multiplier 0.3 to 0.1 and 0.8.
%            What changes in the plot? What neuroscience concept does
%            the multiplier control? (Think: frequency!)

% ============================================================
%  BONUS CHALLENGE (if you finish early):
%  Build TWO signals (sin and cos at the same frequency) in a 
%  single loop, then plot them together using 'hold on'.
% ============================================================
