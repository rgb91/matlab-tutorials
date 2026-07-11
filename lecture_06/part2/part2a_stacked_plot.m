%% PART 2a & 2b — Stacked (Clinical) EEG Plot
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% MATLAB CONCEPTS COVERED:
%   - hold on               keeping existing lines when plot() is called again
%   - Arithmetic offset     shifting traces on the y-axis inside a loop
%   - RGB colour triplet    'Color', [r g b] with values 0–1
%   - yticks / yticklabels  custom y-axis tick positions and labels
%   - arrayfun + sprintf    generating a cell array of strings programmatically
%   - grid on / box off     figure appearance
%
% NOTE: Run part1_matrices_forloops.m first so 'eeg', 't', 'n_channels' exist.

%% 2a — The Problem: All Channels Overlapping
% ─────────────────────────────────────────────────────────────────────────────
figure('Name', '2a: No offset — overlapping traces');
for ch = 1 : n_channels
    plot(t, eeg(ch, :));
    hold on;              % keeps existing lines on the same axes
end
title('All channels — no offset (unreadable)');
xlabel('Time (s)');
ylabel('Amplitude');

% ── PAUSE ────────────────────────────────────────────────────────────────────
% Q: "Why are all the traces on top of each other?"
% Q: "What is one way to separate them vertically without changing the data?"

%% 2b — The Fix: Vertical Offset Per Channel
% ─────────────────────────────────────────────────────────────────────────────
offset_scale = 6;   % spacing between channels (in amplitude units)
                    % try: 12 (too spaced), 1 (too cramped), 6 (just right)

figure('Name', '2b: Stacked EEG with offsets'); 
hold on;

for ch = 1 : n_channels
    % ch=1 → offset=0,  ch=2 → offset=6,  ch=3 → offset=12 ...
    offset = (ch - 1) * offset_scale;

    plot(t, eeg(ch, :) + offset, 'Color', [0.2 0.4 0.8]);
    % [0.2 0.4 0.8] = RGB triplet: low red, medium green, high blue → steel blue
    % Try changing to [0.8 0.2 0.2] — what colour do you get?
end

% Custom y-axis ticks: position at each channel's baseline offset
yticks( (0 : n_channels-1) * offset_scale );

% Replace the tick numbers with channel labels: 'Ch 1', 'Ch 2', ...
% arrayfun applies sprintf to every element of 1:n_channels at once
yticklabels( arrayfun(@(c) sprintf('Ch %d', c), 1:n_channels, 'UniformOutput', false) );

xlabel('Time (s)');
title('8-Channel EEG — Stacked View');
grid on;
box off;

% ── EXPERIMENT PROMPTS ───────────────────────────────────────────────────────
% 1. Change offset_scale to 12. What happens?
% 2. Change offset_scale to 1. Why is 1 too small?
% 3. Change the color to [0.8 0.2 0.2]. What colour appears?
% 4. What does 'box off' do? Try removing it.
