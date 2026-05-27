%% BLOCK 3 — Importing Data & Publication-Quality Plotting
% Lecture 3: MATLAB Summer Prep | NSBV BC2001
% -----------------------------------------------
% In the actual module you will load real EEG and electrophysiology
% data from files. Here we simulate that workflow using CSV data,
% and learn to make clean, publication-quality figures.

clc; clearvars;

%% 1. Saving data to a CSV (simulating what the module's instruments produce)
t        = linspace(0, 2, 2000)';          % column vector — standard for data tables
ch1      = sin(2*pi*10*t) + 0.3*randn(size(t));   % channel 1: noisy 10 Hz
ch2      = sin(2*pi*20*t) + 0.3*randn(size(t));   % channel 2: noisy 20 Hz
ch3      = sin(2*pi*5*t)  + 0.3*randn(size(t));   % channel 3: noisy 5 Hz

% Build a table and write to CSV
data_table = table(t, ch1, ch2, ch3, ...
    'VariableNames', {'time_s','channel1','channel2','channel3'});
writetable(data_table, 'simulated_eeg.csv');
disp('CSV saved: simulated_eeg.csv');

%% 2. Reading data back from CSV
loaded = readtable('simulated_eeg.csv');
disp('Loaded table preview:');
disp(loaded(1:5, :));   % show first 5 rows

% Extract columns back into arrays
t2   = loaded.time_s;
sig1 = loaded.channel1;
sig2 = loaded.channel2;
sig3 = loaded.channel3;

%% 3. Multi-channel plot — EEG-style stacked display
% In EEG visualisation, channels are often stacked with an offset
offset = 3;   % vertical spacing between channels

figure;
plot(t2, sig1,            'b',  'LineWidth', 0.8); hold on;
plot(t2, sig2 + offset,   'r',  'LineWidth', 0.8);
plot(t2, sig3 + 2*offset, 'k',  'LineWidth', 0.8);
hold off;

yticks([0, offset, 2*offset]);
yticklabels({'Ch1 (10Hz)', 'Ch2 (20Hz)', 'Ch3 (5Hz)'});
xlabel('Time (s)');
title('Simulated Multi-Channel EEG Recording');
set(gca, 'FontSize', 11);   % gca = "get current axes" — a very useful handle

%% 4. Publication-quality figure: annotating a region of interest
fig = figure;
fig.Position = [100 100 900 400];   % set figure size [x y width height]

ax = axes;
plot(t2, sig1, 'Color', [0.2 0.4 0.8], 'LineWidth', 1);
xlabel('Time (s)', 'FontSize', 13);
ylabel('Amplitude (a.u.)', 'FontSize', 13);
title('Channel 1 — 10 Hz Signal', 'FontSize', 14);

% Shade a region of interest (e.g. a time window of interest)
roi_start = 0.5;
roi_end   = 1.0;
y_lim     = ylim;
patch([roi_start roi_end roi_end roi_start], ...
      [y_lim(1) y_lim(1) y_lim(2) y_lim(2)], ...
      [1 0.9 0.6], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
text(roi_start + 0.02, y_lim(2)*0.85, 'ROI', 'FontSize', 11, 'Color', [0.7 0.4 0]);

% Add a horizontal threshold line
threshold = 0.8;
yline(threshold, 'r--', 'LineWidth', 1.5, 'Label', 'Threshold');

box off;   % cleaner look — removes top and right axes borders

%% 5. Saving a figure to file (useful for lab reports)
saveas(fig, 'channel1_figure.png');
disp('Figure saved: channel1_figure.png');
