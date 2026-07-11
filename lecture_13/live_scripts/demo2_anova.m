%% DEMO 2: ONE-WAY ANOVA  (anova1 + multcompare)
%  Session 13 — 5 July 2026
%  MATLAB functions: anova1, multcompare
%  Requires: Statistics and Machine Learning Toolbox
%  Neuroscience context: does resting alpha power differ across THREE
%  clinical groups (control / mild / severe)?
%  ─────────────────────────────────────────────────────────────────────
%
%  ANOVA (ANalysis Of VAriance) compares 3+ group means with ONE test.
%  It asks: is the spread BETWEEN group means large compared with the
%  spread WITHIN groups? That ratio is the F-statistic:
%        F = (variance between groups) / (variance within groups)
%  Big F -> groups look genuinely different -> small p.

%% 2A — Load the three groups
load('data/anova_data.mat');   % control, mild, severe, values, group, measure
fprintf('Measure: %s\n', measure);
fprintf('n per group: control=%d, mild=%d, severe=%d\n', ...
    numel(control), numel(mild), numel(severe));

%% 2B — Look before you test: means + SEM per group
grp_data = {control, mild, severe};
grp_name = {'control', 'mild', 'severe'};
fprintf('\n%-10s %8s %8s %8s\n', 'group', 'mean', 'std', 'SEM');
for g = 1:3
    x = grp_data{g};
    fprintf('%-10s %8.2f %8.2f %8.2f\n', ...
        grp_name{g}, mean(x), std(x), std(x)/sqrt(numel(x)));
end

%% 2C — Set up the group-label vector (THE key data-shaping step)
%  anova1 wants ONE long column of values + a MATCHING vector of labels.
%  This is the pattern to memorise:
values = [control, mild, severe]';                 % 48x1 column
group  = [repmat({'control'}, numel(control), 1); ...
          repmat({'mild'},    numel(mild),    1); ...
          repmat({'severe'},  numel(severe),  1)]; % 48x1 cell of labels
fprintf('\nvalues is %dx%d, group is %dx%d — they must match in rows.\n', ...
    size(values,1), size(values,2), size(group,1), size(group,2));

%% 2D — Run the one-way ANOVA
%  Passing 'off' as the display arg suppresses the auto pop-up boxplot so
%  we can control the figures ourselves.
[p, tbl, stats] = anova1(values, group, 'off');

% The ANOVA table (tbl) is a cell array. Pull out the numbers we report:
F         = tbl{2, 5};   % F-statistic
df_between = tbl{2, 3};  % between-groups df = k - 1
df_within  = tbl{3, 3};  % within-groups df  = N - k
fprintf('\n--- One-way ANOVA ---\n');
fprintf('F(%d,%d) = %.2f,  p = %.3e\n', df_between, df_within, F, p);
if p < 0.05
    fprintf('=> Significant: at least one group mean differs.\n');
else
    fprintf('=> Not significant: no evidence the group means differ.\n');
end
% NOTE: a significant ANOVA does NOT say WHICH groups differ — only that
% not all of them are equal. For that we need post-hoc comparisons.

%% 2E — Post-hoc: WHICH pairs differ? (multcompare)
%  multcompare corrects for multiple comparisons (default: Tukey's HSD),
%  so the 5%% error rate applies to the WHOLE family of comparisons.
figure;
c = multcompare(stats);          % also draws an interactive comparison plot
title('Tukey post-hoc comparison of group means');

% c has one row per pair: [group_i  group_j  lowerCI  diff  upperCI  p]
fprintf('\n--- Post-hoc pairwise comparisons (Tukey HSD) ---\n');
fprintf('%-20s %8s %8s\n', 'comparison', 'diff', 'p');
for r = 1:size(c, 1)
    i = c(r, 1); j = c(r, 2);
    fprintf('%-20s %8.2f %8.3e\n', ...
        sprintf('%s vs %s', grp_name{i}, grp_name{j}), c(r, 4), c(r, 6));
end
% If a pair's confidence interval [lowerCI, upperCI] does NOT include 0,
% that pair is significantly different.

%% 2F — Report it the way a paper would
fprintf('\n--- How to write it up ---\n');
fprintf(['A one-way ANOVA showed a significant effect of group on\n' ...
         '%s (F(%d,%d) = %.2f, p < 0.001). Tukey post-hoc tests\n' ...
         'indicated control > mild > severe.\n'], measure, df_between, df_within, F);

%% 2G — Looking ahead
fprintf('\n=== NEXT ===\n');
fprintf('demo3: turn multi-subject data into publication-quality figures\n');
fprintf('(grand averages, SEM error bars, colourmaps).\n');
