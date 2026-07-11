function eeg = generate_eeg(fs, duration, noise_std)
%GENERATE_EEG  Generate a synthetic multi-band EEG signal.
%
%   eeg = generate_eeg(fs, duration, noise_std)
%
%   Inputs:
%     fs         - sampling frequency in Hz  (e.g. 256)
%     duration   - signal duration in seconds (e.g. 4)
%     noise_std  - standard deviation of additive white noise in µV
%
%   Output:
%     eeg        - synthetic EEG signal (1 × N row vector)
%
%   Frequency components:
%     Delta  2 Hz   8 µV
%     Theta  6 Hz   5 µV
%     Alpha  10 Hz  4 µV
%     Beta   20 Hz  2 µV
%     White noise with amplitude = noise_std
%
%   Example:
%     signal = generate_eeg(256, 4, 3);
%     plot(0:1/256:4-1/256, signal);

t = 0 : 1/fs : duration - 1/fs;

eeg = 8 * sin(2*pi * 2  * t) ...   % Delta
    + 5 * sin(2*pi * 6  * t) ...   % Theta
    + 4 * sin(2*pi * 10 * t) ...   % Alpha
    + 2 * sin(2*pi * 20 * t) ...   % Beta
    + randn(size(t)) * noise_std;  % White noise

end
