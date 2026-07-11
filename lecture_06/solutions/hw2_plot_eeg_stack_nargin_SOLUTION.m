function plot_eeg_stack(eeg_data, t, offset_scale, fig_title, peak_locs)
% plot_eeg_stack   Plot a multi-channel EEG matrix as stacked traces.
%                  Optionally overlays peak markers on channel 1.
%
% SYNTAX:
%   plot_eeg_stack(eeg_data, t, offset_scale, fig_title)
%   plot_eeg_stack(eeg_data, t, offset_scale, fig_title, peak_locs)
%
% INPUTS:
%   eeg_data     — matrix (n_channels × n_samples)
%   t            — time vector [seconds]
%   offset_scale — scalar spacing between channels
%   fig_title    — string title for the figure
%   peak_locs    — [OPTIONAL] vector of peak time locations (seconds)
%
% EXAMPLE (without peaks):
%   plot_eeg_stack(eeg, t, 6, 'My EEG Stack')
%
% EXAMPLE (with peaks on channel 1):
%   [~, locs] = findpeaks(eeg(1,:), t, 'MinPeakHeight', mean(eeg(1,:))+1.5*std(eeg(1,:)));
%   plot_eeg_stack(eeg, t, 6, 'EEG with Peaks', locs)
%
% ── SOLUTION ─────────────────────────────────────────────────────────────────

% Step 1: Get n_channels from data — NOT hard-coded
n_channels = size(eeg_data, 1);

% Step 2: Open figure and hold
figure('Name', fig_title, 'NumberTitle', 'off');
hold on;

% Step 3: Loop — plot each channel with vertical offset
for ch = 1 : n_channels
    offset = (ch - 1) * offset_scale;
    plot(t, eeg_data(ch, :) + offset, 'Color', [0.2 0.4 0.8]);
end

% Step 4: Axis formatting
yticks( (0 : n_channels-1) * offset_scale );
yticklabels( arrayfun(@(c) sprintf('Ch %d', c), 1:n_channels, 'UniformOutput', false) );
xlabel('Time (s)');
title(fig_title);
grid on;
box off;

% Step 5: Optional peak overlay using nargin
% nargin = number of arguments the CALLER passed in
% If nargin == 5, peak_locs was provided; if nargin == 4, it was not.
if nargin == 5
    % Channel 1's offset is (1-1)*offset_scale = 0
    % So markers sit at the same y-value as the peak amplitudes in the data
    ch1_data   = eeg_data(1, :);
    ch1_offset = 0;   % (1-1) * offset_scale

    % Get the y-values at the peak locations (look them up in the signal)
    % interp1 interpolates — but since locs are exact sample times from findpeaks,
    % we can re-run findpeaks on ch1 to get matching pks, OR use interp1:
    pks_y = interp1(t, ch1_data, peak_locs) + ch1_offset;

    plot(peak_locs, pks_y, 'rv', ...
        'MarkerFaceColor', 'r', ...
        'MarkerSize', 8, ...
        'DisplayName', 'Peaks (Ch 1)');

    legend('show', 'Location', 'northeast')
end

end

% ── INSTRUCTOR NOTES ─────────────────────────────────────────────────────────
% KEY THINGS TO CHECK:
%   ✓ nargin == 5 condition (not nargin > 4 or nargin >= 5 — all equivalent but 5 is clearest)
%   ✓ The peak markers are offset by ch1_offset (which is 0 here, but code is explicit about it)
%   ✓ Function still works correctly when called with only 4 arguments
%
% ALTERNATIVE APPROACH (also correct):
%   Use nargin < 5 to set a default:
%       if nargin < 5; peak_locs = []; end
%       if ~isempty(peak_locs)  ... overlay markers
