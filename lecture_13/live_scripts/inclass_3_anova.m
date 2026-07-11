%%
addpath("/Users/sanjaysaha/Projects/matlab-tutorials/lecture_13/data/");
load('anova_data.mat');

% reporting
fprintf('Measure: %s\n', measure);
fprintf('control n = %d, mild n = %d, severe n = %d\n', ...
    numel(control), numel(mild), numel(severe));
fprintf('control   mean = %.2f\n', mean(control));
fprintf('mild      mean = %.2f\n', mean(mild));
fprintf('severe    mean = %.2f\n', mean(severe));


%% SEM per-group -- reporting
group_data = {control, mild, severe};
group_name = {'control', 'mild', 'severe'};
fprintf("\n\n%-10s %8s %8s %8s\n", 'group', 'mean', 'std', 'SEM')
fprintf("------------------------------------------------------\n")
for g=1:3
    x = group_data{g};
    fprintf("%-10s %8.2f %8.2f %8.2f\n", ...
        group_name{g}, mean(x), std(x), std(x)/sqrt(numel(x)));
end


%% Prepare data for ANOVA
values = [control, mild, severe]';                      % 48x1 column
group  = [repmat({'control'}, numel(control), 1); ...
          repmat({'mild'},    numel(mild),    1); ...
          repmat({'severe'},  numel(severe),  1)];      % 48x1 cell labels
fprintf('\nvalues is %dx%d, group is %dx%d — they must match in rows.\n', ...
    size(values,1), size(values,2), size(group,1), size(group,2));


%% ANOVA test

[p, tbl, stats] = anova1(values, group, 'off');
F = tbl{2, 5};
fprintf("\np value: %e\n", p);
fprintf("F stats: %f\n", F);


%% MULTCOMPARE
%  multcompare corrects for multiple comparisons 
%  so the 5%% error rate applies to the WHOLE family of comparisons.
figure;
c = multcompare(stats);          % also draws an interactive comparison plot
title('Tukey post-hoc comparison of group means');

% c has one row per pair: [group_i  group_j  lowerCI  diff  upperCI  p]
fprintf('\n--- Post-hoc pairwise comparisons (Tukey HSD) ---\n');
fprintf('%-20s %10s %10s\n', 'comparison', 'diff', 'p');
fprintf('---------------------------------------------------------\n');
for r = 1:size(c, 1)
    i = c(r, 1); j = c(r, 2);
    fprintf('%-20s %10.2f %10.3e\n', ...
        sprintf('%s vs %s', group_name{i}, group_name{j}), c(r, 4), c(r, 6));
end
% If a pair's confidence interval [lowerCI, upperCI] does NOT include 0,
% that pair is significantly different.


%% WRITE UP
df_between = tbl{2, 3};  % between-groups df = k - 1
df_within  = tbl{3, 3};  % within-groups df  = N - k
fprintf(['A one-way ANOVA showed a significant effect of group on\n' ...
    '%s (F(%d,%d) = %.2f, p < 0.001). Tukey post-hoc tests\n' ...
    'indicated control > mild > severe.\n'], measure, df_between, df_within, F);