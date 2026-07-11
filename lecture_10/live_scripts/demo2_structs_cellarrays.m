%% DEMO 2: DATA STRUCTURES — STRUCTS & CELL ARRAYS
%  Session 10 — 27 June 2026
%  MATLAB concepts: struct, fieldnames, cell array, {} vs ()
%  ─────────────────────────────────────────────────────────

%% 2A — Creating a struct
%  A struct groups related data under named fields.
%  Think of it as a labelled container.

% Method 1: dot notation (most common)
subject.id       = 'S01';
subject.age      = 22;
subject.condition = 'control';
subject.data     = randn(1, 100);    % placeholder EEG data

% Display the struct
disp(subject);
% You see:
%       id: 'S01'
%      age: 22
%   condition: 'control'
%       data: [1×100 double]

%% 2B — Accessing struct fields
fprintf('Subject ID: %s\n', subject.id);
fprintf('Age: %d\n', subject.age);
fprintf('Data has %d samples\n', length(subject.data));

% Method 2: create all at once using struct()
subject2 = struct('id', 'S02', 'age', 25, ...
                  'condition', 'treatment', ...
                  'data', randn(1, 100));
disp(subject2);

%% 2C — Adding fields dynamically
%  You can add new fields at any time — no need to declare them first.
subject.gender = 'F';
subject.recording_date = '2026-06-15';
disp(subject);

% List all field names
fields = fieldnames(subject);
disp('Fields in subject struct:');
disp(fields);

%% 2D — Removing a field
subject = rmfield(subject, 'gender');
disp('After removing gender:');
disp(fieldnames(subject));

%% 2E — Struct arrays
%  An ARRAY of structs — like a table where each row is one subject.
%  All elements must have the SAME fields.

subjects(1) = struct('id', 'S01', 'age', 22, 'condition', 'control');
subjects(2) = struct('id', 'S02', 'age', 25, 'condition', 'treatment');
subjects(3) = struct('id', 'S03', 'age', 21, 'condition', 'control');

% Access one element
fprintf('Subject 2 ID: %s, age: %d\n', subjects(2).id, subjects(2).age);

% Loop through all subjects
for i = 1:length(subjects)
    fprintf('  %s — %s, age %d\n', subjects(i).id, ...
            subjects(i).condition, subjects(i).age);
end

%% 2F — Cell arrays
%  A cell array stores MIXED types: strings, numbers, matrices, etc.
%  Use curly braces {} to access contents, parentheses () for the cell itself.

% Create a cell array
info = {'Fz', 256, [1 2 3 4 5], true};

% Access with {} — gets the CONTENTS
ch_name = info{1};           % 'Fz' (a string)
fs      = info{2};           % 256  (a number)
values  = info{3};           % [1 2 3 4 5] (a vector)
fprintf('Channel: %s, fs = %d Hz\n', ch_name, fs);

% Access with () — gets a CELL (still wrapped)
cell_1 = info(1);            % {1×1 cell} containing 'Fz'
fprintf('Type with {}: %s\n', class(info{1}));    % char
fprintf('Type with (): %s\n', class(info(1)));    % cell

% ⚠️ COMMON MISTAKE: using () when you need {}
% info(1) gives you a 1×1 cell — you can't use it as a string!
% info{1} gives you the actual string 'Fz'

%% 2G — Cell arrays for channel names
%  This is exactly how ch_names is stored in our .mat files.
ch_names = {'Fz', 'Cz', 'Pz', 'Oz'};z

% Print each channel name
for i = 1:length(ch_names)
    fprintf('Channel %d: %s\n', i, ch_names{i});
end

% Find a specific channel
target = 'Cz';
idx = find(strcmp(ch_names, target));
fprintf('"%s" is at index %d\n', target, idx);

%% 2H — Structs with cell array fields
%  Combine them: a struct whose fields include cell arrays.
recording.ch_names = {'Fz', 'Cz', 'Pz', 'Oz'};
recording.data     = randn(4, 512);     % 4 channels × 512 samples
recording.fs       = 256;

% Access channel 2 data
ch2_data = recording.data(2, :);
ch2_name = recording.ch_names{2};
fprintf('Channel "%s" has %d samples\n', ch2_name, length(ch2_data));

fprintf('\nKey takeaway: structs organise by FIELD NAME, cell arrays store MIXED TYPES.\n');
fprintf('Use dot notation for struct fields, {} for cell array contents.\n');
