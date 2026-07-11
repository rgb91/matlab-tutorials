%% HOMEWORK EXERCISE 3 — Exploration & Notebook
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% TASK:
%   Pick at least TWO of the four experiments below.
%   Run each, observe the result, and write 2–3 sentences in your
%   digital notebook describing what you observe and WHY it happens.
%   Focus on the MATLAB behaviour, not the neuroscience.
%
% NOTE: Run part1_matrices_forloops.m first.

%% ── EXPERIMENT A — Scale the number of channels ────────────────────────────
%
% Change n_channels to 16 and regenerate the EEG matrix.
% Then call your plot_eeg_stack function without changing anything in the file.
%
% NOTEBOOK PROMPT:
%   "Does plot_eeg_stack still work with 16 channels? Why or why not?
%    What MATLAB line inside the function makes this possible?"

n_channels_A = 16;     % <-- change here

% Re-run the data generation loop with n_channels_A instead of n_channels
% (copy the loop from part1 and swap the variable name)

% YOUR CODE HERE:


%% ── EXPERIMENT B — High noise, effect on peak detection ────────────────────
%
% Re-generate the EEG with noise_std = 1.5 (instead of ~0.2–0.3).
% Re-run findpeaks on channel 1 with the same threshold formula.
%
% NOTEBOOK PROMPT:
%   "What happens to the peak count when noise is high?
%    Does the threshold (mean + 1.5*std) change too? Why?"

noise_std_B = 1.5;   % <-- high noise

fs_B = 500;
t_B  = 0 : 1/fs_B : 4 - 1/fs_B;

% YOUR CODE HERE: generate a single noisy channel, run findpeaks, plot result


%% ── EXPERIMENT C — Remove MinPeakDistance ──────────────────────────────────
%
% Call findpeaks WITHOUT the 'MinPeakDistance' argument on channel 1.
% Compare the peak count to the version with MinPeakDistance = 0.08.
%
% NOTEBOOK PROMPT:
%   "What is MATLAB's default behaviour when MinPeakDistance is omitted?
%    (Hint: check the documentation or run help findpeaks)
%    How does the peak count change?"

% YOUR CODE HERE:
ch1 = eeg(1, :);
threshold = mean(ch1) + 1.5 * std(ch1);

% Version WITH MinPeakDistance:
[pks_with, locs_with] = findpeaks(ch1, t, ...
    'MinPeakHeight',    threshold, ...
    'MinPeakDistance',  0.08);

% Version WITHOUT MinPeakDistance — YOUR CODE:


fprintf('Peaks WITH MinPeakDistance:    %d\n', length(pks_with))
% add fprintf for without version here

%% ── EXPERIMENT D — Auto-computed offset_scale ──────────────────────────────
%
% The hard-coded offset_scale = 6 works for our signal but might not
% work for signals with very different amplitudes.
%
% NOTEBOOK PROMPT:
%   "What would a smarter way to compute offset_scale automatically look like?
%    Write a line of code that computes it from the data itself.
%    Hint: think about what max() or std() across all channels might give you."

% YOUR CODE HERE: compute offset_scale automatically, then call plot_eeg_stack


