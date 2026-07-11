%% Epoching from Continuous EEG data -- loading data
addpath('/Users/sanjaysaha/Projects/matlab-tutorials/lecture_11/data')
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

pre = round(0.1*fs);  % num of pre-event samples to take -- 26
post = round(0.3*fs);  % num of post-event samples to take -- 77

epoch_lenght = pre + post;

s = event_samples(1) - pre; % start point / index
e = s +  - 1;  % end point / index


% 'continue from here'
% 1 July 2026