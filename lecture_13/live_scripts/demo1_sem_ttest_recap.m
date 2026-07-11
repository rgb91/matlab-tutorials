%% DEMO 1: SEM + t-TEST RECAP  (bridge from Session 11/12)
%  Session 13 — 5 July 2026
%  MATLAB functions: mean, std, numel, ttest, ttest2
%  Requires: Statistics and Machine Learning Toolbox (for ttest/ttest2)
%  Neuroscience context: 5-minute warm bridge before ANOVA.
%  ─────────────────────────────────────────────────────────────────────
%
%  Two ideas we lean on all session:
%    SEM  = std / sqrt(n)   -> how precisely we know the MEAN
%    t-test -> is a TWO-group difference bigger than chance?
%  ANOVA (demo2) is the same idea for THREE or more groups.

%% 1A — Load two of the three ANOVA groups (treat as a 2-group recap)
load('data/anova_data.mat');   % control, mild, severe, values, group, measure
fprintf('Measure: %s\n', measure);
fprintf('control n = %d, severe n = %d\n', numel(control), numel(severe));

%% 1B — SEM: standard error of the mean
%  SEM shrinks as n grows: doubling n divides SEM by sqrt(2).
sem_control = std(control) / sqrt(numel(control));
fprintf('\ncontrol: mean = %.2f, std = %.2f, SEM = %.2f\n', ...
    mean(control), std(control), sem_control);
fprintf('Approx 95%% CI (mean +/- 2*SEM): [%.2f, %.2f]\n', ...
    mean(control) - 2*sem_control, mean(control) + 2*sem_control);
% SD describes the SPREAD of subjects; SEM describes UNCERTAINTY in the mean.
% Never mix them up on a figure — always say which one the error bars show.

%% 1C — Two-sample t-test: control vs severe
[h, p, ci, stats] = ttest2(control, severe);
fprintf('\n--- ttest2: control vs severe ---\n');
fprintf('t(%d) = %.2f,  p = %.3e\n', stats.df, stats.tstat, p);
fprintf('h = %d  (1 = reject "means equal")\n', h);
fprintf('95%% CI for difference in means: [%.2f, %.2f]\n', ci(1), ci(2));

%% 1D — Why we cannot just run many t-tests
%  With 3 groups there are 3 possible pairs; with 4 groups, 6 pairs.
%  Each test at alpha = 0.05 has a 5%% false-positive risk. Run enough of
%  them and a "significant" result appears by chance alone.
n_groups = 3;
n_pairs  = nchoosek(n_groups, 2);
familywise = 1 - (1 - 0.05)^n_pairs;   % chance of >=1 false positive
fprintf('\n%d groups -> %d pairwise tests.\n', n_groups, n_pairs);
fprintf('Family-wise false-positive risk approx %.1f%% (not 5%%!).\n', ...
    familywise * 100);

%% 1E — The fix: one omnibus test, then corrected follow-ups
fprintf('\nANOVA asks ONE question first: "are ANY of the group means\n');
fprintf('different?" Only if yes do we look at which pairs differ, using a\n');
fprintf('correction (multcompare). That is demo2.\n');
