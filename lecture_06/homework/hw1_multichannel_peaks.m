%% HOMEWORK EXERCISE 1 — Loop Over All Channels
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% MATLAB SKILLS PRACTISED:
%   - for-loop over matrix rows
%   - Pre-allocated result arrays (zeros)
%   - Dynamic threshold per channel using mean() and std()
%   - findpeaks() with name-value arguments
%   - fprintf() output formatting
%
% TASK:
%   Extend the peak detection from Part 3 to all 8 channels.
%   For each channel:
%     1. Extract the row as a vector
%     2. Compute a dynamic threshold: mean + 1.5 * std
%     3. Run findpeaks with MinPeakHeight and MinPeakDistance
%     4. Store the number of peaks and mean peak amplitude in pre-allocated arrays
%   After the loop, print a summary table using fprintf.
%
% EXPECTED OUTPUT FORMAT:
%   Channel 1:  14 peaks,  mean amplitude = 2.34
%   Channel 2:  11 peaks,  mean amplitude = 2.18
%   ...
%
% NOTE: Run part1_matrices_forloops.m first so 'eeg', 't', 'n_channels' exist.

% ── YOUR CODE BELOW ──────────────────────────────────────────────────────────

% Step 1: Pre-allocate two result arrays (one for peak counts, one for mean amplitudes)


% Step 2: Loop over all channels


    % 2a. Extract channel data


    % 2b. Compute threshold


    % 2c. Run findpeaks


    % 2d. Store results


% Step 3: Print summary with fprintf


