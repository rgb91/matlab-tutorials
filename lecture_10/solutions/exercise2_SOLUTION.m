%% EXERCISE 2: Epoch Extraction & ERP — SOLUTION
%  Session 10 — 27 June 2026
%  ─────────────────────────────────────────────────────

%% 1: Load data
load('data/continuous_eeg.mat');
fprintf('Channels: %d, Samples: %d (%.1f s)\n', ...
    size(data,1), size(data,2), size(data,2)/fs);
fprintf('Number of events: %d\n', length(event_samples));

%% 2: Define epoch window
pre_stim  = 0.1;   % 100 ms before
post_stim = 0.3;   % 300 ms after

pre_samples  = round(pre_stim * fs);     % 26
post_samples = round(post_stim * fs);    % 77
epoch_length = pre_samples + post_samples; % 103

epoch_time = linspace(-pre_stim, post_stim, epoch_length);
fprintf('Epoch: %d samples (%.0f ms to +%.0f ms)\n', ...
    epoch_length, -pre_stim*1000, post_stim*1000);

%% 3: Extract epochs for channel 2 (Pz)
ch = 2;  % Pz
n_events = length(event_samples);
epochs = zeros(n_events, epoch_length);
valid = true(1, n_events);

for trial = 1:n_events
    start_idx = event_samples(trial) - pre_samples;
    end_idx   = start_idx + epoch_length - 1;
    
    if start_idx < 1 || end_idx > size(data, 2)
        fprintf('  Skipping trial %d (boundary)\n', trial);
        valid(trial) = false;
        continue;
    end
    
    epochs(trial, :) = data(ch, start_idx:end_idx);
end

epochs = epochs(valid, :);
fprintf('Extracted %d valid epochs.\n', size(epochs, 1));

%% 4: Baseline correction
baseline_idx = epoch_time < 0;
epochs_bc = zeros(size(epochs));

for trial = 1:size(epochs, 1)
    bl_mean = mean(epochs(trial, baseline_idx));
    epochs_bc(trial, :) = epochs(trial, :) - bl_mean;
end

%% 5: Compute ERP
erp = mean(epochs_bc, 1);

%% 6: Plot
figure;
for trial = 1:size(epochs_bc, 1)
    plot(epoch_time*1000, epochs_bc(trial,:), 'Color', [0.8 0.8 0.8]);
    hold on;
end
plot(epoch_time*1000, erp, 'b', 'LineWidth', 2.5);
xline(0, 'r--', 'Stimulus', 'LabelVerticalAlignment', 'bottom');
yline(0, 'k:');
xlabel('Time relative to stimulus (ms)');
ylabel('Amplitude (\muV)');
title(sprintf('ERP at %s — Average of %d trials', ch_names{ch}, size(epochs_bc,1)));
% Expected: ERP shows a clear peak ~100 ms post-stimulus
%   (the injected ERP template peaks at 100 ms)
