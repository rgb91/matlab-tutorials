%% SIGNAL Generation
%  Key idea: real EEG is a mixture of oscillations at different
%  frequencies. We can build a convincing fake one by summing
%  sine waves at brain-rhythm frequencies.
%
%  Brain rhythm bands:
%    Delta  (δ) : 0.5 – 4  Hz   deep sleep
%    Theta  (θ) : 4  – 8   Hz   drowsiness, memory
%    Alpha  (α) : 8  – 13  Hz   relaxed, eyes closed
%    Beta   (β) : 13 – 30  Hz   alert, active thinking
%    Gamma  (γ) : 30 – 80  Hz   high-level processing

Fs = 256;
T = 4;
t = 0: 1/Fs : T;  % time - data points

alpha_wave = 0.5 * sin(2*pi * 10 * t);  % t
beta_wave = 0.8 * sin(2*pi * 20 * t);
theta_wave = 1.5 * sin(2*pi * 6 * t);   % t
noise_signal = 0.5 * randn(1, length(t));     % t

eeg_signal = alpha_wave + theta_wave + beta_wave + noise_signal;

% ===== plotting - single signal
% figure;
% plot(t, eeg_signal, 'g', 'LineWidth', 1.2);
% xlabel('Time (seconds)');
% ylabel('Amplitude');
% title('Alpha band 8 Hz Wave');
% grid on;


% ===== plotting - multiple signals
figure;
subplot(5, 1, 1); plot(t, alpha_wave, 'b'); xlabel('Time'); ylabel('Alpha'); xlim([0 T]); grid on;
subplot(5, 1, 2); plot(t, beta_wave, 'g'); xlabel('Time'); ylabel('Beta'); xlim([0 T]);  grid on;
subplot(5, 1, 3); plot(t, theta_wave, 'y'); xlabel('Time'); ylabel('Theta'); xlim([0 T]);  grid on;
subplot(5, 1, 4); plot(t, noise_signal, 'Color', [0.3, 0.3, 0.3]); xlabel('Time'); ylabel('Noise'); xlim([0 T]);  grid on;
subplot(5, 1, 5); plot(t, eeg_signal, 'w'); xlabel('Time'); ylabel('EEG'); xlim([0 T]);  grid on;
sgtitle('Synthetic EEG signals')


% t is the timestamps
% t itself is a vector with positions from 1:4*256
% zooming in: take only the positions where value <= 0.5 seconds

% indices_500ms = t <= 0.5;
% 
% figure;
% plot(t(indices_500ms), eeg_signal(indices_500ms), 'w', 'LineWidth', 1.2);
% xlabel('Time (seconds)');
% ylabel('Amplitude');
% title('Synthetic EEG signals');
% grid on;