%% Loading .mat files
load('eeg_recording.mat')

ch1_data = data(1, :);
disp("Channel 1 name " + ch_names(1))
disp("Channel 1 length " + length(ch1_data))


ch2_data = data(2, :);
disp("Channel 2 name " + ch_names(2))
disp("CHannel 2 data " + length(ch2_data))


figure;
plot(time, ch1_data);
xlabel('time (s)');
ylabel('amplitude');
grid on;
title('channel 1')


%% Load .CSV
csv_data = readmatrix("eeg_data.csv");

csv_table = readtable("eeg_data.csv");

channel_Oz = csv_table.Oz;

figure;
plot(time, channel_Oz);
xlabel('time (s)');
ylabel('amplitude');
grid on;
title('channel Oz')


%% Load .txt
opts = detectImportOptions("eeg_params.txt");
params = readtable("eeg_params.txt", opts);
disp(params)
disp(params.Var2(5))