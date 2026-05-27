%% PLOT -- simple plot
% Simulating a Time Axis (like EEG data)
% need to create a timestamp vector: 1 second, 1000 samples (1 kHz)

t       = linspace(0, 1, 50);  % timestamps
signal  = sin(2 * pi * t); % sine wave

% disp(signal(1:10))

figure;
plot(t, signal)
xlabel("time (s)")
ylabel("amplitude")
title("Simple Sine Wave")