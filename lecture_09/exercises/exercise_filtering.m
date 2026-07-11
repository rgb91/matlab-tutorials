%% EXERCISE 2: FILTERING
%  Practice designing and applying bandpass and notch filters.
%  Replace the TODO lines with your code.
%  ─────────────────────────────────────────────────────────────

%% Task 1: Isolate the theta band (4–8 Hz) from Oz
%  Load the multi-channel recording and extract channel 4 (Oz).
%  Design a bandpass filter for 4–8 Hz and apply it.

% TODO: Load 'eeg_recording.mat'


% TODO: Extract channel 4 (Oz) into variable 'signal'


% TODO: Compute the Nyquist frequency
%        nyquist = fs / 2;


% TODO: Design a 4th-order Butterworth bandpass filter for 4–8 Hz
%        [b, a] = butter(???, [??? ???] / nyquist, 'bandpass');


% TODO: Apply with filtfilt
%        theta_signal = filtfilt(b, a, signal);


% TODO: Plot raw vs filtered in a 2×1 subplot
%   subplot(2,1,1): raw signal in grey, filtered in red, legend
%   subplot(2,1,2): spectra of both using get_spectrum, xlim [0 30]


%% Task 2: Remove 60 Hz from the noisy signal
%  Load 'noisy_eeg.mat'. Design and apply a notch filter.

% TODO: Load 'noisy_eeg.mat'


% TODO: Design a notch (bandstop) filter for 59–61 Hz
%        Use butter with 'stop' type


% TODO: Apply with filtfilt, store in 'cleaned'


% TODO: Compute the spectrum of noisy_signal AND cleaned
%        [f1, amp1] = get_spectrum(noisy_signal, fs);
%        [f2, amp2] = get_spectrum(cleaned, fs);


% TODO: Plot both spectra on one figure
%        noisy in grey, cleaned in blue, legend, xlim [0 80]
%        Can you confirm the 60 Hz spike is gone?


%% Task 3: Identify the dominant frequency after filtering
%  After notch-filtering the noisy signal (Task 2), find the
%  strongest remaining frequency.

% TODO: Use the spectrum from Task 2 (f2, amp2)
%        Find the index of the maximum amplitude
%        [peak_amp, idx] = max(amp2);


% TODO: The dominant frequency is f2(idx). Print it:
%        fprintf('Dominant frequency: %.1f Hz\n', f2(idx));
%        Expected answer: should be near 10 Hz (the alpha component)


%% Task 4 (Challenge): Isolate ONLY the 20 Hz beta component
%  From the original Oz signal (Task 1), design a NARROW bandpass
%  around 18–22 Hz and extract just the beta rhythm.

% TODO: Design a 4th-order bandpass for 18–22 Hz


% TODO: Apply with filtfilt, store in 'beta_signal'


% TODO: Plot a 3×1 subplot:
%   subplot(3,1,1): raw signal (grey)
%   subplot(3,1,2): theta (red, from Task 1)
%   subplot(3,1,3): beta (green, this task)
%   Title each panel with the frequency band name


fprintf('\n--- Exercise 2 complete! ---\n');
