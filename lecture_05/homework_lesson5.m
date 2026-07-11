%% ============================================================
%  HOMEWORK  |  Lesson 5
%  Custom Functions & EEG Signal Generation
%  NSBV BC2001 – MATLAB for Neuroscience
%
%  Instructions:
%    Complete each exercise below.
%    Save this file as:  homework_lesson5_YOURNAME.m
%    Bring it to the next lesson — we will review together.
% ============================================================

%% ---- Exercise 1: normalize_signal.m  -----------------------
%
%  If you did not finish this in class, complete it now.
%  Create normalize_signal.m in the same folder as this script.
%
%  The function must:
%    - Accept a vector x
%    - Return z = (x - mean(x)) / std(x)
%
%  Test with the code below (uncomment after writing the function):

raw = [10, 14, 9, 16, 13, 11, 15, 12];

% norm_sig = normalize_signal(raw);
% fprintf('Mean of normalized: %.6f\n', mean(norm_sig));   % expect ~0
% fprintf('Std  of normalized: %.6f\n', std(norm_sig));    % expect ~1


%% ---- Exercise 2: Brain Band Frequency Explorer  ------------
%
%  Generate and plot one sine wave for each brain band:
%    Delta: 2 Hz, Theta: 6 Hz, Alpha: 10 Hz, Beta: 20 Hz, Gamma: 40 Hz
%
%  Use Fs = 256 Hz and T = 2 seconds.
%
%  Requirements:
%    a) Plot all five waves in separate subplots (5 rows, 1 column)
%    b) Label each subplot with the band name AND frequency
%       e.g. title('Alpha – 10 Hz')
%    c) Add x-axis label 'Time (s)' to the bottom subplot only
%    d) Add y-axis label 'Amplitude (µV)' to each subplot
%
%  BONUS: Add a 6th subplot showing all five waves summed together.

Fs    = 256;
T     = 2;
t     = 0 : 1/Fs : T - 1/Fs;
freqs = [2, 6, 10, 20, 40];
names = {'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma'};

% YOUR CODE HERE:


%% ---- Exercise 3: Written Questions  ------------------------
%
%  Answer each question as a comment below.
%
%  Q1: In the sine wave formula:   A * sin(2 * pi * f * t)
%      What does each of the following control?
%        - A
%        - f
%        - t
%
%  Q2: In Part B of the lesson, we set Fs = 256 Hz.
%      What is the HIGHEST frequency signal we could represent
%      at this sampling rate? (Nyquist theorem: max freq = Fs / 2)
%      Why does this matter for EEG recordings?
%
%  Q3: We added Gaussian noise using randn().
%      What would the EEG signal look like if the noise amplitude
%      were very large (e.g. 10.0 instead of 0.5)?
%      What real-world situation might this represent?
%
%  Q4: The normalize_signal function produces a z-score.
%      Why might z-scoring be useful when comparing EEG signals
%      recorded from different participants?

% Q1:
% Q2:
% Q3:
% Q4:

% ============================================================
%  END OF HOMEWORK
% ============================================================
