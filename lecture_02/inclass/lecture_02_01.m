clc
clearvars

%% SECTION 1
% Vectors and Arrays

row_vec = [1 2 3 4 5]; % creating a row vector
disp("vector 1 (row vector)")
disp(row_vec)
 
col_vec = [1; 2; 3; 4; 5];  % creating a column vector
disp("vector 2 (column vector)"); 
disp(col_vec);


row_vec_transposed = row_vec';
disp("row vector transposed")
disp(row_vec_transposed)


%% SECTION 2
% colon operators and linspace
x1 = 1 : 10;  % number range

x2 = 1 : 0.5 : 10;  % number range with interval

x3 = 1: 0.1 : 5;
% disp("x3")
% disp(x3)


x4 = linspace(0, 1, 30);
disp(x4)

%% SECTION 3
% Indexing
v = [10 12 15 17 18 34];
disp("First element"); disp(v(1));
disp("Third element"); disp(v(3));
disp("Last element"); disp(v(end));
disp("Elements 2 to 4"); disp(v(2:4));


%% SECTION 4
% Element-wise operations
v2 = v * 2;   % double each element
v3  = v + 5;   % add 5 to each element
disp(v3)

w = [30 40 20 10 5 1];
v4 = v + w;  % add the two vectors (v & w)
disp(v4);


%% SECTION 5
% Size, Length, Numel
disp(size(v))
disp(length(v))
disp(numel(v))  % number of elements


%% SECTION 6
% simple signal EEG
% Simulating a Time Axis (like EEG data)
% need to create a timestamp vector: 1 second, 1000 samples (1 kHz)
% t = 0 : 0.001 : 1;  % this is harder to work with
t = linspace(0, 1, 1000);  % because we know only the number of samples, not the interval

% sine wave
signal = sin(2 * pi * t);
disp(signal(1:10))