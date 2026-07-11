% ============================================================
%  SESSION 7 — MATLAB FILES
%  Multi-Channel EEG & Peak Detection
%  NSBV BC2001 — MATLAB Summer Prep
% ============================================================
%
% HOW TO USE THESE FILES
% ──────────────────────
% 1. Open MATLAB and set your Current Folder to this directory.
% 2. Run files in the order shown below — each part depends on
%    variables created by the previous one.
% 3. Student files contain blank sections to complete.
%    Solutions are in the /solutions folder — instructor use only.
%
%
% FILE MAP & RUN ORDER
% ──────────────────────────────────────────────────────────────
%
%  WARMUP  (run first, at session start)
%  ──────
%  warmup/warmup_task2_reconstruct.m
%      Student reconstructs last session's synthetic EEG from scratch.
%      No solutions needed — instructor checks against the solution file.
%
%  PART 1  (run before Parts 2 and 3)
%  ──────
%  part1/part1_matrices_forloops.m
%      CONCEPTS: zeros(), size(), for-loop, M(row,:), rand() vs randn()
%      Creates: eeg [8×2000], t [1×2000], n_channels, fs
%      *** All later scripts depend on these variables ***
%
%  PART 2
%  ──────
%  part2/part2a_stacked_plot.m
%      CONCEPTS: hold on, vertical offset, RGB colour, yticks, yticklabels
%      Run AFTER part1 (needs eeg, t, n_channels)
%
%  part2/plot_eeg_stack.m           <-- STUDENT writes this
%      CONCEPTS: 4-argument function, size(M,1), no hard-coded values
%
%  PART 3
%  ──────
%  part3/part3_findpeaks.m
%      CONCEPTS: name-value args, findpeaks(), mean/std threshold,
%                two output variables, sprintf in title
%      Run AFTER part1 (needs eeg, t)
%
%  HOMEWORK  (complete before next session)
%  ────────
%  homework/hw1_multichannel_peaks.m     Loop + pre-allocation + fprintf
%  homework/hw2_plot_eeg_stack_nargin.m  nargin, optional 5th argument
%  homework/hw3_exploration.m            4 open-ended experiments + notebook
%
%  SOLUTIONS  (instructor use only)
%  ─────────
%  solutions/warmup_task2_SOLUTION.m
%  solutions/plot_eeg_stack_SOLUTION.m
%  solutions/hw1_multichannel_peaks_SOLUTION.m
%  solutions/hw2_plot_eeg_stack_nargin_SOLUTION.m
%  solutions/hw3_exploration_SOLUTION.m
%
%
% QUICK REFERENCE — NEW MATLAB CONCEPTS THIS SESSION
% ──────────────────────────────────────────────────────────────
%
%  zeros(r, c)                    Pre-allocate r×c matrix of zeros
%  size(M)                        Returns [rows, cols]
%  size(M, 1)                     Rows only
%  size(M, 2)                     Cols only
%  M(i, :)                        Row i, all columns
%  M(:, j)                        All rows, column j
%  hold on                        Keep existing plot lines
%  yticks / yticklabels           Custom y-axis tick positions and labels
%  arrayfun(@(x) f(x), vec)       Apply function to each element of a vector
%  findpeaks(sig, t, 'Opt', val)  Detect local maxima; returns [pks, locs]
%  [a, b] = func(...)             Capture two output variables
%  ~                              Discard an output variable
%  sprintf('text %d', n)          Build a string with a number embedded
%  nargin                         Count of arguments passed to a function
%
% ============================================================
