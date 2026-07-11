%% EXERCISE 2: Two-Sample t-test — SOLUTION
%  Session 11 — 1 July 2026
%  ─────────────────────────────────────────────────────

%% 1: Load data
load('data/exercise_data.mat');   % eyes_open, eyes_closed, measure

%% 2 & 3: Two-sample t-test
[h, p, ci, stats] = ttest2(eyes_open, eyes_closed);
fprintf('Two-sample t-test: eyes open vs eyes closed\n');
fprintf('t(%d) = %.3f,  p = %.4e\n', stats.df, stats.tstat, p);
fprintf('95%% CI for difference: [%.2f, %.2f]\n', ci(1), ci(2));
% EXPECTED: t(34) = -6.66, p ~ 1.2e-07  (negative: open < closed)

%% 4: Plain-English conclusion
if h == 1
    fprintf('=> Significant (p < 0.05): alpha amplitude differs between\n');
    fprintf('   eyes open and eyes closed. Eyes-closed is higher.\n');
else
    fprintf('=> Not significant.\n');
end

%% 5 (bonus): one-sample t-test, eyes_closed vs 0
[h2, p2, ~, st2] = ttest(eyes_closed);
fprintf('\nOne-sample (eyes_closed vs 0): t(%d) = %.2f, p = %.2e\n', ...
    st2.df, st2.tstat, p2);
% EXPECTED: hugely significant — alpha power is well above zero.
