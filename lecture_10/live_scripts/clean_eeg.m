function cleaned = clean_eeg(signal, fs, band_low, band_high)
% CLEAN_EEG  Remove 60 Hz noise and bandpass-filter an EEG signal.
%   cleaned = clean_eeg(signal, fs, band_low, band_high)
%
%   Pipeline:
%     1. Notch filter at 60 Hz (59-61 Hz bandstop)
%     2. Bandpass filter between band_low and band_high
%
%   Inputs:
%       signal    – 1-D vector (raw EEG)
%       fs        – sampling frequency in Hz
%       band_low  – lower cutoff for bandpass (Hz)
%       band_high – upper cutoff for bandpass (Hz)
%
%   Outputs:
%       cleaned   – filtered signal (same length as input)

% Step 1: Notch filter at 60 Hz
notch_low  = 59;
notch_high = 61;
Wn_notch = [notch_low, notch_high] / (double(fs) / 2.0);
[b_notch, a_notch] = butter(4, Wn_notch, 'stop');
notched = filtfilt(b_notch, a_notch, signal);

% Step 2: Bandpass filter
Wn_bp = [band_low, band_high] / (double(fs) / 2.0);
[b_bp, a_bp] = butter(4, Wn_bp, 'bandpass');
cleaned = filtfilt(b_bp, a_bp, notched);
end
