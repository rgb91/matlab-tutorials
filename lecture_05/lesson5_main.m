%% ============================================================
%  LESSON 5  |  Custom Functions & First EEG Signals
%  NSBV BC2001 – MATLAB for Neuroscience
%  Duration: ~90 minutes (after warm-up)
%
%  PARTS:
%    Part A  –  Revisiting Custom Functions
%    Part B  –  First EEG Signal Generation
%    Part C  –  Student Experiment
% ============================================================

%% ============================================================
%  PART A: CUSTOM FUNCTIONS — REVISIT & CONSOLIDATE
%  Make sure the following files are in the same folder:
%    my_mean.m
%    signal_stats.m
% ============================================================

%% A1 – Recall: what does a function file look like?
% Open my_mean.m and read through it.
% Key things to notice:
%   1. Filename = function name  (my_mean.m contains "function my_mean")
%   2. function output = name(input)
%   3. Docstring comment block at the top
%   4. end keyword at the bottom

%% A2 – Call my_mean and compare with built-in
data = [3, 7, 2, 9, 4, 6, 1, 8];

result = my_mean(data);
fprintf('Custom mean = %.4f\n', result);
fprintf('MATLAB mean = %.4f\n', mean(data));

%% A3 – Multiple outputs: signal_stats
% Open signal_stats.m and read it.
% It returns THREE values at once.

[mn, sd, pk] = signal_stats(data);
fprintf('Mean: %.2f  |  Std: %.2f  |  Peak: %.2f\n', mn, sd, pk);

% What happens if you only ask for one output?
mn_only = signal_stats(data);
fprintf('First output only: %.2f\n', mn_only);

%% A4 – YOUR TURN: Write normalize_signal.m   ★ HANDS-ON
% Create a NEW file called normalize_signal.m in this folder.
%
% The function should:
%   - Accept a vector x as input
%   - Return z = (x - mean(x)) / std(x)    <- this is a z-score
%
% Then uncomment and run the test below:

raw = [10, 14, 9, 16, 13, 11, 15, 12];

% norm_sig = normalize_signal(raw);
% fprintf('Mean of normalized: %.6f\n', mean(norm_sig));   % should be ~0
% fprintf('Std  of normalized: %.6f\n', std(norm_sig));    % should be ~1

% figure;
% subplot(2,1,1); plot(raw, 'ro-'); title('Raw'); ylabel('Value'); grid on;
% subplot(2,1,2); plot(norm_sig, 'bo-'); title('Z-scored'); ylabel('Z'); grid on;
% xlabel('Sample');


%% ============================================================
%  PART B: EEG SIGNAL GENERATION
%
%  Key idea: real EEG is a mixture of oscillations at different
%  frequencies. We can build a convincing fake one by summing
%  sine waves at brain-rhythm frequencies.
%
%  Brain rhythm bands:
%    Delta  (δ) : 0.5 – 4  Hz   deep sleep
%    Theta  (θ) : 4  – 8   Hz   drowsiness, memory
%    Alpha  (α) : 8  – 13  Hz   relaxed, eyes closed
%    Beta   (β) : 13 – 30  Hz   alert, active thinking
%    Gamma  (γ) : 30 – 80  Hz   high-level processing
% ============================================================

%% B1 – Set up signal parameters
Fs = 256;               % Sampling rate in Hz (standard EEG hardware)
T  = 4;                 % Duration in seconds
t  = 0 : 1/Fs : T - 1/Fs;   % Time vector

fprintf('Sampling rate : %d Hz\n', Fs);
fprintf('Duration      : %d s\n',  T);
fprintf('Total samples : %d\n',    length(t));

% Discussion: why 256 Hz? What is the highest frequency we can capture?
% (Hint: Nyquist — highest freq = Fs / 2 = 128 Hz. Enough for gamma!)

%% B2 – Build individual waves
alpha_wave = 3.0 * sin(2*pi * 10 * t);   % 10 Hz  (alpha band)
theta_wave = 1.5 * sin(2*pi *  6 * t);   %  6 Hz  (theta band)
noise      = 0.5 * randn(1, length(t));  % background Gaussian noise

% Combine into a synthetic EEG
eeg_signal = alpha_wave + theta_wave + noise;

%% B3 – Plot each component + the summed signal
figure('Name', 'Synthetic EEG Components', 'NumberTitle', 'off');

subplot(4, 1, 1);
plot(t, alpha_wave, 'b', 'LineWidth', 1.2);
ylabel('Alpha (µV)'); title('EEG Signal Components'); xlim([0 T]); grid on;

subplot(4, 1, 2);
plot(t, theta_wave, 'r', 'LineWidth', 1.2);
ylabel('Theta (µV)'); xlim([0 T]); grid on;

subplot(4, 1, 3);
plot(t, noise, 'Color', [0.3 0.3 0.3]);
ylabel('Noise (µV)'); xlim([0 T]); grid on;

subplot(4, 1, 4);
plot(t, eeg_signal, 'w', 'LineWidth', 1);
ylabel('Summed EEG (µV)'); xlabel('Time (s)'); xlim([0 T]); grid on;

%% ============================================================
%  PART C: STUDENT EXPERIMENT   ★ HANDS-ON
% ============================================================

%% C1 – Add a beta wave independently
% Add:  beta_wave = 0.8 * sin(2*pi * 20 * t);
% Add it to eeg_signal and re-plot the 4-panel figure.
% Question: what changes in the summed trace?

% YOUR CODE HERE:


%% C2 – Zoom into the first 500 ms
% Use logical indexing to extract only the first 500 ms.
% Plot the zoomed signal with a proper title and axis labels.

idx_500ms = t <= 0.5;   % logical index

figure('Name', 'First 500 ms', 'NumberTitle', 'off');
plot(t(idx_500ms), eeg_signal(idx_500ms), 'k', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude (µV)');
title('Synthetic EEG – First 500 ms');
grid on;

% YOUR TURN: try zooming into 0.2 s, then 1 s. What do you observe?


%% C3 – Change amplitudes and observe  ★ EXPERIMENT
% The numbers 3.0, 1.5, 0.5 control how strong each component is.
% Try making alpha_wave weaker (e.g. 0.5) and noise stronger (e.g. 2.0).
% Re-run B2 → B3. What does the EEG trace look like now?
% What does this correspond to in a real noisy recording?

% YOUR CODE HERE:
