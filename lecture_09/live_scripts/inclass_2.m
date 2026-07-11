%% Filter - Bandpass filter | Notch (bandstop) filter
load("eeg_recording.mat");

% figure;
% plot(time, data);
% grid on;


signal = data(4, :);  % Oz
[f, amp] = get_spectrum(signal, fs);


figure;
subplot(2, 1, 1);
plot(time, signal, 'LineWidth', 1.5);
grid on;
title('Raw Signal (time) vs (signal)');

subplot(2, 1, 2);
plot(f, amp, 'LineWidth', 1.5);
grid on;
title('Raw Spectrum (f) vs (amp)');
xlim([0 50]);


%%  Running the filter - bandpass

order = 4;
f_low = 8;   %  lower range of the band
f_high = 13; %  upper range of the band


nyquist = double(fs / 2);
Wn = double([f_low f_high]) ./ nyquist;  % [8 13] / 128
[b, a] = butter(order, Wn, 'bandpass');  % b & a are filter-coefficients
% disp(b)
% disp("filter-coefficient b " + b)
% disp("filter-coefficient a " + a)

alpha_signal = filtfilt(b, a, signal);


figure;
subplot(2, 1, 1);
plot(time, signal, 'LineWidth', 1.5, 'Color', 'w');
xlabel('time');
ylabel('amplitude');
title('Raw Signal');
grid on;

subplot(2, 1, 2);
plot(time, alpha_signal, 'LineWidth', 1.5, 'Color', 'g');
xlabel('time');
ylabel('amplitude');
title('Alpha (8-13 Hz) Signal');
grid on;


%%  Running the filter - bandstop / Notch

load('noisy_eeg.mat'); 

figure;
subplot(2, 1, 1);
plot(time, clean_signal, 'LineWidth', 1.5, 'Color', 'w');
grid on;
title('Raw CLEAN Signal (time) vs (signal)');
xlim([0 1]);

subplot(2, 1, 2);
plot(time, noisy_signal, 'LineWidth', 1.5, 'Color', 'r');
grid on;
title('Raw NOISY Signal (time) vs (signal)');
xlim([0 1]);

%% GET Spectrum
[freq, amp] = get_spectrum(noisy_signal, fs);

figure;
plot(freq, amp);
xlabel('freq'); ylabel('amp');
xlim([0 80]);


%% DO filtering
f_low_notch = 59;
f_high_notch = 61;
Wn_notch = double([f_low_notch f_high_notch]) ./ double(fs / 2);
[b_notch, a_notch] = butter(4, Wn_notch, 'stop');

clean_signal_by_us = filtfilt(b_notch, a_notch, noisy_signal);

[freq_clean, amp_clean] = get_spectrum(clean_signal_by_us, fs);

figure;
plot(freq_clean, amp_clean);
xlabel('freq'); ylabel('amp');
xlim([0 80]);

%% Visualize
figure;
subplot(3, 1, 1);
plot(time, clean_signal, 'LineWidth', 1.5, 'Color', 'w');
grid on;
title('Raw CLEAN Signal (time) vs (signal)');
xlim([0 1]);

subplot(3, 1, 2);
plot(time, noisy_signal, 'LineWidth', 1.5, 'Color', 'r');
grid on;
title('Raw NOISY Signal (time) vs (signal)');
xlim([0 1]);

subplot(3, 1, 3);
plot(time, clean_signal_by_us, 'LineWidth', 1.5, 'Color', 'g');
grid on;
title('Raw CLEAN BY US Signal (time) vs (signal)');
xlim([0 1]);
