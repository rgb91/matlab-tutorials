function [mn, sd, pk] = signal_stats(x)
% SIGNAL_STATS  Return basic descriptive statistics of a signal vector.
%
%   [mn, sd, pk] = signal_stats(x)
%
%   Inputs:
%     x   – numeric vector (e.g., one channel of EEG data)
%
%   Outputs:
%     mn  – mean amplitude
%     sd  – standard deviation
%     pk  – peak absolute value (max of abs(x))
%
%   Example:
%     data = sin(0:0.1:2*pi);
%     [m, s, p] = signal_stats(data);

mn = mean(x);
sd = std(x);
pk = max(abs(x));

end
