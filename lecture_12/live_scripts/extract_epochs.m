function [epochs, epoch_time] = extract_epochs(data_1d, fs, event_samples, pre_s, post_s)
% EXTRACT_EPOCHS  Cut and baseline-correct epochs from continuous EEG.
%   [epochs, epoch_time] = extract_epochs(data_1d, fs, event_samples, pre_s, post_s)
%
%   Inputs:
%       data_1d       — 1-D continuous EEG vector (single channel)
%       fs            — sampling frequency (Hz)
%       event_samples — vector of event sample indices
%       pre_s         — seconds before stimulus to include
%       post_s        — seconds after stimulus to include
%
%   Outputs:
%       epochs     — (n_valid_trials × epoch_length) baseline-corrected epochs
%       epoch_time — 1-D time axis relative to stimulus (seconds)

% Convert seconds to samples
pre_samp  = round(pre_s * fs);
post_samp = round(post_s * fs);
epoch_len = pre_samp + post_samp;
N = length(data_1d);

% Time axis
epoch_time = linspace(-pre_s, post_s, epoch_len);

% Pre-allocate
n_events = length(event_samples);
raw_epochs = zeros(n_events, epoch_len);
valid = true(1, n_events);

% Extract each epoch
for i = 1:n_events
    s = event_samples(i) - pre_samp;
    e = s + epoch_len - 1;
    
    if s < 1 || e > N
        valid(i) = false;
        continue;
    end
    
    raw_epochs(i, :) = data_1d(s:e);
end

% Keep only valid trials
raw_epochs = raw_epochs(valid, :);

% Baseline correction: subtract mean of pre-stimulus period
bl_idx = epoch_time < 0;
epochs = zeros(size(raw_epochs));
for i = 1:size(raw_epochs, 1)
    epochs(i, :) = raw_epochs(i, :) - mean(raw_epochs(i, bl_idx));
end

end
