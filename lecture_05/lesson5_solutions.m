%% ============================================================
%  SOLUTIONS  |  Lesson 5
%  Custom Functions & First EEG Signals
%  *** FOR INSTRUCTOR USE ***
% ============================================================

%% ============================================================
%  PART A SOLUTIONS
% ============================================================

%% A4 – normalize_signal.m (content of the file)
% function z = normalize_signal(x)
%     z = (x - mean(x)) / std(x);
% end

% Test:
raw      = [10, 14, 9, 16, 13, 11, 15, 12];
norm_sig = (raw - mean(raw)) / std(raw);   % inline equivalent
fprintf('Mean of normalized: %.6f\n', mean(norm_sig));
fprintf('Std  of normalized: %.6f\n', std(norm_sig));

figure;
subplot(2,1,1); plot(raw, 'ro-', 'LineWidth', 1.5);
title('Raw'); ylabel('Value'); grid on;
subplot(2,1,2); plot(norm_sig, 'bo-', 'LineWidth', 1.5);
title('Z-scored'); ylabel('Z-score'); xlabel('Sample'); grid on;


%% ============================================================
%  PART C SOLUTIONS
% ============================================================

Fs = 256; T = 4;
t  = 0 : 1/Fs : T - 1/Fs;

alpha_wave = 3.0 * sin(2*pi * 10 * t);
theta_wave = 1.5 * sin(2*pi *  6 * t);
noise      = 0.5 * randn(1, length(t));
eeg_signal = alpha_wave + theta_wave + noise;

%% C1 – Add beta wave
beta_wave  = 0.8 * sin(2*pi * 20 * t);
eeg_with_beta = alpha_wave + theta_wave + beta_wave + noise;

figure('Name', 'EEG with Beta Added');
subplot(5,1,1); plot(t, alpha_wave, 'b'); ylabel('Alpha'); xlim([0 T]); grid on;
subplot(5,1,2); plot(t, theta_wave, 'r'); ylabel('Theta'); xlim([0 T]); grid on;
subplot(5,1,3); plot(t, beta_wave,  'm'); ylabel('Beta');  xlim([0 T]); grid on;
subplot(5,1,4); plot(t, noise, 'Color', [0.6 0.6 0.6]); ylabel('Noise'); xlim([0 T]); grid on;
subplot(5,1,5); plot(t, eeg_with_beta, 'w'); ylabel('Sum'); xlabel('Time (s)'); xlim([0 T]); grid on;
sgtitle('Synthetic EEG with Beta Added');

%% C2 – Zoom to 500 ms
idx_500ms = t <= 0.5;
figure;
plot(t(idx_500ms), eeg_signal(idx_500ms), 'w', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude (µV)');
title('Synthetic EEG – First 500 ms'); grid on;

%% C3 – Weak alpha, strong noise
alpha_weak  = 0.5 * sin(2*pi * 10 * t);
noise_heavy = 2.0 * randn(1, length(t));
eeg_noisy   = alpha_weak + theta_wave + noise_heavy;

figure;
subplot(2,1,1); plot(t, eeg_signal, 'w'); title('Original EEG'); ylabel('µV'); xlim([0 T]); grid on;
subplot(2,1,2); plot(t, eeg_noisy,  'w'); title('High Noise EEG'); ylabel('µV'); xlabel('Time (s)'); xlim([0 T]); grid on;
% Observation: the oscillatory structure is buried — mirrors a noisy real recording


%% ============================================================
%  HOMEWORK SOLUTIONS
% ============================================================

%% Exercise 1 – normalize_signal.m (same as A4 above)

%% Exercise 2 – Brain Band Frequency Explorer
Fs    = 256; T = 2;
t2    = 0 : 1/Fs : T - 1/Fs;
freqs = [2,   6,    10,    20,   40];
names = {'Delta – 2 Hz', 'Theta – 6 Hz', 'Alpha – 10 Hz', ...
         'Beta – 20 Hz', 'Gamma – 40 Hz'};

figure('Name', 'Brain Band Explorer');
for k = 1:5
    wave = sin(2*pi * freqs(k) * t2);
    subplot(6, 1, k);
    plot(t2, wave, 'LineWidth', 1.2);
    title(names{k});
    ylabel('µV');
    xlim([0 T]); grid on;
    if k < 5; set(gca, 'XTickLabel', []); end
end

% BONUS: 6th subplot — all summed
summed = zeros(1, length(t2));
for k = 1:5
    summed = summed + sin(2*pi * freqs(k) * t2);
end
subplot(6, 1, 6);
plot(t2, summed, 'k', 'LineWidth', 1.2);
title('All Bands Summed');
ylabel('µV'); xlabel('Time (s)');
xlim([0 T]); grid on;

%% Exercise 3 – Written answer key
% Q1: A controls amplitude (height of the wave, in µV)
%     f controls frequency (oscillation speed, in Hz)
%     t is the time vector that determines when each sample is
%
% Q2: Max frequency = 256/2 = 128 Hz. This matters because EEG
%     contains gamma up to ~80 Hz — 128 Hz gives comfortable headroom.
%     Sampling below 160 Hz would risk aliasing gamma.
%
% Q3: The oscillatory structure would be hidden under noise —
%     the trace would look like random white noise.
%     This mirrors a real recording with poor electrode contact,
%     muscle artefacts, or electrical interference.
%
% Q4: Different participants have different overall EEG amplitudes
%     due to skull thickness, electrode impedance, etc.
%     Z-scoring removes this between-subject amplitude difference
%     so you can compare the SHAPE/pattern of the signal fairly.
