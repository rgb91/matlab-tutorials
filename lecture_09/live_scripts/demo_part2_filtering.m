%% PART 2: DIGITAL FILTERING
%  Session 9 — 20 June 2026
%  MATLAB concepts: butter, filtfilt, filter design, before/after comparison
%  ─────────────────────────────────────────────────────────────────────────

%% 2A — Why filter?
%  Our EEG signals contain multiple frequency components mixed together.
%  Filtering lets us KEEP the frequencies we care about and REMOVE the rest.
%
%  Two common tasks:
%    1. Bandpass filter: keep only a RANGE of frequencies (e.g. 8-13 Hz alpha)
%    2. Notch filter:    remove ONE specific frequency (e.g. 60 Hz power line)

%% 2B — Load the multi-channel data

% load() reads a .mat file and puts all variables inside it into the workspace.
% After this line we have: data (8×1024 matrix), fs (sample rate in Hz),
% ch_names (cell array of channel names), and time (1×1024 time vector).
load('eeg_recording.mat');  % data (8×1024), fs (256), ch_names, time

% Pull out just one row of the data matrix (channel 4 = Oz, occipital electrode).
% Oz sits at the back of the head and shows the strongest alpha rhythm (8–13 Hz).
% data(4, :) → row 4, all columns → a 1×1024 row vector.
signal = data(4, :);

% Compute the frequency spectrum of the raw signal BEFORE we filter it.
% get_spectrum() is a helper function that runs an FFT and returns:
%   f   — frequency axis in Hz (e.g. 0, 0.25, 0.5, … up to Nyquist)
%   amp — amplitude at each frequency (magnitude of the FFT)
[f, amp] = get_spectrum(signal, fs);

% Open a new figure window so this plot does not overwrite a previous one.
figure;

% subplot(rows, cols, panel_index) divides the figure into a grid and selects
% the panel to draw in.  subplot(2,1,1) → 2 rows, 1 column, top panel.
subplot(2,1,1);

% Plot the raw signal in the TIME domain (amplitude vs. time in seconds).
plot(time, signal);
xlabel('Time (s)'); ylabel('Amplitude');
title('Oz — Raw Signal (Time Domain)');

% Bottom panel: the same signal in the FREQUENCY domain (amplitude vs. Hz).
subplot(2,1,2);
plot(f, amp);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Oz — Raw Spectrum');
xlim([0 50]);   % zoom to 0–50 Hz; EEG rarely has useful content above that

%% 2C — Bandpass filter: isolate the alpha band (8–13 Hz)
%  Step 1: Choose filter ORDER and CUTOFF frequencies
%  Step 2: Design the filter with butter()
%  Step 3: Apply with filtfilt() (zero-phase filtering)

% -- Step 1: parameters

% Filter order controls how SHARP the roll-off is at the cutoff edges.
% Higher order = steeper cutoff, but also more numerical problems.
% Order 4 is a safe, widely used default for EEG bandpass work.
order  = 4;             % filter order (4 is a good default)

% The frequency band we want to KEEP.
% Alpha oscillations (8–13 Hz) are linked to relaxed, eyes-closed states.
f_low  = 8;             % lower cutoff (Hz)
f_high = 13;            % upper cutoff (Hz)

% -- Step 2: design the filter

%  butter() requires cutoff frequencies expressed as a fraction of the
%  Nyquist frequency (= fs/2), NOT in raw Hz.
%  Nyquist rate = highest frequency the signal can contain without aliasing.
%  For fs = 256 Hz, Nyquist = 128 Hz.
nyquist = fs / 2;

%  Normalise: divide each cutoff by the Nyquist rate so the values land in (0, 1).
%  double() is used as a precaution — it ensures both values are floating-point
%  even if fs happened to be stored as an integer type.
%  Result: Wn = [8/128, 13/128] = [0.0625, 0.1016]
Wn = double([f_low f_high]) ./ double(nyquist);

%  butter(order, Wn, 'bandpass') designs a Butterworth bandpass filter.
%  Butterworth = maximally flat in the passband (no ripple).
%  Returns two coefficient vectors:
%    b — numerator   (feedforward coefficients)
%    a — denominator (feedback coefficients)
%  These two vectors fully describe the filter's behaviour.
[b, a] = butter(order, Wn, 'bandpass');

% Print the number of coefficients so students can see that a 4th-order
% bandpass filter produces more coefficients than they might expect
% (a bandpass doubles the order internally → 9 coefficients each).
fprintf('Filter coefficients:\n');
fprintf('  b has %d values\n', length(b));
fprintf('  a has %d values\n', length(a));

% -- Step 3: apply the filter

%  filtfilt(b, a, signal) applies the filter TWICE:
%    pass 1 — forward in time
%    pass 2 — backward in time (on the result of pass 1)
%  This cancels out the time delay (phase shift) that a single-pass filter
%  introduces, giving us a "zero-phase" output.
%  The filtered result has the same length as the input.
alpha_signal = filtfilt(b, a, signal);

% ---- Visual comparison: time domain ----
figure;
subplot(2,1,1);

% Plot the raw signal in light grey so it sits "behind" the filtered version.
% 'Color', [0.7 0.7 0.7] sets an RGB grey (each channel on 0–1 scale).
plot(time, signal, 'Color', [0.7 0.7 0.7]); hold on;

% hold on keeps the grey plot visible while we add the blue alpha signal on top.
% 'LineWidth', 1.5 makes the blue line slightly thicker so it stands out.
plot(time, alpha_signal, 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Bandpass 8–13 Hz: Raw (grey) vs Filtered (blue)');
legend('Raw', 'Alpha only');

% ---- Visual comparison: frequency domain ----
subplot(2,1,2);

% Compute the spectrum of the filtered signal so we can confirm that
% only the 8–13 Hz region survives.
[f_filt, amp_filt] = get_spectrum(alpha_signal, fs);

% Plot raw spectrum (grey) and filtered spectrum (blue) together.
plot(f, amp, 'Color', [0.7 0.7 0.7]); hold on;
plot(f_filt, amp_filt, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Spectrum: Raw vs Alpha-Filtered');
xlim([0 50]);
legend('Raw', 'Alpha only');

%% 2D — Why filtfilt and not filter?
%  filter()   applies the filter in ONE direction → introduces a time delay.
%  filtfilt() applies it FORWARD then BACKWARD → no time delay (zero-phase).

% filter(b, a, signal) is the standard one-pass version.
% The output signal is shifted later in time relative to the input —
% this is the "group delay" introduced by the filter.
% For EEG, a time shift is a problem because it distorts event timing.
delayed = filter(b, a, signal);  % one-pass → delayed

figure;
% Blue solid line = filtfilt output (no delay, the "correct" version).
plot(time, alpha_signal, 'b', 'LineWidth', 1.5); hold on;

% Red dashed line = filter output (shifted to the right in time).
% 'r--' sets colour to red and line style to dashed.
plot(time, delayed, 'r--', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amplitude');
title('filtfilt (blue) vs filter (red, shifted)');
legend('filtfilt (zero-phase)', 'filter (delayed)');

% xlim zooms into the first second only so the phase shift is easy to see.
% At fs=256 the delay is several samples, which is very visible when zoomed in.
xlim([0 1]);  % zoom in to see the shift

%% 2E — Notch filter: remove 60 Hz power line noise
%  A notch filter is a "bandstop" that kills a narrow band.
%  We target 59–61 Hz to remove exactly the 60 Hz hum.

% Load a second dataset that has artificial 60 Hz noise added.
% Variables: noisy_signal (1×N), clean_signal (1×N), fs, time
load('noisy_eeg.mat');  % noisy_signal, clean_signal, fs, time

% Inspect the spectrum of the noisy signal first.
% You should see a tall, narrow spike at exactly 60 Hz — that's the power line.
[f_n, amp_n] = get_spectrum(noisy_signal, fs);
figure;
plot(f_n, amp_n);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Noisy Signal Spectrum — Spot the 60 Hz Spike');
xlim([0 80]);   % show up to 80 Hz so the spike at 60 Hz is clearly in view

% Define a narrow band (59–61 Hz) around the power-line frequency.
% Making the band too wide would also remove legitimate neural signal near 60 Hz.
f_notch_low  = 59;
f_notch_high = 61;

% Normalise the notch cutoffs exactly as we did for the bandpass above.
% nyquist was computed earlier from the bandpass section (fs/2 = 128 Hz).
Wn_notch = [f_notch_low f_notch_high] / nyquist;

% butter(..., 'stop') designs a BANDSTOP (notch) filter.
% 'stop' tells butter() to REMOVE the specified band instead of keeping it.
% Everything outside 59–61 Hz passes through unchanged.
[b_notch, a_notch] = butter(4, Wn_notch, 'stop');  % 'stop' = bandstop

% Apply zero-phase notch filter to the noisy signal.
% After this step the 60 Hz spike should be gone from the spectrum.
cleaned = filtfilt(b_notch, a_notch, noisy_signal);

% Compute the spectrum of the cleaned signal for comparison.
[f_c, amp_c] = get_spectrum(cleaned, fs);

figure;

% ---- Time-domain comparison ----
subplot(2,1,1);
% Noisy signal in grey; cleaned signal in blue on top.
plot(time, noisy_signal, 'Color', [0.7 0.7 0.7]); hold on;
plot(time, cleaned, 'b', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amplitude');
title('Notch Filter: Before (grey) vs After (blue)');
legend('Noisy', 'Cleaned');

% ---- Frequency-domain comparison ----
% This is the most convincing view: the 60 Hz spike should disappear
% while the rest of the spectrum stays identical.
subplot(2,1,2);
plot(f_n, amp_n, 'Color', [0.7 0.7 0.7]); hold on;
plot(f_c, amp_c, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Spectrum: 60 Hz Spike Removed');
xlim([0 80]);
legend('Before', 'After notch');

fprintf('\n--- Part 2 complete. ---\n');
