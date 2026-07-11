%% Epoching from Continuous EEG data -- loading data
addpath('/Users/sanjaysaha/Projects/matlab-tutorials/lecture_12/data')
load('continuous_eeg.mat')

n_events = length(event_samples);
n_control = sum(event_type == 1);
n_treatment = sum(event_type == 2);

fprintf("Recording: %d, Channels: %d\n", size(data, 1), size(data,2)/fs);


%% Visualize continuous Pz trace with color-coded events - Pz channel
ch = 2;
figure;
plot(time, data(ch, :), "Color", [0.6 0.6 0.6]); hold on;
for i = 1:n_events
    if event_type(i) == 1
        xline(event_times(i), 'g--')  % control group in blue
    else
        xline(event_times(i), 'r-')  % treatment group in red
    end
end
xlabel("Time (s)"); ylabel("Amp");
title( sprintf("Continuous %s - Control vs Treatment stimuli", ch_names{ch}))
xlim([0 5]);

%% Define the epoch window (same recipe as Session 10)

pre_event_samples = round(0.1*fs);  % num of pre-event samples to take -- 26
post_event_samples = round(0.3*fs);  % num of post-event samples to take -- 77
epoch_length = pre_event_samples + post_event_samples;

s = event_samples(1) - pre_event_samples; % start point / index
e = s + epoch_length - 1;  % end point / index

% epoch
segment = data(ch, s:e);
epoch_time = linspace(-0.1, 0.3, epoch_length);

figure;
plot(epoch_time, segment, "w", "LineWidth", 1.3);
xline(0, 'g--')
grid on;


%% Extraction of All events epochs

epochs_control = [];
epochs_treatment = [];
baseline_idx = epoch_time < 0;

for trial = 1:n_events
    s = event_samples(trial) - pre_event_samples; % start point / index
    e = s + epoch_length - 1; % end point / index

    segment = data(ch, s:e);
    segment = segment - mean(segment(baseline_idx));  % baseline correction

    % store the segments
    if event_type(trial) == 1
        % save in control group list
        epochs_control(end+1, :) = segment; %#ok<SAGROW>
    else
        % save in treatment group list
        epochs_treatment(end+1, :) = segment; %#ok<SAGROW>
    end
end

fprintf("Extracted Control events: %d, Treatment events: %d\n", ...
    size(epochs_control, 1), size(epochs_treatment, 1))


%% Averaging
erp_control = mean(epochs_control, 1);
erp_treatment = mean(epochs_treatment, 1);

figure;
plot(epoch_time*1000, epochs_control, 'Color', [0.2 0.2 0.5]); hold on;
plot(epoch_time*1000, epochs_treatment, 'Color', [0.5 0.2 0.2]);
% h1 = plot(epoch_time*1000, erp_control, 'b', 'LineWidth', 2.5);
% h2 = plot(epoch_time*1000, erp_treatment, 'p', 'LineWidth', 2.5);

plot(epoch_time*1000, erp_control, 'b', 'LineWidth', 2.5); hold on;
plot(epoch_time*1000, erp_treatment, 'm', 'LineWidth', 2.5);

xlabel("Time relative to stimulus (s)"); ylabel("Amplitude");
xline(0, 'w--', 'Stimulus'); yline(0, 'k:');
title(sprintf("Event-Related Potentials (ERPs) at %s - Control vs Treatment", ch_names{ch}));
xlim([-0.1 0.3]);
% legend([h1, h2], {"Standard ERP", "Target ERP"}, "Location", "northwest")
grid on;


%% Peak amplitude per trial
peak_window = epoch_time >= 0.05 & epoch_time <= 0.25;
peaks_control = max(epochs_control(:, peak_window), [], 2);
peaks_treatment = max(epochs_treatment(:, peak_window), [], 2);

% Calculate average peak amplitudes for control and treatment groups
avg_peak_control = mean(peaks_control);
avg_peak_treatment = mean(peaks_treatment);

fprintf("Average Peak Amplitude - Control: %.2f, Treatment: %.2f\n", ...
    avg_peak_control, avg_peak_treatment);

fprintf("Number of peaks in control: %d, treatment: %d\n", ...
    numel(peaks_control), numel(peaks_treatment))