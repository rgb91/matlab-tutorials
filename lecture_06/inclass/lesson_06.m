%% Multi-channel signal

T = 4; % duration
fs = 500; % sampling rate
t = 0: 1/fs : T-1/fs;  % time vector

n_channels = 16;
n_samples = length(t);

eeg_matrix = zeros(n_channels, n_samples);  % pre-allocating matrix

% every signal = alpha sig + theta sig + rand_noise

for ch = 1:n_channels
    alpha_amp = 1.5 + rand(); % 1.5 + [0,1]
    theta_amp = 0.8 + rand(); % 0.8 + [0,1]
    noise_amp = 0.2 + 0.1*rand();

    alpha_sig = alpha_amp * sin(2*pi * 10 * t);
    theta_sig = theta_amp * sin(2*pi * 6  * t);
    noise_sig = noise_amp * randn(1, n_samples);

    final_sig = alpha_sig + theta_sig + noise_sig;

    eeg_matrix(ch,:) = final_sig;
end



plot_eeg_multichannel(eeg_matrix, t, 6, 'All channels stacked')