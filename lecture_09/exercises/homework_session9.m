%% HOMEWORK — SESSION 9: FILE I/O & FILTERING
%  Due before Session 10
%  ──────────────────────────────────────────────

%% Homework Task 1: Write a function clean_eeg()
%  Create a function called clean_eeg that:
%    Input:  signal (1-D vector), fs (sampling rate)
%    Output: cleaned signal
%
%  Inside the function:
%    1. Apply a notch filter at 60 Hz (59–61 Hz, 4th-order butter, 'stop')
%    2. Apply a bandpass filter at 1–40 Hz (4th-order butter, 'bandpass')
%    3. Return the result
%
%  Test it:
%    load('noisy_eeg.mat');
%    result = clean_eeg(noisy_signal, fs);
%    Plot the spectrum of result — you should see peaks at 6, 10, and 20 Hz
%    with no 60 Hz spike and nothing above 40 Hz.

% TODO: Create clean_eeg.m as a separate file


%% Homework Task 2: Multi-channel processing loop
%  Load 'eeg_recording.mat'.  Write a for loop that:
%    - Goes through all 8 channels
%    - Bandpass-filters each channel to 1–40 Hz
%    - Stores the filtered data in a new matrix called filtered_data (8×1024)
%
%  After the loop:
%    - Pick the channel with the HIGHEST alpha power (8–13 Hz)
%      Hint: for each channel, bandpass 8–13 Hz, then compute mean(abs(alpha_signal))
%    - Print: "Strongest alpha channel: %s (index %d)\n"
%    - Expected answer: Oz (index 4)

% TODO: Write your code below


%% Homework Task 3: Load, filter, and save
%  This task practises the full pipeline plus SAVING results.
%
%  1. Load 'eeg_recording.mat'
%  2. Filter ALL channels to 4–30 Hz (one loop, same as Task 2 pattern)
%  3. Save the filtered data to a NEW .mat file called 'eeg_filtered.mat'
%     using:  save('eeg_filtered.mat', 'filtered_data', 'fs', 'ch_names', 'time');
%  4. Save ONLY the Oz channel to a CSV file called 'oz_filtered.csv'
%     using:  writematrix(filtered_data(4,:)', 'oz_filtered.csv');
%     (the ' transposes to a column so each row is one time point)

% TODO: Write your code below


fprintf('\n--- Homework complete! ---\n');
