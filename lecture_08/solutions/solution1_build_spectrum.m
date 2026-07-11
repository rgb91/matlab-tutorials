%% SOLUTION 1 - Build an amplitude spectrum from scratch
clear; clc; close all;

Fs  = 200;
t   = (0:1/Fs:3-1/Fs)';
x   = 2.0*sin(2*pi*7*t) + 1.0*sin(2*pi*40*t);
N   = length(x);

% 1. FFT
Y = fft(x);

% 2. two-sided magnitude scaled by N
P2 = abs(Y/N);

% 3. single-sided, double the interior bins
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% 4. frequency axis
f = (0:N/2)'*(Fs/N);

% 5. plot
figure;
plot(f, P1, 'LineWidth', 1.2); grid on; xlim([0 60]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Solution 1 - amplitude spectrum (peaks at 7 Hz and 40 Hz)');

% Quick numeric check of peak heights
[~,i7]  = min(abs(f-7));   fprintf('Amplitude at 7 Hz  = %.2f (expected ~2.0)\n', P1(i7));
[~,i40] = min(abs(f-40));  fprintf('Amplitude at 40 Hz = %.2f (expected ~1.0)\n', P1(i40));
