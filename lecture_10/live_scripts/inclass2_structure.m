%% function nice_display
function nice_display(sub)
    fprintf("Subject ID: %s\n", sub.id);
    fprintf("Age: %d\n", sub.age);
    fprintf("Condition: %s\n", sub.condition);
    fprintf("Number of samples: %d\n", length(sub.data));
end



%% Create a struct

subject.id = 'S01';
subject.age = 25;
subject.condition = 'control';
subject.data = randn(1, 100);

disp(subject);


%% Access the fields/attributes of the struct (in this case `subject`)
% fprintf("Subject ID: %s\n", subject.id);
% fprintf("Age: %d\n", subject.age);
% fprintf("Condition: %s\n", subject.condition);
% fprintf("Number of samples: %d\n", length(subject.data));
nice_display(subject)



%% USING struct 

subject2 = struct( ...
    'id', 'S02', ...
    'age', 23, ...
    'condition', 'treatment', ...
    'data', randn(1,100));

nice_display(subject2)



%% adding dynamic fields
subject.gender = 'M';
subject2.gender = 'F';

subject.recodring_date = '2026-06-17';
subject2.recodring_date = '2026-06-18';

% nice_display(subject)
% disp(subject)

fields = fieldnames(subject);
disp(fields)

for i = 1:numel(fields)
    field_name = fields{i};
    field_val = subject.(field_name); % Dynamic field reference

    disp(field_name);
    disp(field_val);
end


%% RMFIELD
subject = rmfield(subject, 'gender');
disp(subject)


%% STRUCT array

subjects(1) = struct('id', 'S01', 'age', 42, 'condition', 'control');
subjects(2) = struct('id', 'S02', 'age', 23, 'condition', 'treatment');
subjects(3) = struct('id', 'S03', 'age', 25, 'condition', 'control');


disp(subjects)


% dummy_data = [1 2 3 4 5]


%% Cell arrays
% A cell array stores MIXED types: strings, numbers, matrices, etc.
% Use curly braces {} to access contents, parentheses () for the cell itself.


info = {'Fz', 256, [1 2 3 4 5], true};

ch_name = info{1}; % curly-brace gives you content 
fs = info{2};
dummy_vals = info{3};

fprintf("CURLY: Channel : %s\n", ch_name);


cell_1 = info(1); % round-brace gives you cell 
% disp(cell_1)
fprintf("ROUND: Channel: %s\n", cell_1{1})

%% Cell arrays for channel names
ch_names = {'Fz', 'Cz', 'Pz', 'Oz'};


for i = 1:length(ch_names)
    fprintf("Channel %d, Name: %s\n", i, ch_names{i})
end