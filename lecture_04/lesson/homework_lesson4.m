%% ============================================================
%  HOMEWORK  |  Lesson 4  – Custom Functions & EEG Signals
%  NSBV BC2001 – MATLAB for Neuroscience
%
%  Instructions:
%    Complete each exercise below.
%    Add your answers / code beneath each prompt.
%    Save this file as:  homework_lesson4_YOURNAME.m
%    Bring it to the next lesson — we will review together.
% ============================================================

%% ---- Exercise 1: Write normalize_signal.m  ------------------
%
%  Create a NEW file called  normalize_signal.m  that:
%    a) Accepts a vector x
%    b) Returns (x - mean(x)) / std(x)   [this is called a z-score]
%
%  Then run the code below to test it:

raw = [10, 14, 9, 16, 13, 11, 15, 12];
% norm_sig = normalize_signal(raw);
%
% Verify:
%   fprintf('Mean of normalized: %.6f\n', mean(norm_sig));   % should be ~0
%   fprintf('Std  of normalized: %.6f\n', std(norm_sig));    % should be ~1

% YOUR FUNCTION FILE (normalize_signal.m) goes in the same folder as this script.


%% ---- Exercise 2: Frequency Explorer  -----------------------
%
%  Using the EEG-generation pattern from lesson4_main.m Part B,
%  write a script that:
%    a) Creates 5 sine waves at frequencies: 2, 8, 12, 25, 40 Hz
%    b) Plots each one in a separate subplot (5 rows, 1 column)
%    c) Labels each subplot with its frequency band name
%       (Delta, Alpha, Beta, Gamma — use the table from lesson notes)
%    d) Uses a 2-second signal at Fs = 256 Hz
%
%  BONUS: Add a 6th subplot showing all 5 summed together.

Fs = 256;
T  = 2;
t  = 0 : 1/Fs : T - 1/Fs;
freqs = [2, 8, 12, 25, 40];
names = {'Delta (2 Hz)', 'Alpha (8 Hz)', 'Beta (12 Hz)', ...
         'Beta (25 Hz)', 'Gamma (40 Hz)'};

% YOUR CODE HERE:


%% ---- Exercise 3: Peak Counting Function  --------------------
%
%  Write a function called  count_peaks.m  with signature:
%
%    n = count_peaks(signal, Fs, threshold)
%
%  The function should:
%    a) Call findpeaks with MinPeakHeight = threshold
%       and MinPeakDistance = Fs * 0.05  (50 ms)
%    b) Return n = the number of peaks found
%
%  Test it:
%    clean = 2 * sin(2*pi * 10 * t);
%    noisy = clean + 0.8 * randn(size(clean));
%    fprintf('Peaks in clean signal: %d\n', count_peaks(clean, Fs, 1.0));
%    fprintf('Peaks in noisy signal: %d\n', count_peaks(noisy, Fs, 1.0));
%
%  Question to answer in a comment: Why does the noisy signal have more peaks?


%% ---- Exercise 4: Multi-channel Loop  ------------------------
%
%  Extend Part C of lesson4_main.m from 4 channels to 8 channels.
%  Use a for-loop to generate each channel with a slightly different
%  alpha frequency (9.0, 9.5, 10.0, ... 12.5 Hz).
%
%  Plot all 8 channels stacked, with offsets of 10 µV.
%  Label each channel Ch1, Ch2, ... Ch8.

n_channels = 8;
Fs = 256; T = 2;
t  = 0 : 1/Fs : T - 1/Fs;
freqs_ch = 9.0 : 0.5 : 12.5;    % 8 values

% YOUR CODE HERE:


%% ---- Exercise 5: Reflection Questions  ----------------------
% Answer these in comments (no code needed).
%
%  Q1: Why is it better to PRE-ALLOCATE a vector (zeros(1,N))
%      before filling it in a loop, rather than growing it each iteration?
%
%  Q2: In signal_stats.m the function returns THREE outputs.
%      What happens in MATLAB if you call it as:
%         mn = signal_stats(data);     (only one output variable)
%      Try it and describe the result.
%
%  Q3: EEG sampling rates are often 256, 512, or 1024 Hz.
%      What is the highest frequency you can represent at each rate?
%      (Hint: Nyquist theorem)
%
%  Q4: If you wanted to REMOVE the noise from the synthetic EEG you built
%      in lesson4_main.m, what MATLAB function might help?
%      (Search MATLAB docs for "filter" or "bandpass")

% YOUR ANSWERS HERE (as comments):
% Q1:
% Q2:
% Q3:
% Q4:

% ============================================================
%  END OF HOMEWORK
% ============================================================
