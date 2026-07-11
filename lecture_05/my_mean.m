function result = my_mean(x)
% MY_MEAN  Compute the arithmetic mean of a vector without using mean().
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

if ~isvector(x) || isempty(x)
    error('my_mean: input must be a non-empty vector.');
end

total = 0;
for k = 1:length(x)
    total = total + x(k);
end

result = total / length(x);

end
