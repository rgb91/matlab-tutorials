%% DEMO 1: Full EEG processing pipeline

addpath("/Users/sanjaysaha/Projects/matlab-tutorials/lecture_10/data/")

load("pipeline_eeg.mat")

%% Check the data
fprintf("Loaded %d channels, %d samples, sampling freq = %d Hz\n", ...
    size(data,1), ...
    size(data,2), ...
    fs)


%% Pick one channel to work with
ch_idx = 2;
raw = data(ch_idx, :);
fprintf("Working with channel: %s\n", ch_names{ch_idx})


figure;
plot(time, raw, 'g', 'LineWidth', 1.3);
xlim([0 1]);
grid on;


%% Let's look at the raw spectrum -- FFT, Spectrum analysis (manual)
[f_raw, amp_raw] = get_spectrum(raw, fs);

figure;
subplot(2, 1, 1);
plot(time, raw, 'g', 'LineWidth', 1.3);
xlabel('Time (s)');
ylabel('Amp');
title_1 = sprintf("Raw Signal: Channel %s - time domain", ch_names{ch_idx});
title(title_1);
xlim([0 1]);
grid on;

subplot(2, 1, 2);
plot(f_raw, amp_raw, 'w', 'LineWidth', 1.3);
xlim([0 80]);
xlabel('Freq');
ylabel('Amp');
title("Raw Spectrum");
grid on;


%% Filtering -- Notch -- remove 60 hz line noise
nyquist = double(fs) / 2.0;
window = [59 61];
[b_notch, a_notch] = butter(4, window/nyquist, "stop");  % co-efficient
notched = filtfilt(b_notch, a_notch, raw);  % notched signal - time domain

[f_notched, amp_notched] = get_spectrum(notched, fs);


figure;
subplot(2, 2, 1);
plot(time, raw, 'g', 'LineWidth', 1.3);
xlabel('Time (s)');
ylabel('Amp');
title_1 = sprintf("Raw Signal: Channel %s - time domain", ch_names{ch_idx});
title(title_1);
xlim([0 1]);
grid on;

subplot(2, 2, 2);
plot(f_raw, amp_raw, 'w', 'LineWidth', 1.3);
xlim([0 80]);
xlabel('Freq');
ylabel('Amp');
title("Raw Spectrum");
grid on;


subplot(2, 2, 3);
plot(time, notched, 'magenta', 'LineWidth', 1.3);
xlabel('Time (s)');
ylabel('Amp');
title_1 = sprintf("NOTCHED Signal: Channel %s - time domain", ch_names{ch_idx});
title(title_1);
xlim([0 1]);
grid on;

subplot(2, 2, 4);
plot(f_notched, amp_notched, 'Color', [0.9, 0.9, 0.9], 'LineWidth', 1.3);
xlim([0 80]);
xlabel('Freq');
ylabel('Amp');
title("NOTCHED Spectrum");
grid on;



%% Filtering -- Bandpass filter -- keep only alpha freq (8-13 Hz)
nyquist = double(fs) / 2.0;
window = [8 13];
[b_bp, a_bp] = butter(4, window/nyquist, "bandpass");  % co-efficient
bp_signal = filtfilt(b_bp, a_bp, notched);  % notched signal - time domain

[f_bp, amp_bp] = get_spectrum(bp_signal, fs);


figure;
subplot(2, 2, 1);
plot(time, raw, 'g', 'LineWidth', 1.3);
xlabel('Time (s)');
ylabel('Amp');
title_1 = sprintf("Raw Signal: Channel %s - time domain", ch_names{ch_idx});
title(title_1);
xlim([0 1]);
grid on;

subplot(2, 2, 2);
plot(f_raw, amp_raw, 'w', 'LineWidth', 1.3);
xlim([0 80]);
xlabel('Freq');
ylabel('Amp');
title("Raw Spectrum");
grid on;


subplot(2, 2, 3);
plot(time, bp_signal, 'cyan', 'LineWidth', 1.3);
xlabel('Time (s)');
ylabel('Amp');
title_1 = sprintf("NOTCHED >> BANDPASS Signal: Ch %s - time domain", ch_names{ch_idx});
title(title_1);
xlim([0 1]);
grid on;

subplot(2, 2, 4);
plot(f_bp, amp_bp, 'Color', [0.9, 0.9, 0.9], 'LineWidth', 1.3);
xlim([0 80]);
xlabel('Freq');
ylabel('Amp');
title("NOTCHED >> BANDPASS Spectrum");
grid on;



%% SAME THING as above -- but using clean_eeg
cleaned_signal = clean_eeg(raw, fs, 8, 13);

figure;
plot(time, bp_signal); hold on;
plot(time, cleaned_signal, 'r--');
legend("Step by step", "clean\_eeg function");
title("Verification -- comparison of step-by-step and clean\_eeg function");



%% Clean all channels
cleaned_data = zeros(size(data));
for ch = 1:size(data, 1)
    cleaned_data(ch,:) = clean_eeg(data(ch,:), fs, 8, 13);
end

figure;
offset = 15;
for ch = 1:size(data, 1)
    plot(time, cleaned_data(ch,:) + (ch-1)*offset); hold on;
end
yticks((0:7)*offset);
yticklabels(ch_names);
xlabel('Time (s)');
title('All 8 Channels — Alpha Band (8–13 Hz)');

fprintf('\nPipeline complete!\n');
fprintf('Summary: load → notch (60 Hz) → bandpass (8–13 Hz) → verify with spectrum\n');
