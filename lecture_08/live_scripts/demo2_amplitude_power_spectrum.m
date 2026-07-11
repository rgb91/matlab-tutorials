%% DEMO 2 - AMPLITUDE SPECTRUM, POWER SPECTRUM, DOMINANT FREQUENCIES
% Session 8 - Signal Processing I
% Builds directly on Demo 1.
%
% NEW CONCEPTS:
%   - Adding realistic noise to a signal
%   - Power spectrum = amplitude squared (used in EEG analysis)
%   - Finding peaks automatically with max() and sort()
%   - Understanding frequency resolution (df = Fs/N)

clear; clc; close all;

%% 1. Rebuild the signal, this time WITH a bit of noise (more realistic)
Fs = 256; dur = 4;
t = (0:1/Fs:dur-1/Fs)';
N = length(t);

% rng() seeds the random number generator so you get the SAME "random"
% numbers every time you run this script. Good practice for reproducible
% research — a collaborator can run your code and get identical results.
rng(7);                          % 7 is an arbitrary seed; any integer works

% randn(N,1) generates N values drawn from a standard normal distribution
% (mean 0, standard deviation 1). This models measurement noise in a
% biological recording — small random fluctuations on top of the real signal.
x = 1.0*sin(2*pi*8*t) ...
  + 0.5*sin(2*pi*15*t) ...
  + 0.3*sin(2*pi*30*t) ...
  + 0.15*randn(N,1);             % noise amplitude 0.15 — smaller than the 30 Hz component

figure;
plot(t, x); xlim([0 0.5]);     % zoom to first 0.5 s; the full 4 s looks messy
xlabel('Time (s)'); ylabel('Amplitude');

%% 2. Single-sided amplitude spectrum (same recipe as Demo 1)
% This block is identical to Demo 1 Section 5. Once you have memorised it
% you can paste it into any script that needs frequency analysis.
Y  = fft(x);               % FFT: time domain -> frequency domain (complex)
P2 = abs(Y/N);             % magnitude, normalised: |complex number| = sqrt(re^2 + im^2)
P1 = P2(1:N/2+1);          % keep positive frequencies only (0 Hz .. Nyquist)
P1(2:end-1) = 2*P1(2:end-1); % double the non-endpoint bins to restore full energy
f  = (0:N/2)'*(Fs/N);      % frequency axis: 0 to 128 Hz in steps of 0.25 Hz

%% 3. Power spectrum = amplitude squared
% "Power" in signal processing means amplitude^2.
% Squaring has two useful effects:
%   (a) Large peaks become MUCH larger relative to small noise
%       (e.g., amplitude 1.0 -> power 1.0 vs amplitude 0.15 -> power 0.02)
%   (b) The result matches the physical idea of signal "energy" or "power"
%       (think of electrical power: P = V^2/R)
% EEG papers almost always report power spectra, not amplitude spectra.
%
% The .^ operator means element-wise squaring (apply ^ to every element).
% Contrast with matrix squaring: P1^2 would try matrix multiplication.
Pow = P1.^2;

figure;
subplot(2,1,1);
% subplot(rows, cols, panel_number) divides the figure into a grid
plot(f, P1, 'LineWidth', 1.1); xlim([0 50]); grid on;
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Amplitude spectrum');

subplot(2,1,2);
plot(f, Pow, 'LineWidth', 1.1); xlim([0 50]); grid on;
xlabel('Frequency (Hz)'); ylabel('Power (amplitude^2)');
title('Power spectrum - peaks are sharper, noise is suppressed');
% COMPARE THE TWO PANELS: notice the 8 Hz peak dominates even more in the
% power plot, and the noise floor looks flatter and lower.

%% 4. Find the SINGLE dominant frequency
% max() with two output arguments returns BOTH the value AND its position.
%   [value, position] = max(vector)
[peakAmp, idx] = max(P1);        % peakAmp = largest amplitude; idx = which bin
domFreq = f(idx);                % convert bin index to Hz using the frequency axis
fprintf('Dominant frequency = %.2f Hz  (amplitude %.2f)\n', domFreq, peakAmp);
% EXPECTED: Dominant frequency = 8.00 Hz
% (The 8 Hz component has amplitude 1.0, larger than 0.5 and 0.3)

%% 5. Find the TOP 3 frequencies with sort
% sort() rearranges values; 'descend' means largest first.
% With two output arguments it also returns the ORIGINAL INDICES (the
% permutation that would sort the vector), which lets us look up the
% corresponding frequencies.
[sortedAmp, order] = sort(P1, 'descend'); % sortedAmp: amplitudes high->low
                                           % order: indices into P1 that produced this sort
top3_freqs = f(order(1:3));               % use the top-3 indices to look up Hz values
top3_amps  = sortedAmp(1:3);             % the corresponding amplitudes
disp('Top 3 frequencies (Hz) and their amplitudes:');
disp([top3_freqs, top3_amps]);    % display as a two-column matrix
% EXPECTED (order): ~8 Hz, ~15 Hz, ~30 Hz

% Mark the dominant peak on the amplitude plot as a red circle
figure;
plot(f, P1, 'LineWidth', 1.1); xlim([0 50]); grid on; hold on;
% 'ro' = red circle marker; 'MarkerFaceColor','r' fills the circle solid red
plot(domFreq, peakAmp, 'ro', 'MarkerFaceColor', 'r');
% text() places a label string at coordinates (x, y) on the current axes
text(domFreq+1, peakAmp, sprintf('  %.0f Hz', domFreq));
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Dominant frequency marked');

%% 6. (Optional) Why the frequency axis has the spacing it has
% The frequency resolution df is the gap between adjacent FFT bins.
% df = Fs / N = (samples/second) / (samples) = 1/second ... i.e. Hz.
df = Fs/N;                       % spacing between neighbouring frequency bins
fprintf('Frequency resolution df = Fs/N = %.4f Hz\n', df);
% With Fs = 256 and N = 1024:  df = 256/1024 = 0.25 Hz
%
% TALKING POINT: longer recordings (larger N for the same Fs) give a finer
% df, so you can tell close frequencies apart more precisely.
% At df = 0.25 Hz you can distinguish 8 Hz from 8.25 Hz, for example.
% A 1-second recording gives df = 1 Hz — coarser, but sometimes enough.
% This is called the "frequency resolution vs time trade-off."
