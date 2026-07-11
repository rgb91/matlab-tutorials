function z = normalize_signal(x)
% NORMALIZE_SIGNAL  Z-score normalize a vector.
%
%   z = normalize_signal(x)
%
%   Input:
%     x  – numeric vector
%
%   Output:
%     z  – zero-mean, unit-variance version of x
%          z = (x - mean(x)) / std(x)
%
%   Example:
%     z = normalize_signal([10 14 9 16 13]);
%     mean(z)   % ≈ 0
%     std(z)    % ≈ 1

z = (x - mean(x)) / std(x);

end
