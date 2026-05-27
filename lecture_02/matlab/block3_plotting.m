%% BLOCK 3 — Plotting
% Lecture 2: MATLAB Summer Prep | NSBV BC2001
% -----------------------------------------------

%% Setup — recreate signal and threshold array from earlier blocks
t         = linspace(0, 1, 1000);
signal    = sin(2 * pi * 10 * t);
threshold = 0.5;
above     = zeros(1, length(signal));

for i = 1:length(signal)
    if signal(i) > threshold
        above(i) = signal(i);
    end
end

%% Basic plot
figure;
plot(t, signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Basic Plot of 10 Hz Sine Wave');

%% Styled plot — line color, width
figure;
plot(t, signal, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Styled 10 Hz Sine Wave');

%% Hold on — overlay two lines
figure;
plot(t, signal, 'b-', 'LineWidth', 1.5);
hold on;
plot(t, above, 'r-', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal with Threshold Crossings');
legend('Full Signal', 'Above Threshold');

%% Subplot — neuroscience-style multi-panel figure
figure;

subplot(2, 1, 1);
plot(t, signal, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('10 Hz Sine Wave');

subplot(2, 1, 2);
plot(t, above, 'r-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Values Above Threshold (0.5)');
