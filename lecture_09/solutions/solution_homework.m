%% SOLUTION — HOMEWORK SESSION 9
%  ──────────────────────────────

%% Task 1: Test clean_eeg()
load('noisy_eeg.mat');
result = clean_eeg(noisy_signal, fs);

[f, amp] = get_spectrum(result, fs);
figure;
plot(f, amp, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('clean\_eeg() Output Spectrum');
xlim([0 50]);
% Peaks at ~6, 10, 20 Hz.  No 60 Hz spike.  Nothing above 40 Hz.

%% Task 2: Multi-channel loop + find strongest alpha
load('eeg_recording.mat');
nyquist = fs / 2;

% Bandpass all channels to 1–40 Hz
filtered_data = zeros(size(data));
[b_bp, a_bp] = butter(4, [1 40] / nyquist, 'bandpass');

for ch = 1:size(data, 1)
    filtered_data(ch, :) = filtfilt(b_bp, a_bp, data(ch, :));
end

% Find the channel with strongest alpha power
[b_alpha, a_alpha] = butter(4, [8 13] / nyquist, 'bandpass');
alpha_power = zeros(1, size(data, 1));

for ch = 1:size(data, 1)
    alpha_sig = filtfilt(b_alpha, a_alpha, filtered_data(ch, :));
    alpha_power(ch) = mean(abs(alpha_sig));
end

[~, best_ch] = max(alpha_power);
fprintf('Strongest alpha channel: %s (index %d)\n', ch_names{best_ch}, best_ch);
% Expected: Oz (index 4)

%% Task 3: Save results
% filtered_data already computed above

save('eeg_filtered.mat', 'filtered_data', 'fs', 'ch_names', 'time');
fprintf('Saved eeg_filtered.mat\n');

writematrix(filtered_data(4,:)', 'oz_filtered.csv');
fprintf('Saved oz_filtered.csv\n');

fprintf('\n--- Homework solution complete! ---\n');
