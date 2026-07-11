%% PART 1 — Matrices & for-Loops
% Session 7 | NSBV BC2001 — MATLAB Summer Prep
%
% MATLAB CONCEPTS COVERED:
%   - zeros(rows, cols)     pre-allocating a 2-D matrix
%   - size(M) / size(M,1)   querying matrix dimensions
%   - M(row, :)             row indexing with colon
%   - for-loop              filling a matrix row by row
%   - rand() vs randn()     uniform vs Gaussian random numbers

%% 1a — Why Pre-allocate?
% ─────────────────────────────────────────────────────────────────────────────
% Without pre-allocation — MATLAB resizes memory on every iteration (slow)
clear v
for i = 1:5
    v(i) = i^2;    % MATLAB has to reallocate the array each time
end
disp(v)

% With pre-allocation — memory reserved once (fast, predictable)
v = zeros(1, 5);   % create the container first: 1 row, 5 columns
for i = 1:5
    v(i) = i^2;    % just fill it in
end
disp(v)

% ── Extend to 2-D ────────────────────────────────────────────────────────────
M = zeros(3, 4);          % 3 rows, 4 columns — all zeros
size(M)                   % returns [3, 4]

[r, c] = size(M);         % capture rows and cols as separate variables
fprintf('Rows: %d   Cols: %d\n', r, c)

M(2, :) = [10 20 30 40];  % fill ALL columns in row 2
disp(M)                   % inspect the whole matrix

% ── PAUSE — questions to answer before continuing ────────────────────────────
% Q1: What would M(:, 2) give you?
% Q2: How many elements in total does zeros(8, 2000) contain?
% Q3: What is the difference between size(M) and length(M)?

%% 1b — Building the Multi-Channel EEG Matrix
% ─────────────────────────────────────────────────────────────────────────────

fs         = 500;                    % samples per second (Hz)
t          = 0 : 1/fs : 4 - 1/fs;  % 4-second time vector (row vector)
n_channels = 8;
n_samples  = length(t);

% PRE-ALLOCATE: 8 rows (channels) × 2000 columns (samples)
eeg = zeros(n_channels, n_samples);

% ── PAUSE: before running, ask ───────────────────────────────────────────────
% "We said 8 channels and 2000 samples. Which is the row, which is the column?"
% Run: size(eeg) — confirm [8, 2000]

for ch = 1 : n_channels

    % Random amplitude variation so each channel looks different
    amp_alpha = 1.5 + rand();        % uniform random in [1.5, 2.5]
    amp_theta = 0.8 + 0.4*rand();    % uniform random in [0.8, 1.2]
    noise_std = 0.2 + 0.1*rand();    % slight noise variation per channel

    % Build the signal for this channel
    alpha = amp_alpha .* sin(2*pi*10*t);   % 10 Hz component
    theta = amp_theta .* sin(2*pi*6*t);    % 6 Hz component

    % Store into row ch — the colon fills ALL columns in that row
    eeg(ch, :) = alpha + theta + noise_std .* randn(1, n_samples);

end

% ── PAUSE — inspect the matrix ───────────────────────────────────────────────
% Run these one at a time and discuss each output:
size(eeg)           % should be [8, 2000]
eeg(1, 1:10)        % first 10 samples of channel 1
eeg(:, 1)           % sample 1 from every channel (a column vector)
eeg(3, :)           % all 2000 samples of channel 3

% ── rand() vs randn() — see the difference ───────────────────────────────────
figure('Name', 'rand vs randn distributions');
subplot(1,2,1)
histogram(rand(1, 10000), 30)
title('rand() — uniform [0, 1]')
xlabel('Value'); ylabel('Count')

subplot(1,2,2)
histogram(randn(1, 10000), 30)
title('randn() — Gaussian (mean=0, std=1)')
xlabel('Value'); ylabel('Count')
