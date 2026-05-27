%% TAKE-HOME ASSIGNMENT — Noisy Neuron Simulator
% Lecture 3: MATLAB Summer Prep | NSBV BC2001
% -----------------------------------------------
% This script simulates a simple noisy neural recording across three
% "trials", computes statistics, smooths the data, and produces a
% clean multi-panel figure. It brings together functions, noise,
% statistics, and publication-quality plotting from Lecture 3.
% -----------------------------------------------

clc; clearvars;

%% Parameters
fs          = 1000;          % sampling frequency (Hz)
duration    = 2;             % seconds
t           = linspace(0, duration, fs * duration);
n_trials    = 3;
freq_hz     = 8;             % alpha-band signal
noise_level = 0.6;

%% Step 1 — Generate three noisy trials using a function
% Each trial has the same underlying signal but different noise
trials = zeros(n_trials, length(t));   % pre-allocate: rows = trials, cols = samples

for trial = 1:n_trials
    trials(trial, :) = generate_trial(t, freq_hz, noise_level);
end

%% Step 2 — Compute trial average (like event-related averaging in EEG)
trial_average = mean(trials, 1);   % mean across rows (across trials)

%% Step 3 — Smooth the average using a moving average
smoothed_avg = movmean(trial_average, 30);

%% Step 4 — Compute and display statistics for each trial
fprintf('%-10s %-10s %-10s %-10s\n', 'Trial', 'Mean', 'Std Dev', 'Max');
fprintf('%s\n', repmat('-', 1, 44));
for trial = 1:n_trials
    fprintf('%-10d %-10.4f %-10.4f %-10.4f\n', ...
        trial, mean(trials(trial,:)), std(trials(trial,:)), max(trials(trial,:)));
end

%% Step 5 — Publication-quality figure with 3 panels
fig = figure;
fig.Position = [100 100 1000 700];

% Panel 1: All individual trials (overlaid)
subplot(3,1,1);
colors = {[0.6 0.6 0.9], [0.9 0.6 0.6], [0.6 0.9 0.6]};
for trial = 1:n_trials
    plot(t, trials(trial,:), 'Color', colors{trial}, 'LineWidth', 0.8);
    hold on;
end
hold off;
ylabel('Amplitude'); title('Individual Trials (3 repetitions)');
legend('Trial 1','Trial 2','Trial 3', 'Location', 'northeast');
box off;

% Panel 2: Trial average + smoothed average
subplot(3,1,2);
plot(t, trial_average, 'Color', [0.7 0.7 0.7], 'LineWidth', 0.8);
hold on;
plot(t, smoothed_avg,  'b-', 'LineWidth', 2);
hold off;
ylabel('Amplitude'); title('Trial Average (grey) and Smoothed Average (blue)');
legend('Raw average', 'Smoothed');
box off;

% Panel 3: Histogram of the smoothed average values
subplot(3,1,3);
histogram(smoothed_avg, 35, 'FaceColor', [0.3 0.5 0.8], 'EdgeColor', 'white');
xlabel('Amplitude'); ylabel('Count');
title('Distribution of Smoothed Average Values');
xline(mean(smoothed_avg), 'r--', 'LineWidth', 1.5, 'Label', sprintf('Mean = %.2f', mean(smoothed_avg)));
box off;

sgtitle(sprintf('Simulated %d Hz Neural Signal — %d Trials', freq_hz, n_trials), 'FontSize', 14);

%% Step 6 — Save the figure
saveas(fig, 'noisy_neuron_simulator.png');
fprintf('\nFigure saved: noisy_neuron_simulator.png\n');

% -----------------------------------------------
% LOCAL FUNCTION
% -----------------------------------------------
function y = generate_trial(t, freq, noise_level)
    % generate_trial  Create a noisy sine wave trial
    %   t           : time vector (s)
    %   freq        : signal frequency (Hz)
    %   noise_level : standard deviation of Gaussian noise
    %   y           : noisy signal
    clean = sin(2 * pi * freq * t);
    noise = noise_level * randn(size(t));
    y     = clean + noise;
end
