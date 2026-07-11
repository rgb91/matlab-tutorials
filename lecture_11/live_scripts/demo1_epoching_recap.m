%% DEMO 1: EPOCHING RECAP — TWO CONDITIONS
%  Session 11 — 1 July 2026
%  MATLAB concepts: epoch extraction, baseline correction, trial averaging
%  Neuroscience context: comparing ERPs between two conditions
%  ─────────────────────────────────────────────────────────────────────
%
%  Last session we cut epochs around events, baseline-corrected, and
%  averaged to get ONE ERP. Today the recording has TWO kinds of event:
%  'standard' tones and 'target' (oddball) tones. We will build an ERP
%  for EACH condition — then later ask: is the difference real? (stats!)

%% 1A — Load continuous data with labelled events
load('data/continuous_eeg.mat');
% Variables: data (2×N), fs, ch_names, time,
%            event_samples, event_times, event_type (1=standard 2=target),
%            cond_names = {'standard','target'}
fs = double(fs);

n_events = length(event_samples);
n_std    = sum(event_type == 1);
n_tgt    = sum(event_type == 2);
fprintf('Recording: %d channels, %.1f s\n', size(data,1), size(data,2)/fs);
fprintf('Events: %d total (%d standard, %d target)\n', n_events, n_std, n_tgt);

%% 1B — Visualise continuous Pz trace with colour-coded events
ch = 2;  % Pz shows the response best
figure;
plot(time, data(ch,:), 'Color', [0.3 0.3 0.3]); hold on;
for i = 1:n_events
    if event_type(i) == 1
        xline(event_times(i), 'b--');   % standard = blue
    else
        xline(event_times(i), 'r-', 'LineWidth', 1.2);  % target = red
    end
end
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title(sprintf('Continuous %s — standard (blue) vs target (red)', ch_names{ch}));
xlim([0 5]);

%% 1C — Define the epoch window (same recipe as Session 10)
pre_stim  = 0.1;    % 100 ms baseline
post_stim = 0.3;    % 300 ms post-stimulus
pre_samples  = round(pre_stim  * fs);
post_samples = round(post_stim * fs);
epoch_length = pre_samples + post_samples;
epoch_time   = linspace(-pre_stim, post_stim, epoch_length);
fprintf('\nEpoch window: %d samples (%.0f ms to +%.0f ms)\n', ...
    epoch_length, -pre_stim*1000, post_stim*1000);

%% 1D — Extract and baseline-correct all epochs, split by condition
epochs_std = [];   % trials × samples
epochs_tgt = [];
baseline_idx = epoch_time < 0;

for trial = 1:n_events
    s = event_samples(trial) - pre_samples;
    e = s + epoch_length - 1;
    if s < 1 || e > size(data,2)      % boundary check
        continue;
    end
    seg = data(ch, s:e);
    seg = seg - mean(seg(baseline_idx));   % baseline correction
    if event_type(trial) == 1
        epochs_std(end+1, :) = seg;        %#ok<SAGROW>
    else
        epochs_tgt(end+1, :) = seg;        %#ok<SAGROW>
    end
end
fprintf('Extracted %d standard and %d target epochs\n', ...
    size(epochs_std,1), size(epochs_tgt,1));
% NOTE: your homework function extract_epochs.m does exactly this cutting +
% baseline step — you could call it here instead of the inline loop.

%% 1E — Average each condition → two ERPs
erp_std = mean(epochs_std, 1);
erp_tgt = mean(epochs_tgt, 1);

figure;
% single trials faint in the background
plot(epoch_time*1000, epochs_std', 'Color', [0.7 0.7 1.0]); hold on;
plot(epoch_time*1000, epochs_tgt', 'Color', [1.0 0.7 0.7]);
% bold averages on top
h1 = plot(epoch_time*1000, erp_std, 'b', 'LineWidth', 2.5);
h2 = plot(epoch_time*1000, erp_tgt, 'r', 'LineWidth', 2.5);
xline(0, 'k--', 'Stimulus'); yline(0, 'k:');
xlabel('Time relative to stimulus (ms)'); ylabel('Amplitude (\muV)');
title(sprintf('ERP at %s — standard vs target', ch_names{ch}));
legend([h1 h2], {'Standard ERP', 'Target ERP'}, 'Location', 'northwest');
% The target ERP peaks higher around 100-150 ms. Is that difference real?

%% 1F — Measure the response: peak amplitude per trial
%  We summarise each epoch by ONE number: its peak in the 50-250 ms window.
%  These per-trial numbers are what we will run statistics on next.
peak_win = epoch_time >= 0.05 & epoch_time <= 0.25;
peaks_std = max(epochs_std(:, peak_win), [], 2);   % column vector
peaks_tgt = max(epochs_tgt(:, peak_win), [], 2);

fprintf('\nPeak amplitude (50-250 ms):\n');
fprintf('  standard: mean=%.2f uV  (n=%d)\n', mean(peaks_std), numel(peaks_std));
fprintf('  target  : mean=%.2f uV  (n=%d)\n', mean(peaks_tgt), numel(peaks_tgt));

% Save these for the t-test demo (demo3) if you want to chain them:
% save('data/condition_peaks.mat', 'peaks_std', 'peaks_tgt');

%% 1G — Bridge to statistics
fprintf('\n=== BRIDGE TO STATS ===\n');
fprintf('The target peaks LOOK bigger. But is the difference real,\n');
fprintf('or just noise? That is exactly what a t-test answers (demo 3).\n');
fprintf('First we need to describe the data properly (demo 2).\n');
