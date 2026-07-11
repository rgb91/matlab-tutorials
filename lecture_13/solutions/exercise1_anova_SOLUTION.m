%% EXERCISE 1 — SOLUTION: ONE-WAY ANOVA
%  Session 13 — 5 July 2026
%  Data: exercise_anova.mat (firing rate, Hz; low/medium/high, n=15 each)

%% Step 0 — Load
load('data/exercise_anova.mat');   % low, medium, high, values, group, measure
fprintf('Measure: %s\n', measure);

%% Step 1 — Describe each group
grp  = {low, medium, high};
name = {'low', 'medium', 'high'};
fprintf('\n%-8s %8s %8s %8s\n', 'group', 'mean', 'std', 'SEM');
for i = 1:3
    x = grp{i};
    fprintf('%-8s %8.2f %8.2f %8.2f\n', ...
        name{i}, mean(x), std(x), std(x)/sqrt(numel(x)));
end
% Expected ~ low 12.1, medium 18.1, high 22.4 Hz.

%% Step 2 — Value column + matching labels
y = [low, medium, high]';                          % 45x1
g = [repmat({'low'},    numel(low),    1); ...
     repmat({'medium'}, numel(medium), 1); ...
     repmat({'high'},   numel(high),   1)];        % 45x1 cell

%% Step 3 — One-way ANOVA
[p, tbl, stats] = anova1(y, g, 'off');
F          = tbl{2, 5};
df_between = tbl{2, 3};
df_within  = tbl{3, 3};
fprintf('\nANOVA: F(%d,%d) = %.2f, p = %.3e\n', df_between, df_within, F, p);
% Expected ~ F(2,42) = 39.0, p ~ 2.7e-10  -> highly significant.

%% Step 4 — Post-hoc
figure;
c = multcompare(stats);
title('Firing rate by contrast — Tukey HSD');
fprintf('\nPairwise (diff, p):\n');
for r = 1:size(c,1)
    fprintf('  %s vs %s: diff=%.2f, p=%.3e\n', ...
        name{c(r,1)}, name{c(r,2)}, c(r,4), c(r,6));
end
% All three pairs differ: firing rate rises with contrast (low<medium<high).

%% Step 5 — Write-up
% A one-way ANOVA showed a significant effect of stimulus contrast on firing
% rate (F(2,42) = 39.0, p < 0.001). Tukey post-hoc tests confirmed that firing
% rate increased significantly with each step in contrast (low < medium < high).
