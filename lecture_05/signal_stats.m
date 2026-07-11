function [mn, sd, pk] = signal_stats(x)
% SIGNAL_STATS  Return basic descriptive statistics of a signal vector.
%
%   [mn, sd, pk] = signal_stats(x)
%
%   Inputs:
%     x   – numeric vector
%
%   Outputs:
%     mn  – mean amplitude
%     sd  – standard deviation
%     pk  – peak absolute value  (max of abs(x))
%
%   Example:
%     [m, s, p] = signal_stats([1 2 3 4 5]);

mn = mean(x);
sd = std(x);
pk = max(abs(x));

end
