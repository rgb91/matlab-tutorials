%% WARMUP — File I/O Revision (Session 10)
%  5 quick tasks to refresh what we learned last session.
%  You have 10 minutes. Work through each task in order.
%  ──────────────────────────── ─────────────────────────

%% Task 1: Load a .mat file
%  Load 'pipeline_eeg.mat' from the data folder.
%  Use whos to check what variables arrived in the workspace.
%  Q: How many channels are in 'data'? How many samples?

% TODO: your code here


%% Task 2: Access channels from the loaded data
%  Extract channel 3 (row 3) from the data matrix.
%  Print the channel name using ch_names (remember: use {} for cell arrays).
%  Q: What is the name of channel 3?

% TODO: your code here


%% Task 3: Load a CSV file
%  Load 'pipeline_eeg.csv' using readmatrix.
%  Q: What size is the resulting matrix? How does it compare to the .mat?

% TODO: your code here


%% Task 4: Load with readtable
%  Load 'pipeline_eeg.csv' using readtable.
%  Access the column called 'Cz' using dot notation.
%  Q: How many values does T.Cz contain?

% TODO: your code here


%% Task 5: Orientation check
%  The .mat file stores data as 8 × 1024 (channels × samples).
%  The .csv stores it as 1024 × 8 (samples × channels).
%  Extract channel 1 from BOTH and verify they match.
%  Hint: you may need to transpose one of them.

% TODO: your code here

