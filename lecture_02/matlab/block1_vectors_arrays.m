%% BLOCK 1 — Vectors & Arrays
% Lecture 2: MATLAB Summer Prep | NSBV BC2001
% -----------------------------------------------

%% Row vs Column Vectors
row_vec = [1 2 3 4 5];          % row vector
col_vec = [1; 2; 3; 4; 5];      % column vector

disp('Row vector:');
disp(row_vec);
disp('Column vector:');
disp(col_vec);

%% Colon Operator and Linspace
t_colon   = 0:0.1:1;             % from 0 to 1, step 0.1
t_linspace = linspace(0, 1, 11); % from 0 to 1, exactly 11 points

disp('Colon operator result:');
disp(t_colon);
disp('Linspace result:');
disp(t_linspace);

%% Indexing
v = [10 20 30 40 50];
disp('First element:');    disp(v(1));
disp('Last element:');     disp(v(end));
disp('Elements 2 to 4:'); disp(v(2:4));

%% Element-wise Operations
v = [1 2 3 4 5];
disp('Multiply by 2:');    disp(v * 2);
disp('Square each element:'); disp(v .^ 2);

w = [10 10 10 10 10];
disp('Add two vectors:');  disp(v + w);

%% Size, Length, Numel
disp('Size:');   disp(size(v));
disp('Length:'); disp(length(v));
disp('Numel:');  disp(numel(v));

%% Neuroscience Example — Simulating a Time Axis (like EEG data)
t      = linspace(0, 1, 1000);       % 1 second, 1000 samples (1 kHz)
signal = sin(2 * pi * 10 * t);       % 10 Hz sine wave

disp('First 5 values of the signal:');
disp(signal(1:5));
