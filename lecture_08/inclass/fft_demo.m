%% DEMO 1 - FFT BASICS: from time domain to frequency domain
% Session 8 - Signal Processing I
% Run this section-by-section in the Live Editor / by pressing Ctrl+Enter.
%
% GOAL: build a signal whose frequencies we already KNOW, then use the FFT
%       to recover those frequencies. Because we built the signal, we can
%       check that the FFT gives the right answer.
clc;
clearvars;

%% Build a Test Signal - mixture of multiple signals
% makeSine(Amp, f, Fs, dur)
Fs = 256;
dur = 4;
[~, y1] = makeSine(1.0, 8,  Fs, dur);
[~, y2] = makeSine(0.5, 15, Fs, dur);
[t, y3] = makeSine(0.3, 30, Fs, dur);

N = length(t);
y = y1 + y2 + y3;  % mixed wave/signal

figure;
plot(t, y);
xlim([0 0.5]);
grid on;

%% FFT - Fast Fourier Transform
y_fft = fft(y);

%  Build the frequency axis and look at the RAW two-sided result
f_full = (0:N-1)'*(Fs/N);  % x-axis

figure;
plot(f_full, abs(y_fft)/N);
xlabel('Frequency (Hz)');
ylabel('|y_fft| / N');
title('Raw FFT magnitude (two-sided) - note the mirror image after Fs/2');

%% Center the spectrum 
y_fft_shift = fftshift(y_fft);
f_centered = (-N/2:N/2-1)' * (Fs/N);

figure;
plot(f_centered, abs(y_fft_shift)/N);
xlabel('Frequency (Hz)');
ylabel('|y_fft_shift| / N');
title('fftshift: spectrum centred on 0 Hz (-ve and +ve frequencies)');

%% Amplitude Spectrum
P2 = abs(y_fft/N);
P1 = (1:N/2+1);  % Nyquist frequency - half freq
P1(2:end-1) = 2*P1(2:end-1);

f = (0:N/2)' * (Fs/N);

figure;
plot(f, P1, 'LineWidth', 1.3);
xlabel('Frequency (Hz)');
ylabel('Amp')
% xlim([0 50]);
grid on;