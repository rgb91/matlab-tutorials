%% BLOCK 2 — Loops
% Lecture 2: MATLAB Summer Prep | NSBV BC2001
% -----------------------------------------------

%% Setup — recreate signal from Block 1
t      = linspace(0, 1, 1000);
signal = sin(2 * pi * 10 * t);

%% Basic FOR Loop
disp('Counting with a for loop:');
for i = 1:5
    disp(i);
end

%% FOR Loop with condition (IF inside)
% This is similar to spike threshold detection in electrophysiology
threshold = 0.5;
above     = zeros(1, length(signal));   % pre-allocate with zeros (good practice)

for i = 1:length(signal)
    if signal(i) > threshold
        above(i) = signal(i);           % keep values above threshold
    end
end

disp('Number of samples above threshold:');
disp(sum(above ~= 0));

%% WHILE Loop example
count = 0;
x     = 0;

while x < 1
    x     = x + 0.25;
    count = count + 1;
    fprintf('Step %d: x = %.2f\n', count, x);
end

%% BREAK and CONTINUE
disp('Break example — stop at 4:');
for i = 1:10
    if i == 4
        break;
    end
    disp(i);
end

disp('Continue example — skip even numbers:');
for i = 1:8
    if mod(i, 2) == 0
        continue;
    end
    disp(i);
end
