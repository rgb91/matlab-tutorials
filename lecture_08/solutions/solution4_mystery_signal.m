%% SOLUTION 4 - The mystery signal
clear; clc; close all;
dataDir = 'data';

% 1. load
M = readmatrix(fullfile(dataDir,'mystery_signal.csv'));
t = M(:,1);
x = M(:,2);

% 2. Fs and N
Fs = 1/(t(2)-t(1));
N  = numel(x);

% 3. raw signal
figure;
subplot(2,1,1);
plot(t, x); xlim([0 1]);
xlabel('Time (s)'); ylabel('Amplitude (\muV)'); title('Mystery signal - time domain');

% 4. amplitude spectrum
Y  = fft(x);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f  = (0:N/2)'*(Fs/N);

% 5. dominant frequency + plot
[peakAmp, idx] = max(P1);
domFreq = f(idx);
fprintf('Mystery dominant frequency = %.2f Hz\n', domFreq);

subplot(2,1,2);
plot(f, P1, 'LineWidth', 1.1); xlim([0 50]); grid on; hold on;
plot(domFreq, peakAmp, 'ro', 'MarkerFaceColor','r');
xlabel('Frequency (Hz)'); ylabel('Amplitude'); title('Mystery signal - spectrum');

% 6. ANSWER -> Dominant frequency = 12 Hz
%    (the recording also contains weaker 5 Hz and 25 Hz components)
