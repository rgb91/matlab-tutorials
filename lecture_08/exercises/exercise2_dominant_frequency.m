%% EXERCISE 2 - Dominant frequency and power spectrum
% Session 8 take-home. Fill in every TODO.

clear; clc; close all;

% Given signal (do NOT change):
Fs = 256; t = (0:1/Fs:4-1/Fs)';
rng(1);
x = 0.4*sin(2*pi*5*t) + 1.5*sin(2*pi*18*t) + 0.7*sin(2*pi*33*t) + 0.2*randn(numel(t),1);
N = length(x);

% Step 1: single-sided amplitude spectrum (reuse the recipe)
Y = fft(x);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f  = (0:N/2)'*(Fs/N);

% TODO 1: compute the POWER spectrum (amplitude squared)
Pow = ;          % <-- fill in

% TODO 2: find the dominant frequency (the one with the largest amplitude)
[peakAmp, idx] = ;   % <-- use max(P1)
domFreq = ;          % <-- convert idx to a frequency using f
fprintf('Dominant frequency = %.2f Hz\n', domFreq);

% TODO 3: find the top 3 frequencies using sort(...,'descend')
[~, order] = ;       % <-- sort P1 descending
top3 = ;             % <-- f(order(1:3))
disp('Top 3 frequencies (Hz):'); disp(top3);

% TODO 4: plot amplitude spectrum and power spectrum as two subplots,
%         limit the x-axis to 0..50 Hz, and label everything.

% CHECK: the dominant frequency should be 18 Hz; the top 3 should be
% 18 Hz, 33 Hz and 5 Hz (in that order of strength).
