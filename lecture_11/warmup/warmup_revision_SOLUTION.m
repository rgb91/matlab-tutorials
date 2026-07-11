%% WARMUP — Revision (Session 11) — SOLUTION
%  Instructor answer key. Expected outputs noted in comments.
%  ─────────────────────────────────────────────────────────────────────

%% Task 1: Vectors & basic functions
rates = [12 8 15 22 9 18 25 11 30 14];
fprintf('Mean = %.1f Hz, Max = %d Hz, Min = %d Hz\n', ...
    mean(rates), max(rates), min(rates));
% EXPECTED: Mean = 16.4 Hz, Max = 30, Min = 8

%% Task 2: Logical indexing
fast = rates(rates > mean(rates));
fprintf('%d neurons fire above average: ', numel(fast));
fprintf('%d ', fast); fprintf('\n');
% EXPECTED: 4 neurons above the mean of 16.4 Hz -> [22 18 25 30].

%% Task 3: Structs & dot notation
subject.id        = 'S07';
subject.age       = 23;
subject.condition = 'control';
subject.handedness = 'right';        % fields can be added any time
fprintf('Subject %s, age %d, %s, %s-handed\n', ...
    subject.id, subject.age, subject.condition, subject.handedness);

%% Task 4: Struct arrays + a loop
subjects(1) = struct('id','S01','age',22);
subjects(2) = struct('id','S02','age',25);
subjects(3) = struct('id','S03','age',21);
for i = 1:length(subjects)
    fprintf('%s: %d\n', subjects(i).id, subjects(i).age);
end

%% Task 5: Cell arrays — {} vs ()
ch_names = {'Fz', 'Cz', 'Pz', 'Oz'};
name3 = ch_names{3};                 % 'Pz' as a char string
fprintf('Channel 3 is %s\n', name3);
% ANSWER: ch_names{3} -> 'Pz' (the string itself).
%         ch_names(3) -> {'Pz'} (a 1x1 cell still wrapping the string).
% Use {} when you need the actual value.

%% Task 6: Safe multi-file loading pattern
tmp = load('data/group_data.mat');
disp(fieldnames(tmp));               % control, treatment, measure
% ANSWER: With tmp = load(...), everything lands inside the struct 'tmp'.
% Plain load(...) dumps the variables straight into the workspace, so the
% next loop iteration would overwrite them. Always capture the output.

%% Task 7: Descriptive statistics (preview of today)
x = tmp.control;
fprintf('control: mean=%.2f  median=%.2f  std=%.2f\n', ...
    mean(x), median(x), std(x));
% EXPECTED (approx): mean=5.25  median=5.63  std=1.23
% ANSWER: mean (5.25) is slightly SMALLER than median (5.63) -> mild left skew.

%% Task 8: Epoching refresher
load('data/continuous_eeg.mat');
fprintf('Number of events: %d\n', length(event_samples));   % 30
fs = double(fs);
pre  = round(0.1 * fs);    % 26 samples
post = round(0.3 * fs);    % 77 samples
s = event_samples(1) - pre;
e = s + pre + post - 1;
epoch1 = data(2, s:e);                       % channel 2 = Pz
et = linspace(-100, 300, pre + post);        % time axis in ms
figure;
plot(et, epoch1, 'b', 'LineWidth', 1.2);
xline(0, 'r--', 'Stimulus');
xlabel('Time relative to event (ms)'); ylabel('Amplitude (\muV)');
title('Single epoch — Pz, event 1');
% EXPECTED: 30 events. A single noisy epoch with a small bump after t=0.
