function plot_eeg_stack(eeg_data, t, offset_scale, fig_title)
% plot_eeg_stack   Plot a multi-channel matrix as a vertically stacked EEG trace.
%
% SYNTAX:
%   plot_eeg_stack(eeg_data, t, offset_scale, fig_title)
%
% INPUTS:
%   eeg_data     — matrix of size (n_channels × n_samples)
%   t            — time vector of length n_samples  [seconds]
%   offset_scale — scalar: vertical spacing between channels
%   fig_title    — string: figure title
%
% EXAMPLE:
%   plot_eeg_stack(eeg, t, 6, 'My EEG Stack')
%
% ── YOUR CODE BELOW ──────────────────────────────────────────────────────────
%
% CHECKLIST before submitting:
%   [ ] Get n_channels from size(eeg_data, 1) — do NOT hard-code 8
%   [ ] Loop from ch = 1 to n_channels
%   [ ] Add (ch-1)*offset_scale to each channel's data before plotting
%   [ ] hold on is inside the figure (not forgotten)
%   [ ] yticks and yticklabels set correctly
%   [ ] xlabel set to 'Time (s)'
%   [ ] title uses the fig_title input variable (not a hard-coded string)
%   [ ] Docstring is present (it already is — keep it!)

% Step 1: get the number of channels from the data (NOT hard-coded)


% Step 2: open a figure and hold


% Step 3: loop — plot each channel with its vertical offset


% Step 4: axis labels, ticks, title


end
