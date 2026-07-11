%% WARMUP — Revision (Session 11)
%  8 quick tasks covering everything from Session 10: vectors, structs,
%  cell arrays, multi-file loading, and a first look at descriptive stats.
%  You have ~20 minutes. Work through each task in order.
%
%  Set your Current Folder to the lecture_11 folder so 'data/...' paths work.
%  ─────────────────────────────────────────────────────────────────────

%% Task 1: Vectors & basic functions
%  Create a vector of 10 firing rates (Hz):
%      rates = [12 8 15 22 9 18 25 11 30 14]
%  Compute and print the mean, max, and min.
%  Q: What is the mean firing rate?

rates = [12 8 15 22 9 18 25 11 30 14];
fprintf("Mean = %.2f, Max = %d, Min = %d\n", ...
    mean(rates), max(rates), min(rates))


%% Task 2: Logical indexing
%  Using the 'rates' vector from Task 1, find all values ABOVE the mean.
%  Hint: logical index  rates(rates > mean(rates))
%  Q: How many neurons fire faster than the average?

% disp(rates > mean(rates))
fast_rates = rates(rates > mean(rates));  % rates(indices of items > mean)
disp(fast_rates)
disp(length(fast_rates))


%% Task 3: Structs & dot notation
%  Build a struct called 'subject' with these fields:
%      id        = 'S07'
%      age       = 23
%      condition = 'control'
%  Then ADD a new field 'handedness' = 'right' after creating it.
%  Print the age using fprintf.

subject.id = 'S07';
subject.age = 23;
subject.condition = 'control';
subject.handedness = 'right';

fprintf("Subject %s, age is %d, Group: %s, %s-handed\n", ...
    subject.id, subject.age, subject.condition, subject.handedness)



%% Task 4: Struct arrays + a loop
%  Create a 3-element struct array 'subjects' with fields id and age:
%      S01 / 22,  S02 / 25,  S03 / 21
%  Loop through it and print "id: age" for each subject.

subjects(1) = struct('id', 'S01', 'age', 22);
subjects(2) = struct('id', 'S02', 'age', 25);
subjects(3) = struct('id', 'S03', 'age', 21);

for i = 1:length(subjects)
    fprintf("%s: %d\n", subjects(i).id, subjects(i).age)
end


%% Task 5: Cell arrays — {} vs ()
%  Create a cell array of channel names:
%      ch_names = {'Fz', 'Cz', 'Pz', 'Oz'}
%  Extract the THIRD name as a string (so it can be printed).
%  Q: What is the difference between ch_names{3} and ch_names(3)?

ch_names = {'Fz', 'Cz', 'Pz', 'Oz'};

% name3 = ch_names(3);
% disp(name3)
% disp(class(name3))

name3 = ch_names{3};
disp(name3)
disp(class(name3))

%% Task 6: Safe multi-file loading pattern
%  Load 'data/group_data.mat' using the OUTPUT-argument pattern:
%      tmp = load('data/group_data.mat');
%  List the variable names inside it with fieldnames(tmp).
%  Q: Why do we write tmp = load(...) instead of just load(...) in a loop?

addpath('/Users/sanjaysaha/Projects/matlab-tutorials/lecture_11/data')

% load('group_data.mat');
tmp = load('group_data.mat');
% disp(fieldnames(tmp));


%% Task 7: Descriptive statistics
%  From the file you just loaded, take tmp.control (a row vector).
%  Compute and print: mean, median, and standard deviation (std).
%  Q: Is the mean bigger or smaller than the median?

x = tmp.control;
fprintf("Mean: %.2f, median = %.2f, std = %.2f\n", ...
    mean(x), median(x), std(x))


%% Task 8: Epoching refresher
%  Load 'data/continuous_eeg.mat'.
%  Print how many events there are (length of event_samples).
%  Then extract ONE epoch for channel 2 (Pz): 100 ms before to 300 ms
%  after event number 1, and plot it against time in milliseconds.
%  Hint:  pre = round(0.1*fs);  post = round(0.3*fs);
%         s = event_samples(1) - pre;  e = s + pre + post - 1;

load('continuous_eeg.mat');
fprintf("Number of events: %d\n", length(event_samples));
fprintf("Number of channels: %d\n", size(data, 1));

pre = round(0.1*fs);  % num of pre-event samples to take -- 26
post = round(0.3*fs);  % num of post-event samples to take -- 77

s = event_samples(1) - pre; % start point / index
e = s + pre + post - 1;  % end point / index

epoch1 = data(2, s:e);
epoch_time = linspace(-100, 300, pre + post);

figure;
plot(epoch_time, epoch1, 'w', 'LineWidth', 1.3);
xline(0, 'r--', 'Stiumus')
xlabel('Time (ms)');
ylabel('Amplitude');
title('Epoch for Channel 2 (Pz)');
grid on;