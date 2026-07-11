function summary = condition_stats(values, group)
% CONDITION_STATS  Descriptive statistics per condition.
%   summary = condition_stats(values, group)
%
%   Inputs:
%       values — 1-D numeric vector of measurements (one per subject)
%       group  — cell array of condition labels, same length as values
%
%   Output:
%       summary — struct array (one element per unique condition) with
%                 fields: condition, n, mean, sd, sem

conditions = unique(group);          % the distinct labels
summary = struct('condition', {}, 'n', {}, 'mean', {}, 'sd', {}, 'sem', {});

for k = 1:numel(conditions)
    mask = strcmp(group, conditions{k});   % logical index for this group
    x    = values(mask);

    summary(k).condition = conditions{k};
    summary(k).n         = numel(x);
    summary(k).mean      = mean(x);
    summary(k).sd        = std(x);
    summary(k).sem       = std(x) / sqrt(numel(x));
end
end
