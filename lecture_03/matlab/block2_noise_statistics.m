%% BLOCK 2 — Noise, Signal Statistics & Basic Signal Processing
% Lecture 3: MATLAB Summer Prep | NSBV BC2001
% -----------------------------------------------
% Real neuroscience data is always noisy.
% EEG and electrophysiology recordings contain both signal and noise.
% Here we simulate that and learn to characterise what we have.

clc; clearvars;

%% 1. Adding Gaussian noise to a clean signal
t      = linspace(0, 1, 1000);
clean  = sin(2 * pi * 10 * t);         % clean 10 Hz signal

noise_level = 0.5;
noise       = noise_level * randn(size(clean));   % randn = random normal (Gaussian)
noisy       = clean + noise;

figure;
subplot(2,1,1);
plot(t, clean, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Clean Signal');

subplot(2,1,2);
plot(t, noisy, 'Color', [0.6 0.6 0.6], 'LineWidth', 0.8);
hold on;
plot(t, clean, 'b-', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)'); ylabel('Amplitude');
title('Noisy Signal (grey) vs Clean (blue)');
legend('Noisy', 'Clean');

%% 2. Descriptive statistics of the signal
fprintf('--- Signal Statistics ---\n');
fprintf('Mean:     %.4f\n', mean(noisy));
fprintf('Std Dev:  %.4f\n', std(noisy));
fprintf('Min:      %.4f\n', min(noisy));
fprintf('Max:      %.4f\n', max(noisy));
fprintf('Range:    %.4f\n', max(noisy) - min(noisy));

%% 3. Simple moving average (smoothing)
% Smoothing reduces noise — fundamental technique in EEG preprocessing
window_size = 20;                          % samples
smoothed    = movmean(noisy, window_size); % built-in moving average

figure;
plot(t, noisy,    'Color', [0.8 0.8 0.8], 'LineWidth', 0.8);
hold on;
plot(t, smoothed, 'r-', 'LineWidth', 2);
plot(t, clean,    'b--', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)'); ylabel('Amplitude');
title('Noisy vs Smoothed vs Clean Signal');
legend('Noisy', 'Smoothed', 'Clean');

%% 4. Signal-to-Noise Ratio (SNR)
signal_power = mean(clean .^ 2);
noise_power  = mean(noise .^ 2);
snr_val      = 10 * log10(signal_power / noise_power);
fprintf('\nSignal-to-Noise Ratio: %.2f dB\n', snr_val);

%% 5. Histogram of signal values
figure;
histogram(noisy, 40, 'FaceColor', [0.4 0.6 0.9], 'EdgeColor', 'white');
xlabel('Amplitude'); ylabel('Count');
title('Distribution of Signal Values');
xline(mean(noisy), 'r--', 'LineWidth', 2, 'Label', 'Mean');
