%% TAKE-HOME ASSIGNMENT — My First Neuroscience Signal
% Lecture 2: MATLAB Summer Prep | NSBV BC2001
% -----------------------------------------------
% This script simulates two brain rhythm sine waves (5 Hz and 12 Hz),
% combines them, detects values above a threshold, and produces a
% three-panel neuroscience-style figure.
% -----------------------------------------------

clc;
clearvars;

%% Step 1 — Create a 2-second time vector with 2000 samples
t = linspace(0, 2, 2000);   % 2 seconds, sampled at 1000 Hz

%% Step 2 — Create two sine waves and combine them
wave_5hz  = sin(2 * pi * 5  * t);   % 5 Hz — like a theta rhythm
wave_12hz = sin(2 * pi * 12 * t);   % 12 Hz — like an alpha/low-beta rhythm
combined  = wave_5hz + wave_12hz;    % sum of both waves

%% Step 3 — Threshold detection using a for loop
% Find values in the combined signal that exceed 0.8
threshold    = 0.8;
above_thresh = zeros(1, length(combined));   % pre-allocate

for i = 1:length(combined)
    if combined(i) > threshold
        above_thresh(i) = combined(i);   % keep value if above threshold
    end
end

%% Step 4 — Plot three subplots
figure;

% Panel 1: 5 Hz wave alone
subplot(3, 1, 1);
plot(t, wave_5hz, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('5 Hz Sine Wave (Theta-like Rhythm)');

% Panel 2: 12 Hz wave alone
subplot(3, 1, 2);
plot(t, wave_12hz, 'm-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('12 Hz Sine Wave (Alpha/Beta-like Rhythm)');

% Panel 3: Combined signal with threshold crossings in red
subplot(3, 1, 3);
plot(t, combined, 'k-', 'LineWidth', 1);
hold on;
plot(t, above_thresh, 'r.', 'MarkerSize', 6);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Combined Signal — Red dots = Above Threshold (0.8)');
legend('Combined Signal', 'Above Threshold');
