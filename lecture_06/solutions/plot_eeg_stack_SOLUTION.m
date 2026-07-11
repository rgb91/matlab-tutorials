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
% ── SOLUTION ─────────────────────────────────────────────────────────────────

% Step 1: Get n_channels from the data — NOT hard-coded
% size(eeg_data, 1) = number of rows = number of channels
n_channels = size(eeg_data, 1);

% Step 2: Open figure and hold
figure('Name', fig_title, 'NumberTitle', 'off');
hold on;

% Step 3: Loop — plot each channel with its vertical offset
for ch = 1 : n_channels
    offset = (ch - 1) * offset_scale;
    plot(t, eeg_data(ch, :) + offset, 'Color', [0.2 0.4 0.8]);
end

% Step 4: Axis labels, custom ticks, title
yticks( (0 : n_channels-1) * offset_scale );
yticklabels( arrayfun(@(c) sprintf('Ch %d', c), 1:n_channels, 'UniformOutput', false) );
xlabel('Time (s)');
title(fig_title);    % uses the INPUT variable — not a hard-coded string
grid on;
box off;

end

% ── INSTRUCTOR NOTES ─────────────────────────────────────────────────────────
% KEY THINGS TO CHECK IN STUDENT CODE:
%   ✓ size(eeg_data, 1) used — NOT n_channels = 8
%   ✓ hold on is present inside the figure block
%   ✓ title(fig_title) uses the variable, not a literal string
%   ✓ Docstring present above the code
%   ✓ offset = (ch-1)*offset_scale — not ch*offset_scale (channel 1 starts at 0)
%
% COMMON MISTAKE: n_channels = 8 hard-coded inside the function.
% Ask: "What happens if I call this with a 16-channel matrix?"
