%% HOMEWORK — Session 11 — SOLUTION
%  Requires condition_stats.m on the path (Part A) and the
%  Statistics Toolbox for ttest2.
%  ─────────────────────────────────────────────────────────────

%% Part B-1: Load data
load('data/homework_data.mat');   % values, group, subject_ids, measure
fprintf('Measure: %s   (%d subjects)\n', measure, numel(values));

%% Part B-2: Call the function from Part A
summary = condition_stats(values, group);

%% Part B-3: Print the summary table
fprintf('\n%-10s %4s %8s %8s %8s\n', 'condition', 'n', 'mean', 'sd', 'sem');
for k = 1:numel(summary)
    fprintf('%-10s %4d %8.2f %8.2f %8.2f\n', ...
        summary(k).condition, summary(k).n, ...
        summary(k).mean, summary(k).sd, summary(k).sem);
end
% EXPECTED (approx):
%   control  n=12  mean 7.71  sd 1.88  sem 0.54
%   patient  n=12  mean 5.44  sd 1.49  sem 0.43

%% Part B-4: Two-sample t-test between the conditions
ctrl = values(strcmp(group, 'control'));
pat  = values(strcmp(group, 'patient'));
[h, p, ci, stats] = ttest2(ctrl, pat);
fprintf('\nttest2 control vs patient: t(%d) = %.3f, p = %.4f\n', ...
    stats.df, stats.tstat, p);
fprintf('95%% CI for difference: [%.2f, %.2f]\n', ci(1), ci(2));
if h == 1
    fprintf('=> Significant (p < 0.05): the groups differ.\n');
else
    fprintf('=> Not significant.\n');
end
% EXPECTED: t(22) = 3.28, p ~ 0.0034 -> significant.

%% Part B-5: Bar chart of means with SEM error bars
means = [summary(1).mean, summary(2).mean];
sems  = [summary(1).sem,  summary(2).sem];
figure;
bar(means, 'FaceColor', [0.7 0.6 0.8]); hold on;
errorbar(1:2, means, sems, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);
set(gca, 'XTickLabel', {summary.condition});
ylabel(measure);
title(sprintf('Mean ERP amplitude by group  (p = %.3f)', p));
