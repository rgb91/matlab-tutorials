function result = my_mean(x)
% MY_MEAN  Compute the arithmetic mean of a vector.
%
%   result = my_mean(x)
%
%   Input:
%     x       – numeric row or column vector
%
%   Output:
%     result  – scalar mean value
%
%   Example:
%     my_mean([1 2 3 4 5])   % returns 3.0
%
%   This function intentionally avoids calling MATLAB's built-in
%   mean() so you can see the manual calculation.

% --- Input validation ---
if ~isvector(x)
    error('my_mean: input must be a vector, got a %dx%d matrix.', size(x,1), size(x,2));
end
if isempty(x)
    error('my_mean: input vector is empty.');
end

% --- Calculation ---
total  = 0;
n      = length(x);

for k = 1:n
    total = total + x(k);
end

result = total / n;

end  % end of function
