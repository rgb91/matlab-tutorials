%% SOLUTION — EXERCISE 2: FILTERING
%  ──────────────────────────────────

%% Task 1: Isolate theta (4–8 Hz) from Oz
load('eeg_recording.mat');
signal = data(4, :);  % Oz

nyquist = fs / 2;     % 128 Hz

[b, a] = butter(4, [4 8] / nyquist, 'bandpass');
theta_signal = filtfilt(b, a, signal);

% Plot
figure;
subplot(2,1,1);
plot(time, signal, 'Color', [0.7 0.7 0.7]); hold on;
plot(time, theta_signal, 'r', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Theta Bandpass (4–8 Hz)');
legend('Raw', 'Theta');

subplot(2,1,2);
[f_raw, amp_raw]     = get_spectrum(signal, fs);
[f_theta, amp_theta] = get_spectrum(theta_signal, fs);
plot(f_raw, amp_raw, 'Color', [0.7 0.7 0.7]); hold on;
plot(f_theta, amp_theta, 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Spectra: Raw vs Theta');
xlim([0 30]);
legend('Raw', 'Theta');

%% Task 2: Notch-filter 60 Hz
load('noisy_eeg.mat');

[b_notch, a_notch] = butter(4, [59 61] / nyquist, 'stop');
cleaned = filtfilt(b_notch, a_notch, noisy_signal);

[f1, amp1] = get_spectrum(noisy_signal, fs);
[f2, amp2] = get_spectrum(cleaned, fs);

figure;
plot(f1, amp1, 'Color', [0.7 0.7 0.7]); hold on;
plot(f2, amp2, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Notch Filter: 60 Hz Removed');
xlim([0 80]);
legend('Noisy', 'Cleaned');

%% Task 3: Dominant frequency after filtering
[peak_amp, idx] = max(amp2);
fprintf('Dominant frequency: %.1f Hz\n', f2(idx));
% Expected: ~10 Hz (alpha component)

%% Task 4 (Challenge): Isolate 20 Hz beta
load('eeg_recording.mat');  % reload in case workspace changed
signal = data(4, :);

[b_beta, a_beta] = butter(4, [18 22] / nyquist, 'bandpass');
beta_signal = filtfilt(b_beta, a_beta, signal);

figure;
subplot(3,1,1);
plot(time, signal, 'Color', [0.5 0.5 0.5]);
xlabel('Time (s)'); ylabel('Amp');
title('Raw Oz Signal');

subplot(3,1,2);
plot(time, theta_signal, 'r', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amp');
title('Theta Band (4–8 Hz)');

subplot(3,1,3);
plot(time, beta_signal, 'Color', [0 0.6 0], 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amp');
title('Beta Band (18–22 Hz)');

sgtitle('Frequency Band Isolation');

fprintf('\n--- Exercise 2 solution complete! ---\n');
