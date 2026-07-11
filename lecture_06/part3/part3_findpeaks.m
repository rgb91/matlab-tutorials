%% PART 3 — findpeaks() & Name-Value Arguments
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% MATLAB CONCEPTS COVERED:
%   - Name-value argument pairs   'OptionName', value
%   - findpeaks()                 detecting local maxima; two output variables
%   - mean() / std()              computing a dynamic threshold
%   - 'rv' marker style           red downward triangle in plot()
%   - ... (line continuation)     splitting a long call across multiple lines
%   - sprintf('%d', n)            embedding an integer in a title string
%   - length() vs size()          difference for vectors
%
% NOTE: Run part1_matrices_forloops.m first so 'eeg', 't', 'fs' exist.

%% 3a — Name-Value Arguments: The Pattern
% ─────────────────────────────────────────────────────────────────────────────
% You already use name-value pairs with plot():
%   plot(t, sig, 'Color', [1 0 0], 'LineWidth', 2)
%                 ^name   ^value    ^name         ^value
%
% findpeaks() uses exactly the same pattern.
% The option names are STRINGS — the quote marks are required syntax.
%
% Try this at the command line to see the error when quotes are missing:
%   [p, l] = findpeaks(rand(1,100), 'MinPeakHeight', 0.5)   % correct
%   [p, l] = findpeaks(rand(1,100),  MinPeakHeight,  0.5)   % errors — why?

%% 3b — Build the Threshold
% ─────────────────────────────────────────────────────────────────────────────
ch1 = eeg(1, :);    % extract row 1 as a plain row vector

% Dynamic threshold: mean + 1.5 standard deviations
threshold = mean(ch1) + 1.5 * std(ch1);

fprintf('mean(ch1)  = %.4f\n', mean(ch1))
fprintf('std(ch1)   = %.4f\n', std(ch1))
fprintf('threshold  = %.4f\n', threshold)

% ── PAUSE ────────────────────────────────────────────────────────────────────
% Q: What does mean() return for a row vector? (a scalar)
% Q: What does std() return for a row vector?  (a scalar)

%% 3c — Call findpeaks()
% ─────────────────────────────────────────────────────────────────────────────

% Two output variables: peak y-values AND their x-positions (in seconds)
[pks, locs] = findpeaks(ch1, t, ...
    'MinPeakHeight',    threshold, ...
    'MinPeakDistance',  0.08);        % 80 ms minimum gap between peaks
                                      % when t is in seconds, distance is in seconds

% What did findpeaks return?
fprintf('\nPeaks found: %d\n',    length(pks))
fprintf('First peak value:    %.4f\n', pks(1))
fprintf('First peak location: %.4f s\n', locs(1))

% ── PAUSE ────────────────────────────────────────────────────────────────────
% Q: "pks and locs are both vectors. What is length(locs)?"   → same as length(pks)
% Q: "How do you access the 3rd detected peak location?"      → locs(3)
% Q: "What is the difference between length(pks) and size(pks)?"
%     length = max dimension = number of peaks
%     size   = [1, n_peaks]  (it's a row vector)

%% 3d — Plot Signal with Peak Markers
% ─────────────────────────────────────────────────────────────────────────────
figure('Name', 'Peak Detection — Channel 1');

% Plot the raw signal
plot(t, ch1, 'Color', [0.2 0.4 0.8]);
hold on;

% Overlay peak markers
% 'rv' = r (red) + v (downward triangle marker)
plot(locs, pks, 'rv', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

% Labels
xlabel('Time (s)');
ylabel('Amplitude');

% sprintf embeds the peak count (an integer) into the title string
title( sprintf('Channel 1 — %d peaks detected', length(pks)) );

% Add the threshold as a dashed line for reference
yline(threshold, '--k', sprintf('Threshold = %.2f', threshold), ...
      'LabelHorizontalAlignment', 'left');

grid on;

% ── EXPERIMENT PROMPTS ───────────────────────────────────────────────────────
% 1. Change threshold to just mean(ch1). Re-run. What happens to peak count?
% 2. Remove 'MinPeakDistance', 0.08 entirely. Re-run. What changes?
%    (This is MATLAB default behaviour when an option is omitted — Exercise 3)
% 3. Change 'MarkerSize' to 14. What happens?
% 4. Change 'rv' to 'g^'. What does that produce?
