%% ============================================================
%  WARM-UP SOLUTIONS  |  Lesson 5
% ============================================================

%% TASK 1: Squares
squares = zeros(1, 10);
for k = 1:10
    squares(k) = k^2;
end
disp(squares)
% 1  4  9  16  25  36  49  64  81  100


%% TASK 2: Evens and Odds
evens = [];
odds  = [];
for k = 1:30
    if mod(k, 2) == 0
        evens = [evens, k];
    else
        odds = [odds, k];
    end
end
fprintf('Evens: %d values\n', length(evens))
fprintf('Odds:  %d values\n', length(odds))


%% TASK 3: Doubling
x     = 1;
count = 0;
while x <= 1000
    x     = x * 2;
    count = count + 1;
end
fprintf('Final value: %d   Steps taken: %d\n', x, count)
% 1024 after 10 steps


%% TASK 4: Multiplication Table
M = zeros(5, 5);
for i = 1:5
    for j = 1:5
        M(i, j) = i * j;
    end
end
disp(M)
figure;
imagesc(M); colorbar;
title('Multiplication Table');
xlabel('j'); ylabel('i');


%% TASK 5: Sine Signal
Fs = 256;   % sampling rate
T = 2;      % duration
t  = 0 : 1/Fs : T - 1/Fs;
N  = length(t);
Freq = 8;

signal = zeros(1, N);
for k = 1:N
    signal(k) = sin(2*pi * Freq * t(k));
end
figure;
plot(t, signal, 'b', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amplitude');
title('8 Hz Alpha Wave'); grid on;
