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
%                  If provided: overlays red triangle markers on channel 1
%                  If omitted:  function behaves exactly as Exercise 1 version
%
% MATLAB CONCEPT: nargin
%   nargin returns the number of arguments the caller actually passed in.
%   Use it to make an argument optional:
%
%   if nargin == 5
%       % caller passed peak_locs — use it
%   end
%
% EXAMPLE (without peaks):
%   plot_eeg_stack(eeg, t, 6, 'My EEG Stack')
%
% EXAMPLE (with peaks):
%   [~, locs] = findpeaks(eeg(1,:), t, 'MinPeakHeight', mean(eeg(1,:)) + 1.5*std(eeg(1,:)));
%   plot_eeg_stack(eeg, t, 6, 'EEG with Peaks', locs)
%
% ── YOUR CODE BELOW ──────────────────────────────────────────────────────────

% Step 1: Get n_channels from the data (NOT hard-coded)


% Step 2: Open figure, hold on, loop and plot with offsets


% Step 3: Axis labels, yticks, title


% Step 4: If peak_locs was provided, overlay markers on channel 1
%         Hint: the y-position of the markers must account for channel 1's offset
%               offset for channel 1 = (1-1) * offset_scale = 0


end
