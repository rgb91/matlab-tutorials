%% EXERCISE 1: FILE I/O
%  Practice loading data from different file types.
%  Replace the TODO lines with your code.
%  ─────────────────────────────────────────────────

%% Task 1: Load the .mat file
%  Load 'eeg_recording.mat' and answer the questions below.

% TODO: Load the file


% TODO: How many channels are in the data? Store in n_channels.


% TODO: How many time points? Store in n_samples.


% TODO: Print both values using fprintf
%        Expected output:  "Channels: 8, Samples: 1024"


%% Task 2: Extract and plot a specific channel
%  Extract channel 4 (Oz) from the data matrix and plot it.

% TODO: Extract Oz (row 4 of data) into a variable called oz


% TODO: Create a figure and plot oz against time


% TODO: Add labels: x = 'Time (s)', y = 'Amplitude', title = channel name


%% Task 3: Load the CSV file two ways
%  Load 'eeg_data.csv' using BOTH readmatrix and readtable.

% TODO: Load with readmatrix, store in csv_matrix


% TODO: Load with readtable, store in csv_table


% TODO: What is the size of csv_matrix? Print it with fprintf.
%        (Hint: it should be 1024 × 8 — rows are time, columns are channels)


% TODO: Display the column names from csv_table
%        (Hint: csv_table.Properties.VariableNames)


%% Task 4: Compare .mat and .csv data
%  The .mat file stores data as 8×1024 (channels × samples).
%  The .csv file stores data as 1024×8 (samples × channels).
%  Verify they contain the same data.

% TODO: Extract column 4 from csv_matrix (the Oz column)
%        Store in oz_from_csv


% TODO: Compare oz (from .mat, Task 2) with oz_from_csv
%        Use: isequal(round(oz,4), round(oz_from_csv',4))
%        Why do we transpose? Why round?


%% Task 5: Load the text file
%  Load 'eeg_params.txt' and extract the sampling rate.

% TODO: Load with readtable using tab delimiter and no header
%        params = readtable('eeg_params.txt', 'Delimiter', '\t', 'ReadVariableNames', false);


% TODO: Extract the sampling rate (first row, second column)
%        Convert from text to number using str2double
%        Store in fs_check


% TODO: Verify it matches: fprintf('fs from .mat: %d, fs from .txt: %d\n', fs, fs_check);


fprintf('\n--- Exercise 1 complete! ---\n');
