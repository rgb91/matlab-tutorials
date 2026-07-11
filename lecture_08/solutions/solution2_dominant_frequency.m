%% SOLUTION 2 - Dominant frequency and power spectrum
clear; clc; close all;

Fs = 256; t = (0:1/Fs:4-1/Fs)';
rng(1);
x = 0.4*sin(2*pi*5*t) + 1.5*sin(2*pi*18*t) + 0.7*sin(2*pi*33*t) + 0.2*randn(numel(t),1);
N = length(x);

% single-sided amplitude spectrum
Y = fft(x);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f  = (0:N/2)'*(Fs/N);

% 1. power spectrum
Pow = P1.^2;

% 2. dominant frequency
[peakAmp, idx] = max(P1);
domFreq = f(idx);
fprintf('Dominant frequency = %.2f Hz (expected 18 Hz)\n', domFreq);

% 3. top 3 frequencies
[~, order] = sort(P1, 'descend');
top3 = f(order(1:3));
disp('Top 3 frequencies (Hz):'); disp(top3);   % expect 18, 33, 5

% 4. plots
figure;
subplot(2,1,1);
plot(f, P1, 'LineWidth', 1.1); xlim([0 50]); grid on;
xlabel('Frequency (Hz)'); ylabel('Amplitude'); title('Amplitude spectrum');
subplot(2,1,2);
plot(f, Pow, 'LineWidth', 1.1); xlim([0 50]); grid on;
xlabel('Frequency (Hz)'); ylabel('Power'); title('Power spectrum');
