%% WARMUP — File I/O Revision — SOLUTION
%  Session 10 — 27 June 2026
%  ─────────────────────────────────────────────────────

%% Task 1: Load a .mat file
load('data/pipeline_eeg.mat');
whos
% ANSWER: data is 8 × 1024  →  8 channels, 1024 samples
fprintf('Channels: %d, Samples: %d\n', size(data, 1), size(data, 2));

%% Task 2: Access channels
ch3 = data(3, :);
fprintf('Channel 3 name: %s\n', ch_names{3});
% ANSWER: Channel 3 is 'Pz'

%% Task 3: Load CSV with readmatrix
csv_data = readmatrix('data/pipeline_eeg.csv');
fprintf('CSV size: %d × %d\n', size(csv_data, 1), size(csv_data, 2));
% ANSWER: 1024 × 8 — rows = samples, columns = channels (TRANSPOSED)

%% Task 4: Load with readtable
T = readtable('data/pipeline_eeg.csv');
cz_col = T.Cz;
fprintf('T.Cz has %d values\n', length(cz_col));
% ANSWER: 1024 values (one per time point)

%% Task 5: Orientation check
ch1_mat = data(1, :);            % row 1 from .mat   → 1 × 1024
ch1_csv = csv_data(:, 1)';       % col 1 from .csv   → 1024 × 1, transpose to row

% Check they match (within floating-point tolerance)
if max(abs(ch1_mat - ch1_csv)) < 1e-6
    fprintf('Match! Both are channel Fz with %d samples.\n', length(ch1_mat));
else
    fprintf('Mismatch — check your indexing.\n');
end
