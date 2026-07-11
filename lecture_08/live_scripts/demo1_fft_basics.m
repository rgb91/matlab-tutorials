%% DEMO 1 - FFT BASICS: from time domain to frequency domain
% Session 8 - Signal Processing I
% Run this section-by-section in the Live Editor / by pressing Ctrl+Enter.
%
% GOAL: build a signal whose frequencies we already KNOW, then use the FFT
%       to recover those frequencies. Because we built the signal, we can
%       check that the FFT gives the right answer.

clear; clc; close all;

%% 1. Build a test signal with known frequency content
Fs = 256;                 % sampling frequency (samples per second), in Hz
                          % 256 Hz is a common EEG sampling rate
dur = 4;                  % signal duration in seconds

% Time vector: one time point every (1/Fs) seconds, starting at 0.
% We go up to (dur - 1/Fs) — NOT dur — so we get exactly N = Fs*dur
% samples. Ending at dur would give N+1 samples and break the FFT math.
% The trailing apostrophe ' transposes the row vector to a column vector.
t = (0:1/Fs:dur-1/Fs)';   % time vector (column). Note step = 1/Fs

N = length(t);            % number of samples = Fs * dur = 256 * 4 = 1024
                          % length() of a column vector = number of rows

% Build the signal as a sum of three pure sine waves.
% Formula for a sine wave at frequency f_Hz:    A * sin(2*pi*f_Hz*t)
%   A         = amplitude (peak height)
%   2*pi*f_Hz = angular frequency in radians/second
%   t         = time vector (seconds)
% The three components have DIFFERENT amplitudes (1.0, 0.5, 0.3) so we
% can check the FFT recovers each amplitude correctly.
x = 1.0*sin(2*pi*8*t) ...      % strongest component  (amplitude 1.0)
  + 0.5*sin(2*pi*15*t) ...     % medium               (amplitude 0.5)
  + 0.3*sin(2*pi*30*t);        % weakest              (amplitude 0.3)

figure;
plot(t, x); xlim([0 0.5]);     % zoom to first 0.5 s; the full 4 s looks messy
xlabel('Time (s)'); ylabel('Amplitude');
title('Time domain - the frequencies are mixed together and hard to read');
% TALKING POINT: in the time domain you cannot easily tell what frequencies
% are inside this wiggle. The FFT will separate them for us.

%% 2. Compute the FFT
Y = fft(x);               % Y is COMPLEX and has the same length as x (N values)
% disp(size(Y));          % 1024 x 1
%
% fft() returns a COMPLEX array — each element has a real part and an
% imaginary part. The magnitude (abs) tells us the AMPLITUDE of that
% frequency, and the angle (angle()) tells us the PHASE.
% We mostly care about magnitude for EEG work.
%
% TALKING POINT: fft does not change how many numbers we have. It re-expresses
% the same data as a sum of sine/cosine waves. Each entry of Y is the
% strength + phase of one frequency.

%% 3. Build the frequency axis and look at the RAW two-sided result
% The k-th bin (1-indexed in MATLAB) corresponds to frequency:
%     f_k = (k-1) * Fs / N
% This means each bin is (Fs/N) = 256/1024 = 0.25 Hz wide.
f_full = (0:N-1)'*(Fs/N);     % full (two-sided) frequency axis, 0 .. almost Fs

% abs() extracts the MAGNITUDE of each complex value (removes phase info).
% We divide by N to normalise so the magnitude matches the true amplitude.
figure;
plot(f_full, abs(Y)/N);
xlabel('Frequency (Hz)'); ylabel('|Y| / N');
title('Raw FFT magnitude (two-sided) - note the mirror image after Fs/2');
% TALKING POINT: the picture is mirrored around Fs/2 = 128 Hz (the Nyquist
% frequency). The right half is a redundant reflection of the left half.
% Nyquist rule: you can only detect frequencies BELOW Fs/2 reliably.
% At Fs = 256 Hz you can detect up to 128 Hz — fine for EEG (brain
% rhythms top out around 80-100 Hz).

%% 4. Centre the spectrum with fftshift (optional but tidy)
% fftshift() rearranges the bins so that 0 Hz sits in the MIDDLE instead
% of the left edge. It is cosmetic — the numbers do not change.
Yshift = fftshift(Y);             % move the 0 Hz component to the centre
f_centred = (-N/2:N/2-1)'*(Fs/N); % symmetric axis: from -Fs/2 to just below +Fs/2
                                   % works because N is even (1024)

figure;
plot(f_centred, abs(Yshift)/N);
xlabel('Frequency (Hz)'); ylabel('|Y| / N');
title('fftshift: spectrum centred on 0 Hz (negative and positive frequencies)');
xline(0,'k:');     % draw a dotted vertical line at x = 0 for reference
% TALKING POINT: fftshift just rearranges the bins so 0 Hz sits in the middle.
% It is mainly for nicer pictures; the numbers are unchanged.
% Negative frequencies are mathematically necessary but carry no extra
% information — they mirror the positive side.

%% 5. The useful version: SINGLE-SIDED amplitude spectrum
% For real (non-complex) signals the two halves mirror each other, so we
% throw away the right (negative-frequency) half and DOUBLE the remaining
% bins to compensate for the discarded energy. This gives us a plot where
% peak height = true amplitude of each sine wave.

P2 = abs(Y/N);                 % two-sided magnitude, normalised by N
P1 = P2(1:N/2+1);              % keep ONLY bins 1 to N/2+1 (0 Hz up to Nyquist)
                                % N/2+1 = 513 for N=1024

% Double every bin EXCEPT 0 Hz (bin 1) and Nyquist (last bin).
% Those two endpoints are NOT mirrored, so they get the full energy already.
P1(2:end-1) = 2*P1(2:end-1);   % 2:end-1 means "all bins except first and last"

% One-sided frequency axis: 0, Fs/N, 2*Fs/N, ..., Fs/2
f = (0:N/2)'*(Fs/N);           % 0 to 128 Hz in 0.25 Hz steps (N/2+1 = 513 points)

figure;
plot(f, P1, 'LineWidth', 1.2);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Single-sided amplitude spectrum - peaks at 8, 15 and 30 Hz');
xlim([0 50]); grid on;   % zoom to 0-50 Hz; our signals are all below 30 Hz
% EXPECTED RESULT (check live): three clean peaks at 8 Hz (~1.0),
% 15 Hz (~0.5) and 30 Hz (~0.3) - exactly the amplitudes we built in.
%
% This "P1 recipe" (lines above) is the STANDARD FFT pipeline.
% Copy it every time you need a single-sided spectrum.
