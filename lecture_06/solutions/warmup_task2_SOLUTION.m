%% WARMUP TASK 2 — SOLUTION: Reconstruct the Synthetic EEG Script
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% INSTRUCTOR USE ONLY — share with student after the task.

% ── STEP 1: Time vector ──────────────────────────────────────────────────────
fs = 500;                      % sampling rate in Hz
t  = 0 : 1/fs : 2 - 1/fs;    % 2-second vector: 0, 0.002, 0.004, ... 1.998
                               % length(t) = 1000 samples

% ── STEP 2: Sine waves ───────────────────────────────────────────────────────
alpha_wave = 2 .* sin(2*pi*10*t);   % 10 Hz, amplitude 2
theta_wave = 1 .* sin(2*pi*6*t);    % 6 Hz,  amplitude 1

% ── STEP 3: Gaussian noise ───────────────────────────────────────────────────
noise = 0.3 .* randn(1, length(t));
% randn() = Gaussian (normal) distribution, mean 0, std 1
% Multiply by 0.3 to scale std to 0.3

% ── STEP 4: Combined signal ──────────────────────────────────────────────────
eeg_signal = alpha_wave + theta_wave + noise;

% ── STEP 5: 4-panel subplot ──────────────────────────────────────────────────
figure('Name', 'Synthetic EEG Components', 'NumberTitle', 'off');

subplot(4, 1, 1)
plot(t, alpha_wave, 'Color', [0.2 0.4 0.8])
title('Alpha wave (10 Hz)')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4, 1, 2)
plot(t, theta_wave, 'Color', [0.8 0.4 0.2])
title('Theta wave (6 Hz)')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4, 1, 3)
plot(t, noise, 'Color', [0.5 0.5 0.5])
title('Gaussian noise (std = 0.3)')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4, 1, 4)
plot(t, eeg_signal, 'Color', [0.1 0.6 0.3])
title('Combined signal (alpha + theta + noise)')
xlabel('Time (s)')
ylabel('Amplitude')

sgtitle('Session 6 Reconstruction — Synthetic EEG')

% ── THINGS TO CHECK IN STUDENT CODE ─────────────────────────────────────────
% ✓  .* used for element-wise multiply (NOT *)
% ✓  subplot(4,1,n) — 4 rows, 1 column, panel n
% ✓  xlabel / ylabel / title on every panel
% ✓  Time vector defined BEFORE sine wave calculations
% ✓  randn() for Gaussian noise (NOT rand() which is uniform)
