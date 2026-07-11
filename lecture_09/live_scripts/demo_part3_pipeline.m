%% PART 3: FULL PIPELINE — LOAD → FILTER → ANALYSE → PLOT
%  Session 9 — 20 June 2026
%  Combines file I/O, bandpass filtering, notch filtering, and spectrum
%  ────────────────────────────────────────────────────────────────────

%% Step 1 — Load the noisy recording
load('noisy_eeg.mat');   % noisy_signal, clean_signal, fs, time

fprintf('Loaded signal: %d samples at %d Hz (%.1f sec)\n', ...
    length(noisy_signal), fs, length(noisy_signal)/fs);

%% Step 2 — Inspect the raw spectrum
[f_raw, amp_raw] = get_spectrum(noisy_signal, fs);

figure('Name', 'Full Pipeline', 'Position', [100 100 900 700]);
subplot(3,2,1);
plot(time, noisy_signal, 'Color', [0.6 0.6 0.6]);
xlabel('Time (s)'); ylabel('Amp');
title('Step 1: Raw Signal');

subplot(3,2,2);
plot(f_raw, amp_raw, 'Color', [0.6 0.6 0.6]);
xlabel('Freq (Hz)'); ylabel('Amp');
title('Step 1: Raw Spectrum');
xlim([0 80]);

%% Step 3 — Notch filter to remove 60 Hz
nyquist = fs / 2;
[b_notch, a_notch] = butter(4, [59 61] / nyquist, 'stop');
after_notch = filtfilt(b_notch, a_notch, noisy_signal);

[f_notch, amp_notch] = get_spectrum(after_notch, fs);

subplot(3,2,3);
plot(time, after_notch, 'Color', [0.2 0.6 0.4]);
xlabel('Time (s)'); ylabel('Amp');
title('Step 2: After Notch (60 Hz removed)');

subplot(3,2,4);
plot(f_notch, amp_notch, 'Color', [0.2 0.6 0.4]);
xlabel('Freq (Hz)'); ylabel('Amp');
title('Step 2: Spectrum After Notch');
xlim([0 80]);

%% Step 4 — Bandpass to keep only 4–30 Hz (theta through beta)
[b_bp, a_bp] = butter(4, [4 30] / nyquist, 'bandpass');
final_signal = filtfilt(b_bp, a_bp, after_notch);

[f_final, amp_final] = get_spectrum(final_signal, fs);

subplot(3,2,5);
plot(time, final_signal, 'b', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amp');
title('Step 3: After Bandpass 4–30 Hz');

subplot(3,2,6);
plot(f_final, amp_final, 'b', 'LineWidth', 1.5);
xlabel('Freq (Hz)'); ylabel('Amp');
title('Step 3: Final Spectrum');
xlim([0 50]);

sgtitle('EEG Processing Pipeline: Load \rightarrow Notch \rightarrow Bandpass');

%% Step 5 — Overlay comparison: raw vs fully processed
figure;
plot(time, noisy_signal, 'Color', [0.7 0.7 0.7]); hold on;
plot(time, final_signal, 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Full Pipeline Result: Raw (grey) vs Processed (blue)');
legend('Raw', 'Notch + Bandpass');

fprintf('\n--- Pipeline complete. ---\n');
