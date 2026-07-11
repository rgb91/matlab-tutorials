%% HOMEWORK EXERCISE 3 — SOLUTION: Exploration & Notebook
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% INSTRUCTOR USE ONLY — share with student after submission.

% NOTE: Run part1_matrices_forloops.m first to get base variables.

%% ── EXPERIMENT A — Scale to 16 channels ────────────────────────────────────

n_channels_A = 16;
fs_A = 500;
t_A  = 0 : 1/fs_A : 4 - 1/fs_A;
n_samples_A = length(t_A);

eeg_A = zeros(n_channels_A, n_samples_A);   % pre-allocate for 16 channels

for ch = 1 : n_channels_A
    amp_alpha = 1.5 + rand();
    amp_theta = 0.8 + 0.4*rand();
    noise_std = 0.2 + 0.1*rand();
    eeg_A(ch, :) = amp_alpha .* sin(2*pi*10*t_A) + ...
                   amp_theta .* sin(2*pi*6*t_A)  + ...
                   noise_std .* randn(1, n_samples_A);
end

% Call plot_eeg_stack WITHOUT changing the function file at all
plot_eeg_stack(eeg_A, t_A, 6, '16-Channel EEG Stack')

% ── NOTEBOOK ANSWER ──────────────────────────────────────────────────────────
% YES — plot_eeg_stack works unchanged for 16 channels.
% The key line is: n_channels = size(eeg_data, 1)
% This reads the row count from the actual input, so it automatically
% adapts to any number of channels. If n_channels = 8 were hard-coded,
% the function would only ever plot 8 rows even if given 16.

%% ── EXPERIMENT B — High noise, effect on findpeaks ─────────────────────────

fs_B = 500;
t_B  = 0 : 1/fs_B : 4 - 1/fs_B;

% Generate one noisy channel
noise_std_B = 1.5;
amp_alpha   = 2.0;
amp_theta   = 1.0;
ch_noisy = amp_alpha .* sin(2*pi*10*t_B) + ...
           amp_theta .* sin(2*pi*6*t_B)  + ...
           noise_std_B .* randn(1, length(t_B));

% Run findpeaks with dynamic threshold
threshold_B = mean(ch_noisy) + 1.5 * std(ch_noisy);
[pks_B, locs_B] = findpeaks(ch_noisy, t_B, ...
    'MinPeakHeight',   threshold_B, ...
    'MinPeakDistance', 0.08);

fprintf('High-noise: threshold = %.4f,  peaks found = %d\n', threshold_B, length(pks_B))

% Compare to low-noise channel 1 from earlier
threshold_low = mean(eeg(1,:)) + 1.5 * std(eeg(1,:));
[pks_low, ~] = findpeaks(eeg(1,:), t, ...
    'MinPeakHeight',   threshold_low, ...
    'MinPeakDistance', 0.08);
fprintf('Low-noise:  threshold = %.4f,  peaks found = %d\n', threshold_low, length(pks_low))

figure('Name', 'Experiment B: High-noise peak detection');
plot(t_B, ch_noisy, 'Color', [0.6 0.6 0.6]); hold on;
plot(locs_B, pks_B, 'rv', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
yline(threshold_B, '--k', 'Threshold');
xlabel('Time (s)'); ylabel('Amplitude');
title(sprintf('High noise (std=1.5) — %d peaks detected', length(pks_B)))
grid on;

% ── NOTEBOOK ANSWER ──────────────────────────────────────────────────────────
% The threshold DOES change — because std(ch_noisy) is much larger (≈1.5 vs ≈0.3).
% mean + 1.5*std scales up with the noise level, making the threshold higher.
% This is the whole point of a dynamic threshold: it adapts to the signal's
% variability. However with very high noise, true peaks may still be missed
% (buried under noise) or false peaks detected (noise spikes above threshold).

%% ── EXPERIMENT C — Remove MinPeakDistance ──────────────────────────────────

ch1 = eeg(1, :);
threshold_C = mean(ch1) + 1.5 * std(ch1);

% WITH MinPeakDistance
[pks_with, locs_with] = findpeaks(ch1, t, ...
    'MinPeakHeight',   threshold_C, ...
    'MinPeakDistance', 0.08);

% WITHOUT MinPeakDistance
[pks_without, locs_without] = findpeaks(ch1, t, ...
    'MinPeakHeight', threshold_C);

fprintf('WITH    MinPeakDistance=0.08:  %d peaks\n', length(pks_with))
fprintf('WITHOUT MinPeakDistance:       %d peaks\n', length(pks_without))

figure('Name', 'Experiment C: Effect of MinPeakDistance');
subplot(2,1,1)
plot(t, ch1, 'Color', [0.4 0.4 0.8]); hold on;
plot(locs_with, pks_with, 'rv', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
title(sprintf('WITH MinPeakDistance=0.08 — %d peaks', length(pks_with)))
xlabel('Time (s)'); grid on;

subplot(2,1,2)
plot(t, ch1, 'Color', [0.4 0.4 0.8]); hold on;
plot(locs_without, pks_without, 'rv', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
title(sprintf('WITHOUT MinPeakDistance — %d peaks', length(pks_without)))
xlabel('Time (s)'); grid on;

% ── NOTEBOOK ANSWER ──────────────────────────────────────────────────────────
% MATLAB's default MinPeakDistance is 0 samples — it will accept consecutive
% samples as separate peaks. This means small ripples on the side of a large
% peak can all be counted as individual peaks. The parameter enforces a minimum
% gap so that neighbouring local maxima on the same wave are not double-counted.

%% ── EXPERIMENT D — Auto-computed offset_scale ──────────────────────────────

% The signal amplitude range per channel ≈ max - min
% A robust auto-scale uses the maximum peak-to-peak range across all channels
channel_ranges = max(eeg, [], 2) - min(eeg, [], 2);  % max across columns, for each row
% max(eeg, [], 2) = column-wise max for each row → [8×1] vector

auto_offset = max(channel_ranges) * 1.2;   % 20% headroom between channels
fprintf('Automatic offset_scale = %.2f\n', auto_offset)

plot_eeg_stack(eeg, t, auto_offset, 'Auto-scaled EEG Stack')

% ── NOTEBOOK ANSWER ──────────────────────────────────────────────────────────
% max(eeg, [], 2) gives the maximum value in each row (channel).
% Subtracting min(eeg, [], 2) gives the amplitude range for each channel.
% Taking the maximum of those ranges and adding 20% headroom gives an
% offset that guarantees no two channels overlap, regardless of signal amplitude.
% This is a data-driven approach — offset_scale adapts to the actual signal.
