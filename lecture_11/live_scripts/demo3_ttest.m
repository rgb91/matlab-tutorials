%% DEMO 3: t-TESTS
%  Session 11 — 1 July 2026
%  MATLAB functions: ttest (one-sample / paired), ttest2 (two-sample)
%  Requires: Statistics and Machine Learning Toolbox
%  Neuroscience context: is the difference between two groups real?
%  ─────────────────────────────────────────────────────────────────────
%
%  A t-test asks: could the difference I see be explained by chance alone?
%  It returns a p-value — the probability of seeing a difference this big
%  (or bigger) IF there were truly no effect. Small p (< 0.05 by
%  convention) -> we call the result "statistically significant".

%% 3A — Load the data
load('data/group_data.mat');   % control, treatment, measure
fprintf('Comparing %s\n', measure);
fprintf('control   mean = %.2f\n', mean(control));
fprintf('treatment mean = %.2f\n', mean(treatment));

%% 3B — One-sample t-test
%  Tests whether ONE group's mean differs from a fixed value (default 0).
%  Example: is resting alpha power significantly greater than zero?
[h, p, ci, stats] = ttest(control);    % default test value mu = 0
fprintf('\n--- One-sample t-test (control vs 0) ---\n');
fprintf('t(%d) = %.2f,  p = %.2e\n', stats.df, stats.tstat, p);
fprintf('h = %d  (1 = reject "mean is 0"; 0 = cannot reject)\n', h);
fprintf('95%% CI for the mean: [%.2f, %.2f]\n', ci(1), ci(2));

%% 3C — Two-sample t-test (the main event)
%  Tests whether TWO INDEPENDENT groups have different means.
%  ttest2 assumes equal variances by default (pooled t-test).
[h, p, ci, stats] = ttest2(control, treatment);
fprintf('\n--- Two-sample t-test (control vs treatment) ---\n');
fprintf('t(%d) = %.3f,  p = %.4e\n', stats.df, stats.tstat, p);
fprintf('h = %d\n', h);
fprintf('95%% CI for the difference in means: [%.2f, %.2f]\n', ci(1), ci(2));

if h == 1
    fprintf('=> Significant: the groups differ (p < 0.05).\n');
else
    fprintf('=> Not significant: cannot conclude the groups differ.\n');
end

%% 3D — What the p-value means (and does NOT mean)
fprintf('\n--- Reading the p-value ---\n');
fprintf('p = %.4e means: if the groups truly had the same mean,\n', p);
fprintf('there is about a %.4f%% chance of a difference this large.\n', p*100);
% It is NOT the probability that the hypothesis is true, and a small p
% does NOT mean the EFFECT is large — only that it is detectable.
% Always report the effect (means, difference, CI) alongside p.

%% 3E — One-sided vs two-sided
%  By default ttest2 is TWO-SIDED (difference in either direction).
%  If you had a directional prediction (control > treatment), use 'right':
[h_r, p_r] = ttest2(control, treatment, 'Tail', 'right');
fprintf('\nOne-sided (control > treatment): p = %.4e (h = %d)\n', p_r, h_r);
% A one-sided test is roughly half the two-sided p — only use it when the
% direction was predicted in advance.

%% 3F — Paired t-test (when the SAME subjects are measured twice)
%  Use ttest(before, after) — NOT ttest2 — for repeated measures.
%  (Demo only; here we pretend the two arrays are paired by subject.)
[h_p, p_p, ~, st_p] = ttest(control, treatment);
fprintf('\nPaired t-test (illustrative): t(%d) = %.2f, p = %.4e\n', ...
    st_p.df, st_p.tstat, p_p);
% Pairing removes between-subject variability and is more powerful WHEN
% the data really are paired. Choosing the right test matters!

%% 3G — Visualise the comparison
means = [mean(control), mean(treatment)];
sems  = [std(control)/sqrt(numel(control)), std(treatment)/sqrt(numel(treatment))];
figure;
bar(means, 'FaceColor', [0.6 0.8 0.6]); hold on;
errorbar(1:2, means, sems, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);
set(gca, 'XTickLabel', {'control', 'treatment'});
ylabel(measure);
title(sprintf('control vs treatment  (t-test p = %.1e)', p));

%% 3H — Looking ahead
fprintf('\n=== NEXT SESSION ===\n');
fprintf('A t-test compares exactly TWO groups. With three or more\n');
fprintf('groups we use ANOVA (anova1) instead — that is next session.\n');
