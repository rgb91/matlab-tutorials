%% t-Tests


%% load data
addpath("/Users/sanjaysaha/Projects/matlab-tutorials/lecture_13/data/");
load("group_data.mat");
fprintf('Comparing %s\n', measure);
fprintf('control   mean = %.2f\n', mean(control));
fprintf('treatment mean = %.2f\n', mean(treatment));

%% ONE-sample/group t-test

% this tests whether ONE group's mean differs from a fixed value
% the fixed value is by default 0 (zero)

% h = 1: Reject the null hypothesis (H₀), indicating a statistically 
%        significant difference.
% h = 0: Fail to reject the null hypothesis, meaning there
%        is no significant difference at the chosen significance level.

[h, p, ci, stats] = ttest(control);  % test value with 0 mu
fprintf("ONE-sample test");
fprintf('t(%d) = %.2f\n', stats.df, stats.tstat);
fprintf('t-test result: h = %d, p = %.4f\n', h, p);
fprintf("95%% CI for the mean: [%.2f %.2f]\n", ci(1), ci(2));


%% TWO-sample/group test
%  Tests whether TWO INDEPENDENT groups have different means.
%  ttest2 assumes equal variances by default (pooled t-test).
[h, p, ci, stats] = ttest2(control, treatment);
fprintf("TWO-sample test");
fprintf('t(%d) = %.2f\n', stats.df, stats.tstat);
fprintf('t-test result: h = %d, p = %.4f\n', h, p);
fprintf("95%% CI for the mean: [%.2f %.2f]\n", ci(1), ci(2));
if h == 1
    fprintf("-->> Significant: the groups differ (p < 0.05).\n");
else
    fprintf("-->> Not significant: cannot conclude the groups differ.\n");
end







