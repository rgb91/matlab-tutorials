%% DEMO 1: FULL EEG PROCESSING PIPELINE
%  Session 10 — 27 June 2026
%  Carry-over from Session 9: the complete load-to-spectrum workflow.
%  ─────────────────────────────────────────────────────────────────

%% Step 1: Load the raw data
load('pipeline_eeg.mat');   % data (8×1024), fs, ch_names, time
fprintf('Loaded %d channels, %d samples, fs = %d Hz\n', ...
    size(data,1), size(data,2), fs);

% Pick one channel to work with
ch_idx = 2;                      % Cz
raw = data(ch_idx, :);
fprintf('Working with channel: %s\n', ch_names{ch_idx});

%% Step 2: Look at the raw spectrum
[f_raw, amp_raw] = get_spectrum(raw, fs);

figure;
subplot(2,1,1);
plot(time, raw);
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title(sprintf('Raw %s — Time Domain', ch_names{ch_idx}));

subplot(2,1,2);
plot(f_raw, amp_raw);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Raw Spectrum');
xlim([0 80]);
% You should see peaks at 6, 10, 20 Hz AND a spike at 60 Hz (noise)

%% Step 3: Notch filter — remove 60 Hz line noise
nyquist = double(fs)/double(2);
[b_notch, a_notch] = butter(4, [59 61]/nyquist, 'stop');
notched = filtfilt(b_notch, a_notch, raw);

% Check the spectrum after notching
[f_notch, amp_notch] = get_spectrum(notched, fs);

figure;
subplot(2,1,1);
plot(f_raw, amp_raw); hold on;
plot(f_notch, amp_notch, 'r');
legend('Raw', 'After Notch');
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Effect of Notch Filter');
xlim([0 80]);

subplot(2,1,2);
plot(f_notch, amp_notch, 'r');
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('After Notch — 60 Hz removed');
xlim([0 80]);
% The 60 Hz spike should be gone; 6, 10, 20 Hz should remain

%% Step 4: Bandpass filter — isolate alpha band (8–13 Hz)
[b_bp, a_bp] = butter(4, [8 13]/nyquist, 'bandpass');
alpha_signal = filtfilt(b_bp, a_bp, notched);

[f_alpha, amp_alpha] = get_spectrum(alpha_signal, fs);

figure;
subplot(2,1,1);
plot(time, notched); hold on;
plot(time, alpha_signal, 'r', 'LineWidth', 1.5);
legend('After Notch', 'Alpha Band Only');
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title('Time Domain — Alpha Extraction');

subplot(2,1,2);
plot(f_notch, amp_notch); hold on;
plot(f_alpha, amp_alpha, 'r', 'LineWidth', 1.5);
legend('After Notch', 'Alpha Band');
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Spectrum — Only 10 Hz peak survives');
xlim([0 40]);

%% Step 5: Using the clean_eeg function (from homework)
%  Now let's do the same thing in one line using clean_eeg:
cleaned = clean_eeg(raw, fs, 8, 13);

% Verify it matches our step-by-step result
figure;
plot(time, alpha_signal); hold on;
plot(time, cleaned, 'r--');
legend('Step-by-step', 'clean\_eeg function');
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title('Verification: clean\_eeg matches our manual pipeline');

%% Step 6: Process ALL channels in a loop
cleaned_all = zeros(size(data));
for ch = 1:size(data, 1)
    cleaned_all(ch, :) = clean_eeg(data(ch, :), fs, 8, 13);
end

% Plot all cleaned channels
figure;
offset = 15;  % vertical spacing between channels
for ch = 1:size(data, 1)
    plot(time, cleaned_all(ch, :) + (ch-1)*offset); hold on;
end
yticks((0:7)*offset);
yticklabels(ch_names);
xlabel('Time (s)');
title('All 8 Channels — Alpha Band (8–13 Hz)');

fprintf('\nPipeline complete!\n');
fprintf('Summary: load → notch (60 Hz) → bandpass (8–13 Hz) → verify with spectrum\n');
