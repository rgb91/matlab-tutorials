%% =========================================================================
%  MATLAB Revision — Session 7  |  SOLUTIONS
%  NSBV BC2001 · Laboratory in Neuroscience  |  Barnard College
%  Date: 14 June 2025
%  =========================================================================
%  Covers: Sessions 1–6
%  Block A — Variables & Workspace          (Tasks 1–2)
%  Block B — Vectors, Matrices & Indexing   (Tasks 3–4)
%  Block C — Control Flow                   (Tasks 5–7)
%  Block D — Plotting & Visualisation       (Tasks 8–9)
%  Block E — Functions & Synthetic EEG      (Tasks 10–11, Challenge 12)
% =========================================================================
clc; clear; close all;

%% =========================================================================
%  BLOCK A — Variables & Workspace
%% =========================================================================

%% Task 1 — Variable Types & Arithmetic
% -----------------------------------------------------------------
fs       = 256;        % sampling frequency (Hz)
duration = 3;          % recording duration (seconds)

n_samples = fs * duration;   % total number of samples = 768

disp(['Total samples: ' num2str(n_samples)]);

% (d) class of n_samples
fprintf('Class of n_samples: %s\n', class(n_samples));
% Answer: double  (MATLAB default numeric type)

%% Task 2 — String Formatting with fprintf
% -----------------------------------------------------------------
channel_name = 'Oz';

fprintf('Recording from channel %s at %d Hz for %d seconds (%d samples).\n', ...
    channel_name, fs, duration, n_samples);

%% =========================================================================
%  BLOCK B — Vectors, Matrices & Indexing
%% =========================================================================

%% Task 3 — Time Vector & Signal Construction
% -----------------------------------------------------------------
% (a) Time vector  — two equivalent approaches shown
t = 0 : 1/fs : duration - 1/fs;       % colon operator  (length = fs*duration)
% t = linspace(0, duration - 1/fs, n_samples);  % linspace alternative

% (b) 10 Hz sine wave, amplitude 5 µV
alpha_wave = 5 * sin(2 * pi * 10 * t);

% (c) Verify dimensions
fprintf('\nSize of t:      %d x %d\n', size(t,1), size(t,2));
fprintf('Length of t:    %d\n', length(t));
fprintf('n_samples:      %d\n', n_samples);
% Both should equal 768

%% Task 4 — Matrix Operations on Multi-Channel Data
% -----------------------------------------------------------------
rng(42);  % fix random seed for reproducibility

% (a) 3 channels × 5 time points, ±50 µV scale
eeg_snippet = randn(3, 5) * 50;

fprintf('\neeg_snippet (3 ch × 5 samples):\n');
disp(eeg_snippet);

% (b) Channel 2 signal (second row)
ch2_signal = eeg_snippet(2, :);
fprintf('Channel 2 signal:\n');
disp(ch2_signal);

% (c) Mean amplitude across channels at time point 3
mean_at_t3 = mean(eeg_snippet(:, 3));
fprintf('Mean amplitude across channels at time point 3: %.2f µV\n', mean_at_t3);

% (d) Transpose
eeg_T = eeg_snippet';
fprintf('\nOriginal size: %d × %d  (channels × time)\n', size(eeg_snippet,1), size(eeg_snippet,2));
fprintf('Transposed size: %d × %d  (time × channels)\n', size(eeg_T,1), size(eeg_T,2));
% After transpose: rows = time points, columns = channels

%% =========================================================================
%  BLOCK C — Control Flow
%% =========================================================================

%% Task 5 — for Loop — Channel RMS Calculator
% -----------------------------------------------------------------
rng(1);
eeg4 = randn(4, 512) * 30;   % 4 channels × 512 samples

rms_values = zeros(1, 4);    % pre-allocate

for ch = 1:4
    rms_values(ch) = sqrt(mean(eeg4(ch, :).^2));
    fprintf('Channel %d RMS: %.2f uV\n', ch, rms_values(ch));
end

%% Task 6 — if / elseif / else — Artefact Classifier
% -----------------------------------------------------------------
fprintf('\n--- Artefact Classification ---\n');
for ch = 1:length(rms_values)
    if rms_values(ch) < 10
        fprintf('Channel %d: Low signal\n', ch);
    elseif rms_values(ch) <= 50
        fprintf('Channel %d: Normal\n', ch);
    else
        fprintf('Channel %d: Artefact detected\n', ch);
    end
end

%% Task 7 — while Loop — Running Mean Convergence
% -----------------------------------------------------------------
rng(5);
noise        = randn(1, 1000) * 20;
running_mean = Inf;
n            = 0;

while abs(running_mean) >= 1
    n            = n + 1;
    running_mean = mean(noise(1:n));
    if n >= length(noise)
        break   % safety exit to avoid infinite loop
    end
end

fprintf('\nRunning mean dropped below 1 µV after %d samples.\n', n);
fprintf('Final running mean: %.4f µV\n', running_mean);

%% =========================================================================
%  BLOCK D — Plotting & Visualisation
%% =========================================================================

%% Task 8 — Time-Domain EEG Plot
% -----------------------------------------------------------------
fs2       = 256;
t2        = 0 : 1/fs2 : 2 - 1/fs2;   % 2-second window
rng(10);
signal8   = 3*sin(2*pi*10*t2) + 1.5*sin(2*pi*40*t2) + randn(size(t2))*2;

figure('Name', 'Task 8 — EEG Time Domain', 'NumberTitle', 'off');
plot(t2, signal8, 'Color', [0.1 0.2 0.5], 'LineWidth', 1.5);
xlabel('Time (s)', 'FontSize', 12);
ylabel('Amplitude (µV)', 'FontSize', 12);
title('EEG Signal — Channel Oz', 'FontSize', 14);
grid on;
set(gca, 'FontSize', 12);

%% Task 9 — Subplots — Three EEG Frequency Bands
% -----------------------------------------------------------------
% Reuse t2 (2-second, 256 Hz)
delta_wave = 8 * sin(2*pi*3*t2);
alpha_sub  = 5 * sin(2*pi*10*t2);
gamma_wave = 2 * sin(2*pi*40*t2);

colours = {[0.18 0.40 0.70], [0.15 0.60 0.40], [0.75 0.25 0.15]};
bands   = {'Delta (3 Hz)', 'Alpha (10 Hz)', 'Gamma (40 Hz)'};
waves   = {delta_wave, alpha_sub, gamma_wave};

figure('Name', 'Task 9 — EEG Frequency Bands', 'NumberTitle', 'off');
for k = 1:3
    subplot(3, 1, k);
    plot(t2, waves{k}, 'Color', colours{k}, 'LineWidth', 1.5);
    ylabel('µV', 'FontSize', 11);
    title(bands{k}, 'FontSize', 12);
    grid on;
    set(gca, 'FontSize', 11);
    if k == 3
        xlabel('Time (s)', 'FontSize', 11);
    end
end
sgtitle('EEG Frequency Band Components', 'FontSize', 14, 'FontWeight', 'bold');

%% =========================================================================
%  BLOCK E — Functions & Synthetic EEG
%% =========================================================================

%% Task 10 — Write compute_snr.m and test it
% -----------------------------------------------------------------
% See compute_snr.m (separate function file, provided below)

t_snr      = 0 : 1/256 : 2 - 1/256;
clean_sig  = 5 * sin(2*pi*10*t_snr);

rng(20);
noisy_low  = clean_sig + randn(size(t_snr)) * 1;   % noise std = 1
noisy_high = clean_sig + randn(size(t_snr)) * 5;   % noise std = 5

snr_low  = compute_snr(clean_sig, noisy_low);
snr_high = compute_snr(clean_sig, noisy_high);

fprintf('\nSNR (noise std=1): %.2f dB\n', snr_low);
fprintf('SNR (noise std=5): %.2f dB\n', snr_high);

%% Task 11 — Synthetic EEG — Assemble & Analyse
% -----------------------------------------------------------------
fs11     = 256;
dur11    = 4;                              % 4 seconds
t11      = 0 : 1/fs11 : dur11 - 1/fs11;

rng(7);
eeg11 = 8*sin(2*pi*2*t11)  ...            % Delta  2 Hz
      + 5*sin(2*pi*6*t11)  ...            % Theta  6 Hz
      + 4*sin(2*pi*10*t11) ...            % Alpha  10 Hz
      + 2*sin(2*pi*20*t11) ...            % Beta   20 Hz
      + randn(size(t11)) * 3;             % White noise

% (b) Descriptive statistics
fprintf('\n--- Task 11 Signal Stats ---\n');
fprintf('Mean:  %.4f µV\n', mean(eeg11));
fprintf('Std:   %.4f µV\n', std(eeg11));
fprintf('Min:   %.4f µV\n', min(eeg11));
fprintf('Max:   %.4f µV\n', max(eeg11));

% (c) Threshold crossings using logical indexing
threshold   = 15;
exceed_mask = abs(eeg11) > threshold;     % logical array
n_crossings = sum(exceed_mask);
fprintf('\nSamples exceeding ±%d µV: %d\n', threshold, n_crossings);

t_crossings = t11(exceed_mask);           % time points of crossings

% (d) Plot signal with threshold crossings marked
figure('Name', 'Task 11 — Synthetic EEG', 'NumberTitle', 'off');
plot(t11, eeg11, 'Color', [0.1 0.2 0.5], 'LineWidth', 1.2); hold on;
plot(t_crossings, eeg11(exceed_mask), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
yline(threshold,  '--r', '+15 µV', 'LineWidth', 1.2, 'FontSize', 11);
yline(-threshold, '--r', '-15 µV', 'LineWidth', 1.2, 'FontSize', 11);
hold off;
xlabel('Time (s)',       'FontSize', 12);
ylabel('Amplitude (µV)', 'FontSize', 12);
title('Synthetic EEG with Threshold Crossings (±15 µV)', 'FontSize', 13);
legend('EEG signal', 'Threshold crossings', 'Location', 'northwest', 'FontSize', 11);
grid on;
set(gca, 'FontSize', 12);

%% Task 12 (Challenge) — Reusable EEG Generator Function
% -----------------------------------------------------------------
% See generate_eeg.m (separate function file, provided below)

noise_levels = [1, 5, 10];

figure('Name', 'Task 12 — generate_eeg() Comparison', 'NumberTitle', 'off');
for k = 1:3
    eeg_gen = generate_eeg(256, 4, noise_levels(k));
    t_gen   = 0 : 1/256 : 4 - 1/256;
    subplot(3, 1, k);
    plot(t_gen, eeg_gen, 'LineWidth', 1.1);
    ylabel('µV', 'FontSize', 11);
    title(sprintf('noise\\_std = %d µV', noise_levels(k)), 'FontSize', 12);
    grid on;
    set(gca, 'FontSize', 11);
    if k == 3
        xlabel('Time (s)', 'FontSize', 11);
    end
end
sgtitle('generate\_eeg() — Effect of Noise Level', 'FontSize', 14, 'FontWeight', 'bold');

fprintf('\nAll tasks complete.\n');
