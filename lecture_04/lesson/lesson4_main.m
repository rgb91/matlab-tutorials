%% ============================================================
%  LESSON 4  |  Custom Functions & EEG-like Signal Visualisation
%  NSBV BC2001 – Neuroscience Lab Prep
%  Estimated time: ~90 minutes (after warm-up)
%
%  SECTIONS:
%    Part A  –  Writing Custom Functions
%    Part B  –  Generating & Plotting EEG-like Signals
%    Part C  –  Multi-channel EEG Visualisation
%    Part D  –  Mini-project: Detect Peaks in a Signal
% ============================================================

%% ============================================================
%  PART A: CUSTOM FUNCTIONS
%  Key idea: A function takes inputs, does work, returns outputs.
%  In MATLAB each function usually lives in its OWN FILE.
%  See the file  my_mean.m  for a worked example.
% ============================================================

%% A1 – Call a simple custom function
% (Make sure my_mean.m is in the same folder as this script)

data = [3, 7, 2, 9, 4, 6, 1, 8];
result = my_mean(data);
fprintf('Custom mean = %.4f\n', result);
fprintf('MATLAB mean = %.4f\n', mean(data));

%% A2 – Write a function that returns MULTIPLE outputs
% Open  signal_stats.m  and read it, then call it here.

[mn, sd, pk] = signal_stats(data);
fprintf('Mean: %.2f  |  Std: %.2f  |  Peak: %.2f\n', mn, sd, pk);

%% A3 – YOUR TURN: Write a function called   normalize_signal.m
%  It should:
%    1. Accept a vector x as input
%    2. Subtract the mean  (zero-centering)
%    3. Divide by the standard deviation  (unit variance)
%    4. Return the normalized vector
%
%  Then call it below and plot the before/after:

raw = [10, 14, 9, 16, 13, 11, 15, 12];

% Uncomment after you have written normalize_signal.m:
% norm_sig = normalize_signal(raw);
% figure;
% subplot(2,1,1); plot(raw, 'ro-'); title('Raw'); ylabel('Value');
% subplot(2,1,2); plot(norm_sig, 'bo-'); title('Normalized'); ylabel('Z-score');
% xlabel('Sample');


%% ============================================================
%  PART B: GENERATING EEG-LIKE SIGNALS
%  Real EEG is complex, but we can build a convincing fake one
%  from a sum of sine waves at brain-rhythm frequencies.
%
%  Brain rhythm bands (approximate):
%    Delta  : 0.5 – 4 Hz   (deep sleep)
%    Theta  : 4  – 8 Hz    (drowsiness / memory)
%    Alpha  : 8  – 13 Hz   (relaxed, eyes closed)
%    Beta   : 13 – 30 Hz   (alert, active thinking)
%    Gamma  : 30 – 80 Hz   (cognitive processing)
% ============================================================

%% B1 – Basic parameters
Fs   = 256;          % Sampling rate (Hz) — typical EEG hardware
T    = 4;            % Duration (seconds)
t    = 0 : 1/Fs : T - 1/Fs;   % Time vector

fprintf('Number of samples: %d\n', length(t));

%% B2 – Build a synthetic EEG from three oscillations
alpha_wave  = 3.0 * sin(2*pi * 10 * t);    % 10 Hz alpha
theta_wave  = 1.5 * sin(2*pi *  6 * t);    %  6 Hz theta
noise       = 0.5 * randn(1, length(t));    % background noise

eeg_signal  = alpha_wave + theta_wave + noise;

%% B3 – Plot the components and the summed signal
figure('Name', 'Synthetic EEG Components', 'NumberTitle', 'off');

subplot(4,1,1);
plot(t, alpha_wave, 'b'); ylabel('Alpha'); title('EEG Components');
xlim([0 T]); grid on;

subplot(4,1,2);
plot(t, theta_wave, 'r'); ylabel('Theta');
xlim([0 T]); grid on;

subplot(4,1,3);
plot(t, noise, 'Color', [0.5 0.5 0.5]); ylabel('Noise');
xlim([0 T]); grid on;

subplot(4,1,4);
plot(t, eeg_signal, 'k'); ylabel('Summed EEG');
xlabel('Time (s)');
xlim([0 T]); grid on;

%% B4 – YOUR TURN: Experiment
% Try adding a beta wave:  beta_wave = 0.8 * sin(2*pi * 20 * t);
% Add it to eeg_signal and re-plot. What does the trace look like?

% YOUR TURN CODE HERE:


%% B5 – Zoom into just the first 500 ms
figure('Name', '500 ms Zoom', 'NumberTitle', 'off');
idx_500ms = t <= 0.5;   % logical index for first 500 ms
plot(t(idx_500ms), eeg_signal(idx_500ms), 'k', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude (µV)');
title('Synthetic EEG – First 500 ms');
grid on;


%% ============================================================
%  PART C: MULTI-CHANNEL EEG VISUALISATION
%  Clinical EEG has 64-256 channels. We will simulate 4.
%  Channels are stacked vertically with an offset (standard style).
% ============================================================

%% C1 – Generate 4 channels
n_channels = 4;
channel_names = {'Fz', 'Cz', 'Pz', 'Oz'};

% Pre-allocate: rows = channels, cols = samples
eeg_multi = zeros(n_channels, length(t));

% Frequencies representing different regions (simplified)
freq_per_ch = [9, 10, 11, 10.5];   % slight variation across channels

for ch = 1:n_channels
    eeg_multi(ch, :) = 2.5 * sin(2*pi * freq_per_ch(ch) * t) ...
                     + 1.0 * sin(2*pi * 6 * t)              ...
                     + 0.4 * randn(1, length(t));
end

%% C2 – Plot stacked channels (butterfly / waterfall style)
offset    = 8;        % vertical separation between channels
t_plot    = t <= 2;   % show only first 2 s

figure('Name', 'Multi-channel EEG', 'NumberTitle', 'off');
hold on;

for ch = 1:n_channels
    plot(t(t_plot), eeg_multi(ch, t_plot) + (ch-1)*offset, ...
         'LineWidth', 1, 'DisplayName', channel_names{ch});
end

yticks((0:n_channels-1) * offset);
yticklabels(channel_names);
xlabel('Time (s)');
ylabel('Channel');
title('4-Channel Synthetic EEG');
xlim([0 2]);
legend('Location', 'northeast');
grid on;
hold off;

%% C3 – YOUR TURN: Colour each channel differently
% Replace the single plot command with a cell array of colours:
%   colours = {'b', 'r', 'g', 'm'};
% and pass  colours{ch}  as the colour argument.


%% ============================================================
%  PART D: MINI-PROJECT – DETECT PEAKS IN A SIGNAL
%  Goal: find every local maximum (peak) and mark it on a plot.
%  This is relevant for detecting ERP components in real EEG.
% ============================================================

%% D1 – Use MATLAB's built-in findpeaks
% Make sure Signal Processing Toolbox is available (it usually is).

clean_eeg = 2.5 * sin(2*pi * 10 * t);   % clean sine for clarity

[peak_values, peak_locs] = findpeaks(clean_eeg, ...
    'MinPeakHeight',  1.0, ...   % must exceed this amplitude
    'MinPeakDistance', Fs * 0.05);  % at least 50 ms apart

fprintf('Number of peaks found: %d\n', numel(peak_values));

%% D2 – Plot signal with peaks marked
figure('Name', 'Peak Detection', 'NumberTitle', 'off');
plot(t, clean_eeg, 'b', 'LineWidth', 1.2); hold on;
plot(t(peak_locs), peak_values, 'rv', ...
    'MarkerSize', 10, 'MarkerFaceColor', 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Peak Detection in EEG-like Signal');
legend('Signal', 'Detected peaks');
grid on; hold off;

%% D3 – YOUR TURN: Apply findpeaks to the NOISY eeg_signal from Part B.
% Experiment with MinPeakHeight and MinPeakDistance to reduce false detections.
% How does noise affect peak detection?

% YOUR TURN CODE HERE:


% ============================================================
%  TAKE-HOME EXERCISES  (see  homework_lesson4.m  for details)
% ============================================================
