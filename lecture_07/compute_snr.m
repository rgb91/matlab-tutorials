function snr_db = compute_snr(signal, noisy)
%COMPUTE_SNR  Compute signal-to-noise ratio in decibels.
%
%   snr_db = compute_snr(signal, noisy)
%
%   Inputs:
%     signal  - clean reference signal (1 × N vector)
%     noisy   - signal with noise added (same size as signal)
%
%   Output:
%     snr_db  - SNR in dB = 10 * log10( var(signal) / var(noise) )
%               where noise = noisy - signal
%
%   Example:
%     clean  = sin(2*pi*10*(0:1/256:1));
%     messy  = clean + randn(size(clean))*2;
%     snr    = compute_snr(clean, messy);

noise_component = noisy - signal;
snr_db = 10 * log10( var(signal) / var(noise_component) );

end
