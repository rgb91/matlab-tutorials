%% HOMEWORK EXERCISE 1 — SOLUTION: Loop Over All Channels
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% INSTRUCTOR USE ONLY — share with student after submission.

% NOTE: Run part1_matrices_forloops.m first so 'eeg', 't', 'n_channels' exist.

%% Step 1: Pre-allocate result arrays
% One value per channel — allocate before the loop
n_peaks_all    = zeros(1, n_channels);   % will hold peak count for each channel
mean_amp_all   = zeros(1, n_channels);   % will hold mean peak amplitude

%% Step 2: Loop over all channels
for ch = 1 : n_channels

    % 2a. Extract the row as a plain vector
    ch_data = eeg(ch, :);

    % 2b. Compute a dynamic threshold for this channel
    threshold = mean(ch_data) + 1.5 * std(ch_data);

    % 2c. Run findpeaks
    [pks, ~] = findpeaks(ch_data, t, ...
        'MinPeakHeight',   threshold, ...
        'MinPeakDistance', 0.08);
    % ~ (tilde) discards the second output (locs) — we don't need it here

    % 2d. Store results
    n_peaks_all(ch)  = length(pks);

    if ~isempty(pks)
        mean_amp_all(ch) = mean(pks);
    else
        mean_amp_all(ch) = 0;   % no peaks found for this channel
    end

end

%% Step 3: Print summary table
fprintf('\n%-12s  %-10s  %s\n', 'Channel', 'Peaks', 'Mean Amplitude')
fprintf('%s\n', repmat('-', 1, 40))
for ch = 1 : n_channels
    fprintf('Channel %d:    %2d peaks,   mean amplitude = %.2f\n', ...
        ch, n_peaks_all(ch), mean_amp_all(ch))
end

%% BONUS: Simple bar chart of peak counts
figure('Name', 'Peak Counts Across Channels');
bar(1:n_channels, n_peaks_all, 'FaceColor', [0.2 0.4 0.8])
xlabel('Channel')
ylabel('Number of Peaks')
title('Peak Count per Channel')
xticks(1:n_channels)
grid on

% ── INSTRUCTOR NOTES ─────────────────────────────────────────────────────────
% KEY THINGS TO CHECK:
%   ✓ zeros(1, n_channels) pre-allocation before the loop — NOT appending
%   ✓ eeg(ch, :) for row extraction — not eeg(ch) which is scalar
%   ✓ ~ used to discard locs (or locs stored — either is fine)
%   ✓ isempty(pks) guard to avoid mean([]) erroring
%   ✓ fprintf format specifiers correct: %d for integers, %.2f for floats
%   ✓ Loop variable ch used consistently (not i or j)
