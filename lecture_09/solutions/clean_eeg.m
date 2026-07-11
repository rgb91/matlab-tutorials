function cleaned = clean_eeg(signal, fs)
% CLEAN_EEG  Remove 60 Hz noise and bandpass to 1–40 Hz.
%   cleaned = clean_eeg(signal, fs)
%
%   Steps:
%     1. Notch filter at 60 Hz (59–61 Hz)
%     2. Bandpass filter at 1–40 Hz
%     3. Return the cleaned signal

nyquist = fs / 2;

% Step 1: Notch filter to remove 60 Hz
[b_notch, a_notch] = butter(4, [59 61] / nyquist, 'stop');
after_notch = filtfilt(b_notch, a_notch, signal);

% Step 2: Bandpass 1–40 Hz
[b_bp, a_bp] = butter(4, [1 40] / nyquist, 'bandpass');
cleaned = filtfilt(b_bp, a_bp, after_notch);

end
