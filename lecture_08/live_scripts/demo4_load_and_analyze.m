%% DEMO 4 - PUTTING IT TOGETHER: load a file, then find its frequencies
% Session 8 - Signal Processing I
%
% This is the workflow the student will reuse on real EEG data all term:
%   LOAD -> PLOT TIME DOMAIN -> FFT -> PLOT SPECTRUM -> REPORT DOMINANT FREQ
%
% The four steps below never change, regardless of what the data is.
% Learn this pattern once and you can analyse any EEG file the course gives you.

clear; clc; close all;
dataDir = 'data';

%% 1. LOAD the data from the .mat file
% load() into a struct S so that S.signal, S.fs, S.t don't clash with any
% other workspace variables. This is the safe way to load (see Demo 3).
S = load(fullfile(dataDir,'eeg_sample.mat'));
x  = S.signal;        % the recorded signal (column vector of amplitude values)
Fs = S.fs;            % sampling rate in Hz — MUST come from the file, not guessed
t  = S.t;             % time vector in seconds (already precomputed and stored)
N  = length(x);       % number of samples; length() of a column = number of rows

%% 2. Look at the raw signal in the time domain
% Always plot raw data FIRST before any analysis. It helps spot obvious
% artefacts (flat lines, sudden jumps) that would corrupt the FFT result.
figure;
subplot(2,1,1);   % subplot(rows, cols, which): 2-row figure, top panel
plot(t, x); xlim([0 1]);   % show just the first 1 second so detail is visible
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title('Step 1-2: raw signal (time domain)');

%% 3. FFT -> single-sided amplitude spectrum
% This is the STANDARD FFT PIPELINE from Demo 1. Copy-paste this block
% any time you need to go from a time-domain signal to a frequency spectrum.
%
%   Y  = fft(x)            -> complex spectrum, N values
%   P2 = abs(Y/N)          -> normalised magnitude (two-sided)
%   P1 = P2(1:N/2+1)       -> keep positive-frequency half only
%   P1(2:end-1) *= 2       -> double non-endpoint bins to restore full energy
%   f  = (0:N/2)'*(Fs/N)  -> matching frequency axis in Hz
Y  = fft(x);               % FFT: N time samples -> N complex frequency bins
P2 = abs(Y/N);             % magnitude, divided by N to normalise amplitude
P1 = P2(1:N/2+1);          % discard the mirrored (negative-frequency) half
P1(2:end-1) = 2*P1(2:end-1); % compensate for discarded half by doubling
f  = (0:N/2)'*(Fs/N);     % frequency axis: 0 Hz to Nyquist (Fs/2) Hz

subplot(2,1,2);   % bottom panel of the same figure
plot(f, P1, 'LineWidth', 1.1); xlim([0 50]); grid on;
% xlim([0 50]) zooms to 0-50 Hz; typical EEG rhythms are all below 40 Hz:
%   delta 0.5-4 Hz | theta 4-8 Hz | alpha 8-13 Hz | beta 13-30 Hz | gamma 30-80 Hz
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Step 3-4: amplitude spectrum (frequency domain)');

%% 4. REPORT the dominant frequency
% max() returns the value AND index of the largest element.
% We convert the index to Hz using the frequency axis f.
[peakAmp, idx] = max(P1);
domFreq = f(idx);   % frequency in Hz corresponding to the tallest peak
fprintf('This recording is dominated by activity at %.2f Hz\n', domFreq);
% EXPECTED: 8.00 Hz  (this is the frequency we hid inside eeg_sample.mat)
% 8 Hz falls in the theta/alpha border — often seen during relaxed wakefulness

% TALKING POINT: you have just taken a file of raw numbers and discovered
% the rhythm hidden inside it. That is exactly what EEG frequency analysis
% does - the data files later in the course will be real recordings, but
% the four steps above never change:
%
%   1. load(...)          -- get data from disk into MATLAB
%   2. plot(t, x)         -- inspect raw signal; check for artefacts
%   3. [standard FFT]     -- convert to frequency domain
%   4. max(P1), f(idx)    -- find and report the dominant frequency
%
% In Lectures 9-10 you will extend Step 3 to band-pass filtering and
% epoching, but the load-plot-FFT core stays the same.
