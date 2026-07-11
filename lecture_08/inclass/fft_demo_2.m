%% DEMO 2
clc;
clearvars;

%% Build a Test Signal - mixture of multiple signals

Fs = 256; dur = 4;
t = (0:1/Fs:dur-1/Fs)';
N = length(t);

y = 1.0*sin(2*pi*8*t) ...
  + 0.5*sin(2*pi*15*t) ...
  + 0.3*sin(2*pi*30*t) ...
  + 0.15*randn(N,1);   

figure;
plot(t, y);
xlim([0 0.15]);
grid on;

%% FFT

y_fft = fft(y);
P2 = abs(y_fft)/N;
P1 = P2(1:N/2+1);  % amplitude
P1(2:end-1) = 2*P1(2:end-1);
f = (0:N/2)' * (Fs/N);  % frequency

figure;
plot(f, P1, 'LineWidth', 1.1); 
xlim([0 50]); 
grid on;
xlabel('Frequency (Hz)'); 
ylabel('Amplitude');
title('Amplitude spectrum');

%% Power Spectrum

Pow = P1.^2;
figure;
plot(f, Pow, 'LineWidth', 1.1); 
xlim([0 50]); 
grid on;
xlabel('Frequency (Hz)'); 
ylabel('Power');
title('Power spectrum');


%% Dominant Signal
[peak_amp, idx] = max(P1);
dominant_freq = f(idx);

disp(peak_amp);
disp(dominant_freq);


%% Top 3

[sortedAmp, order] = sort(P1, 'descend'); % sort amplitudes high -> low
top3_freqs = f(order(1:3));               % frequencies of the 3 biggest bins
top3_amps  = sortedAmp(1:3);
disp('Top 3 frequencies (Hz) and their amplitudes:');
disp([top3_freqs, top3_amps]);
