%% EXERCISE 1: Organise Multi-Subject Data — SOLUTION
%  Session 10 — 27 June 2026
%  ─────────────────────────────────────────────────────

%% 1: Load all subjects in a loop
subject_ids = {'S01', 'S02', 'S03'};
dataset = struct();

for i = 1:length(subject_ids)
    filename = sprintf('data/subject_%s.mat', subject_ids{i});
    tmp = load(filename);
    
    dataset(i).id        = subject_ids{i};
    dataset(i).data      = tmp.data;
    dataset(i).fs        = tmp.fs;
    dataset(i).ch_names  = tmp.ch_names;
    dataset(i).time      = tmp.time;
    dataset(i).age       = tmp.age;
    dataset(i).condition = tmp.condition;
end
fprintf('Loaded %d subjects.\n', length(dataset));

%% 2: Print summary
fprintf('\n--- Subject Summary ---\n');
fprintf('%-6s %-5s %-12s %-10s\n', 'ID', 'Age', 'Condition', 'Channels');
fprintf('%-6s %-5s %-12s %-10s\n', '----', '---', '---------', '--------');
for i = 1:length(dataset)
    fprintf('%-6s %-5d %-12s %-10d\n', ...
        dataset(i).id, dataset(i).age, ...
        dataset(i).condition, size(dataset(i).data, 1));
end
% Expected:
%   S01   22    control       4
%   S02   25    treatment     4
%   S03   21    control       4

%% 3: Find control subjects
control_idx = [];
for i = 1:length(dataset)
    if strcmp(dataset(i).condition, 'control')
        control_idx = [control_idx, i];
    end
end
fprintf('\nControl subjects: ');
for j = control_idx
    fprintf('%s ', dataset(j).id);
end
fprintf('\n');
% Expected: S01 S03

%% 4: Compute spectrum for channel 1
for i = 1:length(dataset)
    ch1 = dataset(i).data(1, :);
    [f, amp] = get_spectrum(ch1, dataset(i).fs);
    dataset(i).freq     = f;
    dataset(i).spectrum = amp;
end

%% 5: Plot all spectra
figure;
colors = lines(3);
for i = 1:length(dataset)
    plot(dataset(i).freq, dataset(i).spectrum, ...
         'Color', colors(i,:), 'LineWidth', 1.5);
    hold on;
end
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Channel Fz Spectrum — All Subjects');
legend({dataset.id}, 'Location', 'northeast');
xlim([0 50]);
% Expected peaks: 10 Hz (alpha) and 22 Hz (beta)
% S01 & S03 (control) have stronger alpha; S02 (treatment) has stronger beta
