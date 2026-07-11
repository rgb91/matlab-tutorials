%% DEMO 3: ORGANIZING MULTI-FILE EEG DATASETS
%  Session 10 — 27 June 2026
%  MATLAB concepts: loop-loading, struct arrays, dynamic field assignment
%  ─────────────────────────────────────────────────────────────────────

%% 3A — The problem: multiple subject files
%  We have 3 subjects: subject_S01.mat, subject_S02.mat, subject_S03.mat
%  Each contains: data (4×512), fs, ch_names, time, age, condition
%  Goal: load all into ONE organised struct array.

% First, let's see what one file looks like
load('data/subject_S01.mat');
whos
fprintf('S01: data is %d × %d, age = %d, condition = %s\n', ...
    size(data,1), size(data,2), age, condition);

%% 3B — Loading multiple files with a loop
%  Key pattern: build a list of filenames, loop through, store in struct array.

subject_ids = {'S01', 'S02', 'S03'};
dataset = struct();   % start with empty struct

for i = 1:length(subject_ids)
    % Build the filename
    filename = sprintf('data/subject_%s.mat', subject_ids{i});
    fprintf('Loading %s...\n', filename);
    
    % Load into a temporary struct (avoids overwriting workspace variables)
    tmp = load(filename);
    
    % Store everything in our dataset struct array
    dataset(i).id        = subject_ids{i};
    dataset(i).data      = tmp.data;
    dataset(i).fs        = tmp.fs;
    dataset(i).ch_names  = tmp.ch_names;
    dataset(i).time      = tmp.time;
    dataset(i).age       = tmp.age;
    dataset(i).condition = tmp.condition;
end

fprintf('\nLoaded %d subjects into dataset struct array.\n', length(dataset));

%% 3C — Accessing data from the struct array
% Print a summary of all subjects
fprintf('\n--- Dataset Summary ---\n');
for i = 1:length(dataset)
    fprintf('  %s: age=%d, condition=%-10s, channels=%d, samples=%d\n', ...
        dataset(i).id, dataset(i).age, dataset(i).condition, ...
        size(dataset(i).data, 1), size(dataset(i).data, 2));
end

% Get data from subject 2, channel 3
subj2_ch3 = dataset(2).data(3, :);
fprintf('\nSubject %s, Channel %s: %d samples\n', ...
    dataset(2).id, dataset(2).ch_names{3}, length(subj2_ch3));

%% 3D — The power of struct arrays: filtering by condition
%  Find all subjects in the 'control' condition.
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

%% 3E — load() with output vs without output
%  Key distinction:
%     load('file.mat')       → dumps variables into workspace (messy!)
%     tmp = load('file.mat') → loads into a struct (clean!)

% Without output — creates data, fs, ch_names etc in workspace
load('data/subject_S01.mat');

% With output — everything goes into s1 struct
s1 = load('data/subject_S01.mat');
fprintf('s1 is a struct with fields: ');
disp(fieldnames(s1)');
fprintf('Access data as: s1.data, s1.fs, s1.ch_names, etc.\n');

% ⚠️ BEST PRACTICE: always use s = load(...) when loading inside a loop
%    to avoid overwriting variables from the previous iteration!

%% 3F — Adding derived data to the struct
%  Let's compute the spectrum for channel 1 of each subject and store it.

for i = 1:length(dataset)
    ch1 = dataset(i).data(1, :);
    [f, amp] = get_spectrum(ch1, dataset(i).fs);
    dataset(i).freq      = f;
    dataset(i).spectrum   = amp;
end

% Now plot all spectra together
figure;
colors = lines(3);
for i = 1:length(dataset)
    plot(dataset(i).freq, dataset(i).spectrum, ...
        'Color', colors(i,:), 'LineWidth', 1.5);
    hold on;
end
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Channel Fz Spectrum — All Subjects');
legend({dataset.id}, 'Location', 'northeast');
xlim([0 50]);

fprintf('\nPattern: load → organise in struct → add derived fields → analyse.\n');
