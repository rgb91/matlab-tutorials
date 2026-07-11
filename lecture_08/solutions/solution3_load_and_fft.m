%% SOLUTION 3 - Load data from different file types
clear; clc; close all;
dataDir = 'data';

% 1. load csv
M = readmatrix(fullfile(dataDir,'eeg_sample.csv'));
tCsv   = M(:,1);
sigCsv = M(:,2);

% 2. load txt
sigTxt = readmatrix(fullfile(dataDir,'eeg_sample.txt'));

% 3. confirm identical
maxDiff = max(abs(sigCsv - sigTxt));
fprintf('Largest difference between csv and txt signals = %.2e\n', maxDiff);

% 4. sampling rate from the time column, then amplitude spectrum
Fs = 1/(tCsv(2) - tCsv(1));
N  = numel(sigCsv);
Y  = fft(sigCsv);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f  = (0:N/2)'*(Fs/N);

% 5. dominant frequency + plot
[~, idx] = max(P1);
fprintf('Fs = %g Hz | dominant frequency = %.2f Hz (expected 8 Hz)\n', Fs, f(idx));

figure;
plot(f, P1, 'LineWidth', 1.1); xlim([0 50]); grid on;
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Solution 3 - spectrum of data loaded from file');
