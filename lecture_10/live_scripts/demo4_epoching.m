%% DEMO 4: EPOCHING & TRIAL-BASED ANALYSIS
%  Session 10 — 27 June 2026
%  MATLAB concepts: epoch extraction, baseline correction, trial averaging
%  Neuroscience context: Event-Related Potentials (ERPs)
%  ─────────────────────────────────────────────────────────────────────

%% 4A — What is an epoch?
%  Continuous EEG is one long recording. But experiments have EVENTS
%  (stimuli, button presses, etc.) at specific times.
%  An EPOCH is a short time window cut around each event.
%
%  Example: stimulus at time 2.5 s
%           epoch = data from 2.4 s to 2.8 s  (−100 ms to +300 ms)
%
%  The period BEFORE the stimulus (−100 to 0 ms) is the BASELINE.
%  We subtract the baseline mean to remove slow drifts.

%% 4B — Load continuous data with event markers
load('continuous_eeg.mat');
% Variables: data (2×2560), fs, ch_names, time, event_samples, event_times

fprintf('Continuous recording: %d channels, %d samples (%.1f s)\n', ...
    size(data,1), size(data,2), size(data,2)/fs);
fprintf('Number of events: %d\n', length(event_samples));
fprintf('First 5 event times: ');
fprintf('%.2f s  ', event_times(1:5));
fprintf('\n');

%% 4C — Visualise continuous data with event markers
ch = 1;  % Cz
figure;
plot(time, data(ch, :), 'b');
hold on;
% Draw vertical lines at each event
for i = 1:length(event_times)
    xline(event_times(i), 'r--', 'LineWidth', 0.5);
end
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title(sprintf('Continuous %s with Event Markers (red)', ch_names{ch}));
xlim([0 5]);  % zoom to first 5 seconds

%% 4D — Define the epoch window
%  We'll cut from 100 ms BEFORE to 300 ms AFTER each event.
pre_stim  = 0.1;   % seconds before stimulus (baseline)
post_stim = 0.3;   % seconds after stimulus

pre_samples  = round(pre_stim * fs);    % 26 samples
post_samples = round(post_stim * fs);   % 77 samples
epoch_length = pre_samples + post_samples;  % 103 samples total

% Epoch time axis (relative to stimulus at t=0)
epoch_time = linspace(-pre_stim, post_stim, epoch_length);

fprintf('\nEpoch window: %.0f ms before to %.0f ms after stimulus\n', ...
    pre_stim*1000, post_stim*1000);
fprintf('Epoch length: %d samples (%.1f ms)\n', epoch_length, ...
    epoch_length/fs*1000);

%% 4E — Extract epochs from continuous data
n_events = length(event_samples);
epochs = zeros(n_events, epoch_length);   % trials × samples

skipped = 0;
for trial = 1:n_events
    start_idx = event_samples(trial) - pre_samples;
    end_idx   = start_idx + epoch_length - 1;
    
    % Boundary check: make sure we don't go outside the data
    if start_idx < 1 || end_idx > size(data, 2)
        fprintf('  Skipping trial %d (out of bounds)\n', trial);
        skipped = skipped + 1;
        continue;
    end
    
    epochs(trial, :) = data(ch, start_idx:end_idx);
end

% Remove any skipped trials (rows of zeros)
if skipped > 0
    epochs = epochs(any(epochs, 2), :);
end
fprintf('Extracted %d epochs (skipped %d)\n', size(epochs,1), skipped);

%% 4F — Plot a few single trials
figure;
for i = 1:5
    subplot(5, 1, i);
    plot(epoch_time * 1000, epochs(i, :));  % time in ms
    xline(0, 'r--');                         % stimulus onset
    ylabel(sprintf('Trial %d', i));
    if i == 1
        title('Single Trials (first 5)');
    end
    if i == 5
        xlabel('Time relative to stimulus (ms)');
    end
end
% Notice: single trials are NOISY. That's why we average!

%% 4G — Baseline correction
%  Subtract the mean of the pre-stimulus period from each trial.
%  This removes slow voltage drifts so all trials start near zero.

baseline_idx = epoch_time < 0;   % logical index: samples before t=0
fprintf('\nBaseline uses %d samples (%.0f ms to 0 ms)\n', ...
    sum(baseline_idx), -pre_stim*1000);

epochs_bc = zeros(size(epochs));
for trial = 1:size(epochs, 1)
    baseline_mean = mean(epochs(trial, baseline_idx));
    epochs_bc(trial, :) = epochs(trial, :) - baseline_mean;
end

% Compare one trial before and after baseline correction
figure;
subplot(2,1,1);
plot(epoch_time*1000, epochs(1,:));
xline(0, 'r--'); yline(0, 'k:');
title('Trial 1 — Before Baseline Correction');
ylabel('Amplitude (\muV)');

subplot(2,1,2);
plot(epoch_time*1000, epochs_bc(1,:));
xline(0, 'r--'); yline(0, 'k:');
title('Trial 1 — After Baseline Correction');
xlabel('Time (ms)'); ylabel('Amplitude (\muV)');

%% 4H — Averaging across trials → ERP
%  The ERP is the MEAN across all trials.
%  Random noise cancels out; the consistent brain response remains.

erp = mean(epochs_bc, 1);   % average along rows (trials)

figure;
% Plot all single trials in light grey
for trial = 1:size(epochs_bc, 1)
    plot(epoch_time*1000, epochs_bc(trial,:), 'Color', [0.8 0.8 0.8]);
    hold on;
end
% Plot the ERP in bold blue on top
plot(epoch_time*1000, erp, 'b', 'LineWidth', 2.5);
xline(0, 'r--', 'Stimulus', 'LabelVerticalAlignment', 'bottom');
yline(0, 'k:');
xlabel('Time relative to stimulus (ms)');
ylabel('Amplitude (\muV)');
title(sprintf('ERP at %s — Average of %d trials', ch_names{ch}, size(epochs_bc,1)));

%% 4I — Putting it all together: the epoching recipe
fprintf('\n=== EPOCHING RECIPE ===\n');
fprintf('1. Define epoch window (pre_stim, post_stim)\n');
fprintf('2. Loop through event_samples\n');
fprintf('3. Extract segment: data(start:end)\n');
fprintf('4. Check boundaries, skip if out of range\n');
fprintf('5. Baseline correct: subtract mean of pre-stimulus period\n');
fprintf('6. Average across trials → ERP\n');
fprintf('========================\n');
